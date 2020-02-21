using System;
using System.Collections.Generic;
using System.Text;
using System.Security.Cryptography;
using System.Net.NetworkInformation;
using Microsoft.Win32;
using System.Text.RegularExpressions;
using System.IO;
using System.Data.SqlClient;
using System.Data;
using System.Net.Mail;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Globalization;
using Microsoft.VisualBasic;

public static class StaticData
{
    /// <summary>
    /// 
    /// </summary>
    /// <param name="str"></param>
    /// <returns></returns>
    public static string TrimEx(this object str)
    {
        if (str == null)
        {
            return "";
        }

        return Convert.ToString(str).Trim();
    }
    public static string EncodePassword(this string passpwd)
    {
        string returnValue = " ";
        int i;
        int k;
        double strPwd = 0;
        string onechar;
        var ArrPwd = new int[31];

        for (i = 1; i <= passpwd.Length; i++)
        {
            onechar = passpwd.TrimEx().Substring(i - 1, 1);
            if (!Information.IsNumeric(onechar))
            {
                ArrPwd[i] = Strings.Asc(onechar);
            }
            else
            {
                ArrPwd[i] = int.Parse(onechar);
            }
        }

        for (k = 1; k <= i - 1; k++)
        {
            strPwd = strPwd + ArrPwd[k];

            strPwd = strPwd * (k + i);
        }

        returnValue = strPwd.ToString();

        return returnValue;
    }
    public static string KiemTraKhongNhap_LoadLen(this string SoTien)
    {
        string KQ = "0";
        try
        {
            KQ = decimal.Parse(SoTien).ToString();
        }
        catch { }
        return KQ;
    }
    public static string PhanTrang(string url, string txtFistPage, string txtPage1, string txtPage2, string txtPage3, string txtPage4, string txtPage5, string txtLastPage, int Page)
    {
        string html = "";
        html += "           <a class='notepaging' id='page_fist' href='" + url + txtFistPage + "' /><i class='fa fa-step-backward'></i></a>";
        //Page 1
        if (txtPage1 != "")
        {
            if (Page.ToString() == txtPage1)
                html += "           <a id='page_1' class='notepagingactive' href='" + url + txtPage1 + "' />" + txtPage1 + "</a>";
            else
                html += "           <a id='page_1' class='notepaging' href='" + url + txtPage1 + "' />" + txtPage1 + "</a>";
        }
        else
        {
            html += "           <a id='page_1' class='notepagingnone' href='" + url + txtPage1 + "' />" + txtPage1 + "</a>";
        }
        //Page 2
        if (txtPage2 != "")
        {
            if (Page.ToString() == txtPage2)
                html += "           <a id='page_2' class='notepagingactive' href='" + url + txtPage2 + "' />" + txtPage2 + "</a>";
            else
                html += "           <a id='page_2' class='notepaging' href='" + url + txtPage2 + "' />" + txtPage2 + "</a>";
        }
        else
        {
            html += "           <a id='page_2' class='notepagingnone' href='" + url + txtPage2 + "' />" + txtPage2 + "</a>";
        }
        //Page 3
        if (txtPage3 != "")
        {
            if (Page.ToString() == txtPage3)
                html += "           <a id='page_3' class='notepagingactive' href='" + url + txtPage3 + "' />" + txtPage3 + "</a>";
            else
                html += "           <a id='page_3' class='notepaging' href='" + url + txtPage3 + "' />" + txtPage3 + "</a>";
        }
        else
        {
            html += "           <a id='page_3' class='notepagingnone' href='" + url + txtPage3 + "' />" + txtPage3 + "</a>";
        }
        //Page 4
        if (txtPage4 != "")
        {
            if (Page.ToString() == txtPage4)
                html += "           <a id='page_4' class='notepagingactive' href='" + url + txtPage4 + "' />" + txtPage4 + "</a>";
            else
                html += "           <a id='page_4' class='notepaging' href='" + url + txtPage4 + "' />" + txtPage4 + "</a>";
        }
        else
        {
            html += "           <a id='page_4' class='notepagingnone' href='" + url + txtPage4 + "' />" + txtPage4 + "</a>";
        }
        //Page 5
        if (txtPage5 != "")
        {
            if (Page.ToString() == txtPage5)
                html += "           <a id='page_5' class='notepagingactive' href='" + url + txtPage5 + "' />" + txtPage5 + "</a>";
            else
                html += "           <a id='page_5' class='notepaging' href='" + url + txtPage5 + "' />" + txtPage5 + "</a>";
        }
        else
        {
            html += "           <a id='page_5' class='notepagingnone' href='" + url + txtPage5 + "' />" + txtPage5 + "</a>";
        }

        html += "           <a id='page_last' class='notepaging' href='" + url + txtLastPage + "' /><i class='fa fa-step-forward'></i></a>";
        return html;
    }
    public static void LoadWaterMark(System.Web.HttpPostedFile file, string file2)
    {
        //string watermarkText = "shopfull.asia";
        //Đường dẫn file ảnh. 
        //string imageFile = Server.MapPath(file.InputStream);
        string textToWrite = "";

        // Tạo đối tượng Bitmap truyền vào đường dẫn File ảnh
        Bitmap myBitmap = new Bitmap(file.InputStream);
        // Tạo đối tượng Graphic từ Bitmap
        Graphics myGraphics = Graphics.FromImage(myBitmap);
        // Định dạng Style
        StringFormat myStringFormat = new StringFormat();
        myStringFormat.Alignment = StringAlignment.Near;

        myGraphics.TextRenderingHint = System.Drawing.Text.TextRenderingHint.AntiAlias;
        Font myFont = new Font("arial", 35, FontStyle.Bold);

        string colorcode = "#40311eb5";
        int argb = Int32.Parse(colorcode.Replace("#", ""), NumberStyles.HexNumber);
        Color fontColor = Color.FromArgb(169, 169, 169); //Color.WhiteSmoke;
        SolidBrush myBrush = new SolidBrush(fontColor);
        SizeF textSize = new SizeF();
        textSize = myGraphics.MeasureString(textToWrite, myFont);
        Point position = new Point(myBitmap.Width / 2 - ((int)textSize.Width / 2), myBitmap.Height / 2 - ((int)textSize.Height / 2));
        //Point position = new Point((myBitmap.Width / 2 - ((int)textSize.Width / 2)), (myBitmap.Height - ((int)textSize.Height)));
        // Vẽ lại hình ảnh, chèn nội dung mới vào.
        myGraphics.DrawString(textToWrite, myFont, myBrush, position, myStringFormat);

        ////
        int originalW = myBitmap.Width;
        int originalH = myBitmap.Height;
        // lấy chiều rộng và chiều cao mới tương ứng với chiều rộng truyền vào của ảnh (nó sẽ giúp ảnh của chúng ta sau khi resize vần giứ được độ cân đối của tấm ảnh
        if (originalW > 800)
        {
            int resizedW = 800;
            int resizedH = (originalH * resizedW) / originalW;
            Bitmap b = new Bitmap(resizedW, resizedH);
            Graphics g = Graphics.FromImage((Bitmap)b);
            g.InterpolationMode = InterpolationMode.Bicubic;    // Specify here
            g.DrawImage(myBitmap, 0, 0, resizedW, resizedH);
            g.Dispose();
            b.Save(file2);
        }
        else
            ////
            //Xuất hình ảnh mới
            //Response.ContentType = "image/jpeg";
            //myBitmap.Save(Response.OutputStream, ImageFormat.Jpeg);
            myBitmap.Save(file2);
    }

