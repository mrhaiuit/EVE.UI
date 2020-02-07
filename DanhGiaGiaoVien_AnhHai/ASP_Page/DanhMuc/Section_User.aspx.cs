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
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["CC_QLCongTrinh_KimNgoc_VSW"] != null)
        {
            string TenDangNhap_Cookie = HttpContext.Current.Request.Cookies["CC_QLCongTrinh_KimNgoc_VSW"].Value; 
            string idLoaiNguoiDung = StaticData.getField("tb_NguoiDung", "idLoaiNguoiDung", "TenDangNhap", TenDangNhap_Cookie.ToString());
            themeColor = StaticData.getField("tb_NguoiDung", "themeSoftware", "TenDangNhap", TenDangNhap_Cookie);
            breadscrumColor.Attributes.Add("class", "breadcrumb breadcrumb-col-" + themeColor);

            mQuyen = StaticData.getField("tb_LoaiNguoiDung", "TenLoaiNguoiDung", "idLoaiNguoiDung", idLoaiNguoiDung);
            if (mQuyen != "Admin")
                Response.Redirect("../Home/Default.aspx");
        }
        else
            Response.Redirect("../Home/Login.aspx");

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
            Load_SelectHTML("select * from tb_LoaiNguoiDung", "TenLoaiNguoiDung", "idLoaiNguoiDung", true, "-- Chọn quyền --", slUserType);
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
    void LoadDanhSach()
    {
        string sql = "";
        sql += @"select * from
                (
                  SELECT ROW_NUMBER() OVER(order by idNguoiDung desc)AS RowNumber
                  ,ND.* , LND.TenLoaiNguoiDung
                  FROM tb_NguoiDung ND LEFT JOIN tb_LoaiNguoiDung LND ON LND.idLoaiNguoiDung=ND.idLoaiNguoiDung where '1'='1'   ";
        if (pChuoiTimKiem != "")
            sql += " and (HoTen like N'%" + pChuoiTimKiem + "%' OR SDT LIKE '%" + pChuoiTimKiem + "%' OR Email LIKE '%" + pChuoiTimKiem + "%' OR TenDangNhap LIKE N'%" + pChuoiTimKiem + "%' )";
        if (pQuyen != "")
            sql += " and ND.idLoaiNguoiDung = '" + pQuyen + "'";
        sql += ") as tb1 ";
        int AllRowNumber = Connect.GetTable(sql).Rows.Count;
        sql += "WHERE RowNumber BETWEEN (" + Page_web + " - 1) * " + PageSize + " + 1 AND (((" + Page_web + " - 1) * " + PageSize + " + 1) + " + PageSize + ") - 1";

        System.Data.DataTable table = Connect.GetTable(sql);
        SetPage(AllRowNumber);

        string html = @"<table class='table table-bordered table-hover'>
                                <thead>
                                    <tr>
                                        <th class='bg-" + themeColor + @"' style='max-width:5rem;'>#</th> 
                                        <th class='bg-" + themeColor + @"' style='min-width:20rem;'>HỌ TÊN</th>
                                        <th class='bg-" + themeColor + @"'>QUYỀN</th> 
                                        <th class='bg-" + themeColor + @"'>SĐT</th>
                                        <th class='bg-" + themeColor + @"'>EMAIL</th>
                                        <th class='bg-" + themeColor + @"'>ĐỊA CHỈ</th> 
                                        <th class='bg-" + themeColor + @"'>TÊN ĐĂNG NHẬP</th> 
                                        <th class='bg-" + themeColor + @"'>MẬT KHẨU</th> 
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
                                        <td>" + table.Rows[i]["HoTen"] + @"</td> 
                                        <td>" + table.Rows[i]["TenLoaiNguoiDung"] + @"</td>
                                        <td>" + table.Rows[i]["SDT"] + @"</td> 
                                        <td>" + table.Rows[i]["Email"] + @"</td> 
                                        <td>" + table.Rows[i]["DiaChi"] + @"</td> 
                                        <td>" + table.Rows[i]["TenDangNhap"] + @"</td> 
                                        <td>" + table.Rows[i]["MatKhau"] + @"</td> 
                                        <td class='align-center'>";
                html += "                       <a onclick='OpenModal_EditUser(" + table.Rows[i]["idNguoiDung"] + ")' class='btn bg-green waves-effect' style='padding: 0 7px 3px 7px;' data-toggle='tooltip' data-placement='top' title='' data-original-title='Sửa'><i class='fa fa-pencil'></i></a>";
                if(tenDangNhap_HienTai != table.Rows[i]["TenDangNhap"].ToString().Trim())
                    html += "                       <a onclick='DeleteUser("+ table.Rows[i]["idNguoiDung"] + ")' class='btn bg-red waves-effect' style='padding: 0 7px 3px 7px;' data-toggle='tooltip' data-placement='top' title='' data-original-title='Xoá'><i class='fa fa-trash'></i></a>";
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