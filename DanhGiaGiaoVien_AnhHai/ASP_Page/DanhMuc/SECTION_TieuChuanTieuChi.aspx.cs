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
    string pLoaiTieuChuan = "";
    string pCapGiaoDuc = "";

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
            Load_SelectHTML("select * from SchoolLevel", "SchoolLevelName", "SchoolLevelCode", true, "── Chọn cấp giáo dục ──", slCapGiaoDuc);
            Load_SelectHTML("select * from SchoolLevel", "SchoolLevelName", "SchoolLevelCode", true, "── Chọn cấp giáo dục ──", slCapGiaoDuc_modal);
            Load_SelectHTML("select * from EvalType", "EvalTypeName", "EvalTypeCode", true, "── Chọn loại tiêu chuẩn ──", slLoaiTieuChuan);
            Load_SelectHTML("select * from EvalType", "EvalTypeName", "EvalTypeCode", true, "── Chọn loại tiêu chuẩn ──", slLoaiTieuChuan_modal);

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
            pLoaiTieuChuan = Request.QueryString["LTC"].ToString();
            slLoaiTieuChuan.Value = pLoaiTieuChuan;
        }
        catch { }
        try
        {
            pCapGiaoDuc = Request.QueryString["CGD"].ToString();
            slCapGiaoDuc.Value = pCapGiaoDuc;
        }
        catch { }
    }
    async void LoadDanhSach()
    {
        ClientResponse<List<EvalStandard>> result = new ClientResponse<List<EvalStandard>>();

       // if (pCapGiaoDuc != "")
         //   result = await _apiAuthentication.GetSchool_ByEduDepartmentId(int.Parse(pCapGiaoDuc == "" ? "0" : pCapGiaoDuc));
        //else
            result = await _apiAuthentication.GetEvalStandard();

        string html = @" ";
        if (result != null)
            if (result.Data != null)
            {
                var standard = result.Data;
                for (int i = 0; i < standard.Count; i++)
                {
                    html += @"<tr class='tr-header'>
                                        <td>" + (i + 1) + @"</td>
                                        <td>" + standard[i].EvalStandardName + @" <b><i class='fa fa-chevron-right'></i></b></td>
                                        <td>" + standard[i].Remarks + @"</td>
                                        <td class='text-nowrap align-center'>
                                            <a href='javascript:OpenModal_AddNewTieuChi(" + standard[i].EvalStandardId + @");' class='btn bg-yellow waves-effect' style='padding: 0 7px 3px 7px;' data-toggle='tooltip' data-placement='top' title='' data-original-title='Thêm Tiêu chí'><i class='fa fa-plus'></i></a>
                                            <a href='javascript:OpenModal_EditTieuChuan(" + standard[i].EvalStandardId + @"," + "\"" + standard[i].EvalStandardName + "\"" + @");' class='btn bg-green waves-effect' style='padding: 0 7px 3px 7px;' data-toggle='tooltip' data-placement='top' title='' data-original-title='Sửa'><i class='fa fa-pencil'></i></a>
                                            <a href='javascript:DeleteTieuChuan(" + standard[i].EvalStandardId + @");' class='btn bg-red waves-effect' style='padding: 0 7px 3px 7px;' data-toggle='tooltip' data-placement='top' title='' data-original-title='Xoá'><i class='fa fa-trash'></i></a>
                                        </td>
                                    </tr>
                                    <tr style='display: none;'>
                                        <td colspan='4'>
                                            <table class='table table-bordered table-hover'>
                                                <thead>
                                                    <tr>
                                                        <th class='bg-orange' style='max-width: 3rem;'>#</th>
                                                        <th class='bg-orange' style='min-width: 10rem;'>TIÊU CHÍ</th>
                                                        <th class='bg-orange align-center'></th>
                                                    </tr>
                                                </thead>
                                                <tbody>";

                    var result2 = await _apiAuthentication.GetEvalCriteria_ByStandardId(standard[i].EvalStandardId);
                    if (result2 != null)
                        if (result2.Data != null)
                        {
                            var criteria = result2.Data;
                            for (int j = 0; j < criteria.Count; j++)
                            {
                                html += @"
                                                    <tr>
                                                        <td>" + (j + 1) + @"</td>
                                                        <td>" + criteria[j].EvalCriteriaName + @"</td>
                                                        <td class='text-nowrap  align-center'>
                                                            <a href='javascript:OpenModal_EditTieuChi(" + standard[i].EvalStandardId + @"," + criteria[j].EvalCriteriaId + @"," + "\"" + standard[i].EvalStandardName + "\"" + @");' class='btn bg-green waves-effect' style='padding: 0 7px 3px 7px;' data-toggle='tooltip' data-placement='top' title='' data-original-title='Sửa'><i class='fa fa-pencil'></i></a>
                                                            <a href='javascript:DeleteTieuChi(" + criteria[j].EvalCriteriaId + @");' class='btn bg-red waves-effect' style='padding: 0 7px 3px 7px;' data-toggle='tooltip' data-placement='top' title='' data-original-title='Xoá'><i class='fa fa-trash'></i></a>
                                                        </td>
                                                    </tr> ";
                            }
                        }

                    html += @"                  </tbody>
                                            </table>
                                        </td>
                                    </tr>";

                }
            }
        tbody_DSTieuChuan.InnerHtml = html;
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        string CGD = slCapGiaoDuc.Value.Trim();
        string LTC = slLoaiTieuChuan.Value.Trim();
        string url = "Section_TieuChuanTieuChi.aspx?";
        if (LTC != "")
            url += "LTC=" + LTC + "&";
        if (CGD != "")
            url += "CGD=" + CGD + "&";
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