    public static string Get_LastName_FromFullName(string FullName)
    {
        string LastName = "";
        string[] arr = FullName.Split(' ');
        if (arr.Length == 1)
            return FullName;
        else
        {
            for (int i = 0; i < arr.Length; i++)
            {
                if (i < arr.Length - 1)
                    LastName += arr[i] + " ";
            }
            return LastName.Trim();
        }
    }
    public static string Get_FirstName_FromFullName(string FullName)
    {
        string[] arr = FullName.Split(' ');
        if (arr.Length == 1)
            return FullName;
        else
            return arr[arr.Length - 1].Trim();
    }
    public static string ConvertDecimalToString(decimal number)
    {
        string s = number.ToString("#");
        string[] so = new string[] { "không", "một", "hai", "ba", "bốn", "năm", "sáu", "bảy", "tám", "chín" };
        string[] hang = new string[] { "", "nghìn", "triệu", "tỷ" };
        int i, j, donvi, chuc, tram;
        string str = " ";
        bool booAm = false;
        decimal decS = 0;
        //Tung addnew
        try
        {
            decS = Convert.ToDecimal(s.ToString());
        }
        catch
        {
        }
        if (decS < 0)
        {
            decS = -decS;
            s = decS.ToString();
            booAm = true;
        }
        i = s.Length;
        if (i == 0)
            str = so[0] + str;
        else
        {
            j = 0;
            while (i > 0)
            {
                donvi = Convert.ToInt32(s.Substring(i - 1, 1));
                i--;
                if (i > 0)
                    chuc = Convert.ToInt32(s.Substring(i - 1, 1));
                else
                    chuc = -1;
                i--;
                if (i > 0)
                    tram = Convert.ToInt32(s.Substring(i - 1, 1));
                else
                    tram = -1;
                i--;
                if ((donvi > 0) || (chuc > 0) || (tram > 0) || (j == 3))
                    str = hang[j] + str;
                j++;
                if (j > 3) j = 1;
                if ((donvi == 1) && (chuc > 1))
                    str = "một " + str;
                else
                {
                    if ((donvi == 5) && (chuc > 0))
                        str = "lăm " + str;
                    else if (donvi > 0)
                        str = so[donvi] + " " + str;
                }
                if (chuc < 0)
                    break;
                else
                {
                    if ((chuc == 0) && (donvi > 0)) str = "lẻ " + str;
                    if (chuc == 1) str = "mười " + str;
                    if (chuc > 1) str = so[chuc] + " mươi " + str;
                }
                if (tram < 0) break;
                else
                {
                    if ((tram > 0) || (chuc > 0) || (donvi > 0)) str = so[tram] + " trăm " + str;
                }
                str = " " + str;
            }
        }
        if (booAm) str = "Âm " + str;
        return str + "đồng chẵn.";
    }




