using EVE.Commons.Response;
using EVE.Data;
using EVE.TransportLayer;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Home_Login : System.Web.UI.Page
{
    ApiAuthentication _apiAuthentication = new ApiAuthentication();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (HttpContext.Current.Request.Cookies.Get("CC_PhanMemDanhGiaGiaoVien_VSW") == null)
        {
            if (!IsPostBack)
            {
                //Load_SelectHTML("select * from UserGroup order by idx asc", "UserGroupName", "UserGroupCode", true, "─ Chọn nhóm người dùng ─", slUserGroup);
            }
        }
    }

    protected async void btnLogin_Click(object sender, EventArgs e)
    {
        string Username = (txtUsername.Value);
        string Password = (txtPassword.Value);
        string UserGroup = txtUserGroup.Value.Trim();

        if (Username.Trim() == "")
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Vui lòng nhập tên đăng nhập !')", true);
        else if (Password.Trim() == "")
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Vui lòng nhập mật khẩu !')", true);
        else if (UserGroup.Trim() == "")
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Vui lòng chọn nhóm người dùng !')", true);
        else if (Username.Any(c => c > 255) || Password.Any(c => c > 255))
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Vui lòng không nhập ký tự có dấu vào tên đăng nhập và mật khẩu !')", true);
        else
        {
            ClientResponse<LoginUser> result = new ClientResponse<LoginUser>();
            result = await _apiAuthentication.Login(Username, Password);
            if (result != null)
            {
                if (result.Data != null)
                {
                    HttpCookie CC_PhanMemDanhGiaGiaoVien_VSW = new HttpCookie("CC_PhanMemDanhGiaGiaoVien_VSW", Username);
                    CC_PhanMemDanhGiaGiaoVien_VSW.Expires = DateTime.Now.AddDays(30);
                    HttpContext.Current.Response.Cookies.Add(CC_PhanMemDanhGiaGiaoVien_VSW);
                    ////////
                    HttpCookie CC_PhanMemDanhGiaGiaoVien_UserGroup_VSW = new HttpCookie("CC_PhanMemDanhGiaGiaoVien_UserGroup_VSW", UserGroup);
                    CC_PhanMemDanhGiaGiaoVien_UserGroup_VSW.Expires = DateTime.Now.AddDays(30);
                    HttpContext.Current.Response.Cookies.Add(CC_PhanMemDanhGiaGiaoVien_UserGroup_VSW);

                    Response.Redirect("../Home/Default.aspx");
                }
                else
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Sai mật khẩu')", true); 
            }
        }
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