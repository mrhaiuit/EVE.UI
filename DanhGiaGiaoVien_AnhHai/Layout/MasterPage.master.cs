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
        if (Request.Cookies["CC_PhanMemDanhGiaGiaoVien_VSW"] != null)
        {
            string TenDangNhap_Cookie = HttpContext.Current.Request.Cookies["CC_PhanMemDanhGiaGiaoVien_VSW"].Value;
            idNguoiDung = StaticData.getField("Employee", "EmployeeId", "UserName", TenDangNhap_Cookie.ToString()); 

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
        string sqlTTND = "SELECT * FROM Employee WHERE EmployeeId = '" + idNguoiDung + "'";

        DataTable tb = Connect.GetTable(sqlTTND);
        if (tb.Rows.Count > 0)
        {
            //idbody.Attributes.Add("class", "theme-" + tb.Rows[0]["themeSoftware"]);
            idbody.Attributes.Add("class", "theme-" + "cyan");
            UserFullname.InnerHtml = tb.Rows[0]["EmployeeName"].ToString();
            emailUser.InnerHtml = tb.Rows[0]["PhoneNumber"].ToString();

            //if (System.IO.File.Exists(System.Web.Hosting.HostingEnvironment.ApplicationPhysicalPath + "/images/image-user/" + ""))
            //    avatarUser.Src = "../images/image-user/" + tb.Rows[0]["LinkHinhDaiDien"];

            //if (System.IO.File.Exists(System.Web.Hosting.HostingEnvironment.ApplicationPhysicalPath + "/images/image-user/" + tb.Rows[0]["LinkAnHBia"].ToString()))
            //    user_info.Attributes.Add("style", "background:url('../../images/image-user/" + tb.Rows[0]["LinkAnHBia"] + "') no-repeat no-repeat;background-size:cover;");
        }
    }
    private void LoadMenu()
    {
        string URL = HttpContext.Current.Request.Url.AbsoluteUri.ToUpper();
        string html = "";

        html += @"
                    <ul class='list' >
                       <li class='header'>MAIN NAVIGATION</li>"; 
         
        {
            html += @"  <li " + ((URL.Contains("/SECTION_")) ? " class='active'" : "") + @">
                            <a href='javascript:void(0);' class='menu-toggle' data-toggle='tooltip' data-placement='right' title='' data-original-title='DANH MỤC'>
                                <i class='material-icons'>view_module</i>
                                <span>DANH MỤC</span>
                            </a>
                            <ul class='ml-menu'>";
            //if (mQuyen == "ADMIN")
                html += @"     <li " + ((URL.Contains("/SECTION_USER.ASPX")) ? " class='active'" : "") + @" data-toggle='tooltip' data-placement='right' title='' data-original-title='Danh mục người dùng'>
                                    <a href='../../ASP_page/DanhMuc/SECTION_USER.aspx' class='toggled waves-effect waves-block' >
                                          <span>Người dùng</span>
                                    </a>
                                </li>  ";
            //if (mQuyen == "ADMIN")
            html += @"     <li " + ((URL.Contains("/SECTION_DOTDANHGIA.ASPX")) ? " class='active'" : "") + @" data-toggle='tooltip' data-placement='right' title='' data-original-title='Danh mục đợt đánh giá'>
                                    <a href='../../ASP_page/DanhMuc/SECTION_DOTDANHGIA.aspx' class='toggled waves-effect waves-block' >
                                          <span>Đợt đánh giá</span>
                                    </a>
                                </li>  ";
            //if (mQuyen == "ADMIN")
            html += @"     <li " + ((URL.Contains("/SECTION_TIEUCHUANTIEUCHI.ASPX")) ? " class='active'" : "") + @" data-toggle='tooltip' data-placement='right' title='' data-original-title='Tiêu chuẩn/tiêu chí'>
                                    <a href='../../ASP_page/DanhMuc/SECTION_TIEUCHUANTIEUCHI.aspx' class='toggled waves-effect waves-block' >
                                          <span>Tiêu chuẩn/tiêu chí</span>
                                    </a>
                                </li>  ";
            //if (mQuyen == "ADMIN")
            html += @"     <li " + ((URL.Contains("/SECTION_PHONGGIAODUC.ASPX")) ? " class='active'" : "") + @" data-toggle='tooltip' data-placement='right' title='' data-original-title='Phòng giáo dục'>
                                    <a href='../../ASP_page/DanhMuc/SECTION_PHONGGIAODUC.aspx' class='toggled waves-effect waves-block' >
                                          <span>Phòng giáo dục</span>
                                    </a>
                                </li>  ";
            //if (mQuyen == "ADMIN")
            html += @"     <li " + ((URL.Contains("/SECTION_TRUONGHOC.ASPX")) ? " class='active'" : "") + @" data-toggle='tooltip' data-placement='right' title='' data-original-title='Trường học'>
                                    <a href='../../ASP_page/DanhMuc/SECTION_TRUONGHOC.aspx' class='toggled waves-effect waves-block' >
                                          <span>Trường học</span>
                                    </a>
                                </li>  ";
            //if (mQuyen == "ADMIN")
            html += @"     <li " + ((URL.Contains("/SECTION_CAPQUYEN.ASPX")) ? " class='active'" : "") + @" data-toggle='tooltip' data-placement='right' title='' data-original-title='Phân quyền'>
                                    <a href='../../ASP_page/DanhMuc/SECTION_CAPQUYEN.aspx' class='toggled waves-effect waves-block' >
                                          <span>Phân quyền</span>
                                    </a>
                                </li>  ";
            html += @"      </ul>
                        </li>";
        } 


        //if (mQuyen == "ADMIN" || mQuyen == "THỦ QUỸ")
        {
            html += @" <li " + ((URL.Contains("DANHGIAGIAOVIEN.ASPX")) ? " class='active'" : "") + @">
                            <a href='../../ASP_page/DANHGIAGIAOVIEN.aspx' data-toggle='tooltip' data-placement='right' title='' data-original-title='Đánh giá giáo viên'>
                                <i class='material-icons'>contacts</i>
                                <span>ĐÁNH GIÁ GIÁO VIÊN</span>
                            </a>
                        </li>";
        }

        html += @"</ul>";

        MainNavigation.InnerHtml = html;
    }



}