    public static byte[] turnImageToByteArray(System.Drawing.Image img)
    {
        MemoryStream ms = new MemoryStream();
        img.Save(ms, System.Drawing.Imaging.ImageFormat.Bmp);
        return ms.ToArray();
    }
    public static bool isNumbericPositive(string str)
    {
        if (string.IsNullOrEmpty(str)) return false;

        int n;
        bool isNumeric = int.TryParse(str, out n);
        if (!isNumeric) return false;
        if (Int64.Parse(str) <= 0) return false;
        return true;
    }
    public static string GetDate()
    {
        string Ngay = DateTime.Now.Day.ToString();
        string Thang = DateTime.Now.Month.ToString();
        string Nam = DateTime.Now.Year.ToString();
        string Gio = DateTime.Now.Hour.ToString();
        string Phut = DateTime.Now.Minute.ToString();
        string Giay = DateTime.Now.Second.ToString();
        return Thang + "/" + Ngay + "/" + Nam + " " + Gio + ":" + Phut + ":" + Giay;
    }
    #region convert date
    public static string ConvertDDMMtoMMDD(this string ngay)
    {
        if (ngay.Equals(""))
        {
            return "";
        }
        else
        {
            string ngayC = ngay.Substring(0, 2);
            string thangC = ngay.Substring(3, 2);
            string namC = ngay.Substring(6, 4);
            return thangC + "/" + ngayC + "/" + namC;
        }
    }
    public static string ConvertMMDDYYtoDDMMYY(this string ngay)
    {
        if (ngay.Trim() == "")
        {
            return "";
        }
        else
        {
            int ngayC = 0;
            int thangC = 0;
            int namC = 0;
            try
            {
                thangC = int.Parse(ngay.Substring(0, 2));
                try
                {
                    ngayC = int.Parse(ngay.Substring(3, 2));
                    namC = int.Parse(ngay.Substring(6, 4));
                }
                catch
                {
                    ngayC = int.Parse(ngay.Substring(3, 1));
                    namC = int.Parse(ngay.Substring(5, 4));
                }
            }
            catch
            {
                thangC = int.Parse(ngay.Substring(0, 1));
                try
                {
                    ngayC = int.Parse(ngay.Substring(2, 2));
                    namC = int.Parse(ngay.Substring(5, 4));
                }
                catch
                {
                    ngayC = int.Parse(ngay.Substring(2, 1));
                    namC = int.Parse(ngay.Substring(4, 4));
                }
            }
            string ngaytrave = "";
            if (ngayC < 10 && thangC < 10)
                ngaytrave = "0" + ngayC.ToString() + "/0" + thangC.ToString() + "/" + namC.ToString();
            if (ngayC < 10 && thangC >= 10)
                ngaytrave = "0" + ngayC.ToString() + "/" + thangC.ToString() + "/" + namC.ToString();
            if (ngayC >= 10 && thangC < 10)
                ngaytrave = ngayC.ToString() + "/0" + thangC.ToString() + "/" + namC.ToString();
            if (ngayC >= 10 && thangC >= 10)
                ngaytrave = ngayC.ToString() + "/" + thangC.ToString() + "/" + namC.ToString();

            return ngaytrave;
        }
    }
    #endregion
    public static bool IsValidEmail(string email)
    {
        try
        {
            int nFirt = int.Parse(email.Substring(0, 1));
            return false;
        }
        catch
        {
            string pattern = @"^[_a-zA-Z0-9][_.a-zA-Z0-9]*@[-.a-zA-Z0-9]+(\.[_.a-zA-Z0-9]+)*\.
                                    (com|edu|info|gov|int|mil|net|org|biz|name|museum|coop|aero|pro|tv|vn|[a-zA-Z]{2})$";
            //Regular expression object
            Regex check = new Regex(pattern, RegexOptions.IgnorePatternWhitespace);
            //boolean variable to return to calling method
            bool valid = false;

            //make sure an email address was provided
            if (string.IsNullOrEmpty(email))
            {
                valid = false;
            }
            else
            {
                //use IsMatch to validate the address
                valid = check.IsMatch(email.ToLower());
            }
            //return the value to the calling method
            return valid;
        }
    }
    public static string Change_AV(string ip_str_change)
    {
        Regex v_reg_regex = new Regex("\\p{IsCombiningDiacriticalMarks}+");
        string v_str_FormD = ip_str_change.Normalize(NormalizationForm.FormD);
        return v_reg_regex.Replace(v_str_FormD, String.Empty).Replace('\u0111', 'd').Replace('\u0110', 'D');
    }
    #region Lisence
    public static string GetMD5(string chuoi)
    {
        string str_md5 = "";
        byte[] mang = System.Text.Encoding.UTF8.GetBytes(chuoi);

        MD5CryptoServiceProvider my_md5 = new MD5CryptoServiceProvider();
        mang = my_md5.ComputeHash(mang);

        foreach (byte b in mang)
        {
            str_md5 += b.ToString("X2");
        }

        return str_md5;
    }
    public static string GetMACAddress()
    {
        NetworkInterface[] nics = NetworkInterface.GetAllNetworkInterfaces();
        String sMacAddress = string.Empty;
        foreach (NetworkInterface adapter in nics)
        {
            if (sMacAddress == String.Empty)// only return MAC Address from first card
            {
                IPInterfaceProperties properties = adapter.GetIPProperties();
                sMacAddress = adapter.GetPhysicalAddress().ToString();
            }
        }
        return sMacAddress;
    }
    private static void HoanVi(string a, string b)
    {
        string x = "";
        x = a;
        a = b;
        b = x;
    }
    public static string getKey(string physicalAdress)
    {
        string result = "";
        string[] arrS = new string[GetMD5(physicalAdress).Length];
        for (int i = 0; i < GetMD5(physicalAdress).Length; i++)
        {
            arrS[i] = GetMD5(physicalAdress).Substring(i, 1);
        }
        //Hoán vị
        for (int i = 0; i < GetMD5(physicalAdress).Length; i++)
        {
            for (int j = 0; j < (GetMD5(physicalAdress).Length - 1); j++)
            {
                HoanVi(arrS[j], arrS[j + 1]);
            }
            for (int j = 0; j < (GetMD5(physicalAdress).Length - 3); j++)
            {
                HoanVi(arrS[j], arrS[j + 3]);
            }
            for (int j = 0; j < (GetMD5(physicalAdress).Length - 5); j++)
            {
                HoanVi(arrS[j], arrS[j + 5]);
            }
            for (int j = 0; j < (GetMD5(physicalAdress).Length - 2); j++)
            {
                HoanVi(arrS[j], arrS[j + 2]);

            }
            result += arrS[i];
        }
        //MessageBox.Show(result.Substring(0, 5) + "-" + result.Substring(5, 5) +"-"+ result.Substring(10, 5));
        return (result.Substring(0, 5) + "-" + result.Substring(5, 5) + "-" + result.Substring(10, 5));
    }

