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
using EVE.ApiModels.Catalog;
using EVE.ApiModels.Authentication.Request;

public partial class Ajax : System.Web.UI.Page
{
    ApiAuthentication _apiAuthentication = new ApiAuthentication();

    protected void Page_Load(object sender, EventArgs e)
    {
        string action = Request.QueryString["Action"].Trim();
        switch (action)
        {
            //Đăng xuất 
            case "Logout":
                Logout(); break;
            case "txtUserName_onchange":
                txtUserName_onchange(); break;
            case "ChangeTheme":
                ChangeTheme(); break;
            case "slSoGiaoDuc_onchange":
                slSoGiaoDuc_onchange(); break;
            case "slTinhThanh_onchange":
                slTinhThanh_onchange(); break;
            case "slQuanHuyen_onchange":
                slQuanHuyen_onchange(); break;
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
            case "slUserType_onchange":
                slUserType_onchange(); break;
            ///////////////////////////////  TRƯỜNG HỌC 
            case "AddTruongHoc":
                AddTruongHoc(); break;
            case "EditTruongHoc":
                EditTruongHoc(); break;
            case "DeleteTruongHoc":
                DeleteTruongHoc(); break;
            case "LoadTruongHoc":
                LoadTruongHoc(); break;
            ///////////////////////////////  ĐỢT ĐÁNH GIÁ 
            case "AddDotDanhGia":
                AddDotDanhGia(); break;
            case "EditDotDanhGia":
                EditDotDanhGia(); break;
            case "DeleteDotDanhGia":
                DeleteDotDanhGia(); break;
            case "LoadDotDanhGia":
                LoadDotDanhGia(); break;
            case "LoadInfoNhanVien":
                LoadInfoNhanVien(); break;
            ///////////////////////////////  TIÊU CHUẨN 
            case "AddTieuChuan":
                AddTieuChuan(); break;
            case "EditTieuChuan":
                EditTieuChuan(); break;
            case "DeleteTieuChuan":
                DeleteTieuChuan(); break;
            case "LoadTieuChuan":
                LoadTieuChuan(); break;
            case "LoadTieuChi_TrongTieuChuan":
                LoadTieuChi_TrongTieuChuan(); break;
            ///////////////////////////////  TIÊU CHÍ
            case "AddTieuChi":
                AddTieuChi(); break;
            case "EditTieuChi":
                EditTieuChi(); break;
            case "DeleteTieuChi":
                DeleteTieuChi(); break;
            case "LoadTieuChi":
                LoadTieuChi(); break;
            ///////////////////////////////  PHÒNG GIÁO DỤC
            case "AddPhongGiaoDuc":
                AddPhongGiaoDuc(); break;
            case "EditPhongGiaoDuc":
                EditPhongGiaoDuc(); break;
            case "DeletePhongGiaoDuc":
                DeletePhongGiaoDuc(); break;
            case "LoadPhongGiaoDuc":
                LoadPhongGiaoDuc(); break;
            /////////////////////////////// CẤP QUYỀN 
            case "AddCapQuyen":
                AddCapQuyen(); break;
            case "DeleteCapQuyen":
                DeleteCapQuyen(); break;
            case "LoadCapQuyen":
                LoadCapQuyen(); break;
            case "ChangeLockAccount":
                ChangeLockAccount(); break;

        }
    }
    private void Logout()
    {
        HttpCookie CC_PhanMemDanhGiaGiaoVien_VSW = new HttpCookie("CC_PhanMemDanhGiaGiaoVien_VSW", "");
        CC_PhanMemDanhGiaGiaoVien_VSW.Expires = DateTime.Now;
        HttpContext.Current.Response.Cookies.Add(CC_PhanMemDanhGiaGiaoVien_VSW);

        HttpCookie CC_PhanMemDanhGiaGiaoVien_UserGroup_VSW = new HttpCookie("CC_PhanMemDanhGiaGiaoVien_UserGroup_VSW", "");
        CC_PhanMemDanhGiaGiaoVien_UserGroup_VSW.Expires = DateTime.Now;
        HttpContext.Current.Response.Cookies.Add(CC_PhanMemDanhGiaGiaoVien_UserGroup_VSW);

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
    async void slSoGiaoDuc_onchange()
    {
        string DataValue = Request.QueryString["value"].Trim();
        string html = "<option value='' >── Chọn phòng giáo dục ──</option>";
        var result = await _apiAuthentication.GetEduDepartment_ByEduProvinceID(int.Parse(DataValue == "" ? "0" : DataValue));
        var list = result.Data;
        if (list != null)
            for (int i = 0; i < list.Count; i++)
                html += "<option value='" + list[i].EduDepartmentId + "' >" + list[i].EduDepartmentName + "</option>";
        Response.Write(html);
    }
    async void slTinhThanh_onchange()
    {
        string DataValue = Request.QueryString["value"].Trim();
        string html = "<option value='' >── Chọn quận/huyện ──</option>";
        var result = await _apiAuthentication.GetDistrict_ByProviceID(int.Parse(DataValue == "" ? "0" : DataValue));
        var list = result.Data;
        if (list != null)
            for (int i = 0; i < list.Count; i++)
                html += "<option value='" + list[i].DistrictId + "' >" + list[i].DistrictName + "</option>";
        Response.Write(html);
    }
    async void slQuanHuyen_onchange()
    {
        string DataValue = Request.QueryString["value"].Trim();
        string html = "<option value='' >── Chọn phường/xã ──</option>";
        var result = await _apiAuthentication.GetWard_ByDistrictID(int.Parse(DataValue == "" ? "0" : DataValue));
        var list = result.Data;
        if (list != null)
            for (int i = 0; i < list.Count; i++)
                html += "<option value='" + list[i].WardId + "' >" + list[i].WardName + "</option>";
        Response.Write(html);
    }
    ///////////////////////////////////////  NGƯỜI DÙNG
    #region NGƯỜI DÙNG 
    void Load_EduDepartment()
    {
        string IDEduProvince = (Request.QueryString["IDEduProvince"].Trim());
        string html = "<option value=''>── Chọn cấp Phòng ──</option>";
        DataTable table = Connect.GetTable(@"select EduDepartmentId,EduDepartmentName from EduDepartment where EduProvinceId='" + IDEduProvince + "'");

        for (int i = 0; i < table.Rows.Count; i++)
            html += "<option value='" + table.Rows[i]["EduDepartmentId"] + "'>" + table.Rows[i]["EduDepartmentName"] + "</option>";

        Response.Write(html);
    }
    void Load_EduSchoold()
    {
        string IDEduDepartment = (Request.QueryString["IDEduDepartment"].Trim());
        string html = "<option value=''>── Chọn cấp Trường ──</option>";
        DataTable table = Connect.GetTable(@"select SchoolId, SchoolName from School where EduDepartmentId='" + IDEduDepartment + "'");

        for (int i = 0; i < table.Rows.Count; i++)
            html += "<option value='" + table.Rows[i]["SchoolId"] + "'>" + table.Rows[i]["SchoolName"] + "</option>";

        Response.Write(html);
    }
    async void slUserType_onchange()
    {
        string EduLevelCode = (Request.QueryString["value"].Trim());
        var result = await _apiAuthentication.Get_Position_ByEduLevel(EduLevelCode);
        string html = "<option value='' >── Chọn chức vụ ──</option>";
        if (result != null)
        {
            var pos = result.Data;
            if (pos != null)
            {
                for (int i = 0; i < pos.Count; i++)
                    html += "<option value='" + pos[i].PositionId + "' >" + pos[i].PositionName + "</option>";
            }
        }
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
    async void txtUserName_onchange()
    {
        string userName = Request.QueryString["value"].Trim();
        string html = "<option value=''>─ Chọn nhóm người dùng ─</option>";
        var result = await _apiAuthentication.Get_UserGroup_ByUsername(userName);
        if (result != null)
            if (result.Data != null)
            {
                var UG = result.Data;
                for (int i = 0; i < UG.Count; i++)
                    html += "<option value='" + UG[i].UserGroupCode + "' >" + UG[i].UserGroupName + "</option>";
            }
        Response.Write(html);
    }
    #endregion
    ///////////////////////////////////////  TRƯỜNG HỌC
    #region TRƯỜNG HỌC
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
        SchoolInsertReq sch = new SchoolInsertReq
        {
            SchoolName = DataValue[0],
            Address = DataValue[1],
            EduProvinceId = int.Parse(DataValue[2]),
            EduDepartmentId = int.Parse(DataValue[3]),
            SchoolLevelCode = DataValue[4],
            PhoneNumber = "",
            HotLine = "",
            WardId = int.Parse(DataValue[7]),
            MinistryofEducationaCode = "VNA",
        };
        var result = await _apiAuthentication.Insert_School(sch);
        if (!result.IsError)
            Response.Write("Success");
    }
    async void LoadTruongHoc()
    {
        string DataValue = Request.QueryString["value"].Trim();
        var result = await _apiAuthentication.GetSchool_ById(int.Parse(DataValue == "" ? "0" : DataValue));
        string KQ = "";
        if (result != null)
        {
            var School = result.Data;
            if (School != null)
            {
                string DistrictID = StaticData.getField("ward", "districtID", "wardID", School.WardId + "");
                string ProvinceID = StaticData.getField("district", "ProvinceID", "districtID", DistrictID);

                KQ = School.EduProvinceId + "@_@" + School.EduDepartmentId + "@_@" + School.SchoolLevelCode + "@_@" + School.SchoolName + "@_@" + School.Address + "@_@" + ProvinceID + "@_@" + DistrictID + "@_@" + School.WardId;
            }
        }
        Response.Write(KQ);
    }
    async void EditTruongHoc()
    {
        string ID = Request.QueryString["TruongHoc"].Trim();
        string[] DataValue = Request.QueryString["value"].Trim().Split(new[] { "@_@" }, StringSplitOptions.None);
        //0 : TenTruong
        //1 : TenDuong
        //2 : EduProvinceID
        //3 : EduDepartmentID
        //4 : SchoolLevelCode
        //5 : Province
        //6 : District
        //7 : Ward 
        SchoolUpdateReq sch = new SchoolUpdateReq
        {
            SchoolName = DataValue[0],
            Address = DataValue[1],
            EduProvinceId = int.Parse(DataValue[2] == "" ? "0" : DataValue[2]),
            EduDepartmentId = int.Parse(DataValue[3] == "" ? "0" : DataValue[3]),
            SchoolLevelCode = DataValue[4],
            PhoneNumber = "",
            HotLine = "",
            WardId = int.Parse(DataValue[7]),
            MinistryofEducationaCode = "VNA",
            SchoolId = int.Parse(ID == "" ? "0" : ID)
        };


        var result = await _apiAuthentication.Update_School(sch);
        if (result != null)
            if (!result.IsError)
                Response.Write("Success");
    }
    async void DeleteTruongHoc()
    {
        string ID = Request.QueryString["TruongHoc"].Trim();
        var result = await _apiAuthentication.Delete_School(int.Parse(ID == "" ? "0" : ID));
        if (result != null)
            if (!result.IsError)
                Response.Write("Success");
    }
    #endregion
    ///////////////////////////////////////  ĐỢT ĐÁNH GIÁ
    #region ĐỢT ĐÁNH GIÁ 
    async void LoadInfoNhanVien()
    {
        string TenDangNhap_Cookie = HttpContext.Current.Request.Cookies["CC_PhanMemDanhGiaGiaoVien_VSW"].Value;
        string EmployeeID = StaticData.getField("Employee", "EmployeeID", "Username", TenDangNhap_Cookie.ToString());

        var result = await _apiAuthentication.GetEmployee_ById(int.Parse(EmployeeID == "" ? "0" : EmployeeID));
        string KQ = "";
        if (result != null)
        {
            var emp = result.Data;
            if (emp != null)
            {
                KQ = emp.EmployeeName + "@_@" + emp.PhoneNumber + "@_@" + emp.Address + "@_@" + emp.EmployeeCode + "@_@" + emp.UserName + "@_@" + emp.Password + "@_@" +
                       emp.EduLevelCode + "@_@" + emp.Active + "@_@" + emp.Remarks + "@_@" + emp.MinistryofEducationaCode + "@_@" + emp.EduProvinceId + "@_@" + emp.EduDepartmentId + "@_@" + emp.SchoolId;
            }
        }
        Response.Write(KQ);
    }
    async void AddDotDanhGia()
    {
        string[] DataValue = Request.QueryString["value"].Trim().Split(new[] { "@_@" }, StringSplitOptions.None);
        //0 : TenDotDanhGia
        //1 : TuNgay
        //2 : DenNgay
        //3 : Nam
        //4 : TruongHoc 
        EvalPeriodInsertReq peri = new EvalPeriodInsertReq
        {
            PeriodName = DataValue[0],
            FromDate = DateTime.Parse(DataValue[1].ConvertDDMMtoMMDD()),
            ToDate = DateTime.Parse(DataValue[2].ConvertDDMMtoMMDD()),
            Year = int.Parse(DataValue[3] == "" ? "0" : DataValue[3]),
            SchoolId = int.Parse(DataValue[4] == "" ? "0" : DataValue[4]),
        };
        var result = await _apiAuthentication.Insert_EvalPeriod(peri);
        if (result != null)
            if (!result.IsError)
                Response.Write("Success");
    }
    async void LoadDotDanhGia()
    {
        string DataValue = Request.QueryString["value"].Trim();
        var result = await _apiAuthentication.GetEvalPeriod_ById(int.Parse(DataValue == "" ? "0" : DataValue));
        string KQ = "";
        if (result != null)
        {
            var Period = result.Data;
            if (Period != null)
            {
                string EduDepartmentId = StaticData.getField("School", "EduDepartmentId", "SchoolId", Period.SchoolId.ToString());
                string EduProvinceId = StaticData.getField("School", "EduProvinceId", "SchoolId", Period.SchoolId.ToString());

                KQ = Period.PeriodName + "@_@" + Period.FromDate.ToString().ConvertMMDDYYtoDDMMYY() + "@_@" + Period.ToDate.ToString().ConvertMMDDYYtoDDMMYY() + "@_@" + Period.Year + "@_@" + EduProvinceId + "@_@" + EduDepartmentId + "@_@" + Period.SchoolId;
            }
        }
        Response.Write(KQ);
    }
    async void EditDotDanhGia()
    {
        string ID = Request.QueryString["DotDanhGia"].Trim();
        string[] DataValue = Request.QueryString["value"].Trim().Split(new[] { "@_@" }, StringSplitOptions.None);
        //0 : TenDotDanhGia
        //1 : TuNgay
        //2 : DenNgay
        //3 : Nam
        //4 : TruongHoc 
        EvalPeriodUpdateReq peri = new EvalPeriodUpdateReq
        {
            PeriodName = DataValue[0],
            FromDate = DateTime.Parse(DataValue[1].ConvertDDMMtoMMDD()),
            ToDate = DateTime.Parse(DataValue[2].ConvertDDMMtoMMDD()),
            Year = int.Parse(DataValue[3] == "" ? "0" : DataValue[3]),
            SchoolId = int.Parse(DataValue[4] == "" ? "0" : DataValue[4]),
            EvalPeriodId = int.Parse(ID == "" ? "0" : ID)
        };

        var result = await _apiAuthentication.Update_EvalPeriod(peri);
        if (result != null)
            if (!result.IsError)
                Response.Write("Success");
    }
    async void DeleteDotDanhGia()
    {
        string ID = Request.QueryString["DotDanhGia"].Trim();
        var result = await _apiAuthentication.Delete_EvalPeriod(int.Parse(ID == "" ? "0" : ID));
        if (result != null)
            if (!result.IsError)
                Response.Write("Success");
    }
    #endregion
    ///////////////////////////////////////  TIÊU CHUẨN
    #region TIEEU CHUẨN
    async void AddTieuChuan()
    {
        string[] DataValue = Request.QueryString["value"].Trim().Split(new[] { "@_@" }, StringSplitOptions.None);
        //0 : TenTieuChuan
        //1 : GhiChu
        //2 : LoaiTieuChuan
        //3 : CapGiaoDuc
        EvalStandardInsertReq std = new EvalStandardInsertReq
        {
            EvalStandardName = DataValue[0],
            Remarks = DataValue[1],
            EvalTypeCode = DataValue[2],
            SchoolLevelCode = DataValue[3]
        };
        var result = await _apiAuthentication.Insert_EvalStandard(std);
        if (result != null)
            if (!result.IsError)
                Response.Write("Success");
    }
    async void LoadTieuChuan()
    {
        string DataValue = Request.QueryString["value"].Trim();
        var result = await _apiAuthentication.GetEvalStandard_ById(int.Parse(DataValue == "" ? "0" : DataValue));
        string KQ = "";
        var Period = result.Data;
        if (Period != null)
            KQ = Period.EvalStandardName + "@_@" + Period.Remarks + "@_@" + Period.EvalTypeCode + "@_@" + Period.SchoolLevelCode;
        Response.Write(KQ);
    }
    async void EditTieuChuan()
    {
        string ID = Request.QueryString["TieuChuan"].Trim();
        string[] DataValue = Request.QueryString["value"].Trim().Split(new[] { "@_@" }, StringSplitOptions.None);
        //0 : TenTieuChuan
        //1 : GhiChu 
        //2 : LoaiTieuChuan
        //3 : CapGiaoDuc
        EvalStandardUpdateReq peri = new EvalStandardUpdateReq
        {
            EvalStandardName = DataValue[0],
            Remarks = DataValue[1],
            EvalTypeCode = DataValue[2],
            SchoolLevelCode = DataValue[3],
            EvalStandardId = int.Parse(ID == "" ? "0" : ID)
        };

        var result = await _apiAuthentication.Update_EvalStandard(peri);
        if (result != null)
            if (!result.IsError)
                Response.Write("Success");
    }
    async void DeleteTieuChuan()
    {
        string ID = Request.QueryString["TieuChuan"].Trim();
        var result = await _apiAuthentication.Delete_EvalStandard(int.Parse(ID == "" ? "0" : ID));
        if (result != null)
            if (!result.IsError)
                Response.Write("Success");
    }
    async void LoadTieuChi_TrongTieuChuan()
    {
        string ID = Request.QueryString["TieuChuan"].Trim();
        var result = await _apiAuthentication.GetEvalCriteria_ByStandardId(int.Parse(ID == "" ? "0" : ID));
        string html = "";
        if (result != null)
            if (result.Data != null)
            {
                var EvalCriteria = result.Data;
                for (int i = 0; i < EvalCriteria.Count; i++)
                {
                    html += @"<tr>
                                  <td>" + (i + 1) + @"</td>
                                  <td>" + EvalCriteria[i].EvalCriteriaName + @"</td>
                                  <td class='text-nowrap  align-center'>
                                      <a href=" + "\"" + "javascript:DeleteTieuChi(" + EvalCriteria[i].EvalCriteriaId + ",'TrongTieuChuan'," + ID + ");" + "\"" + @" class='btn bg-red waves-effect' style='padding: 0 7px 3px 7px;' data-toggle='tooltip' data-placement='top' title='' data-original-title='Xoá'><i class='fa fa-trash'></i></a>
                                  </td>
                              </tr>";
                }
            }
        Response.Write(html);
    }
    #endregion
    ///////////////////////////////////////  TIÊU CHÍ
    #region TIÊU CHÍ
    async void AddTieuChi()
    {
        string[] DataValue = Request.QueryString["value"].Trim().Split(new[] { "@_@" }, StringSplitOptions.None);
        //0 : TenTieuChi 
        //1 : idTieuChuan 
        //2 : Idx 
        EvalCriteriaInsertReq std = new EvalCriteriaInsertReq
        {
            EvalCriteriaName = DataValue[0],
            EvalStandardId = int.Parse(DataValue[1] == "" ? "0" : DataValue[1]),
            Idx = DataValue[2]
            //Idx = int.Parse(DataValue[2] == "" ? "0" : DataValue[2])
        };
        var result = await _apiAuthentication.Insert_EvalCriteria(std);
        if (result != null)
            if (!result.IsError)
                Response.Write("Success");
    }
    async void LoadTieuChi()
    {
        string DataValue = Request.QueryString["value"].Trim();
        var result = await _apiAuthentication.GetEvalCriteria_ById(int.Parse(DataValue == "" ? "0" : DataValue));
        string KQ = "";
        var Period = result.Data;
        if (Period != null)
            KQ = Period.EvalCriteriaName + "@_@" + Period.Idx;
        Response.Write(KQ);
    }
    async void EditTieuChi()
    {
        string ID = Request.QueryString["TieuChi"].Trim();
        string[] DataValue = Request.QueryString["value"].Trim().Split(new[] { "@_@" }, StringSplitOptions.None);
        //0 : TenTieuChi 
        //1 : idTieuChuan 
        //2 : Idx 
        EvalCriteriaUpdateReq peri = new EvalCriteriaUpdateReq
        {
            EvalCriteriaName = DataValue[0],
            EvalStandardId = int.Parse(DataValue[1] == "" ? "0" : DataValue[1]),
            Idx = DataValue[2],
            EvalCriteriaId = int.Parse(ID == "" ? "0" : ID)
        };

        var result = await _apiAuthentication.Update_EvalCriteria(peri);
        if (result != null)
            if (!result.IsError)
                Response.Write("Success");
    }
    async void DeleteTieuChi()
    {
        string ID = Request.QueryString["TieuChi"].Trim();
        var result = await _apiAuthentication.Delete_EvalCriteria(int.Parse(ID == "" ? "0" : ID));
        if (result != null)
            if (!result.IsError)
                Response.Write("Success");
    }
    #endregion
    ///////////////////////////////////////  PHÒNG GIÁO DỤC
    #region PHÒNG GIAO DỤC
    async void AddPhongGiaoDuc()
    {
        string[] DataValue = Request.QueryString["value"].Trim().Split(new[] { "@_@" }, StringSplitOptions.None);
        //0 : TenPhongGiaoDuc 
        //1 : DiaChi 
        //2 : idTinhThanh
        //3 : idQUanHuyen
        //4 : idPhuongXa
        //5 : Idx
        EduDepartmentInsertReq std = new EduDepartmentInsertReq
        {
            EduDepartmentName = DataValue[0],
            Address = DataValue[1],
            DistrictId = int.Parse(DataValue[3] == "" ? "0" : DataValue[3]),
            Idx = int.Parse(DataValue[5] == "" ? "0" : DataValue[5])
        };
        var result = await _apiAuthentication.Insert_EduDepartment(std);
        if (result != null)
            if (!result.IsError)
                Response.Write("Success");
    }
    async void LoadPhongGiaoDuc()
    {
        string DataValue = Request.QueryString["value"].Trim();
        var result = await _apiAuthentication.GetEduDepartment_ById(int.Parse(DataValue == "" ? "0" : DataValue));
        string KQ = "";
        if (result != null)
        {
            var EduDept = result.Data;
            if (EduDept != null)
            {
                string ProvinceID = StaticData.getField("district", "ProvinceID", "districtID", EduDept.DistrictId + "");
                KQ = EduDept.EduDepartmentName + "@_@" + EduDept.Address + "@_@" + EduDept.Idx + "@_@" + ProvinceID + "@_@" + EduDept.DistrictId;
            }
        }
        Response.Write(KQ);
    }
    async void EditPhongGiaoDuc()
    {
        string ID = Request.QueryString["PhongGiaoDuc"].Trim();
        string[] DataValue = Request.QueryString["value"].Trim().Split(new[] { "@_@" }, StringSplitOptions.None);
        //0 : TenPhongGiaoDuc 
        //1 : DiaChi 
        //2 : idTinhThanh
        //3 : idQUanHuyen
        //4 : idPhuongXa
        //5 : Idx
        EduDepartmentUpdateReq std = new EduDepartmentUpdateReq
        {
            EduDepartmentName = DataValue[0],
            Address = DataValue[1],
            DistrictId = int.Parse(DataValue[3] == "" ? "0" : DataValue[3]),
            Idx = int.Parse(DataValue[5] == "" ? "0" : DataValue[5]),
            EduDepartmentId = int.Parse(ID == "" ? "0" : ID)
        };

        var result = await _apiAuthentication.Update_EduDepartment(std);
        if (result != null)
            if (!result.IsError)
                Response.Write("Success");
    }
    async void DeletePhongGiaoDuc()
    {
        string ID = Request.QueryString["PhongGiaoDuc"].Trim();
        var result = await _apiAuthentication.Delete_EduDepartment(int.Parse(ID == "" ? "0" : ID));
        if (result != null)
            if (!result.IsError)
                Response.Write("Success");
    }
    #endregion
    ///////////////////////////////////////  CẤP QUYỀN
    #region  CẤP QUYỀN
    async void AddCapQuyen()
    {
        string[] DataValue = Request.QueryString["value"].Trim().Split(new[] { "@_@" }, StringSplitOptions.None);
        //0 : NhanVienID 
        //1 : NhomQuyen 
        UserGroupEmployeeInsertReq std = new UserGroupEmployeeInsertReq
        {
            EmployeeId = int.Parse(DataValue[0] == "" ? "0" : DataValue[0]),
            UserGroupCode = DataValue[1]
        };
        var result = await _apiAuthentication.Insert_UserGroup_Employee(std);
        if (result != null)
        {
            if (!result.IsError)
                Response.Write("Success");
            else if (result.Message.ToUpper().Contains("ĐÃ TỒN TẠI"))
                Response.Write("Already");
        }
    }
    async void LoadCapQuyen()
    {
        string NhanVien = Request.QueryString["NhanVien"].Trim();
        string NhomQuyen = Request.QueryString["NhomQuyen"].Trim();
        var result = await _apiAuthentication.Get_UserGroup_Employee_ById(int.Parse(NhanVien == "" ? "0" : NhanVien), NhomQuyen);
        string KQ = "";
        var UG = result.Data;
        if (UG != null)
            KQ = UG.EmployeeId + "@_@" + UG.UserGroupCode;
        Response.Write(KQ);
    }
    async void DeleteCapQuyen()
    {
        string NhanVien = Request.QueryString["NhanVien"].Trim();
        string NhomQuyen = Request.QueryString["NhomQuyen"].Trim();
        var result = await _apiAuthentication.Delete_UserGroup_Employee(int.Parse(NhanVien == "" ? "0" : NhanVien), NhomQuyen);
        if (result != null)
            if (!result.IsError)
                Response.Write("Success");
    }
    void ChangeLockAccount()
    {
        string status = Request.QueryString["status"].Trim();
        string[] id = Request.QueryString["id"].Trim().Split('_');
        //0 : status Active  
        string sql = "update Employee SET Active='" + status + "' where EmployeeID='" + id[1] + "' ";
        if (Connect.Exec(sql))
            Response.Write("Success");
    }
    #endregion
}