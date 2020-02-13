using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class QuanLyNhapKho_NhapKho : System.Web.UI.Page
{ 
    string mQuyen;
    string idNguoiDung = "";
    string tenDangNhap_HienTai = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["CC_PhanMemDanhGiaGiaoVien_VSW"] != null)
        {
            string TenDangNhap_Cookie = HttpContext.Current.Request.Cookies["CC_PhanMemDanhGiaGiaoVien_VSW"].Value;
            idNguoiDung = StaticData.getField("tb_NguoiDung", "idNguoiDung", "TenDangNhap", TenDangNhap_Cookie.ToString());
            string idLoaiNguoiDung = StaticData.getField("tb_NguoiDung", "idLoaiNguoiDung", "TenDangNhap", TenDangNhap_Cookie.ToString());

            mQuyen = StaticData.getField("tb_LoaiNguoiDung", "TenLoaiNguoiDung", "idLoaiNguoiDung", idLoaiNguoiDung);
        }
        else
        {
            Response.Redirect("../Home/Login.aspx");
        }

        if (!IsPostBack)
        {
            LoadThongTinNguoiDung();
        }
    }

    void LoadThongTinNguoiDung()
    {
        DataTable table = Connect.GetTable("select * from tb_NguoiDung ND LEFT JOIN tb_LoaiNguoiDung LND ON LND.idLoaiNguoiDung=ND.idLoaiNguoiDung Where idNguoiDung=" + idNguoiDung);
        if (table.Rows.Count > 0)
        {
            h3FullnameUser.InnerHtml = txtFullName.Value = table.Rows[0]["HoTen"].ToString();
            pUserType.InnerHtml = table.Rows[0]["TenLoaiNguoiDung"].ToString();
            if (File.Exists(System.Web.Hosting.HostingEnvironment.ApplicationPhysicalPath + "/images/image-user/" + table.Rows[0]["LinkHinhDaiDien"]))
                imgAvatar.Src = "../../images/image-user/" + table.Rows[0]["LinkHinhDaiDien"];

            if (File.Exists(System.Web.Hosting.HostingEnvironment.ApplicationPhysicalPath + "/images/image-user/" + table.Rows[0]["LinkAnhBia"]))
                imgCoverImage.Src = "../../images/image-user/" + table.Rows[0]["LinkAnhBia"];

            txtEmail.Value = table.Rows[0]["Email"].ToString();
            txtPhoneNumber.Value = table.Rows[0]["SDT"].ToString();
            txtUsername.Value = table.Rows[0]["TenDangNhap"].ToString(); 
        }
    }
     
    protected void btnSaveInfo_Click(object sender, EventArgs e)
    {
        string linkHinhDaiDIen_OLD = StaticData.getField("tb_NguoiDung", "LinkHinhDaiDien", "idNguoiDung", idNguoiDung);
        string linkAnhBia_OLD = StaticData.getField("tb_NguoiDung", "LinkAnhBia", "idNguoiDung", idNguoiDung);

        string HoTen = txtFullName.Value.Trim();
        string Email =txtEmail.Value.Trim();
        string SDT = txtPhoneNumber.Value.Trim();  
        string TenDangNhap = txtUsername.Value.Trim();

        string linkHinhDaiDIen = "";
        string linkAnhBia = ""; 

        string linkHinhDaiDIen_DB = "";
        string linkAnhBia_DB = "";

        if (fuAvatarImage.HasFile && DaThayDoi_imgAvatar.Value == "1")
        {
            linkHinhDaiDIen = HoTen.Replace("'", "''") + "_" + DateTime.Now.ToString("dddd-dd-MMM-yyyy-HH-mm-ss-ms") + "_Avatar" + Path.GetExtension(fuAvatarImage.PostedFile.FileName);
        }
        else
            linkHinhDaiDIen = linkHinhDaiDIen_OLD;

        if (fuCoverImage.HasFile && DaThayDoi_imgCoverImage.Value == "1")
        {
            linkAnhBia = HoTen.Replace("'", "''")+ "_" + DateTime.Now.ToString("dddd-dd-MMM-yyyy-HH-mm-ss-ms") + "_Cover" + Path.GetExtension(fuCoverImage.PostedFile.FileName);
        }
        else
            linkAnhBia = linkAnhBia_OLD;

        if (linkHinhDaiDIen == "" && DaThayDoi_imgAvatar.Value == "1")
            linkHinhDaiDIen_DB = "NULL";
        else
            linkHinhDaiDIen_DB = " '" + linkHinhDaiDIen + "'";

        if (linkAnhBia == "" && DaThayDoi_imgCoverImage.Value == "1")
            linkAnhBia_DB = "NULL";
        else
            linkAnhBia_DB = " '" + linkAnhBia + "'";

        string sql = @" update tb_NguoiDung 
                        SET  
                             HoTen = '" + HoTen + @"' , 
                             SDT = '" + SDT + @"' ,
                             Email = '" + Email + @"' ,
                             LinkHinhDaiDien = " + linkHinhDaiDIen_DB + @" ,
                             LinkAnhBia = " + linkAnhBia_DB + @" ,
                             TenDangNhap = " + (TenDangNhap == "" ? "NULL" : "'" + TenDangNhap + "'") + @"
                        where 
                            idnguoiDung='" + idNguoiDung + @"'";
        if (Connect.Exec(sql))
        {
            try
            {
                if (linkHinhDaiDIen_OLD.Trim() != "" && linkHinhDaiDIen.Trim() != "" && DaThayDoi_imgAvatar.Value == "1")
                {
                    File.Delete(Server.MapPath(linkHinhDaiDIen_OLD).Replace("ASP_page\\Pages\\", "images\\image-user\\"));
                    fuAvatarImage.SaveAs(Server.MapPath(linkHinhDaiDIen).Replace("ASP_page\\Pages\\", "images\\image-user\\"));
                }
                else if (linkHinhDaiDIen_OLD.Trim() == "" && linkHinhDaiDIen.Trim() != "" && DaThayDoi_imgAvatar.Value == "1")
                    fuAvatarImage.SaveAs(Server.MapPath(linkHinhDaiDIen).Replace("ASP_page\\Pages\\", "images\\image-user\\"));
            }
            catch { }
            try
            {
                if (linkAnhBia_OLD.Trim() != "" && linkAnhBia.Trim() != "" && DaThayDoi_imgCoverImage.Value == "1")
                {
                    File.Delete(Server.MapPath(linkAnhBia_OLD).Replace("ASP_page\\Pages\\", "images\\image-user\\"));
                    fuCoverImage.SaveAs(Server.MapPath(linkAnhBia).Replace("ASP_page\\Pages\\", "images\\image-user\\"));
                }
                else if (linkAnhBia_OLD.Trim() == "" && linkAnhBia.Trim() != "" && DaThayDoi_imgCoverImage.Value == "1")
                    fuCoverImage.SaveAs(Server.MapPath(linkAnhBia).Replace("ASP_page\\Pages\\", "images\\image-user\\"));
            }
            catch { }

            HttpCookie CC_PhanMemDanhGiaGiaoVien_VSW = new HttpCookie("CC_PhanMemDanhGiaGiaoVien_VSW", "");
            CC_PhanMemDanhGiaGiaoVien_VSW.Expires = DateTime.Now;
            HttpContext.Current.Response.Cookies.Add(CC_PhanMemDanhGiaGiaoVien_VSW);

            HttpCookie CC_PhanMemDanhGiaGiaoVien_VSW_NEW = new HttpCookie("CC_PhanMemDanhGiaGiaoVien_VSW", TenDangNhap); 
            CC_PhanMemDanhGiaGiaoVien_VSW_NEW.Expires = DateTime.Now.AddDays(7);
            HttpContext.Current.Response.Cookies.Add(CC_PhanMemDanhGiaGiaoVien_VSW_NEW);

            Response.Write("<script type='text/javascript'>"); 
            Response.Write("document.location.href='" + Page.Request.Url + "';");
            Response.Write("</script>");
        }
    }

    protected void btnChangePassword_Click(object sender, EventArgs e)
    {
        string MatKhau = txtPasswordNEW.Value.Trim();
        if(Connect.Exec("update tb_NguoiDung set MatKhau= '"+MatKhau+"' where idNguoiDung='"+idNguoiDung+"'"))
        {
            Response.Write("<script type='text/javascript'>");
            Response.Write("alert('Đã thay đổi mật khẩu thành công !');");
            Response.Write("document.location.href='" + Page.Request.Url + "';");
            Response.Write("</script>");
        }
    }
}