    //Đọc và ghi dữ liệu vào registry
    public static string ReadRegKey(string path, string getName)
    {
        try
        {
            RegistryKey regkey;
            regkey = Registry.LocalMachine.OpenSubKey(path);
            //return regkey.GetSubKeyNames(); 
            return regkey.GetValue(getName).ToString();
        }
        catch
        {
            return "";
        }
    }

    public static bool WriteRegKey(string keyName, object value, string path)
    {
        RegistryKey rk = Registry.LocalMachine;
        RegistryKey sk1 = rk.CreateSubKey(path);
        sk1.SetValue(keyName, value);
        return true;
    }
    public static void EnabledTCTSQLServer()
    {
        #region Enabeld TCP
        try
        {
            RegistryKey regkey = Registry.LocalMachine.OpenSubKey(@"Software\Microsoft\Microsoft SQL Server\MSSQL.1\MSSQLServer\SuperSocketNetLib\Tcp", true);
            regkey.SetValue("Enabled", 1);
            RegistryKey regkey1 = Registry.LocalMachine.OpenSubKey(@"Software\Microsoft\Microsoft SQL Server\MSSQL.1\MSSQLServer", true);
            regkey1.SetValue("LoginMode", 2);
        }
        catch
        { }
        try
        {
            RegistryKey regkey = Registry.LocalMachine.OpenSubKey(@"Software\Microsoft\Microsoft SQL Server\MSSQL.2\MSSQLServer\SuperSocketNetLib\Tcp", true);
            regkey.SetValue("Enabled", 1);
            RegistryKey regkey1 = Registry.LocalMachine.OpenSubKey(@"Software\Microsoft\Microsoft SQL Server\MSSQL.2\MSSQLServer", true);
            regkey1.SetValue("LoginMode", 2);
        }
        catch
        { }
        try
        {
            RegistryKey regkey = Registry.LocalMachine.OpenSubKey(@"Software\Microsoft\Microsoft SQL Server\MSSQL.3\MSSQLServer\SuperSocketNetLib\Tcp", true);
            regkey.SetValue("Enabled", 1);
            RegistryKey regkey1 = Registry.LocalMachine.OpenSubKey(@"Software\Microsoft\Microsoft SQL Server\MSSQL.3\MSSQLServer", true);
            regkey1.SetValue("LoginMode", 2);
        }
        catch
        { }
        try
        {
            RegistryKey regkey = Registry.LocalMachine.OpenSubKey(@"Software\Microsoft\Microsoft SQL Server\MSSQL.4\MSSQLServer\SuperSocketNetLib\Tcp", true);
            regkey.SetValue("Enabled", 1);
            RegistryKey regkey1 = Registry.LocalMachine.OpenSubKey(@"Software\Microsoft\Microsoft SQL Server\MSSQL.4\MSSQLServer", true);
            regkey1.SetValue("LoginMode", 2);
        }
        catch
        { }
        try
        {
            RegistryKey regkey = Registry.LocalMachine.OpenSubKey(@"Software\Microsoft\Microsoft SQL Server\MSSQL.5\MSSQLServer\SuperSocketNetLib\Tcp", true);
            regkey.SetValue("Enabled", 1);
            RegistryKey regkey1 = Registry.LocalMachine.OpenSubKey(@"Software\Microsoft\Microsoft SQL Server\MSSQL.5\MSSQLServer", true);
            regkey1.SetValue("LoginMode", 2);
        }
        catch
        { }
        try
        {
            RegistryKey regkey = Registry.LocalMachine.OpenSubKey(@"Software\Microsoft\Microsoft SQL Server\MSSQL.6\MSSQLServer\SuperSocketNetLib\Tcp", true);
            regkey.SetValue("Enabled", 1);
            RegistryKey regkey1 = Registry.LocalMachine.OpenSubKey(@"Software\Microsoft\Microsoft SQL Server\MSSQL.6\MSSQLServer", true);
            regkey1.SetValue("LoginMode", 2);
        }
        catch
        { }
        try
        {
            RegistryKey regkey = Registry.LocalMachine.OpenSubKey(@"Software\Microsoft\Microsoft SQL Server\MSSQL.7\MSSQLServer\SuperSocketNetLib\Tcp", true);
            regkey.SetValue("Enabled", 1);
            RegistryKey regkey1 = Registry.LocalMachine.OpenSubKey(@"Software\Microsoft\Microsoft SQL Server\MSSQL.7\MSSQLServer", true);
            regkey1.SetValue("LoginMode", 2);
        }
        catch
        { }
        try
        {
            RegistryKey regkey = Registry.LocalMachine.OpenSubKey(@"Software\Microsoft\Microsoft SQL Server\MSSQL.8\MSSQLServer\SuperSocketNetLib\Tcp", true);
            regkey.SetValue("Enabled", 1);
            RegistryKey regkey1 = Registry.LocalMachine.OpenSubKey(@"Software\Microsoft\Microsoft SQL Server\MSSQL.8\MSSQLServer", true);
            regkey1.SetValue("LoginMode", 2);
        }
        catch
        { }
        try
        {
            RegistryKey regkey = Registry.LocalMachine.OpenSubKey(@"Software\Microsoft\Microsoft SQL Server\MSSQL.9\MSSQLServer\SuperSocketNetLib\Tcp", true);
            regkey.SetValue("Enabled", 1);
            RegistryKey regkey1 = Registry.LocalMachine.OpenSubKey(@"Software\Microsoft\Microsoft SQL Server\MSSQL.9\MSSQLServer", true);
            regkey1.SetValue("LoginMode", 2);
        }
        catch
        { }
        try
        {
            RegistryKey regkey = Registry.LocalMachine.OpenSubKey(@"Software\Microsoft\Microsoft SQL Server\MSSQL.10\MSSQLServer\SuperSocketNetLib\Tcp", true);
            regkey.SetValue("Enabled", 1);
            RegistryKey regkey1 = Registry.LocalMachine.OpenSubKey(@"Software\Microsoft\Microsoft SQL Server\MSSQL.10\MSSQLServer", true);
            regkey1.SetValue("LoginMode", 2);
        }
        catch
        { }
        try
        {
            RegistryKey regkey = Registry.LocalMachine.OpenSubKey(@"Software\Microsoft\Microsoft SQL Server\MSSQL.11\MSSQLServer\SuperSocketNetLib\Tcp", true);
            regkey.SetValue("Enabled", 1);
            RegistryKey regkey1 = Registry.LocalMachine.OpenSubKey(@"Software\Microsoft\Microsoft SQL Server\MSSQL.11\MSSQLServer", true);
            regkey1.SetValue("LoginMode", 2);
        }
        catch
        { }
        try
        {
            RegistryKey regkey = Registry.LocalMachine.OpenSubKey(@"Software\Microsoft\Microsoft SQL Server\MSSQL.12\MSSQLServer\SuperSocketNetLib\Tcp", true);
            regkey.SetValue("Enabled", 1);
            RegistryKey regkey1 = Registry.LocalMachine.OpenSubKey(@"Software\Microsoft\Microsoft SQL Server\MSSQL.12\MSSQLServer", true);
            regkey1.SetValue("LoginMode", 2);
        }
        catch
        { }
        try
        {
            RegistryKey regkey = Registry.LocalMachine.OpenSubKey(@"Software\Microsoft\Microsoft SQL Server\MSSQL.13\MSSQLServer\SuperSocketNetLib\Tcp", true);
            regkey.SetValue("Enabled", 1);
            RegistryKey regkey1 = Registry.LocalMachine.OpenSubKey(@"Software\Microsoft\Microsoft SQL Server\MSSQL.13\MSSQLServer", true);
            regkey1.SetValue("LoginMode", 2);
        }
        catch
        { }
        try
        {
            RegistryKey regkey = Registry.LocalMachine.OpenSubKey(@"Software\Microsoft\Microsoft SQL Server\MSSQL.14\MSSQLServer\SuperSocketNetLib\Tcp", true);
            regkey.SetValue("Enabled", 1);
            RegistryKey regkey1 = Registry.LocalMachine.OpenSubKey(@"Software\Microsoft\Microsoft SQL Server\MSSQL.14\MSSQLServer", true);
            regkey1.SetValue("LoginMode", 2);
        }
        catch
        { }
        try
        {
            RegistryKey regkey = Registry.LocalMachine.OpenSubKey(@"Software\Microsoft\Microsoft SQL Server\MSSQL.15\MSSQLServer\SuperSocketNetLib\Tcp", true);
            regkey.SetValue("Enabled", 1);
            RegistryKey regkey1 = Registry.LocalMachine.OpenSubKey(@"Software\Microsoft\Microsoft SQL Server\MSSQL.15\MSSQLServer", true);
            regkey1.SetValue("LoginMode", 2);
        }
        catch
        { }
        #endregion
    }
    #endregion
    public static bool CoppyFile(string sourceFile, string destinationFile)
    {
        //try
        //{
        SqlConnection.ClearAllPools();
        if (System.IO.File.Exists(destinationFile))
        {
            System.IO.File.Delete(destinationFile);
            //if (System.IO.File.Exists(Application.StartupPath + @"\Database\db_CDSoft_Printer_log.ldf"))
            //    System.IO.File.Delete(Application.StartupPath+@"\Database\db_CDSoft_Printer_log.ldf");
        }
        //destinationFile = System.IO.Path.Combine(destinationFile, System.IO.Path.GetFileName(sourceFile));
        System.IO.File.Copy(sourceFile, destinationFile);
        return true;
        //}
        //catch
        //{
        //    return false;
        //}

    }

