using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using Zen.Barcode;
using System.Text;
using EVE.TransportLayer;
using EVE.Data;

public partial class Ajax : System.Web.UI.Page
{
    ApiAuthentication _apiAuthentication = new ApiAuthentication();

    protected async void Page_Load(object sender, EventArgs e)
    {
        string action = Request.QueryString["Action"].Trim();
        switch (action)
        {
            //Đăng xuất 
            case "Logout":
                Logout(); break;
            case "ChangeTheme":
                ChangeTheme(); break;
            ///////////////////////////////  NGƯỜI DÙNG  
            case "DeleteUser":
                DeleteUser(); break;
            case "AddNewUser":
                AddNewUser(); break;
            case "LoadInfoUser":
                LoadInfoUser(); break;
            case "EditUser":
                EditUser(); break;
            case "CheckUsername":
                CheckUsername(); break;
            case "CheckPasswordOLD":
                CheckPasswordOLD(); break;
            case "Load_EduDepartment":
                Load_EduDepartment(); break;
            case "Load_EduSchoold":
                Load_EduSchoold(); break;
            ///////////////////////////////  NGƯỜI DÙNG  
            case "slSoGiaoDuc_onchange":
                slSoGiaoDuc_onchange(); break;
            case "AddTruongHoc":
                AddTruongHoc(); break;

        }
    }
    private void Logout()
    {
        HttpCookie CC_PhanMemDanhGiaGiaoVien_VSW = new HttpCookie("CC_PhanMemDanhGiaGiaoVien_VSW", "");
        CC_PhanMemDanhGiaGiaoVien_VSW.Expires = DateTime.Now;
        HttpContext.Current.Response.Cookies.Add(CC_PhanMemDanhGiaGiaoVien_VSW);
        Response.Write("Success");
    }
    void ChangeTheme()
    {
        string color = (Request.QueryString["color"]);

        if (Request.Cookies["CC_PhanMemDanhGiaGiaoVien_VSW"] != null)
        {
            string Username = Request.Cookies["CC_PhanMemDanhGiaGiaoVien_VSW"].Value.Trim();
            if (Connect.Exec(" update tb_NguoiDung set themeSoftware='" + color + "' where tendangnhap='" + Username + "' "))
                Response.Write("Success");
        }
    }
    ///////////////////////////////////////  NGƯỜI DÙNG
    #region NGƯỜI DÙNG 
    void Load_EduDepartment()
    {
        string IDEduProvince = (Request.QueryString["IDEduProvince"].Trim());
        string html = "<option value=''>-- Chọn cấp Phòng --</option>";
        DataTable table = Connect.GetTable(@"select EduDepartmentId,EduDepartmentName from EduDepartment where EduProvinceId='" + IDEduProvince + "'");

        for (int i = 0; i < table.Rows.Count; i++)
            html += "<option value='" + table.Rows[i]["EduDepartmentId"] + "'>" + table.Rows[i]["EduDepartmentName"] + "</option>";

        Response.Write(html);
    }
    void Load_EduSchoold()
    {
        string IDEduDepartment = (Request.QueryString["IDEduDepartment"].Trim());
        string html = "<option value=''>-- Chọn cấp Trường --</option>";
        DataTable table = Connect.GetTable(@"select SchoolId, School from School where EduDepartmentId='" + IDEduDepartment + "'");

        for (int i = 0; i < table.Rows.Count; i++)
            html += "<option value='" + table.Rows[i]["SchoolId"] + "'>" + table.Rows[i]["School"] + "</option>";

        Response.Write(html);
    }
    void CheckPasswordOLD()
    {
        if (Request.Cookies["CC_PhanMemDanhGiaGiaoVien_VSW"] != null)
        {
            string PasswordOLD = (Request.QueryString["PasswordOLD"].Trim());
            string TenDangNhap = Request.Cookies["CC_PhanMemDanhGiaGiaoVien_VSW"].Value.Trim();
            string PasswordDB = StaticData.getField("tb_NguoiDung", "Matkhau", "TenDangNhap", TenDangNhap).Trim();
            if (PasswordOLD == PasswordDB)
                Response.Write("OK");
            else
                Response.Write("NOT");
        }
    }
    void CheckUsername()
    {
        if (Request.Cookies["CC_PhanMemDanhGiaGiaoVien_VSW"] != null)
        {
            string Username = (Request.QueryString["Username"].Trim());
            string TenDangNhap_OLD = Request.Cookies["CC_PhanMemDanhGiaGiaoVien_VSW"].Value.Trim();

            string TenDangNhap_CheckExist = StaticData.getField("tb_nguoiDung", "TenDangNhap", "TenDangNhap", Username).Trim();
            if (TenDangNhap_CheckExist != "" && TenDangNhap_CheckExist != TenDangNhap_OLD)
            {
                Response.Write("SameUsername");
                return;
            }
            else
                Response.Write("OK");
        }
    }
    void DeleteUser()
    {
        string user = (Request.QueryString["user"]);
        // string LinkHinhAnh = StaticData.getField("tb_NguoiDung", "LinkHinhDaiDien", "idNguoiDung", user);
        if (Connect.Exec("delete from Employee where EmployeeId='" + user + "'"))
        {
            //try
            //{
            //    File.Delete(System.Web.Hosting.HostingEnvironment.ApplicationPhysicalPath + "/images/image-user/" + LinkHinhAnh);
            //}
            //catch { }
            Response.Write("Success");
        }
    }
    void AddNewUser()
    {
        string[] chuoi = (Request.QueryString["chuoi"].Trim()).Split(new[] { "@_@" }, StringSplitOptions.None);
        //0 : FullnameUser 
        //1 : PhoneUser 
        //2 : AddresslUser 
        //3 : CodeUser 
        //4 : Username 
        //5 : Password 
        //6 : UserType 
        //7 : Active 
        //8 : GhiChu 
        //9 : MinistryofEducationaCode
        //10 : EduProvinceId
        //11 : EduDepartmentId
        //12 : SchoolId

        DataTable table_checkExist_tenDangNhap = Connect.GetTable("select * from Employee where Username = '" + chuoi[4] + "' ");
        DataTable table_checkExist_maNhanVien = Connect.GetTable("select * from Employee where EmployeeCode = '" + chuoi[3] + "' ");
        if (table_checkExist_tenDangNhap.Rows.Count > 0)
        {
            Response.Write("SameUsername");
            return;
        }
        else if (table_checkExist_maNhanVien.Rows.Count > 0)
        {
            Response.Write("SameCode");
            return;
        }

        string sql = @" insert into Employee (EmployeeName, PhoneNumber,Address ,EmployeeCode,UserName,Password, EduLevelCode, Active, Remarks, 
                                               MinistryofEducationaCode, EduProvinceId, EduDepartmentId, SchoolId)

