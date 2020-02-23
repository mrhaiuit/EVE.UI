using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ASP_Page_Default : System.Web.UI.Page
{ 
    string pNhanVien = "";
    string pKyDanhGia = "";

    string themeColor;
    int Page_web = 1;
    string tenDangNhap_HienTai = "";
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
            Load_SelectHTML("select EvalPeriodName,EvalPeriodID from EvalPeriod", "EvalPeriodName", "EvalPeriodID", false, "── Chọn kỳ đánh giá ──", slKyDanhGia_TimKiem);
            Load_SelectHTML("select EvalPeriodName,EvalPeriodID from EvalPeriod", "EvalPeriodName", "EvalPeriodID", false, "── Chọn giáo viên ──", slGiaoVien_TimKiem);

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
            pKyDanhGia = Request.QueryString["KDG"].ToString();
            slKyDanhGia_TimKiem.Value = pKyDanhGia;
        }
        catch { } 
        try
        {
            pNhanVien = Request.QueryString["NV"].ToString();
            slGiaoVien_TimKiem.Value = pNhanVien;
        }
        catch { }
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