    public static string getField(string table, string getField, string paraField, string valueParaField)
    {
        string result = "";
        string sql = "select " + getField + " from " + table + " where " + paraField + "='" + valueParaField + "'";
        try
        {
            DataTable tb = Connect.GetTable(sql);
            if (tb.Rows.Count > 0)
                result = tb.Rows[0][0].ToString();
        }
        catch
        { }
        return result;
    }

    public static string getFieldN(string table, string getField, string paraField, string valueParaField)
    {
        string result = "";
        string sql = "select " + getField + " from " + table + " where " + paraField + "= N'" + valueParaField + "'";
        try
        {
            DataTable tb = Connect.GetTable(sql);
            if (tb.Rows.Count > 0)
                result = tb.Rows[0][0].ToString();
        }
        catch
        { }
        return result;
    }


    public static string getFieldString(string table, string getField, string paraField, string valueParaField)
    {
        string result = "";
        string sql = "select " + getField + " from " + table + " where " + paraField + " like N'" + valueParaField + "'";
        try
        {
            DataTable tb = Connect.GetTable(sql);
            if (tb.Rows.Count > 0)
                result = tb.Rows[0][0].ToString();
        }
        catch
        { }
        return result;
    }
    public static bool SendMail(string Subject, string Body, string FromMail, string FromMailPass, string ToMail)
    {
        try
        {
            MailMessage mail = new MailMessage();
            mail.To.Add(ToMail);
            mail.From = new MailAddress(ToMail);
            mail.Subject = Subject;
            mail.Body = Body;

            mail.IsBodyHtml = true;

            SmtpClient smtp = new SmtpClient("localhost", 25);
            smtp.Host = "smtp.gmail.com"; //Or Your SMTP Server Address  
            smtp.Credentials = new System.Net.NetworkCredential
                 (FromMail, FromMailPass);
            smtp.DeliveryMethod = SmtpDeliveryMethod.Network;
            smtp.EnableSsl = true;
            smtp.Send(mail);
            return true;
        }
        catch
        {
            return false;
        }
    }
    public static string ValidParameter(string s)
    {
        s = s.Replace("\"", "").Replace("'", "").Replace("update", "").Replace("select", "").Replace("drop", "").Replace(";", "").Replace("--", "").Replace("insert", "").Replace("delete", "").Replace("xp_", "");
        return s;
    }
    private static readonly string[] VietnameseSigns = new string[]

