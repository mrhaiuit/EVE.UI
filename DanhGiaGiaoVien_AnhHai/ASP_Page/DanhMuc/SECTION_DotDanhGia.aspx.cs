using EVE.Commons.Response;
using EVE.Data;
using EVE.TransportLayer;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ASP_Page_Default : System.Web.UI.Page
{
    string pChuoiTimKiem = "";
    string pNam = "";

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
            Load_SelectHTML("select * from EduMinistry", "EduMinistryName", "EduMinistryCode", false, "── Chọn cấp Bộ ──", slEduMinistry);
            Load_SelectHTML("select * from EduProvince", "EduProvinceName", "EduProvinceId", true, "── Chọn cấp Sở ──", slEduProvince);
            Load_SelectHTML("select * from EduProvince", "EduProvinceName", "EduProvinceId", true, "── Chọn cấp Sở ──", slEduProvince_TimKiem);

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
            pNam = Request.QueryString["Nam"].ToString();
            slNam.Value = pNam;
        }
        catch { }
    }
    async void LoadDanhSach()
    {
        ClientResponse<List<EvalPeriod>> result = new ClientResponse<List<EvalPeriod>>();

        //if (pNam != "")
        //    result = await _apiAuthentication.GetSchool_ByEduDepartmentId(int.Parse(pNam == "" ? "0" : pNam));
        //else
        result = await _apiAuthentication.GetEvalPeriod();

        string html = @" ";
        if (result != null)
            if (!result.IsError)
            {
                var period = result.Data;
                for (int i = 0; i < period.Count; i++)
                {
                    if (pNam != "")
                        if (pNam != period[i].Year.ToString())
                            continue;

                    html += @"  <tr>
                                 <td>" + (i + 1) + @"</td>
                                 <td class='align-center'>" + period[i].Year + @"</td>
                                 <td>" + period[i].PeriodName + @"</td>
                                 <td class='align-center text-nowrap'>" + period[i].FromDate.ToString().ConvertMMDDYYtoDDMMYY() + @" - " + period[i].ToDate.ToString().ConvertMMDDYYtoDDMMYY() + @"</td>
                                 <td class='align-center'>Đã hoàn thành</td>
                                 <td class='align-center'>99</td>
                                 <td class='align-center'>99</td>
                                 <td class='align-center'>99</td>
                                 <td class='align-center'>99</td>
                                 <td class='align-center'>99</td>
                                 <td class='text-nowrap text-nowrap'>
                                     <a href='javascript:OpenModal_EditDotDanhGia(" + period[i].EvalPeriodId + @");' class='btn bg-green waves-effect' style='padding: 0 7px 3px 7px;' data-toggle='tooltip' data-placement='top' title='' data-original-title='Sửa'><i class='fa fa-pencil'></i></a>
                                     <a href='javascript:DeleteDotDanhGia(" + period[i].EvalPeriodId + @")' class='btn bg-red waves-effect' style='padding: 0 7px 3px 7px;' data-toggle='tooltip' data-placement='top' title='' data-original-title='Xoá'><i class='fa fa-trash'></i></a>
                                 </td> 
                            </tr>";

                }
            }
        tbody_DSDotDanhGia.InnerHtml = html;
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        string Nam = slNam.Value.Trim();
        string Truong = slEduSchoold_TimKiem.Value.Trim();
        string url = "Section_DotDanhGia.aspx?";
        if (Nam != "")
            url += "Nam=" + Nam + "&";
        if (Truong != "")
            url += "Truong=" + Truong + "&";
        Response.Redirect(url);
    }
    void Load_SelectHTML(string sql, string TextField, string ValueField, bool AddANewItem, string ItemName, System.Web.UI.HtmlControls.HtmlSelect select)
    {
        System.Data.DataTable table = Connect.GetTable(sql);

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
}