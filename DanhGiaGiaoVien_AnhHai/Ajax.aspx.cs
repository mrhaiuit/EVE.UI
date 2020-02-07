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

public partial class Ajax : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
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
            ///////////////////////////////  THỐNG KÊ 
            case "LoadNhaCungCap_choPopup":
                LoadNhaCungCap_choPopup(); break;
            case "LoadVatTu_choPopup":
                LoadVatTu_choPopup(); break;
            case "LoadTraLai_choPopup":
                LoadTraLai_choPopup(); break;

            case "LoadChiTietThu":
                LoadChiTietThu(); break;
            case "LoadChiTietChi":
                LoadChiTietChi(); break; 
            ///////////////////////////////  QL THU
            case "ThemQLThu":
                ThemQLThu(); break;
            case "CapNhatQLThu":
                CapNhatQLThu(); break;
            case "XoaQLThu":
                XoaQLThu(); break;
            ///////////////////////////////  QL Chi
            case "ThemQLChi":
                ThemQLChi(); break;
            case "CapNhatQLChi":
                CapNhatQLChi(); break;
            case "XoaQLChi":
                XoaQLChi(); break; 

        }
    }
    private void Logout()
    {
        HttpCookie CC_QLCongTrinh_KimNgoc_VSW = new HttpCookie("CC_QLCongTrinh_KimNgoc_VSW", "");
        CC_QLCongTrinh_KimNgoc_VSW.Expires = DateTime.Now;
        HttpContext.Current.Response.Cookies.Add(CC_QLCongTrinh_KimNgoc_VSW);
        Response.Write("Success");
    }
    void ChangeTheme()
    {
        string color = StaticData.ValidParameter(Request.QueryString["color"]);

        if (Request.Cookies["CC_QLCongTrinh_KimNgoc_VSW"] != null)
        {
            string Username = Request.Cookies["CC_QLCongTrinh_KimNgoc_VSW"].Value.Trim();
            if (Connect.Exec(" update tb_NguoiDung set themeSoftware='" + color + "' where tendangnhap='" + Username + "' "))
                Response.Write("Success");
        }
    }
    ///////////////////////////////////////  NGƯỜI DÙNG
    #region NGƯỜI DÙNG 
    void CheckPasswordOLD()
    {
        if (Request.Cookies["CC_QLCongTrinh_KimNgoc_VSW"] != null)
        {
            string PasswordOLD = StaticData.ValidParameter(Request.QueryString["PasswordOLD"].Trim());
            string TenDangNhap = Request.Cookies["CC_QLCongTrinh_KimNgoc_VSW"].Value.Trim();
            string PasswordDB = StaticData.getField("tb_NguoiDung", "Matkhau", "TenDangNhap", TenDangNhap).Trim();
            if (PasswordOLD == PasswordDB)
                Response.Write("OK");
            else
                Response.Write("NOT");
        }
    }
    void CheckUsername()
    {
        if (Request.Cookies["CC_QLCongTrinh_KimNgoc_VSW"] != null)
        {
            string Username = StaticData.ValidParameter(Request.QueryString["Username"].Trim());
            string TenDangNhap_OLD = Request.Cookies["CC_QLCongTrinh_KimNgoc_VSW"].Value.Trim();

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
        string user = StaticData.ValidParameter(Request.QueryString["user"]);
        string LinkHinhAnh = StaticData.getField("tb_NguoiDung", "LinkHinhDaiDien", "idNguoiDung", user);
        if (Connect.Exec("delete from tb_NguoiDung where idNguoiDung='" + user + "'"))
        {
            try
            {
                File.Delete(System.Web.Hosting.HostingEnvironment.ApplicationPhysicalPath + "/images/image-user/" + LinkHinhAnh);
            }
            catch { }
            Response.Write("Success");
        }
    }
    void AddNewUser()
    {
        string MaNguoiDUng = StaticData.ValidParameter(Request.QueryString["CodeUser"].Trim());
        string HoTen = StaticData.ValidParameter(Request.QueryString["FullnameUser"].Trim());
        string Email = StaticData.ValidParameter(Request.QueryString["EmailUser"].Trim());
        string SDT = StaticData.ValidParameter(Request.QueryString["PhoneUser"].Trim());
        string idLoaiNguoiDung = StaticData.ValidParameter(Request.QueryString["UserType"].Trim());
        string TenDangNhap = StaticData.ValidParameter(Request.QueryString["Username"].Trim());

        DataTable table_checkExist_tenDangNhap = Connect.GetTable("select * from tb_NguoiDung where TenDangNhap = '" + TenDangNhap + "' ");
        DataTable table_checkExist_maNhanVien = Connect.GetTable("select * from tb_NguoiDung where MaNguoiDUng = '" + MaNguoiDUng + "' ");
        if (table_checkExist_tenDangNhap.Rows.Count > 0)
        {
            Response.Write("SameUsername");
            return;
        }
        else if (table_checkExist_maNhanVien.Rows.Count > 0)
        {
            //Response.Write("SameCode");
            //return;
        }

        string sql = @" insert into tb_NguoiDung(HoTen, SDT,Email,TenDangNhap,MatKhau,idLoaiNguoiDung)
                        values( 
                                N'" + HoTen + @"' , 
                                '" + SDT + @"' ,
                                '" + Email + @"' ,
                                " + (TenDangNhap == "" ? "NULL" : "'" + TenDangNhap + "'") + @" ,
                                " + (TenDangNhap == "" ? "NULL" : "'" + "123" + "'") + @" ,
                                '" + idLoaiNguoiDung + @"'
                              ) ";

        if (Connect.Exec(sql))
            Response.Write("Success");
    }
    void LoadInfoUser()
    {
        string idNguoiDung = StaticData.ValidParameter(Request.QueryString["user"].Trim());
        string sql = "select * from tb_NguoiDung where idNguoiDung ='" + idNguoiDung + "' ";
        DataTable table = Connect.GetTable(sql);
        if (table.Rows.Count > 0)
        {
            string kq = "cc" + "@_@" + table.Rows[0]["HoTen"] + "@_@" + table.Rows[0]["SDT"] + "@_@" + table.Rows[0]["Email"] + "@_@" + table.Rows[0]["TenDangNhap"] + "@_@" + table.Rows[0]["idLoaiNguoiDung"];
            Response.Write(kq);
        }
    }
    void EditUser()
    {
        string idNguoiDung = StaticData.ValidParameter(Request.QueryString["user"].Trim());
        string MaNguoiDUng = StaticData.ValidParameter(Request.QueryString["CodeUser"].Trim());
        string MaNguoiDUng_OLD = StaticData.getField("tb_NguoiDung", "MaNguoiDung", "idNguoiDung", idNguoiDung);
        string HoTen = StaticData.ValidParameter(Request.QueryString["FullnameUser"].Trim());
        string Email = StaticData.ValidParameter(Request.QueryString["EmailUser"].Trim());
        string SDT = StaticData.ValidParameter(Request.QueryString["PhoneUser"].Trim());
        string idLoaiNguoiDung = StaticData.ValidParameter(Request.QueryString["UserType"].Trim());
        string TenDangNhap = StaticData.ValidParameter(Request.QueryString["Username"].Trim());
        string TenDangNhap_OLD = StaticData.getField("tb_NguoiDung", "TenDangNhap", "idNguoiDung", idNguoiDung);

        //string MaNguoiDung_CheckExist = StaticData.getField("tb_nguoiDung", "MaNguoiDung", "MaNguoiDung", MaNguoiDUng).Trim();
        //if (MaNguoiDung_CheckExist != "" && MaNguoiDung_CheckExist != MaNguoiDUng_OLD)
        //{
        //    Response.Write("SameCode");
        //    return;
        //}

        string TenDangNhap_CheckExist = StaticData.getField("tb_nguoiDung", "TenDangNhap", "TenDangNhap", TenDangNhap).Trim();
        if (TenDangNhap_CheckExist != "" && TenDangNhap_CheckExist != TenDangNhap_OLD)
        {
            Response.Write("SameUsername");
            return;
        }
        string sql = @" update tb_NguoiDung 
                        SET  
                             HoTen = N'" + HoTen + @"' , 
                             SDT = '" + SDT + @"' ,
                             Email = '" + Email + @"' ,
                             TenDangNhap = " + (TenDangNhap == "" ? "NULL" : "'" + TenDangNhap + "'") + @" ,
                             MatKhau = " + (TenDangNhap == "" ? "NULL" : "'" + TenDangNhap + "'") + @" ,
                             idLoaiNguoiDung = '" + idLoaiNguoiDung + @"'
                        where idnguoiDung='" + idNguoiDung + @"'";
        if (Connect.Exec(sql))
            Response.Write("Success");
    }
    #endregion   
    ///////////////////////////////////////   THỐNG KÊ
    #region THỐNG KÊ

    void LoadNhaCungCap_choPopup()
    {
        string html = "";
        string idCongTrinh = Request.QueryString["idCongTrinh"].Trim();
        string Nam = Request.QueryString["Nam"].Trim();
        if (Nam != "" && Nam != "undefined")
            Nam = "and NgayMua >= '01/01/" + Nam + " 00:00:00' and NgayMua<= '12/31/" + Nam + " 23:59:59' ";
        else
            Nam = "";
        string sql_idNhaCC = string.Format("select idNhaCC from tb_Vattu where idcongtrinh ='{0}' {1} group by idNhaCC", idCongTrinh, Nam);
        DataTable table_NhaCC = Connect.GetTable(sql_idNhaCC);
        for (int i = 0; i < table_NhaCC.Rows.Count; i++)
        {
            string sql = string.Format("select SoLuong,DonGia from tb_vattu where idNhaCC ='{0}' and idCongTrinh = '{1}' {2} ", table_NhaCC.Rows[i]["idNhaCC"], idCongTrinh, Nam);
            DataTable table = Connect.GetTable(sql);

            html += @"    <tr>
                                <td>" + (i + 1) + @"</td>
                                <td>" + StaticData.getField("tb_NhaCungCap", "TenNhaCC", "idNhaCC", table_NhaCC.Rows[i]["idNhaCC"].ToString()) + @"</td>";
            ///////////
            string NamTra = "";
            if (Nam != "" && Nam != "undefined")
                NamTra = Nam.Replace("NgayMua", "NgayTra");
            else
                NamTra = "";
            string sql_TongTienDaTra = string.Format("select SoTien from tb_lichsuTraNo1 where idnhacc = '{0}' {1} ", table_NhaCC.Rows[i]["idNhaCC"], NamTra);
            decimal TongSoTienDaTra = 0;
            DataTable table_TongTienDaTra = Connect.GetTable(sql_TongTienDaTra);
            for (int k = 0; k < table_TongTienDaTra.Rows.Count; k++)
            {
                try
                {
                    TongSoTienDaTra += decimal.Parse(table.Rows[k]["SoTien"].ToString());
                }
                catch { }
            }
            ///////////////
            decimal TongNo_Cua1NhaCungCap = 0;
            for (int j = 0; j < table.Rows.Count; j++)
            {
                try
                {
                    TongNo_Cua1NhaCungCap += (decimal.Parse(table.Rows[j]["SoLuong"].ToString()) * decimal.Parse(table.Rows[j]["DonGia"].ToString())) - TongSoTienDaTra;
                }
                catch { }
            }

            html += @"          <td style='text-align:center;vertical-align: inherit;font-size:14px;'>" + TongNo_Cua1NhaCungCap.ToString("##,0") + @"</td>
                          </tr>";

        }
        Response.Write(html.Trim());
    }
    void LoadVatTu_choPopup()
    {
        string Nam = Request.QueryString["Nam"].Trim();
        if (Nam != "" && Nam != "undefined")
            Nam = "and NgayMua >= '01/01/" + Nam + " 00:00:00' and NgayMua<= '12/31/" + Nam + " 23:59:59' ";
        else
            Nam = "";
        string sql = string.Format("select DonGia,SoLuong,TenVatTu,idCongTrinh,ngaymua from tb_vatTu where idNhaCC = '{0}' {1} ", Request.QueryString["idNhaCC"].Trim(), Nam);
        DataTable table = Connect.GetTable(sql);
        string html = "";
        for (int i = 0; i < table.Rows.Count; i++)
        {
            decimal DonGia = decimal.Parse(table.Rows[i]["DonGia"].ToString());
            decimal SoLuong = decimal.Parse(table.Rows[i]["SoLuong"].ToString());
            decimal ThanhTien = DonGia * SoLuong;
            html += @"      <tr>
                                <td class='' >" + (i + 1) + @"</td>
                                <td class='text-center' >" + StaticData.ConvertMMDDYYtoDDMMYY(table.Rows[i]["NgayMua"].ToString()) + @"</td>
                                <td class='' >" + table.Rows[i]["TenVatTu"] + @"</td>
                                <td class='text-right' >" + SoLuong.ToString("#,##") + @"</td>
                                <td class='text-right' >" + DonGia.ToString("#,##") + @"</td>
                                <td class='text-right' >" + ThanhTien.ToString("#,##") + @"</td>
                                <td class='' >" + StaticData.getField("tb_Congtrinh", "TenCongTrinh", "idCongTrinh", table.Rows[i]["idCongTrinh"].ToString()) + @"</td>
                            </tr>";
        }
        Response.Write(html.Trim());
    }
    void LoadTraLai_choPopup()
    {
        string sql = string.Format("select * from tb_TraLai where maNganHang = '{0}' ", Request.QueryString["idNganHang"].Trim());
        string html = "";
        DataTable table = Connect.GetTable(sql);
        if (table != null && table.Rows.Count > 0)
        {
            for (int i = 0; i < table.Rows.Count; i++)
            {
                html += @" <tr>
                                <td class='' >" + (i + 1) + @"</td> 
                                <td class='text-center' >" + StaticData.ConvertMMDDYYtoDDMMYY(table.Rows[i]["NgayTra"].ToString()) + @"</td>
                                <td class='text-right' >" + (decimal.Parse(table.Rows[i]["SoTien"].ToString())).ToString("#,##") + @"</td> 
                                <td class='' >" + table.Rows[i]["NoiDung"].ToString() + @"</td>
                                <td class='' >" + table.Rows[i]["GhiChu"].ToString() + @"</td>
                            </tr>";
            }
        }
        Response.Write(html);
    }


    void LoadChiTietThu()
    {
        var idKhoanThuChi = Request.QueryString["idKhoanThuChi"].Trim();
        var Nam = Request.QueryString["Nam"].Trim();
        if (Nam.Trim() != "")
            Nam = @" and NgayThu >= '01/01/" + Nam + @" 00:00:00' and NgayThu <= '12/31/" + Nam + @" 23:59:59'  ";


        string html = "";
        string sql = "select * from tb_Thu THU LEFT JOIN tb_KhoanThuChi KTC ON KTC.idKhoanThuChi=THU.idKhoanThuChi where THU.idKhoanThuChi = " + idKhoanThuChi + Nam + " order by NgayThu desc";
        DataTable table = Connect.GetTable(sql);
        if (table != null)
            for (int i = 0; i < table.Rows.Count; i++)
            {
                html += @" <tr>
                                <td class='font-12'>" + (i + 1) + @"</td>
                                <td class='font-12'>" + StaticData.getField("tb_KhoanThuChi", "TenKhoan", "idKhoanThuChi", table.Rows[i]["idKhoanThuChi"].ToString()) + @"</td>
                                <td class='font-12 text-center'>" + StaticData.ConvertMMDDYYtoDDMMYY(table.Rows[i]["NgayThu"].ToString()) + @"</td> 
                                <td class='font-12 text-right'>" + decimal.Parse(table.Rows[i]["SoTien"].ToString()).ToString("##,0") + @"</td> 
                                <td class='font-12' style='min-width:150px;'>" + table.Rows[i]["NoiDung"].ToString() + @"</td> 
                                <td class='font-12'>" + table.Rows[i]["GhiChu"].ToString() + @"</td> 
                            </tr>";
            }
        Response.Write(html);
    }
    void LoadChiTietChi()
    {
        var idKhoanThuChi = Request.QueryString["idKhoanThuChi"].Trim();
        var Nam = Request.QueryString["Nam"].Trim();
        if (Nam.Trim() != "")
            Nam = @" and NgayChi >= '01/01/" + Nam + @" 00:00:00' and NgayChi <= '12/31/" + Nam + @" 23:59:59'  ";


        string html = "";
        string sql = "select * from tb_ChiTieu CT LEFT JOIN tb_KhoanThuChi KTC ON KTC.idKhoanThuChi=CT.idKhoanThuChi  where CT.idKhoanThuChi = " + idKhoanThuChi + Nam + " order by NgayCHi desc";
        DataTable table = Connect.GetTable(sql);
        if (table != null)
            for (int i = 0; i < table.Rows.Count; i++)
            {
                html += @" <tr>
                                <td class='font-12'>" + (i + 1) + @"</td>
                                <td class='font-12'>" + table.Rows[i]["TenKhoan"] + @"</td>
                                <td class='font-12 text-center'>" + StaticData.ConvertMMDDYYtoDDMMYY(table.Rows[i]["NgayChi"].ToString()) + @"</td> 
                                <td class='font-12 text-right'>" + decimal.Parse(table.Rows[i]["SoTien"].ToString()).ToString("##,0") + @"</td> 
                                <td class='font-12' style='min-width:150px;'>" + table.Rows[i]["NoiDung"].ToString() + @"</td> 
                                <td class='font-12'>" + table.Rows[i]["GhiChu"].ToString() + @"</td> 
                            </tr>";
            }
        string a = decimal.Parse(table.Compute("Sum(SoTien)", string.Empty).ToString()).ToString("##,0");
        Response.Write(html);
    }
    #endregion 

    ///////////////////////////////////////   QL THU
    #region QL THU
    void ThemQLThu()
    {
        var arr = (Request.QueryString["chuoi"].Trim()).Split(new[] { "@_@" }, StringSplitOptions.None);
        arr[0] = StaticData.ConvertDDMMtoMMDD(arr[0]);

        string sql = string.Format(@" insert into tb_Thu(NgayThu,SoTien,idKhoanThuChi,NoiDung,GhiChu)
                                      values('{0}',N'{1}',N'{2}',N'{3}',N'{4}')", arr[0], arr[1], arr[2], arr[3], arr[4]);
        if (Connect.Exec(sql))
            Response.Write("Success");
    }
    void CapNhatQLThu()
    {
        var arr = (Request.QueryString["chuoi"].Trim()).Split(new[] { "@_@" }, StringSplitOptions.None);
        arr[0] = StaticData.ConvertDDMMtoMMDD(arr[0]);
        string sql = string.Format(@" update tb_Thu 
                                      set NgayThu = '{0}', SoTien= N'{1}', idKhoanThuChi= N'{2}', NoiDung= N'{3}', GhiChu= N'{4}'
                                      where idThu = '{5}' ", arr[0], arr[1], arr[2], arr[3], arr[4], arr[5]);

        if (Connect.Exec(sql))
            Response.Write("Success");
    }
    void XoaQLThu()
    {
        string id = Request.QueryString["Thu"].Trim();
        string sql = string.Format("delete from tb_Thu where idThu = '{0}' ", id);

        if (Connect.Exec(sql))
            Response.Write("Success");
    }
    #endregion

    ///////////////////////////////////////   QL Chi
    #region QL CHI
    void ThemQLChi()
    {
        var arr = (Request.QueryString["chuoi"].Trim()).Split(new[] { "@_@" }, StringSplitOptions.None);
        arr[0] = StaticData.ConvertDDMMtoMMDD(arr[0]);

        string sql = string.Format(@" insert into tb_ChiTieu(NgayChi,SoTien,idKhoanThuChi,NoiDung,GhiChu)
                                      values('{0}',N'{1}',N'{2}',N'{3}',N'{4}')", arr[0], arr[1], arr[2], arr[3], arr[4]);
        if (Connect.Exec(sql))
            Response.Write("Success");
    }
    void CapNhatQLChi()
    {
        var arr = (Request.QueryString["chuoi"].Trim()).Split(new[] { "@_@" }, StringSplitOptions.None);
        arr[0] = StaticData.ConvertDDMMtoMMDD(arr[0]);
        string sql = string.Format(@" update tb_ChiTieu 
                                      set NgayChi = '{0}', SoTien= N'{1}', idKhoanThuChi= N'{2}', NoiDung= N'{3}', GhiChu= N'{4}'
                                      where idChiTieu = '{5}' ", arr[0], arr[1], arr[2], arr[3], arr[4], arr[5]);

        if (Connect.Exec(sql))
            Response.Write("Success");
    }
    void XoaQLChi()
    {
        string id = Request.QueryString["Chi"].Trim();
        string sql = string.Format("delete from tb_ChiTieu where idChiTieu = '{0}' ", id);

        if (Connect.Exec(sql))
            Response.Write("Success");
    }
    #endregion 
}