    {

        "aAeEoOuUiIdDyY",

        "áàạảãâấầậẩẫăắằặẳẵ",

        "ÁÀẠẢÃÂẤẦẬẨẪĂẮẰẶẲẴ",

        "éèẹẻẽêếềệểễ",

        "ÉÈẸẺẼÊẾỀỆỂỄ",

        "óòọỏõôốồộổỗơớờợởỡ",

        "ÓÒỌỎÕÔỐỒỘỔỖƠỚỜỢỞỠ",

        "úùụủũưứừựửữ",

        "ÚÙỤỦŨƯỨỪỰỬỮ",

        "íìịỉĩ",

        "ÍÌỊỈĨ",

        "đ",

        "Đ",

        "ýỳỵỷỹ",

        "ÝỲỴỶỸ"

    };


    public static string BoDauTiengViet(string str)
    {

        //Tiến hành thay thế , lọc bỏ dấu cho chuỗi

        for (int i = 1; i < VietnameseSigns.Length; i++)
        {

            for (int j = 0; j < VietnameseSigns[i].Length; j++)

                str = str.Replace(VietnameseSigns[i][j], VietnameseSigns[0][i - 1]);

        }

        return str;

    }
    public static string ReplaceTieuDe(string TieuDe)
    {
        string sTieuDe = TieuDe.Replace("?", "").Replace("[=1]", "").Replace("[=2]", "").Replace("[=3]", "").Replace("[=4]", "").Replace("[=5]", "").Replace("[=6]", "").Replace("[=7]", "").Replace("[=8]", "").Replace("[=9]", "").Replace("[=10]", "").Replace("[=11]", "").Replace("[=12]", "").Replace("[=13]", "").Replace("[=14]", "").Replace("[=15]", "").ToLower().Trim().Replace("/", " ").Replace("|", " ").Replace("–", "").Replace(" ", "-").Replace(".", "").Replace("%", "").Replace(":", "").Replace("!", "").Replace("\"", "").Replace(",", "").Replace(".", "").Replace("'", "").Replace("“", "").Replace("”", "").Replace("(", "").Replace(")", "").Replace(" ", "-").Replace(" ", "-").Replace(" ", "-").Replace(" ", "-").Replace(" ", "-").Replace("--", "-").Replace("--", "-").Replace("--", "-").Replace("---", "-").Replace("----", "-").Replace("-----", "-").Replace("&", "");
        if (sTieuDe.Length <= 62)
            return sTieuDe;
        else
            return sTieuDe.Substring(0, 62);
    }
    public static string ReplaceTieuDePage(string TieuDe)
    {
        string sTieuDe = TieuDe.Replace("?", "").Replace("[=1]", "").Replace("[=2]", "").Replace("[=3]", "").Replace("[=4]", "").Replace("[=5]", "").Replace("[=6]", "").Replace("[=7]", "").Replace("[=8]", "").Replace("[=9]", "").Replace("[=10]", "").Replace("[=11]", "").Replace("[=12]", "").Replace("[=13]", "").Replace("[=14]", "").Replace("[=15]", "").Trim().Replace(".", "").Replace("%", "").Replace(":", ""); ;
        if (sTieuDe.Length <= 62)
            return sTieuDe;
        else
            return sTieuDe.Substring(0, 62);
    }
    public static string RemoveHtmlTagsUsingCharArray(this string htmlString)
    {
        var array = new char[htmlString.Length];
        var arrayIndex = 0;
        var inside = false;

        foreach (var @let in htmlString)
        {
            if (let == '<')
            {
                inside = true;
                continue;
            }
            if (let == '>')
            {
                inside = false;
                continue;
            }
            if (inside) continue;
            array[arrayIndex] = let;
            arrayIndex++;
        }
        return new string(array, 0, arrayIndex);
    }
    public static string DecodeFromUtf8(this string utf8String)
    {
        // read the string as UTF-8 bytes.
        byte[] encodedBytes = Encoding.UTF8.GetBytes(utf8String);

        // convert them into unicode bytes.
        byte[] unicodeBytes = Encoding.Convert(Encoding.UTF8, Encoding.Unicode, encodedBytes);

        // builds the converted string.
        return Encoding.Unicode.GetString(encodedBytes);
    }



