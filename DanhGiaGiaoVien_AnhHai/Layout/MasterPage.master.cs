using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Layout_MasterPage : System.Web.UI.MasterPage
{
    string idNguoiDung = "";
    string mQuyen = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["CC_QLCongTrinh_KimNgoc_VSW"] != null)
        {
            string TenDangNhap_Cookie = HttpContext.Current.Request.Cookies["CC_QLCongTrinh_KimNgoc_VSW"].Value;
            idNguoiDung = StaticData.getField("tb_NguoiDung", "idNguoiDung", "TenDangNhap", TenDangNhap_Cookie.ToString());
            string idLoaiNguoiDung = StaticData.getField("tb_NguoiDung", "idLoaiNguoiDung", "TenDangNhap", TenDangNhap_Cookie.ToString());

            mQuyen = StaticData.getField("tb_LoaiNguoiDung", "TenLoaiNguoiDung", "idLoaiNguoiDung", idLoaiNguoiDung);

            LoadThongTinNguoiDung();
        }
        else
        {
            Response.Redirect("../Home/Login.aspx");
        }

        if (!IsPostBack)
        {
            LoadMenu();
        }
    }
    private void LoadThongTinNguoiDung()
    {
        string sqlTTND = "SELECT * FROM tb_NguoiDung WHERE idNguoiDung = '" + idNguoiDung + "'";

        DataTable tb = Connect.GetTable(sqlTTND);
        if (tb.Rows.Count > 0)
        {
            idbody.Attributes.Add("class", "theme-" + tb.Rows[0]["themeSoftware"].ToString());
            UserFullname.InnerHtml = tb.Rows[0]["HoTen"].ToString();
            emailUser.InnerHtml = tb.Rows[0]["Email"].ToString();

            if (System.IO.File.Exists(System.Web.Hosting.HostingEnvironment.ApplicationPhysicalPath + "/images/image-user/" + tb.Rows[0]["LinkHinhDaiDien"].ToString()))
                avatarUser.Src = "../images/image-user/" + tb.Rows[0]["LinkHinhDaiDien"];

            if (System.IO.File.Exists(System.Web.Hosting.HostingEnvironment.ApplicationPhysicalPath + "/images/image-user/" + tb.Rows[0]["LinkAnHBia"].ToString()))
                user_info.Attributes.Add("style", "background:url('../../images/image-user/" + tb.Rows[0]["LinkAnHBia"] + "') no-repeat no-repeat;background-size:cover;");
        }
    }
    private void LoadMenu()
    {
        string URL = HttpContext.Current.Request.Url.AbsoluteUri.ToUpper();
        string html = "";

        html += @"
                    <ul class='list' >
                       <li class='header'>MAIN NAVIGATION</li>";
        mQuyen = mQuyen.ToUpper(); 

        if (mQuyen == "ADMIN" || mQuyen == "USER" )
        {
            html += @"  <li " + ((URL.Contains("/SECTION_")) ? " class='active'" : "") + @">
                            <a href='javascript:void(0);' class='menu-toggle' data-toggle='tooltip' data-placement='right' title='' data-original-title='DANH MỤC'>
                                <i class='material-icons'>view_module</i>
                                <span>DANH MỤC</span>
                            </a>
                            <ul class='ml-menu'>";
            if (mQuyen == "ADMIN")
                html += @"     <li " + ((URL.Contains("/SECTION_USER.ASPX")) ? " class='active'" : "") + @" data-toggle='tooltip' data-placement='right' title='' data-original-title='Danh mục người dùng'>
                                    <a href='../../ASP_page/DanhMuc/Section_User.aspx' class='toggled waves-effect waves-block' >
                                          <span>Người dùng</span>
                                    </a>
                                </li>  "; 
            html += @"      </ul>
                        </li>";
        }

        if (mQuyen == "ADMIN" || mQuyen == "USER" || mQuyen == "THỦ QUỸ")
        {
            html += @"  <li " + ((URL.Contains("/THONGKE/")) ? " class='active'" : "") + @">
                            <a href='javascript:void(0);' class='menu-toggle' data-toggle='tooltip' data-placement='right' title='' data-original-title='THỐNG KÊ'>
                                <i class='material-icons'>insert_chart</i>
                                <span>THỐNG KÊ</span>
                            </a>
                            <ul class='ml-menu'>";
            if (mQuyen == "USER" || mQuyen == "ADMIN")
                html += @"      <li " + ((URL.Contains("/STATISTIC_NOCONGTRINH.ASPX")) ? " class='active'" : "") + @" data-toggle='tooltip' data-placement='right' title='' data-original-title='Thống kê Nợ công trình'>
                                    <a href='../../ASP_page/ThongKe/STATISTIC_NoCongTrinh.aspx' class='toggled waves-effect waves-block' >
                                          <span>Nợ công trình</span>
                                    </a>
                                </li>   "; 
            html += @"       </ul>
                        </li>";
        } 

        if (mQuyen == "ADMIN" || mQuyen == "THỦ QUỸ")
        {
            html += @" <li " + ((URL.Contains("MANAGEMENT_QLTHU.ASPX")) ? " class='active'" : "") + @">
                            <a href='../../ASP_page/QuanLy/MANAGEMENT_QLThu.aspx' data-toggle='tooltip' data-placement='right' title='' data-original-title='QL Thu'>
                                <i class='material-icons'>local_atm</i>
                                <span>QL THU</span>
                            </a>
                        </li>";
        }

        if (mQuyen == "ADMIN" || mQuyen == "THỦ QUỸ")
        {
            html += @" <li " + ((URL.Contains("MANAGEMENT_QLCHI.ASPX")) ? " class='active'" : "") + @">
                            <a href='../../ASP_page/QuanLy/MANAGEMENT_QLChi.aspx' data-toggle='tooltip' data-placement='right' title='' data-original-title='QL Chi'>
                                <i class='material-icons'>local_atm</i>
                                <span>QL CHI</span>
                            </a>
                        </li>";
        }
         
        html += @"</ul>";

        MainNavigation.InnerHtml = html;
    }



}
