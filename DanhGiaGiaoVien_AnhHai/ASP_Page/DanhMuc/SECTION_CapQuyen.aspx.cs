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
    string pNhomQuyen = "";

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
            Load_SelectHTML("select * from UserGroup order by idx asc", "UserGroupName", "eduLevelCode", true, "── Chọn tìm nhóm quyền ──", slNhomQuyen);
            Load_SelectHTML("select * from UserGroup order by idx asc", "UserGroupName", "UserGroupCode", true, "── Chọn nhóm quyền ──", slNhomQuyen_modal);
            Load_SelectHTML("select EmployeeID,(EmployeeName + ' (' + EduLevelName + ')' ) as EmployeeName from Employee Em LEFT JOIN EduLevel EL ON Em.EduLevelCode=El.EduLevelCode ", "EmployeeName", "EmployeeID", true, "── Chọn nhân viên ──", slNhanVien_modal);

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
            pNhomQuyen = Request.QueryString["NQ"].ToString();
            slNhomQuyen.Value = pNhomQuyen;
        }
        catch { }
    }
    async void LoadDanhSach()
    {
        ClientResponse<List<UserGroup_Employee>> result = new ClientResponse<List<UserGroup_Employee>>();

        //if (pCapGiaoDuc != "")
        //    result = await _apiAuthentication.GetSchool_ByEduDepartmentId(int.Parse(pCapGiaoDuc == "" ? "0" : pCapGiaoDuc));
        //else
        result = await _apiAuthentication.Get_UserGroup_Employee();
        string html = @"";
        if (result != null)
            if (!result.IsError)
            {
                var emp = result.Data;
                for (int i = 0; i < emp.Count; i++)
                {
                    html += @"    <tr>
                                     <td>" + (i + 1) + @"</td>
                                     <td>" + StaticData.getField("Employee", "EmployeeName", "EmployeeID", emp[i].EmployeeId + "") + @"</td>
                                     <td class='align-center'>" + StaticData.getField("Employee", "EmployeeCode", "EmployeeID", emp[i].EmployeeId + "") + @"</td>
                                     <td class='align-center'>" + StaticData.getField("EduLevel", "EduLevelName", "EduLevelCode", StaticData.getField("Employee", "EduLevelCode", "EmployeeID", emp[i].EmployeeId + "")) + @"</td>
                                     <td class='align-center'>" + StaticData.getField("UserGroup", "UserGroupName", "UserGroupCode", emp[i].UserGroupCode + "") + @"</td>
                                     <td class='align-center'>" + StaticData.getField("Employee", "PhoneNumber", "EmployeeID", emp[i].EmployeeId + "") + @"</td>
                                     <td class='align-center'>";
                    if (StaticData.getField("Employee", "Active", "EmployeeID", emp[i].EmployeeId + "").Trim() == "False")
                        html += @"             <span class='label label-danger font-17' id='spLock_" + emp[i].EmployeeId + @"' onclick='ChangeLockAccount(this.id,1);' style='cursor:pointer;'  data-toggle='tooltip' data-placement='top' title='' data-original-title='Unlock'><i class='fa fa-lock'></i></span>";
                    else
                        html += @"             <span class='label label-success font-17' id='spLock_" + emp[i].EmployeeId + @"' onclick='ChangeLockAccount(this.id,0);' style='cursor:pointer;'  data-toggle='tooltip' data-placement='top' title='' data-original-title='Lock'><i class='fa fa-unlock'></i></span>";
                    html += @"       </td>
                                     <td class='text-nowrap align-center'> 
                                         <a href='javascript:DeleteCapQuyen(" + emp[i].EmployeeId + @"," + "\"" + emp[i].UserGroupCode + "\"" + @")' class='btn bg-red waves-effect' style='padding: 0 7px 3px 7px;' data-toggle='tooltip' data-placement='top' title='' data-original-title='Xoá'><i class='fa fa-trash'></i></a>
                                     </td>
                                 </tr> ";

                }
            }
        tbody_DSCapQuyen.InnerHtml = html;
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        string NQ = slNhomQuyen.Value.Trim();
        string url = "Section_CapQuyen.aspx?";
        if (NQ != "")
            url += "NQ=" + NQ + "&";
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