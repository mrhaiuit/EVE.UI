using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Home_Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (HttpContext.Current.Request.Cookies.Get("CC_QLCongTrinh_KimNgoc_VSW") == null)
        {

        } 
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string Username = StaticData.ValidParameter(txtUsername.Value);
        string Password = StaticData.ValidParameter(txtPassword.Value);

        if (Username.Trim() == "")
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Vui lòng nhập tên đăng nhập !')", true); 
        else if (Password.Trim() == "")
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Vui lòng nhập mật khẩu !')", true); 
        else if (Username.Any(c => c > 255) || Password.Any(c => c > 255))
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Vui lòng không nhập ký tự có dấu vào tên đăng nhập và mật khẩu !')", true); 
        else
        {
            string MatKhau_DB = StaticData.getField("tb_NguoiDung", "MatKhau", "TenDangNhap", Username);
            if (Password == MatKhau_DB)
            {
                HttpCookie CC_QLCongTrinh_KimNgoc_VSW = new HttpCookie("CC_QLCongTrinh_KimNgoc_VSW", Username);

                CC_QLCongTrinh_KimNgoc_VSW.Expires = DateTime.Now.AddDays(30);
                HttpContext.Current.Response.Cookies.Add(CC_QLCongTrinh_KimNgoc_VSW);

                Response.Redirect("../Home/Default.aspx");
            }
            else
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Sai mật khẩu')", true); 
        }
    }
}