    #region
    //P. V. Đạo

    public static string[] SetPage(int Page, int TotalRows, int PageSize)
    {
        int MaxPage = 0;
        string[] page = new string[] { "1", "", "", "", "", "", "" };

        if (TotalRows % PageSize == 0)
            MaxPage = TotalRows / PageSize;
        else
            MaxPage = TotalRows / PageSize + 1;
        page[6] = MaxPage.ToString();
        if (Page == 1)
        {
            for (int i = 1; i <= MaxPage; i++)
            {
                if (i <= 5)
                {
                    switch (i)
                    {
                        case 1: page[1] = i.ToString(); break;
                        case 2: page[2] = i.ToString(); break;
                        case 3: page[3] = i.ToString(); break;
                        case 4: page[4] = i.ToString(); break;
                        case 5: page[5] = i.ToString(); break;
                    }
                }
                else
                    break;
            }
        }
        else
        {
            if (Page == 2)
            {
                for (int i = 1; i <= MaxPage; i++)
                {
                    if (i == 1)
                        page[1] = "1";
                    if (i <= 5)
                    {
                        switch (i)
                        {
                            case 2: page[2] = i.ToString(); break;
                            case 3: page[3] = i.ToString(); break;
                            case 4: page[4] = i.ToString(); break;
                            case 5: page[5] = i.ToString(); break;
                        }
                    }
                    else
                        break;
                }
            }
            else
            {
                int Cout = 1;
                if (Page <= MaxPage)
                {
                    for (int i = Page; i <= MaxPage; i++)
                    {
                        if (i == Page)
                        {
                            page[1] = (Page - 2).ToString();
                            page[2] = (Page - 1).ToString();
                        }
                        if (Cout <= 3)
                        {
                            if (i == Page)
                                page[3] = i.ToString();
                            if (i == (Page + 1))
                                page[4] = i.ToString();
                            if (i == (Page + 2))
                                page[5] = i.ToString();
                            Cout++;
                        }
                        else
                            break;
                    }
                }
                else
                {
                    SetPage(Page, TotalRows, PageSize);
                }
            }
        }

        return page;

    }

