using EVE.Commons.Response;
using EVE.Data;
using EVE.TransportLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ASP_Page_Default : System.Web.UI.Page
{
    string pChuoiTimKiem = "";
    string pQuyen = "";

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
            string TenDangNhap_Cookie = tenDangNhap_HienTai = HttpContext.Current.Request.Cookies["CC_PhanMemDanhGiaGiaoVien_VSW"].Value;
            themeColor = "cyan";
            breadscrumColor.Attributes.Add("class", "breadcrumb breadcrumb-col-" + themeColor);
        }
        else
            Response.Redirect("../../Home/Login.aspx");

        if (!IsPostBack)
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
                pQuyen = Request.QueryString["Quyen"].ToString();
                slUserType.Value = pQuyen;
            }
            catch { }

            LoadEduLevel();
            Load_SelectHTML("select * from EduMinistry", "EduMinistryName", "EduMinistryCode", false, "── Chọn cấp Bộ ──", slEduMinistry);
            LoadEduProvince();
            //Load_SelectHTML("select * from EduProvince", "EduProvinceName", "EduProvinceId", true, "── Chọn cấp Sở ──", slEduProvince);
            //Load_SelectHTML("select * from EduDepartment", "EduDepartmentName", "EduDepartmentId", true, "-- Chọn cấp Phòng --", slEduDepartment);
            //Load_SelectHTML("select * from School", "School", "SchoolId", true, "-- Chọn cấp Trường --", slEduSchoold);
            LoadDanhSach();
        }
    }
    #region paging
    private void SetPage(int AllRowNumber)
    {
        int TotalRows = AllRowNumber;
        if (TotalRows % PageSize == 0)
            MaxPage = TotalRows / PageSize;
        else
            MaxPage = TotalRows / PageSize + 1;
        txtLastPage = MaxPage.ToString();
        if (Page_web == 1)
        {
            for (int i = 1; i <= MaxPage; i++)
            {
                if (i <= 5)
                {
                    switch (i)
                    {
                        case 1: txtPage1 = i.ToString(); break;
                        case 2: txtPage2 = i.ToString(); break;
                        case 3: txtPage3 = i.ToString(); break;
                        case 4: txtPage4 = i.ToString(); break;
                        case 5: txtPage5 = i.ToString(); break;
                    }
                }
                else
                    return;
            }
        }
        else
        {
            if (Page_web == 2)
            {
                for (int i = 1; i <= MaxPage; i++)
                {
                    if (i == 1)
                        txtPage1 = "1";
                    if (i <= 5)
                    {
                        switch (i)
                        {
                            case 2: txtPage2 = i.ToString(); break;
                            case 3: txtPage3 = i.ToString(); break;
                            case 4: txtPage4 = i.ToString(); break;
                            case 5: txtPage5 = i.ToString(); break;
                        }
                    }
                    else
                        return;
                }
            }
            else
            {
                int Cout = 1;
                if (Page_web <= MaxPage)
                {
                    for (int i = Page_web; i <= MaxPage; i++)
                    {
                        if (i == Page_web)
                        {
                            txtPage1 = (Page_web - 2).ToString();
                            txtPage2 = (Page_web - 1).ToString();
                        }
                        if (Cout <= 3)
                        {
                            if (i == Page_web)
                                txtPage3 = i.ToString();
                            if (i == (Page_web + 1))
                                txtPage4 = i.ToString();
                            if (i == (Page_web + 2))
                                txtPage5 = i.ToString();
                            Cout++;
                        }
                        else
                            return;
                    }
                }
                else
                {
                    SetPage(AllRowNumber);
                }
            }
        }
    }
    #endregion
    async void LoadEduLevel()
    {
        string UserGroup_DB = HttpContext.Current.Request.Cookies["CC_PhanMemDanhGiaGiaoVien_UserGroup_VSW"].Value;

        ClientResponse<List<EduLevel>> result = new ClientResponse<List<EduLevel>>();
        result = await _apiAuthentication.Get_EduLevel_ByUserGroup(UserGroup_DB);
        if (result != null)
            if (result.Data != null)
            {
                DataTable table = new DataTable();
                table.Columns.Add("EduLevelCode");
                table.Columns.Add("EduLevelName");

                var edu = result.Data;
                for (int i = 0; i < edu.Count; i++)
                {
                    DataRow row = table.NewRow();
                    row["EduLevelCode"] = edu[i].EduLevelCode;
                    row["EduLevelName"] = edu[i].EduLevelName;
                    table.Rows.Add(row);
                }

                slUserType.DataSource = table;
                slUserType.DataTextField = "EduLevelName";
                slUserType.DataValueField = "EduLevelCode";
                slUserType.DataBind();
                slUserType.Items.Add(new ListItem("── Chọn Cấp ──", ""));
                slUserType.Items.FindByText("── Chọn Cấp ──").Selected = true;
            }

    } 
    async void LoadEduProvince()
    {
        string UserGroup_DB = HttpContext.Current.Request.Cookies["CC_PhanMemDanhGiaGiaoVien_UserGroup_VSW"].Value; 
        string TenDangNhap_Cookie = HttpContext.Current.Request.Cookies["CC_PhanMemDanhGiaGiaoVien_VSW"].Value;
        string EmployeeID = StaticData.getField("Employee", "EmployeeID", "Username", TenDangNhap_Cookie);

        ClientResponse<List<EduProvince>> result = new ClientResponse<List<EduProvince>>();
        result = await _apiAuthentication.Get_EduProvince_ByUserGroup(UserGroup_DB, int.Parse(EmployeeID));
        if (result != null)
            if (result.Data != null)
            {
                DataTable table = new DataTable();
                table.Columns.Add("EduProvinceId");
                table.Columns.Add("EduProvinceName");

                var edu = result.Data;
                for (int i = 0; i < edu.Count; i++)
                {
                    DataRow row = table.NewRow();
                    row["EduProvinceId"] = edu[i].EduProvinceId;
                    row["EduProvinceName"] = edu[i].EduProvinceName;
                    table.Rows.Add(row);
                }

                slEduProvince.DataSource = table;
                slEduProvince.DataTextField = "EduProvinceName";
                slEduProvince.DataValueField = "EduProvinceId";
                slEduProvince.DataBind();
                slEduProvince.Items.Add(new ListItem("── Chọn cấp sở ──", ""));
                slEduProvince.Items.FindByText("── Chọn cấp sở ──").Selected = true;
            }

    }
    void LoadDanhSach()
    {
        string sql = "";
        sql += @"select * from
                (
                  SELECT ROW_NUMBER() OVER(order by EmployeeId desc)AS RowNumber
                  ,Em.* , EL.EduLevelName
                  FROM Employee Em LEFT JOIN EduLevel EL ON EL.EduLevelCode=Em.EduLevelCode where '1'='1'   ";
        if (pChuoiTimKiem != "")
            sql += " and (EmployeeName like N'%" + pChuoiTimKiem + "%' OR PhoneNumber LIKE '%" + pChuoiTimKiem + "%' OR Address LIKE '%" + pChuoiTimKiem + "%' )";
        if (pQuyen != "")
            sql += " and Em.EduLevelCode = '" + pQuyen + "'";
        sql += ") as tb1 ";
        int AllRowNumber = Connect.GetTable(sql).Rows.Count;
        sql += "WHERE RowNumber BETWEEN (" + Page_web + " - 1) * " + PageSize + " + 1 AND (((" + Page_web + " - 1) * " + PageSize + " + 1) + " + PageSize + ") - 1";

        System.Data.DataTable table = Connect.GetTable(sql);
        SetPage(AllRowNumber);

        string html = @"<table class='table table-bordered table-hover'>
                                <thead>
                                    <tr>
                                        <th class='bg-" + themeColor + @"' style='max-width:5rem;'>#</th> 
                                        <th class='bg-" + themeColor + @"' style='min-width:15rem;'>HỌ TÊN</th>
                                        <th class='bg-" + themeColor + @"'>MÃ NHÂN VIÊN</th> 
                                        <th class='bg-" + themeColor + @"'>SĐT</th> 
                                        <th class='bg-" + themeColor + @"'>ĐỊA CHỈ</th> 
                                        <th class='bg-" + themeColor + @"'>CẤP</th>
                                        <th class='bg-" + themeColor + @" align-center'></th>
                                    </tr>
                                </thead>
                                <tbody>";
        if (table != null)
        {
            for (int i = 0; i < table.Rows.Count; i++)
            {
                html += @"          <tr>
                                        <th scope='row'>" + (((Page_web - 1) * PageSize) + i + 1) + @"</th> 
                                        <td>" + table.Rows[i]["EmployeeName"] + @"</td> 
                                        <td>" + table.Rows[i]["EmployeeCode"] + @"</td>
                                        <td>" + table.Rows[i]["PhoneNumber"] + @"</td>  
                                        <td>" + table.Rows[i]["Address"] + @"</td> 
                                        <td>" + table.Rows[i]["EduLevelName"] + @"</td>  
                                        <td class='align-center text-nowrap'>";
                html += "                       <a onclick='OpenModal_EditUser(" + table.Rows[i]["EmployeeId"] + ")' class='btn bg-green waves-effect' style='padding: 0 7px 3px 7px;' data-toggle='tooltip' data-placement='top' title='' data-original-title='Sửa'><i class='fa fa-pencil'></i></a>";
                if (tenDangNhap_HienTai != table.Rows[i]["UserName"].ToString().Trim())
                    html += "                       <a onclick='DeleteUser(" + table.Rows[i]["EmployeeId"] + ")' class='btn bg-red waves-effect' style='padding: 0 7px 3px 7px;' data-toggle='tooltip' data-placement='top' title='' data-original-title='Xoá'><i class='fa fa-trash'></i></a>";
                html += @"              </td> 
                                    </tr>   ";
            }
            html += "   <tr>";
            html += "       <td colspan='15' class='footertable align-center'>";
            string url = "Section_User.aspx?";
            if (pChuoiTimKiem != "")
                url += "CTK=" + pChuoiTimKiem + "&";
            if (pQuyen != "")
                url += "Quyen=" + pQuyen + "&";
            url += "Page=";
            html += @"<ul class='pagination margin-0'>
                          <li><a href='" + url + txtFistPage + @"' class='waves-effect'><i class='material-icons'>chevron_left</i></a></li>";

            //Page 1
            if (txtPage1 != "")
                html += "<li " + (Page_web.ToString() == txtPage1 ? "class='active'" : "") + "><a href='" + url + txtPage1 + "' class='waves-effect " + (Page_web.ToString() == txtPage1 ? "bg-" + themeColor : "") + "'>" + txtPage1 + "</a></li>";
            else
                html += "    <li class='hidden'><a href='" + url + txtPage1 + "' class='waves-effect'>" + txtPage1 + "</a></li>";
            //Page 2
            if (txtPage2 != "")
                html += "    <li " + (Page_web.ToString() == txtPage2 ? "class='active'" : "") + "><a href='" + url + txtPage2 + "' class='waves-effect " + (Page_web.ToString() == txtPage2 ? "bg-" + themeColor : "") + "'>" + txtPage2 + "</a></li>";
            else
                html += "    <li class='hidden'><a href='" + url + txtPage2 + "' class='waves-effect'>" + txtPage2 + "</a></li>";
            //Page 3
            if (txtPage3 != "")
                html += "    <li " + (Page_web.ToString() == txtPage3 ? "class='active'" : "") + "><a href='" + url + txtPage3 + "' class='waves-effect " + (Page_web.ToString() == txtPage3 ? "bg-" + themeColor : "") + "'>" + txtPage3 + "</a></li>";
            else
                html += "    <li class='hidden'><a href='" + url + txtPage3 + "' class='waves-effect'>" + txtPage3 + "</a></li>";
            //Page 4
            if (txtPage4 != "")
                html += "    <li " + (Page_web.ToString() == txtPage4 ? "class='active'" : "") + "><a href='" + url + txtPage4 + "' class='waves-effect " + (Page_web.ToString() == txtPage4 ? "bg-" + themeColor : "") + "'>" + txtPage4 + "</a></li>";
            else
                html += "    <li class='hidden'><a href='" + url + txtPage4 + "' class='waves-effect'>" + txtPage4 + "</a></li>";
            //Page 5
            if (txtPage5 != "")
                html += "    <li " + (Page_web.ToString() == txtPage5 ? "class='active'" : "") + "><a href='" + url + txtPage5 + "' class='waves-effect " + (Page_web.ToString() == txtPage5 ? "bg-" + themeColor : "") + "'>" + txtPage5 + "</a></li>";
            else
                html += "    <li class='hidden'><a href='" + url + txtPage5 + "' class='waves-effect'>" + txtPage5 + "</a></li>";

            html += @"       <li><a href='" + url + txtLastPage + @"' class='waves-effect'><i class='material-icons'>chevron_right</i></a></li>
                        </ul>";
            html += "   </td></tr>";
        }

        html += @"              </tbody>
                            </table>";
        dvtable.InnerHtml = html;
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

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        string CTK = txtSearch.Value.Trim();
        string Quyen = slUserType.Value.Trim();

        string url = "Section_User.aspx?";
        if (CTK != "")
            url += "CTK=" + CTK + "&";
        if (Quyen != "--- Tất cả quyền---")
            url += "Quyen=" + Quyen + "&";
        Response.Redirect(url);
    }
}