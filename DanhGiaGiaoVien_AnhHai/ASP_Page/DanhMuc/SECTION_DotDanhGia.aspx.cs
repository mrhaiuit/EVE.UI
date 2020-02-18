using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ASP_Page_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    { 
        Load_SelectHTML("select * from EduMinistry", "EduMinistryName", "EduMinistryCode", false, "-- Chọn cấp Bộ --", slEduMinistry);
        Load_SelectHTML("select * from EduProvince", "EduProvinceName", "EduProvinceId", true, "-- Chọn cấp Sở --", slEduProvince);

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