                        values( @EmployeeName, @PhoneNumber, @Address, @EmployeeCode, @UserName, @Password, @EduLevelCode, @Active, @Remarks, 
                                        @MinistryofEducationaCode, @EduProvinceId, @EduDepartmentId, @SchoolId ) ";

        string[] paraName = new string[13] { "@EmployeeName", "@PhoneNumber", "@Address", "@EmployeeCode", "@UserName", "@Password", "@EduLevelCode", "@Active", "@Remarks",
                                                    "@MinistryofEducationaCode", "@EduProvinceId", "@EduDepartmentId", "@SchoolId" };

        object[] paraValue = new object[13] { chuoi[0], chuoi[1], chuoi[2], chuoi[3], chuoi[4], chuoi[5].EncodePassword() , chuoi[6], chuoi[7], chuoi[8],
                                                    chuoi[9], chuoi[10], chuoi[11], chuoi[12]};

        if (Connect.Exec(sql, paraName, paraValue))
            Response.Write("Success");
    }
    void LoadInfoUser()
    {
        string EmployeeId = (Request.QueryString["user"].Trim());
        string sql = "select * from Employee where EmployeeId ='" + EmployeeId + "' ";
        DataTable table = Connect.GetTable(sql);
        if (table.Rows.Count > 0)
        {
            string kq = table.Rows[0]["EmployeeName"] + "@_@" + table.Rows[0]["PhoneNumber"] + "@_@" + table.Rows[0]["Address"] + "@_@" + table.Rows[0]["EmployeeCode"]
                      + "@_@" + table.Rows[0]["UserName"] + "@_@" + table.Rows[0]["Password"] + "@_@" + table.Rows[0]["EduLevelCode"] + "@_@" + table.Rows[0]["Active"]
                       + "@_@" + table.Rows[0]["Remarks"]
                        + "@_@" + table.Rows[0]["MinistryofEducationaCode"] + "@_@" + table.Rows[0]["EduProvinceId"] + "@_@" + table.Rows[0]["EduDepartmentId"] + "@_@" + table.Rows[0]["SchoolId"];
            Response.Write(kq);
        }
    }
    void EditUser()
    {
        string idNguoiDung = (Request.QueryString["user"].Trim());
        string MaNguoiDUng_OLD = StaticData.getField("Employee", "EmployeeCode", "EmployeeId", idNguoiDung);
        string TenDangNhap_OLD = StaticData.getField("Employee", "UserName", "EmployeeId", idNguoiDung);

        string[] chuoi = (Request.QueryString["chuoi"].Trim()).Split(new[] { "@_@" }, StringSplitOptions.None);
        //0 : FullnameUser 
        //1 : PhoneUser 
        //2 : AddresslUser 
        //3 : CodeUser 
        //4 : Username 
        //5 : Password 
        //6 : UserType 
        //7 : Active 
        //8 : GhiChu 
        //9 : MinistryofEducationaCode
        //10 : EduProvinceId
        //11 : EduDepartmentId
        //12 : SchoolId

        string MaNguoiDung_CheckExist = StaticData.getField("Employee", "EmployeeCode", "EmployeeCode", chuoi[3]).Trim();
        if (MaNguoiDung_CheckExist != "" && MaNguoiDung_CheckExist != MaNguoiDUng_OLD)
        {
            Response.Write("SameCode");
            return;
        }

        string TenDangNhap_CheckExist = StaticData.getField("Employee", "UserName", "UserName", chuoi[4]).Trim();
        if (TenDangNhap_CheckExist != "" && TenDangNhap_CheckExist != TenDangNhap_OLD)
        {
            Response.Write("SameUsername");
            return;
        }
        string sql = @" update Employee 
                        SET  
                             EmployeeName = @EmployeeName,
                             PhoneNumber = @PhoneNumber,
                             Address = @Address ,
                             EmployeeCode = @EmployeeCode,
                             UserName = @UserName,
                             Password = @Password,
                             EduLevelCode = @EduLevelCode, 
                             Active  = @Active, 
                             Remarks = @Remarks, 
                             MinistryofEducationaCode = @MinistryofEducationaCode, 
                             EduProvinceId = @EduProvinceId, 
                             EduDepartmentId = @EduDepartmentId, 
                             SchoolId = @SchoolId
                        where EmployeeId= @EmployeeId";
        string[] paraName = new string[14] { "@EmployeeName", "@PhoneNumber", "@Address", "@EmployeeCode", "@UserName", "@Password", "@EduLevelCode", "@Active", "@Remarks",
                                                    "@MinistryofEducationaCode", "@EduProvinceId", "@EduDepartmentId", "@SchoolId","@EmployeeId" };

        object[] paraValue = new object[14] { chuoi[0], chuoi[1], chuoi[2], chuoi[3], chuoi[4], chuoi[5].EncodePassword() , chuoi[6],  (chuoi[7] =="True"? "1":"0"), chuoi[8],
                                                     (chuoi[9] ==""? Convert.DBNull:chuoi[9]), (chuoi[10] ==""? Convert.DBNull:chuoi[10]), (chuoi[11] ==""? Convert.DBNull:chuoi[11]), (chuoi[12] ==""? Convert.DBNull:chuoi[12]), idNguoiDung};
        if (Connect.Exec(sql, paraName, paraValue))
            Response.Write("Success");
    }
    #endregion
    ///////////////////////////////////////  TRƯỜNG HỌC
    #region TRƯỜNG HỌC
    void slSoGiaoDuc_onchange()
    {
        string DataValue = Request.QueryString["DataValue"].Trim();

    }
    async void AddTruongHoc()
    {
        string[] DataValue = Request.QueryString["value"].Trim().Split(new[] { "@_@" }, StringSplitOptions.None);
        //0 : TenTruong
        //1 : TenDuong
        //2 : EduProvinceID
        //3 : EduDepartmentID
        //4 : SchoolLevelCode
        //5 : Province
        //6 : District
        //7 : Ward 
        School sch = new School
        {
            School1 = DataValue[0]
        };

        var result = await _apiAuthentication.Insert_School(sch);
        if (!result.IsError)
            Response.Write("Success");
    }
    #endregion
}