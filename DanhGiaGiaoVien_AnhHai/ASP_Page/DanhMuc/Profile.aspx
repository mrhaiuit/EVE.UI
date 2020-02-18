<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/MasterPage.master" AutoEventWireup="true" CodeFile="Profile.aspx.cs" Inherits="QuanLyNhapKho_NhapKho" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script>
        function UploadHinhAnh_Onchange(input, iddd) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();

                reader.onload = function (e) {
                    $('#ContentMaster_' + iddd)
                        .attr('src', e.target.result)
                        .width('100%');
                };
                $("#ContentMaster_DaThayDoi_" + iddd).val('1');
                reader.readAsDataURL(input.files[0]);
            }
        }
        function btnSaveInfo_click() {
            var flag = true;
            var FullnameUser = $("#ContentMaster_txtFullName").val().trim();
            var PhoneUser = $("#ContentMaster_txtPhoneNumber").val().trim();
            var EmailUser = $("#ContentMaster_txtEmail").val().trim();
            var Username = $("#ContentMaster_txtUsername").val().trim();

            ////////////////////////////////////
            if (FullnameUser == "") {
                $("#spFullname").html("Vui lòng nhập họ tên !");
                $("#spFullname").css('display', 'block');
                $("#fltxtFullname").addClass("animated shake");
                setTimeout(function () {
                    $("#fltxtFullname").removeClass("animated shake");
                }, 1000);
                flag = false;
            }
            else
                $("#spFullname").css('display', 'none');
            ////////////////////////////////////
            if (Username == "") {
                $("#spUsername").html("Vui lòng nhập tên đăng nhập !");
                $("#spUsername").css('display', 'block');
                $("#fltxtUsername").addClass("animated shake");
                setTimeout(function () {
                    $("#fltxtUsername").removeClass("animated shake");
                }, 1000);
                flag = false;
            }
            else
                $("#spUsername").css('display', 'none');
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
                    if (xmlhttp.responseText == "OK") {
                        document.getElementById("ContentMaster_btnSaveInfo").click();
                    }
                    else if (xmlhttp.responseText == "SameUsername") {
                        $("#spUsername").html("Tên đăng nhập này đã được sử dụng !");
                        $("#spUsername").css('display', 'block');
                        $("#fltxtUsername").addClass("animated shake");
                        setTimeout(function () {
                            $("#fltxtUsername").removeClass("animated shake");
                        }, 1000);
                    }
                    else {
                        alert("Lỗi !");
                    }

                }
            }
            xmlhttp.open("GET", "../../Ajax.aspx?Action=CheckUsername&Username=" + Username, true);
            xmlhttp.send();
        }
        function btnChangePasswordJS_click() {
            var flag = true;
            var PasswordOLD = $("#ContentMaster_txtPasswordOLD").val().trim();
            var PasswordNEW = $("#ContentMaster_txtPasswordNEW").val().trim();
            var PasswordConfirm = $("#ContentMaster_txtPasswordConfirm").val().trim();
            ////////////////////////////////////
            if (PasswordOLD == "") {
                $("#spPasswordOLD").html("Vui lòng nhập mật khẫu cũ !");
                $("#spPasswordOLD").css('display', 'block');
                $("#fltxtPasswordOLD").addClass("animated shake");
                setTimeout(function () {
                    $("#fltxtPasswordOLD").removeClass("animated shake");
                }, 1000);
                flag = false;
            }
            else
                $("#spPasswordOLD").css('display', 'none'); debugger;
            ////////////////////////////////////
            if (PasswordNEW == "") {
                $("#spPasswordNEW").html("Vui lòng nhập mật khẫu mới !");
                $("#spPasswordNEW").css('display', 'block');
                $("#fltxtPasswordNEW").addClass("animated shake");
                setTimeout(function () {
                    $("#fltxtPasswordNEW").removeClass("animated shake");
                }, 1000);
                flag = false;
            }
            else
                $("#spPasswordNEW").css('display', 'none');
            ////////////////////////////////////
            if (hasUnicode(PasswordNEW) && PasswordNEW != "") {
                $("#spPasswordNEW").html("Vui lòng nhập mật khẫu có dấu !");
                $("#spPasswordNEW").css('display', 'block');
                $("#fltxtPasswordNEW").addClass("animated shake");
                setTimeout(function () {
                    $("#fltxtPasswordNEW").removeClass("animated shake");
                }, 1000);
                flag = false;
            }
            else if (!hasUnicode(PasswordNEW) && PasswordNEW != "")
                $("#spPasswordNEW").css('display', 'none');
            ////////////////////////////////////
            if (PasswordConfirm != PasswordNEW) {
                $("#spPasswordConfirm").html("Không khớp !");
                $("#spPasswordConfirm").css('display', 'block');
                $("#fltxtPasswordConfirm").addClass("animated shake");
                setTimeout(function () {
                    $("#fltxtPasswordConfirm").removeClass("animated shake");
                }, 1000);
                flag = false;
            }
            else
                $("#spPasswordConfirm").css('display', 'none');

            if (!flag)
                return;
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
                    if (xmlhttp.responseText == "OK") {
                        document.getElementById("ContentMaster_btnChangePassword").click();
                    }
                    else if (xmlhttp.responseText == "NOT") {
                        $("#spPasswordOLD").html("Mật khẩu cũ không đúng !");
                        $("#spPasswordOLD").css('display', 'block');
                        $("#fltxtPasswordOLD").addClass("animated shake");
                        setTimeout(function () {
                            $("#fltxtPasswordOLD").removeClass("animated shake");
                        }, 1000);
                    }
                    else {
                        alert("Lỗi !");
                    }

                }
            }
            xmlhttp.open("GET", "../../Ajax.aspx?Action=CheckPasswordOLD&PasswordOLD=" + PasswordOLD, true);
            xmlhttp.send();

        }
        function hasUnicode(str) {
            for (var i = 0; i < str.length; i++) {
                if (str.charCodeAt(i) > 127) return true;
            }
            return false;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentMaster" runat="Server">

    <section class="content">
        <div class="container-fluid">
            <div class="row clearfix">
                <div class="col-xs-12 col-sm-4 col-md-3">
                    <div class="card profile-card">
                        <input type="hidden" name="" value="0" runat="server" id="DaThayDoi_imgCoverImage" />
                        <input type="hidden" name="" value="0" runat="server" id="DaThayDoi_imgAvatar" />
                        <div class="profile-header" id="profile_header" runat="server">
                            <img id="imgCoverImage" runat="server" src="/images/user-img-background.jpg" alt="Cover" style="width: 100%; height: 100%; object-fit: cover;" />
                            <asp:FileUpload ID="fuCoverImage" runat="server" accept=".png,.jpg,.jpeg,.gif" Style="display: none" onchange="UploadHinhAnh_Onchange(this,'imgCoverImage');" />
                            <i class="fa fa-camera fa-2x" onclick="javascript:$('#ContentMaster_fuCoverImage').click();" data-toggle="tooltip" data-placement="right" title="" data-original-title="Đổi ảnh bìa"></i>
                        </div>
                        <div class="profile-body">
                            <div class="image-area">
                                <div style="width: 20rem; height: 20rem; margin: auto;">
                                    <i class="fa fa-camera fa-2x" onclick="javascript:$('#ContentMaster_fuAvatarImage').click();" data-toggle="tooltip" data-placement="right" title="" data-original-title="Đổi ảnh đại diện"></i>
                                    <img id="imgAvatar" runat="server" src="/images/user-lg.jpg" alt="Avatar" />
                                </div>
                                <asp:FileUpload ID="fuAvatarImage" runat="server" accept=".png,.jpg,.jpeg,.gif" Style="display: none" onchange="UploadHinhAnh_Onchange(this,'imgAvatar');" />
                            </div>
                            <div class="content-area">
                                <h3 id="h3FullnameUser" runat="server">Le Thanh Vinh</h3>
                                <p id="pUserType" runat="server">Administrator</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-xs-12 col-sm-8 col-md-9">
                    <div class="card">
                        <div class="body">
                            <div>
                                <ul class="nav nav-tabs" role="tablist">
                                    <li role="presentation" class="active"><a href="#home" aria-controls="home" role="tab" data-toggle="tab">Thông tin chung</a></li>
                                    <li role="presentation"><a href="#change_password_settings" aria-controls="settings" role="tab" data-toggle="tab">Đổi mật khẩu</a></li>
                                </ul>

                                <div class="tab-content">
                                    <div role="tabpanel" class="tab-pane fade in active" id="home">
                                        <div class="form-horizontal">
                                            <div class="form-group">
                                                <label for="ContentMaster_txtFullName" class="col-sm-4 control-label">Họ tên</label>
                                                <div class="col-sm-8">
                                                    <div class="form-line" id="fltxtFullname">
                                                        <input type="text" class="form-control" id="txtFullName" value="" runat="server">
                                                    </div>
                                                    <span id="spFullname" style="color: rgb(255, 5, 5); font-weight: 600; display: none;">Error</span>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="ContentMaster_txtPhoneNumber" class="col-sm-4 control-label">Số điện thoại</label>
                                                <div class="col-sm-8">
                                                    <div class="form-line">
                                                        <input type="text" class="form-control" id="txtPhoneNumber" value="" runat="server">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="ContentMaster_txtEmail" class="col-sm-4 control-label">Email</label>
                                                <div class="col-sm-8">
                                                    <div class="form-line">
                                                        <input type="text" class="form-control" id="txtEmail" value="" runat="server">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="ContentMaster_txtUsername" class="col-sm-4 control-label">Tên đăng nhập</label>
                                                <div class="col-sm-8">
                                                    <div class="form-line" id="fltxtUsername">
                                                        <input type="text" class="form-control" id="txtUsername" value="" runat="server">
                                                    </div>
                                                    <span id="spUsername" style="color: rgb(255, 5, 5); font-weight: 600; display: none;">Error</span>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-sm-offset-4 col-sm-8">
                                                    <a class="btn btn-success waves-effect waves-float" onclick="btnSaveInfo_click();" id="btnSaveInfoJS" runat="server"><i class="fa fa-check m-r-10"></i>LƯU</a>
                                                    <asp:LinkButton ID="btnSaveInfo" OnClick="btnSaveInfo_Click" runat="server" Style="display: none;"><i class="fa fa-check m-r-10"></i>LƯU</asp:LinkButton>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div role="tabpanel" class="tab-pane fade in" id="change_password_settings">
                                        <div class="form-horizontal">
                                            <div class="form-group">
                                                <label for="ContentMaster_txtPasswordOLD" class="col-sm-4 control-label">Mật khẩu cũ</label>
                                                <div class="col-sm-8">
                                                    <div class="form-line" id="fltxtPasswordOLD">
                                                        <input type="password" class="form-control" id="txtPasswordOLD" value="" runat="server">
                                                    </div>
                                                    <span id="spPasswordOLD" style="color: rgb(255, 5, 5); font-weight: 600; display: none;">Error</span>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="ContentMaster_txtPasswordNew" class="col-sm-4 control-label">Mật khẩu mới</label>
                                                <div class="col-sm-8">
                                                    <div class="form-line" id="fltxtPasswordNEW">
                                                        <input type="password" class="form-control" id="txtPasswordNEW" value="" runat="server">
                                                    </div>
                                                    <span id="spPasswordNEW" style="color: rgb(255, 5, 5); font-weight: 600; display: none;">Error</span>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="ContentMaster_txtPasswordConfirm" class="col-sm-4 control-label">Nhập lại mật khẩu mới</label>
                                                <div class="col-sm-8">
                                                    <div class="form-line" id="fltxtPasswordConfirm">
                                                        <input type="password" class="form-control" id="txtPasswordConfirm" value="" runat="server">
                                                    </div>
                                                    <span id="spPasswordConfirm" style="color: rgb(255, 5, 5); font-weight: 600; display: none;">Error</span>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-sm-offset-4 col-sm-8">
                                                    <a class="btn btn-danger waves-effect waves-float" onclick="btnChangePasswordJS_click();"><i class="fa fa-refresh m-r-10"></i>ĐỔI</a>
                                                    <asp:LinkButton ID="btnChangePassword" OnClick="btnChangePassword_Click" runat="server" Style="display: none;"><i class="fa fa-check m-r-10"></i>LƯU</asp:LinkButton>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FooterMaster" runat="Server">
</asp:Content>

