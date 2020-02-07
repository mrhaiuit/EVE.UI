<%@ Page Language="C#" MasterPageFile="~/Layout/MasterPage.master" AutoEventWireup="true" CodeFile="Section_User.aspx.cs" Inherits="ASP_Page_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .form-group span {
            color: #ca0000;
            font-size: 13px;
            display: none;
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
                $("#txtEmailUser").val('');
                $("#txtCodeUser").val('');
                $("#txtUsername").val('');
                $("#ContentMaster_slUserType").val('').trigger('change');
                $("#btnModalSave").attr('onclick', 'AddNewUser();');
                $("#spFullnameUser").css('display', 'none');
                $("#spUsername").css('display', 'none');
                $("#spCodeUser").css('display', 'none');

                $("#myModalTile").html('THÊM MỚI NGƯỜI DÙNG');
                $("#verticalModal").modal('show');
                $("#verticalModal").css({ 'display': 'flex', 'align-items': 'center' });
            }
            function AddNewUser() {
                var flag = true;
                var CodeUser = $("#txtCodeUser").val().trim();
                var FullnameUser = $("#txtFullnameUser").val().trim();
                var PhoneUser = $("#txtPhoneUser").val().trim();
                var EmailUser = $("#txtEmailUser").val().trim();
                var UserType = $("#ContentMaster_slUserType").val().trim();
                var Username = $("#txtUsername").val().trim();

                //if (CodeUser == "") {
                //    $("#spCodeUser").html("Vui lòng nhập mã người dùng !");
                //    $("#spCodeUser").css('display', 'block');
                //    $("#fltxtCodeUser").addClass("animated shake");
                //    setTimeout(function () {
                //        $("#fltxtCodeUser").removeClass("animated shake");
                //    }, 1000);
                //    flag = false;
                //}
                //else
                //    $("#spCodeUser").css('display', 'none');
                ////////////////////////////////////
                if (FullnameUser == "") {
                    $("#spFullnameUser").html("Vui lòng nhập họ tên !");
                    $("#spFullnameUser").css('display', 'block');
                    $("#fltxtFullnameUser").addClass("animated shake");
                    setTimeout(function () {
                        $("#fltxtFullnameUser").removeClass("animated shake");
                    }, 1000);
                    flag = false;
                }
                else
                    $("#spFullnameUser").css('display', 'none');
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
                else
                    $("#spUsername").css('display', 'none');
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
                xmlhttp.onreadystatechange = function ()
                {
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                        if (xmlhttp.responseText == "Success") {
                            window.location.reload();
                        }
                        else if (xmlhttp.responseText == "SameUsername") {
                            $("#spUsername").html("Tên đăng nhập này đã được sử dụng !");
                            $("#spUsername").css('display', 'block');
                            $("#fltxtUsername").addClass("animated shake");
                            setTimeout(function () {
                                $("#fltxtUsername").removeClass("animated shake");
                            }, 1000);
                        }
                        else if (xmlhttp.responseText == "SameCode") {
                            $("#spCodeUser").html("Mã này đã được sử dụng !");
                            $("#spCodeUser").css('display', 'block');
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
                xmlhttp.open("GET", "../../Ajax.aspx?Action=AddNewUser&CodeUser=" + CodeUser + "&FullnameUser=" + FullnameUser + "&PhoneUser=" + PhoneUser + "&EmailUser=" + EmailUser + "&UserType=" + UserType + "&Username=" + Username, true);
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
                            $("#fltxtEmailUser").addClass('focused');
                            $("#fltxtUsername").addClass('focused');

                            $("#txtCodeUser").val(arr[0]);
                            $("#txtCodeUser").val(arr[0]);
                            $("#txtFullnameUser").val(arr[1]);
                            $("#txtPhoneUser").val(arr[2]);
                            $("#txtEmailUser").val(arr[3]);
                            $("#txtUsername").val(arr[4]);
                            $("#ContentMaster_slUserType").val(arr[5]).trigger('change');
                            $("#spFullnameUser").css('display', 'none');
                            $("#spUsername").css('display', 'none');
                            $("#spCodeUser").css('display', 'none');

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
                var EmailUser = $("#txtEmailUser").val().trim();
                var UserType = $("#ContentMaster_slUserType").val().trim();
                var Username = $("#txtUsername").val().trim();

                //if (CodeUser == "") {
                //    $("#spCodeUser").html("Vui lòng nhập mã người dùng !");
                //    $("#spCodeUser").css('display', 'block');
                //    $("#fltxtCodeUser").addClass("animated shake");
                //    setTimeout(function () {
                //        $("#fltxtCodeUser").removeClass("animated shake");
                //    }, 1000);
                //    flag = false;
                //}
                //else
                //    $("#spCodeUser").css('display', 'none');
                ////////////////////////////////////
                if (FullnameUser == "") {
                    $("#spFullnameUser").html("Vui lòng nhập họ tên !");
                    $("#spFullnameUser").css('display', 'block');
                    $("#fltxtFullnameUser").addClass("animated shake");
                    setTimeout(function () {
                        $("#fltxtFullnameUser").removeClass("animated shake");
                    }, 1000);
                    flag = false;
                }
                else
                    $("#spFullnameUser").css('display', 'none');
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
                else
                    $("#spUsername").css('display', 'none');
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
                        if (xmlhttp.responseText == "Success") {
                            window.location.reload();
                        }
                        else if (xmlhttp.responseText == "SameUsername") {
                            $("#spUsername").html("Tên đăng nhập này đã được sử dụng !");
                            $("#spUsername").css('display', 'block');
                            $("#fltxtUsername").addClass("animated shake");
                            setTimeout(function () {
                                $("#fltxtUsername").removeClass("animated shake");
                            }, 1000);
                        }
                        else if (xmlhttp.responseText == "SameCode") {
                            $("#spCodeUser").html("Mã này đã được sử dụng !");
                            $("#spCodeUser").css('display', 'block');
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
                xmlhttp.open("GET", "../../Ajax.aspx?Action=EditUser&CodeUser=" + CodeUser + "&FullnameUser=" + FullnameUser + "&PhoneUser=" + PhoneUser + "&EmailUser=" + EmailUser + "&UserType=" + UserType + "&Username=" + Username + "&user=" + user, true);
                xmlhttp.send();
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentMaster" runat="Server">

    <section class="content">
        <div class="container-fluid">
            <div class="block-header">
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
                                    <h2>DANH SÁCH NGƯỜI DÙNG</h2>
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
                                <div class="col-lg-1 col-md-1 col-sm-3 col-xs-3 align-right">
                                    <a class="btn btn-warning waves-effect" href="Section_User.aspx"  style="width: 100%; box-shadow: none;"  data-toggle='tooltip' data-placement='top' title='' data-original-title='Refresh'><i class="material-icons">cached</i></a>
                                </div>
                            </div>
                        </div>
                        <div class="body table-responsive" id="dvtable" runat="server">
                        </div>
                    </div>
                </div>
            </div>
            <!-- vertical Modal -->
            <div class="modal fade" id="verticalModal" tabindex="-1" role="dialog" aria-labelledby="verticalModal">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content" style="border-radius: 10px;">
                        <div class="modal-header">
                            <h4 class="modal-title" id="myModalTile">THÊM MỚI NGƯỜI DÙNG</h4>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-3 col-lg-3">
                                    <div class="form-group form-float">
                                        <div class="form-line" id="fltxtFullnameUser">
                                            <input type="text" class="form-control" id="txtFullnameUser">
                                            <label class="form-label">Họ tên <span style="display: inline-block; font-size: 10px;">(<i class="fa fa-certificate"></i>)</span></label>
                                        </div>
                                        <span id="spFullnameUser">Error</span>
                                    </div>
                                </div>
                                <div class="col-md-3 col-lg-3">
                                    <div class="form-group form-float">
                                        <div class="form-line" id="fltxtPhoneUser">
                                            <input type="text" class="form-control" id="txtPhoneUser">
                                            <label class="form-label">Số điện thoại</label>
                                        </div>
                                        <span id="spPhoneUser">Error</span>
                                    </div>
                                </div>
                                <div class="col-md-3 col-lg-3">
                                    <div class="form-group form-float">
                                        <div class="form-line" id="fltxtEmailUser">
                                            <input type="text" class="form-control" id="txtEmailUser">
                                            <label class="form-label">Email</label>
                                        </div>
                                        <span id="spEmailUser">Error</span>
                                    </div>
                                </div>
                                <div class="col-md-3 col-lg-3">
                                    <select class="form-control" id="slUserType" runat="server" style="width:100%;">
                                    </select>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-3 col-lg-3">
                                    <div class="form-group form-float">
                                        <div class="form-line" id="fltxtCodeUser">
                                            <input type="text" class="form-control" id="txtCodeUser">
                                            <label class="form-label">Mã người dùng <span style="display: inline-block; font-size: 10px;">(<i class="fa fa-certificate"></i>)</span></label>
                                        </div>
                                        <span id="spCodeUser">Error</span>
                                    </div>
                                </div>
                                <div class="col-md-3 col-lg-3">
                                    <div class="form-group form-float">
                                        <div class="form-line" id="fltxtUsername">
                                            <input type="text" class="form-control" id="txtUsername">
                                            <label class="form-label">Tên đăng nhập</label>
                                        </div>
                                        <span id="spUsername">Error</span>
                                    </div>
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
    <script>
        //$("#ContentMaster_slUserType").selectpicker('render'); 
        $("#ContentMaster_slUserType").select2();
    </script>
</asp:Content>
