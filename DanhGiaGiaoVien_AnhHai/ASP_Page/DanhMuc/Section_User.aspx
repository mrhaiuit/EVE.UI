<%@ Page Language="C#" MasterPageFile="~/Layout/MasterPage.master" AutoEventWireup="true" CodeFile="SECTION_User.aspx.cs" Inherits="ASP_Page_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .form-group span {
            color: #ca0000;
            font-size: 13px;
        }

        .popover {
            max-width: 750px;
        }
    </style>
    <script>
        {
            function hasUnicode(str) {
                for (var i = 0; i < str.length; i++) {
                    if (str.charCodeAt(i) > 127) return true;
                }
                return false;
            }
            function DeleteUser(user) {
                swal({
                    title: 'Bạn có chắc muốn xoá ?',
                    type: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#F44336',
                    cancelButtonColor: '#ef4848',
                    confirmButtonText: 'OK',
                    cancelButtonText: 'Không'
                }, function () {
                    var xmlhttp;
                    if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                        xmlhttp = new XMLHttpRequest();
                    }
                    else {// code for IE6, IE5
                        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                    }
                    xmlhttp.onreadystatechange = function () {
                        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                            if (xmlhttp.responseText == "Success") {
                                window.location.reload();
                            }
                            else {
                                swal("Lỗi !", "", "error");
                            }
                        }
                    }
                    xmlhttp.open("GET", "../../Ajax.aspx?Action=DeleteUser&user=" + user, true);
                    xmlhttp.send();

                });
            }
            function OpenModal_AddNewUser() {
                $("#txtFullnameUser").val('');
                $("#txtPhoneUser").val('');
                $("#txtAddresslUser").val('');
                $("#txtCodeUser").val('');
                $("#txtUsername").val('');
                $("#txtPassword").val('');
                $("#txtGhiChu").val('');
                $("#ContentMaster_slUserType").val('').trigger('change');
                $("#ContentMaster_slActive").val('').trigger('change');
                $("#btnModalSave").attr('onclick', 'AddNewUser();');

                $("#myModalTile").html('THÊM MỚI NHÂN VIÊN');
                $("#verticalModal").modal('show');
                $("#verticalModal").css({ 'display': 'flex', 'align-items': 'center' });
            }
            function AddNewUser() {
                var flag = true;
                var CodeUser = $("#txtCodeUser").val().trim();
                var FullnameUser = $("#txtFullnameUser").val().trim();
                var PhoneUser = $("#txtPhoneUser").val().trim();
                var AddresslUser = $("#txtAddresslUser").val().trim();
                var UserType = $("#ContentMaster_slUserType").val().trim();
                var Active = $("#ContentMaster_slActive").val().trim();
                var Username = $("#txtUsername").val().trim();
                var Password = $("#txtPassword").val().trim();
                var GhiChu = $("#txtGhiChu").val().trim();

                var Cap_Phong = $("#ContentMaster_slEduDepartment").val();
                var Cap_Bo = $("#ContentMaster_slEduMinistry").val();
                var Cap_So = $("#ContentMaster_slEduProvince").val();
                var Cap_Truong = $("#ContentMaster_slEduSchoold").val();
                ////////////////////////////////////
                if (FullnameUser == "") {
                    $("#txtFullnameUser").notify("Vui lòng nhập Nhập họ tên", { position: "top", className: "error", autoHideDelay: 5000 });
                    $("#fltxtFullnameUser").addClass("animated shake");
                    setTimeout(function () {
                        $("#fltxtFullnameUser").removeClass("animated shake");
                    }, 1000);
                    flag = false;
                }
                ////////////////////////////////////
                if (CodeUser == "") {
                    $("#txtCodeUser").notify("Vui lòng nhập Mã nhân viên", { position: "top", className: "error", autoHideDelay: 5000 });
                    $("#fltxtCodeUser").addClass("animated shake");
                    setTimeout(function () {
                        $("#fltxtCodeUser").removeClass("animated shake");
                    }, 1000);
                    flag = false;
                }
                ////////////////////////////////////
                if (Username == "") {
                    $("#txtUsername").notify("Vui lòng nhập Tên đăng nhập", { position: "top", className: "error", autoHideDelay: 5000 });
                    $("#fltxtUsername").addClass("animated shake");
                    setTimeout(function () {
                        $("#fltxtUsername").removeClass("animated shake");
                    }, 1000);
                    flag = false;
                }
                ////////////////////////////////////
                if (Password == "") {
                    $("#txtPassword").notify("Vui lòng nhập Mật khẩu", { position: "top", className: "error", autoHideDelay: 5000 });
                    $("#fltxtPassword").addClass("animated shake");
                    setTimeout(function () {
                        $("#fltxtPassword").removeClass("animated shake");
                    }, 1000);
                    flag = false;
                }
                ////////////////////////////////////
                if (hasUnicode(Username)) {
                    $("#spUsername").html("Tên đăng nhập không được có dấu !");
                    $("#spUsername").css('display', 'block');
                    $("#fltxtUsername").addClass("animated shake");
                    setTimeout(function () {
                        $("#fltxtUsername").removeClass("animated shake");
                    }, 1000);
                    flag = false;
                }
                if (!flag)
                    return;
                var chuoi = FullnameUser + "@_@" + PhoneUser + "@_@" + AddresslUser + "@_@" + CodeUser + "@_@" + Username + "@_@" + Password + "@_@" + UserType + "@_@" + Active + "@_@" + GhiChu + "@_@" + Cap_Bo + "@_@" + Cap_So + "@_@" + Cap_Phong + "@_@" + Cap_Truong;

                ////////////////////////////////////
                var xmlhttp;
                if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                    xmlhttp = new XMLHttpRequest();
                }
                else {// code for IE6, IE5
                    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                }
                xmlhttp.onreadystatechange = function () {
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                        if (xmlhttp.responseText == "Success") {
                            window.location.reload();
                        }
                        else if (xmlhttp.responseText == "SameUsername") {

                            $("#txtUsername").notify("Tên đăng nhập này đã được dùng", { position: "top", className: "error", autoHideDelay: 5000 });
                            $("#fltxtUsername").addClass("animated shake");
                            setTimeout(function () {
                                $("#fltxtUsername").removeClass("animated shake");
                            }, 1000);
                        }
                        else if (xmlhttp.responseText == "SameCode") {
                            $("#txtCodeUser").notify("Mã này đã tồn tại", { position: "top", className: "error", autoHideDelay: 5000 });
                            $("#fltxtCodeUser").addClass("animated shake");
                            setTimeout(function () {
                                $("#fltxtCodeUser").removeClass("animated shake");
                            }, 1000);
                        }
                        else {
                            swal("Lỗi !", "", "error");
                        }

                    }
                }
                xmlhttp.open("GET", "../../Ajax.aspx?Action=AddNewUser&chuoi=" + chuoi, true);
                xmlhttp.send();
            }
            function OpenModal_EditUser(user) {
                var xmlhttp;
                if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                    xmlhttp = new XMLHttpRequest();
                }
                else {// code for IE6, IE5
                    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                }
                xmlhttp.onreadystatechange = function () {
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                        if (xmlhttp.responseText != "") {
                            var arr = xmlhttp.responseText.split("@_@");
                            $("#fltxtCodeUser").addClass('focused');
                            $("#fltxtFullnameUser").addClass('focused');
                            $("#fltxtPhoneUser").addClass('focused');
                            $("#fltxtAddresslUser").addClass('focused');
                            $("#fltxtUsername").addClass('focused');
                            $("#fltxtPassword").addClass('focused');
                            $("#fltxtGhiChu").addClass('focused');

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

                            $("#txtFullnameUser").val(arr[0]);
                            $("#txtPhoneUser").val(arr[1]);
                            $("#txtAddresslUser").val(arr[2]);
                            $("#txtCodeUser").val(arr[3]);
                            $("#txtUsername").val(arr[4]);
                            $("#txtPassword").val(arr[5]);
                            $("#ContentMaster_slUserType").val(arr[6]).trigger('change');
                            $("#ContentMaster_slActive").val(arr[7]).trigger('change');
                            $("#txtPassword").val(arr[8]);
                            $("#ContentMaster_slEduMinistry").val(arr[9]).trigger('change');
                            $("#ContentMaster_slEduProvince").val(arr[10]).trigger('change');
                            setTimeout(function () {
                                $("#ContentMaster_slEduDepartment").val(arr[11]).trigger('change');
                            }, 1000);
                            setTimeout(function () {
                                $("#ContentMaster_slEduSchoold").val(arr[12]).trigger('change');
                            }, 1500);

                            $("#myModalTile").html("CHỈNH SỬA THÔNG TIN NGƯỜI DÙNG");
                            $("#btnModalSave").attr("onclick", "EditUser(" + user + ")");
                            $("#verticalModal").modal('show');
                            $("#verticalModal").css({ 'display': 'flex', 'align-items': 'center' });
                        }
                        else {
                            swal("Lỗi !", "", "error");
                        }

                    }
                }
                xmlhttp.open("GET", "../../Ajax.aspx?Action=LoadInfoUser&user=" + user, true);
                xmlhttp.send();
            }
            function EditUser(user) {
                var flag = true;
                var CodeUser = $("#txtCodeUser").val().trim();
                var FullnameUser = $("#txtFullnameUser").val().trim();
                var PhoneUser = $("#txtPhoneUser").val().trim();
                var AddresslUser = $("#txtAddresslUser").val().trim();
                var UserType = $("#ContentMaster_slUserType").val().trim();
                var Active = $("#ContentMaster_slActive").val().trim();
                var Username = $("#txtUsername").val().trim();
                var Password = $("#txtPassword").val().trim();
                var GhiChu = $("#txtGhiChu").val().trim();

                var Cap_Phong = $("#ContentMaster_slEduDepartment").val();
                var Cap_Bo = $("#ContentMaster_slEduMinistry").val();
                var Cap_So = $("#ContentMaster_slEduProvince").val();
                var Cap_Truong = $("#ContentMaster_slEduSchoold").val();
                ////////////////////////////////////
                if (FullnameUser == "") {
                    $("#txtFullnameUser").notify("Vui lòng nhập Nhập họ tên", { position: "top", className: "error", autoHideDelay: 5000 });
                    $("#fltxtFullnameUser").addClass("animated shake");
                    setTimeout(function () {
                        $("#fltxtFullnameUser").removeClass("animated shake");
                    }, 1000);
                    flag = false;
                }
                ////////////////////////////////////
                if (CodeUser == "") {
                    $("#txtCodeUser").notify("Vui lòng nhập Mã nhân viên", { position: "top", className: "error", autoHideDelay: 5000 });
                    $("#fltxtCodeUser").addClass("animated shake");
                    setTimeout(function () {
                        $("#fltxtCodeUser").removeClass("animated shake");
                    }, 1000);
                    flag = false;
                }
                ////////////////////////////////////
                if (Username == "") {
                    $("#txtUsername").notify("Vui lòng nhập Tên đăng nhập", { position: "top", className: "error", autoHideDelay: 5000 });
                    $("#fltxtUsername").addClass("animated shake");
                    setTimeout(function () {
                        $("#fltxtUsername").removeClass("animated shake");
                    }, 1000);
                    flag = false;
                }
                ////////////////////////////////////
                if (Password == "") {
                    $("#txtPassword").notify("Vui lòng nhập Mật khẩu", { position: "top", className: "error", autoHideDelay: 5000 });
                    $("#fltxtPassword").addClass("animated shake");
                    setTimeout(function () {
                        $("#fltxtPassword").removeClass("animated shake");
                    }, 1000);
                    flag = false;
                }
                ////////////////////////////////////
                if (hasUnicode(Username)) {
                    $("#spUsername").html("Tên đăng nhập không được có dấu !");
                    $("#spUsername").css('display', 'block');
                    $("#fltxtUsername").addClass("animated shake");
                    setTimeout(function () {
                        $("#fltxtUsername").removeClass("animated shake");
                    }, 1000);
                    flag = false;
                }
                if (!flag)
                    return;
                var chuoi = FullnameUser + "@_@" + PhoneUser + "@_@" + AddresslUser + "@_@" + CodeUser + "@_@" + Username + "@_@" + Password + "@_@" + UserType + "@_@" + Active + "@_@" + GhiChu + "@_@" + Cap_Bo + "@_@" + Cap_So + "@_@" + Cap_Phong + "@_@" + Cap_Truong;

                ////////////////////////////////////
                var xmlhttp;
                if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                    xmlhttp = new XMLHttpRequest();
                }
                else {// code for IE6, IE5
                    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                }
                xmlhttp.onreadystatechange = function () {
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                        if (xmlhttp.responseText == "Success") {
                            window.location.reload();
                        }
                        else if (xmlhttp.responseText == "SameUsername") {
                            $("#txtUsername").notify("Tên đăng nhập này đã được dùng", { position: "top", className: "error", autoHideDelay: 5000 });
                            $("#fltxtUsername").addClass("animated shake");
                            setTimeout(function () {
                                $("#fltxtUsername").removeClass("animated shake");
                            }, 1000);
                        }
                        else if (xmlhttp.responseText == "SameCode") {
                            $("#txtCodeUser").notify("Mã này đã tồn tại", { position: "top", className: "error", autoHideDelay: 5000 });
                            $("#fltxtCodeUser").addClass("animated shake");
                            setTimeout(function () {
                                $("#fltxtCodeUser").removeClass("animated shake");
                            }, 1000);
                        }
                        else {
                            swal("Lỗi !", "", "error");
                        }

                    }
                }
                xmlhttp.open("GET", "../../Ajax.aspx?Action=EditUser&chuoi=" + chuoi + "&user=" + user, true);
                xmlhttp.send();
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentMaster" runat="Server">

    <section class="content">
        <div class="container-fluid">
            <div class="block-header hidden">
                <ol class="breadcrumb" id="breadscrumColor" runat="server">
                    <li><a href="../../Asp_page/index.aspx"><i class="material-icons">home</i> Trang chủ</a></li>
                    <li class="active"><a href="../../Asp_page/DanhMuc/section_user.aspx"><i class="fa fa-user m-r-10"></i>Người dùng</a></li>
                </ol>
            </div>
            <div class="row clearfix">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="card">
                        <div class="header">
                            <div class="row">
                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                    <h4>DANH SÁCH NGƯỜI DÙNG</h4>
                                </div>
                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6 align-right">
                                    <a class="btn btn-warning waves-effect" href="javascript:OpenModal_AddNewUser();"><i class="material-icons">playlist_add</i> <span>THÊM MỚI</span></a>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
                                    <!-- Search Bar -->
                                    <div class="search-bar">
                                        <div class="search-icon">
                                            <i class="material-icons">search</i>
                                        </div>
                                        <input type="text" placeholder="Tìm theo tên..." id="txtSearch" runat="server" onkeypress="javascript:if(event.keyCode == 13) document.getElementById('ContentMaster_btnSearch').click();">
                                        <div class="close-search">
                                            <i class="material-icons">close</i>
                                        </div>
                                    </div>
                                    <!-- #END# Search Bar -->
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-2 col-md-2 col-sm-9 col-xs-9">
                                    <!-- Call Search -->
                                    <a class="btn btn-warning waves-effect js-search" data-close="true" style="width: 100%; box-shadow: none;"><i class="material-icons">search</i><span>Tìm kiếm</span></a>
                                    <asp:LinkButton ID="btnSearch" OnClick="btnSearch_Click" runat="server" Style="display: none"></asp:LinkButton>
                                    <!-- #END# Call Search -->
                                </div>
                            </div>
                        </div>
                        <div class="body table-responsive" id="dvtable" runat="server">
                        </div>
                    </div>
                </div>
            </div>
            <!-- vertical Modal -->
            <div class="modal fade" id="verticalModal" tabindex="-1" role="dialog" aria-labelledby="verticalModal" data-keyboard="false" data-backdrop="static">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content" style="border-radius: 10px;">
                        <div class="modal-header">
                            <h4 class="modal-title" id="myModalTile">THÊM MỚI NHÂN VIÊN</h4>
                        </div>
                        <div class="modal-body">
                            <h5 class="card-inside-title " style="margin-bottom: 0px;">Thông tin cá nhân</h5>
                            <hr class="m-t-0" />
                            <div class="row">
                                <div class="col-md-3 col-lg-3">
                                    <div class="form-group form-float">
                                        <div class="form-line" id="fltxtFullnameUser">
                                            <input type="text" class="form-control" id="txtFullnameUser">
                                            <label class="form-label">Họ tên nhân viên <span style="display: inline-block; font-size: 10px;">(<i class="fa fa-certificate"></i>)</span></label>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-2 col-lg-2">
                                    <select class="form-control" id="slGioiTinh" style="width: 100%;">
                                        <option value="">-- Giới tính --</option>
                                        <option value="0">Nữ</option>
                                        <option value="1">Nam</option>
                                    </select>
                                </div>
                                <div class="col-md-2 col-lg-2">
                                    <div class="form-group form-float">
                                        <div class="form-line" id="fltxtPhoneUser">
                                            <input type="text" class="form-control" id="txtPhoneUser">
                                            <label class="form-label">Số điện thoại</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-2 col-lg-2">
                                    <div class="form-group form-float">
                                        <div class="form-line" id="fltxtNgaySinh">
                                            <input type="text" class="form-control" id="txtNgaySinh">
                                            <label class="form-label">Ngày sinh</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3 col-lg-3">
                                    <div class="form-group form-float">
                                        <div class="form-line" id="fltxtEmail">
                                            <input type="text" class="form-control" id="txtEmail">
                                            <label class="form-label">Email</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-9 col-lg-9">
                                    <div class="form-group form-float">
                                        <div class="form-line" id="fltxtAddresslUser">
                                            <input type="text" class="form-control" id="txtAddresslUser">
                                            <label class="form-label">Địa chỉ</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3 col-lg-3">
                                    <select class="form-control" id="slChucVu" style="width: 100%;">
                                        <option value="">-- Chức vụ --</option>
                                        <option value="1">Chức vụ A</option>
                                        <option value="2">Chức vụ B</option>
                                    </select>
                                </div>
                                <div class="col-md-9 col-lg-9">
                                    <div class="form-group form-float">
                                        <div class="form-line" id="fltxtGhiChu">
                                            <input type="text" class="form-control" id="txtGhiChu">
                                            <label class="form-label">Ghi chú</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3 col-lg-3">
                                    <select class="form-control" id="slActive" runat="server" style="width: 100%;">
                                        <option value="">-- Chọn active --</option>
                                        <option value="True">Active</option>
                                        <option value="False">Disable</option>
                                    </select>
                                </div>
                            </div>


                            <h5 class="card-inside-title " style="margin-bottom: 0px;">Thông tin tài khoản</h5>
                            <hr class="m-t-0" />
                            <div class="row">
                                <div class="col-md-3 col-lg-3">
                                    <select class="form-control" id="slUserType" runat="server" style="width: 100%;">
                                    </select>
                                </div>
                                <div class="col-md-3 col-lg-3">
                                    <div class="form-group form-float">
                                        <div class="form-line" id="fltxtCodeUser">
                                            <input type="text" class="form-control" id="txtCodeUser">
                                            <label class="form-label">Mã nhân viên <span style="display: inline-block; font-size: 10px;">(<i class="fa fa-certificate"></i>)</span></label>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3 col-lg-3">
                                    <div class="form-group form-float">
                                        <div class="form-line" id="fltxtUsername">
                                            <input type="text" class="form-control" id="txtUsername">
                                            <label class="form-label">Tên đăng nhập <span style="display: inline-block; font-size: 10px;">(<i class="fa fa-certificate"></i>)</span></label>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3 col-lg-3">
                                    <div class="form-group form-float">
                                        <div class="form-line" id="fltxtPassword">
                                            <input type="password" class="form-control" id="txtPassword">
                                            <label class="form-label">Mật khẩu <span style="display: inline-block; font-size: 10px;">(<i class="fa fa-certificate"></i>)</span></label>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-3 col-lg-3 hidden">
                                    <select class="form-control" id="slEduMinistry" runat="server" style="width: 100%;">
                                    </select>
                                </div>
                                <div class="col-md-3 col-lg-3">
                                    <select class="form-control" id="slEduProvince" runat="server" style="width: 100%;" onchange="slEduProvince_onchange(this.value);">
                                    </select>
                                </div>
                                <div class="col-md-3 col-lg-3">
                                    <select class="form-control" id="slEduDepartment" runat="server" style="width: 100%;" onchange="slEduDepartment_onchange(this.value);">
                                    </select>
                                </div>
                                <div class="col-md-6 col-lg-6">
                                    <select class="form-control" id="slEduSchoold" runat="server" style="width: 100%;">
                                    </select>
                                </div>
                            </div>

                        </div>
                        <div class="modal-footer">
                            <a class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times m-r-10"></i>ĐÓNG</a>
                            <a class="btn btn-success" id="btnModalSave"><i class="fa fa-check m-r-10"></i>LƯU</a>
                        </div>
                    </div>
                </div>
            </div>
            <!-- END vertical Modal -->
        </div>
    </section>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FooterMaster" runat="Server">
    <link href="../../plugins/jquery-datetimepicker/jquery.datetimepicker.min.css" rel="stylesheet" />
    <script src="../../plugins/jquery-datetimepicker/jquery.datetimepicker.full.min.js"></script>
    <script>
        function slEduProvince_onchange(value) {
            var xmlhttp;
            if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                xmlhttp = new XMLHttpRequest();
            }
            else {// code for IE6, IE5
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                    if (xmlhttp.responseText != "") {
                        $("#ContentMaster_slEduDepartment").html(xmlhttp.responseText);
                    }
                }
            }
            xmlhttp.open("GET", "../../Ajax.aspx?Action=Load_EduDepartment&IDEduProvince=" + value, true);
            xmlhttp.send();
        }

        function slEduDepartment_onchange(value) {
            var xmlhttp;
            if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                xmlhttp = new XMLHttpRequest();
            }
            else {// code for IE6, IE5
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                    if (xmlhttp.responseText != "") {
                        $("#ContentMaster_slEduSchoold").html(xmlhttp.responseText);
                    }
                }
            }
            xmlhttp.open("GET", "../../Ajax.aspx?Action=Load_EduSchoold&IDEduDepartment=" + value, true);
            xmlhttp.send();
        }
        $("#ContentMaster_slUserType,#ContentMaster_slEduMinistry,#ContentMaster_slEduProvince,#ContentMaster_slEduDepartment,#ContentMaster_slEduSchoold").select2();

        //datetimepicker jquery
        jQuery.datetimepicker.setLocale('vi');//chỉ cần dòng này là có thể đổi được ngôn ngữ

        $('#txtNgaySinh').datetimepicker({
            lang: "vi",
            autoclose: true,
            todayHighlight: true,
            timepicker: false,
            format: 'd/m/Y',
            //step:60,//số phút cách
            //format: 'd/m/Y H:i',
            //formatTime: 'H',
            //datepicker: true,
            //allowTimes: ['12:00', '13:00', '15:00','17:00', '17:05', '17:20', '19:00', '20:00'], //chỉ cho vài giờ để chọn
        });
    </script>
</asp:Content>
