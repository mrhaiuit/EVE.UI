﻿using EVE.Commons.Response;
using EVE.Data;
using EVE.TransportLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ASP_Page_Default : System.Web.UI.Page
{
    string pChuoiTimKiem = "";
    string pSoGiaoDuc = "";
    string pPhongGiaoDuc = "";

    string txtFistPage = "1";
    string txtPage1 = "";
    string txtPage2 = "";
    string txtPage3 = "";
    string txtPage4 = "";
    string txtPage5 = "";
    string txtLastPage = "";
    int Page_web = 1;
    int MaxPage = 0;
    int PageSize = 20;
    string mQuyen;
    string themeColor;
    string tenDangNhap_HienTai = "";
    ApiAuthentication _apiAuthentication = new ApiAuthentication();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["CC_PhanMemDanhGiaGiaoVien_VSW"] != null)
        {
            string TenDangNhap_Cookie = HttpContext.Current.Request.Cookies["CC_PhanMemDanhGiaGiaoVien_VSW"].Value;
            string idLoaiNguoiDung = StaticData.getField("tb_NguoiDung", "idQuyen", "TenDangNhap", TenDangNhap_Cookie.ToString());
            themeColor = "cyan";
            breadscrumColor.Attributes.Add("class", "breadcrumb breadcrumb-col-" + themeColor);

            //mQuyen = StaticData.getField("tb_Quyen", "TenQUyen", "idQuyen", idLoaiNguoiDung);
            //if (mQuyen == "User")
            //Response.Redirect("../Home/Default.aspx");
        }
        else
            Response.Redirect("../Home/Login.aspx");

        if (!IsPostBack)
        {
            Load_SelectHTML("select * from EduProvince", "EduProvinceName", "EduProvinceId", true, "── Tìm theo sở ──", slSoGiaoDuc);
            Load_SelectHTML("select * from EduProvince", "EduProvinceName", "EduProvinceId", true, "── Chọn Sở ──", slSoGiaoDuc_modal);
            Load_SelectHTML("select * from SchoolLevel", "SchoolLevelName", "SchoolLevelCode", true, "── Chọn cấp trường ──", slCapTruong_modal);
            Load_SelectHTML("select * from Province order by PostCode desc", "ProvinceName", "ProvinceID", true, "── Chọn Tỉnh/Thành ──", slTinhThanh);

            LoadQueryString();
            LoadDanhSach();
        }
    }
    void LoadQueryString()
    {
        try
        {
            Page_web = int.Parse(Request.QueryString["Page"].ToString());
        }
        catch { }
        try
        {
            pChuoiTimKiem = Request.QueryString["CTK"].ToString();
            txtSearch.Value = pChuoiTimKiem;
        }
        catch { }
        try
        {
            pSoGiaoDuc = Request.QueryString["SGD"].ToString();
            slSoGiaoDuc.Value = pSoGiaoDuc;
        }
        catch { }
        try
        {
            pPhongGiaoDuc = Request.QueryString["PGD"].ToString();
        }
        catch { }
    }
    async void LoadDanhSach()
    {
        ClientResponse<List<School>> result = new ClientResponse<List<School>>();

        if (pSoGiaoDuc != "")
            result = await _apiAuthentication.GetSchool_ByEduProvinceId(int.Parse(pSoGiaoDuc == "" ? "0" : pSoGiaoDuc));
        if (pPhongGiaoDuc != "")
            result = await _apiAuthentication.GetSchool_ByEduDepartmentId(int.Parse(pPhongGiaoDuc == "" ? "0" : pPhongGiaoDuc));
        if (pPhongGiaoDuc == "" && pSoGiaoDuc == "")
            result = await _apiAuthentication.GetSchool();

        string html = @" ";
        if (result != null)
            if (!result.IsError)
            {
                var school = result.Data;
                for (int i = 0; i < school.Count; i++)
                {
                    string DistrictID = StaticData.getField("ward", "districtID", "wardID", school[i].WardId + "");
                    string ProvinceID = StaticData.getField("district", "ProvinceID", "districtID", DistrictID);

                    string DistrictName = StaticData.getField("District", "DistrictName", "districtID", DistrictID);
                    string ProvinceName = StaticData.getField("Province", "ProvinceName", "ProvinceID", ProvinceID);
                    string WardName = StaticData.getField("ward", "WardName", "wardID", school[i].WardId + "");

                    string DiaChi = school[i].Address + ", " + WardName + ", " + DistrictName + ", " + ProvinceName;
                    html += @"          <tr>
                                        <th scope='row'>" + (i + 1) + @"</th> 
                                        <td>" + StaticData.getField("EduDepartment", "EduDepartmentName", "EduDepartmentId", school[i].EduDepartmentId + "") + @"</td> 
                                        <td class='text-center'>" + StaticData.getField("SchoolLevel", "SchoolLevelName", "SchoolLevelCode", school[i].SchoolLevelCode + "") + @"</td>  
                                        <td>" + school[i].SchoolName + @"</td>  
                                        <td>" + DiaChi + @"</td>  
                                        <td class='align-center text-nowrap'>";
                    html += "                       <a onclick='OpenModal_EditTruongHoc(" + school[i].SchoolId + ")' class='btn bg-green waves-effect' style='padding: 0 7px 3px 7px;' data-toggle='tooltip' data-placement='top' title='' data-original-title='Sửa'><i class='fa fa-pencil'></i></a>";
                    html += "                       <a onclick='DeleteTruongHoc(" + school[i].SchoolId + ")' class='btn bg-red waves-effect' style='padding: 0 7px 3px 7px;' data-toggle='tooltip' data-placement='top' title='' data-original-title='Xoá'><i class='fa fa-trash'></i></a>";
                    html += @"              </td> 
                                    </tr>   ";
                }
            }
        tbody_DSTruongHoc.InnerHtml = html;
    }
    void Load_SelectHTML(string sql, string TextField, string ValueField, bool AddANewItem, string ItemName, System.Web.UI.HtmlControls.HtmlSelect select)
    {
        DataTable table = Connect.GetTable(sql);

        select.DataSource = table;
        select.DataTextField = TextField;
        select.DataValueField = ValueField;
        select.DataBind();

        if (AddANewItem)
        {
            select.Items.Add(new ListItem(ItemName, ""));
            select.Items.FindByText(ItemName).Selected = true;
        }
    }
    public async Task<int> getint()
    {
        return 1;
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        string CTK = txtSearch.Value.Trim();
        string SGD = slSoGiaoDuc.Value.Trim();
        string PGD = txtPhongGiaoDuc.Value.Trim();

        string url = "Section_TruongHoc.aspx?";
        if (CTK != "")
            url += "CTK=" + CTK + "&";
        if (SGD != "")
            url += "SGD=" + SGD + "&";
        if (PGD != "")
            url += "PGD=" + PGD + "&";
        Response.Redirect(url);
    }
}