    #endregion



    #region Paging
    //P. V. Đạo
    public static string CreateHTMLPaging(int page, string url, string[] p)
    {
        string html = "";
        html += "           <a class='notepaging' id='page_fist' href='" + url + p[0] + "' /><i class='fa fa-step-backward'></i></a>";
        //Page 1
        if (p[1] != "")
        {
            if (page.ToString() == p[1])
                html += "           <a id='page_1' class='notepagingactive' href='" + url + p[1] + "' />" + p[1] + "</a>";
            else
                html += "           <a id='page_1' class='notepaging' href='" + url + p[1] + "' />" + p[1] + "</a>";
        }
        else
        {
            html += "           <a id='page_1' class='notepagingnone' href='" + url + p[1] + "' />" + p[1] + "</a>";
        }
        //Page 2
        if (p[2] != "")
        {
            if (page.ToString() == p[2])
                html += "           <a id='page_2' class='notepagingactive' href='" + url + p[2] + "' />" + p[2] + "</a>";
            else
                html += "           <a id='page_2' class='notepaging' href='" + url + p[2] + "' />" + p[2] + "</a>";
        }
        else
        {
            html += "           <a id='page_2' class='notepagingnone' href='" + url + p[2] + "' />" + p[2] + "</a>";
        }
        //Page 3
        if (p[3] != "")
        {
            if (page.ToString() == p[3])
                html += "           <a id='page_3' class='notepagingactive' href='" + url + p[3] + "' />" + p[3] + "</a>";
            else
                html += "           <a id='page_3' class='notepaging' href='" + url + p[3] + "' />" + p[3] + "</a>";
        }
        else
        {
            html += "           <a id='page_3' class='notepagingnone' href='" + url + p[3] + "' />" + p[3] + "</a>";
        }
        //Page 4
        if (p[4] != "")
        {
            if (page.ToString() == p[4])
                html += "           <a id='page_4' class='notepagingactive' href='" + url + p[4] + "' />" + p[4] + "</a>";
            else
                html += "           <a id='page_4' class='notepaging' href='" + url + p[4] + "' />" + p[4] + "</a>";
        }
        else
        {
            html += "           <a id='page_4' class='notepagingnone' href='" + url + p[4] + "' />" + p[4] + "</a>";
        }
        //Page 5
        if (p[5] != "")
        {
            if (page.ToString() == p[5])
                html += "           <a id='page_5' class='notepagingactive' href='" + url + p[5] + "' />" + p[5] + "</a>";
            else
                html += "           <a id='page_5' class='notepaging' href='" + url + p[5] + "' />" + p[5] + "</a>";
        }
        else
        {
            html += "           <a id='page_5' class='notepagingnone' href='" + url + p[5] + "' />" + p[5] + "</a>";
        }

        html += "           <a id='page_last' class='notepaging' href='" + url + p[6] + "' /><i class='fa fa-step-forward'></i></a>";

        return html;
    }

    #endregion

}
