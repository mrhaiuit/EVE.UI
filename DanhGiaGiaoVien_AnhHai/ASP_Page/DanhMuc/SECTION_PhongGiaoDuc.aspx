<%@ Page Language="C#" Async="true" MasterPageFile="~/Layout/MasterPage.master" AutoEventWireup="true" CodeFile="SECTION_PhongGiaoDuc.aspx.cs" Inherits="ASP_Page_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .form-group span {
            color: #ca0000;
            font-size: 13px;
        }

        .select2-container .select2-selection--single {
            height: 37px !important;
        }

        .modal-lg {
            width: 80%;
        }
    </style>
    <script>
        {
            function OpenModal_AddPhongGiaoDuc() {
                $("#txtTenPhongGiaoDuc,#txtTenDuong").val("");
                $("#ContentMaster_slTinhThanh, #slQuanHuyen, #slPhuongXa").val("").trigger('change');

                $("#btnModalSave").attr('onclick', 'AddPhongGiaoDuc();');
                $("#myModalTile").html('THÊM MỚI PHÒNG GIÁO DỤC');
                $("#verticalModal").modal('show');
                $("#verticalModal").css({ 'display': 'flex', 'align-items': 'center' });
            }
            function AddPhongGiaoDuc() {
                var TenPhongGiaoDuc = $("#txtTenPhongGiaoDuc").val();
                var TenDuong = $("#txtTenDuong").val();
                var STT = $("#txtSTT").val();
                var Province = $("#ContentMaster_slTinhThanh").val();
                var District = $("#slQuanHuyen").val();
                var Ward = $("#slPhuongXa").val();

                var flag_OK = true;
                if (TenPhongGiaoDuc == "")//
                {
                    $("#txtTenPhongGiaoDuc").notify("Vui lòng nhập tên Phòng giáo dục!", { position: "top", className: "error", autoHideDelay: 5000, });
                    $("#fltxtTenPhongGiaoDuc").addClass("animated shake");
                    setTimeout(function () {
                        $("#fltxtTenPhongGiaoDuc").removeClass("animated shake");
                    }, 1000);
                    flag_OK = false;
                }
                if (TenDuong == "")//
                {
                    $("#txtTenDuong").notify("Vui lòng nhập tên Đường!", { position: "top", className: "error", autoHideDelay: 5000, });
                    $("#fltxtTenDuong").addClass("animated shake");
                    setTimeout(function () {
                        $("#fltxtTenDuong").removeClass("animated shake");
                    }, 1000);
                    flag_OK = false;
                }
                if (District == "")//
                {
                    $("#slQuanHuyen").notify("Vui lòng chọn Quận/Huyện!", { position: "top", className: "error", autoHideDelay: 5000, });
                    $("#slQuanHuyen").addClass("animated shake");
                    setTimeout(function () {
                        $("#slQuanHuyen").removeClass("animated shake");
                    }, 1000);
                    flag_OK = false;
                }

                var value = TenPhongGiaoDuc + "@_@" + TenDuong + "@_@" + Province + "@_@" + District + "@_@" + Ward + "@_@" + STT;
                if (!flag_OK)
                    return;
                $('.page-loader-wrapper').fadeIn(300);//mở hiệu ứng chờ

                var xmlhttp;
                if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                    xmlhttp = new XMLHttpRequest();
                }
                else {// code for IE6, IE5
                    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                }
                xmlhttp.onreadystatechange = function () {
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                        if (xmlhttp.responseText == "Success")//
                        {
                            window.location.reload();
                        }
                        else {
                            $('.page-loader-wrapper').fadeOut();//tắt hiệu ứng chờ
                            swal("Lỗi !", "", "error");
                        }

                    }
                }
                xmlhttp.open("GET", "../../Ajax.aspx?Action=AddPhongGiaoDuc&value=" + value, true);
                xmlhttp.send();

            }
            function OpenModal_EditPhongGiaoDuc(value)//
            {
                var xmlhttp;
                if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                    xmlhttp = new XMLHttpRequest();
                }
                else {// code for IE6, IE5
                    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                }
                xmlhttp.onreadystatechange = function () {
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                        if (xmlhttp.responseText != "")//
                        {
                            $("#fltxtTenPhongGiaoDuc,#fltxtTenDuong,#fltxtSTT").addClass("focused");

                            var arr = xmlhttp.responseText.split("@_@");
                            $("#txtTenPhongGiaoDuc").val(arr[0]);
                            $("#txtTenDuong").val(arr[1]);
                            $("#txtSTT").val(arr[2]);
                            $("#ContentMaster_slTinhThanh").val(arr[3]).trigger('change');
                            setTimeout(function () { $("#slQuanHuyen").val(arr[4]).trigger('change'); }, 300);
                            //setTimeout(function () { $("#slPhuongXa").val(arr[7]).trigger('change'); }, 600);


                            $("#btnModalSave").attr('onclick', 'EditPhongGiaoDuc(' + value + ');');

                            $("#myModalTile").html('CHỈNH SỬA THÔNG TIN PHÒNG GIÁO DỤC');
                            $("#verticalModal").modal('show');
                            $("#verticalModal").css({ 'display': 'flex', 'align-items': 'center' });
                        }
                        else {
                            swal("Lỗi !", "", "error");
                        }
                    }
                }
                xmlhttp.open("GET", "../../Ajax.aspx?Action=LoadPhongGiaoDuc&value=" + value, true);
                xmlhttp.send();
            }
            function EditPhongGiaoDuc(PhongGiaoDuc) {
                var TenPhongGiaoDuc = $("#txtTenPhongGiaoDuc").val();
                var TenDuong = $("#txtTenDuong").val();
                var STT = $("#txtSTT").val();
                var Province = $("#ContentMaster_slTinhThanh").val();
                var District = $("#slQuanHuyen").val();
                var Ward = $("#slPhuongXa").val();

                var flag_OK = true;
                if (TenPhongGiaoDuc == "")//
                {
                    $("#txtTenPhongGiaoDuc").notify("Vui lòng nhập tên Phòng giáo dục!", { position: "top", className: "error", autoHideDelay: 5000, });
                    $("#fltxtTenPhongGiaoDuc").addClass("animated shake");
                    setTimeout(function () {
                        $("#fltxtTenPhongGiaoDuc").removeClass("animated shake");
                    }, 1000);
                    flag_OK = false;
                }
                if (TenDuong == "")//
                {
                    $("#txtTenDuong").notify("Vui lòng nhập tên Đường!", { position: "top", className: "error", autoHideDelay: 5000, });
                    $("#fltxtTenDuong").addClass("animated shake");
                    setTimeout(function () {
                        $("#fltxtTenDuong").removeClass("animated shake");
                    }, 1000);
                    flag_OK = false;
                }
                if (STT == "")//
                {
                    $("#txtSTT").notify("Vui lòng nhập Số thứ tự!", { position: "top", className: "error", autoHideDelay: 5000, });
                    $("#fltxtSTT").addClass("animated shake");
                    setTimeout(function () {
                        $("#fltxtSTT").removeClass("animated shake");
                    }, 1000);
                    flag_OK = false;
                }
                if (District == "")//
                {
                    $("#slQuanHuyen").notify("Vui lòng chọn Quận/Huyện!", { position: "top", className: "error", autoHideDelay: 5000, });
                    $("#slQuanHuyen").addClass("animated shake");
                    setTimeout(function () {
                        $("#slQuanHuyen").removeClass("animated shake");
                    }, 1000);
                    flag_OK = false;
                }


                var value = TenPhongGiaoDuc + "@_@" + TenDuong + "@_@" + Province + "@_@" + District + "@_@" + Ward + "@_@" + STT;
                if (!flag_OK)
                    return;
                $('.page-loader-wrapper').fadeIn(300);//mở hiệu ứng chờ

                var xmlhttp;
                if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                    xmlhttp = new XMLHttpRequest();
                }
                else {// code for IE6, IE5
                    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                }
                xmlhttp.onreadystatechange = function () {
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                        if (xmlhttp.responseText == "Success")//
                        {
                            window.location.reload();
                        }
                        else {
                            $('.page-loader-wrapper').fadeOut();//tắt hiệu ứng chờ
                            swal("Lỗi !", "", "error");
                        }

                    }
                }
                xmlhttp.open("GET", "../../Ajax.aspx?Action=EditPhongGiaoDuc&value=" + value + "&PhongGiaoDuc=" + PhongGiaoDuc, true);
                xmlhttp.send();

            }
            function slTinhThanh_onchange(value) {
                var xmlhttp;
                if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                    xmlhttp = new XMLHttpRequest();
                }
                else {// code for IE6, IE5
                    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                }
                xmlhttp.onreadystatechange = function () {
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                        if (xmlhttp.responseText != "")//
                        {
                            $("#slQuanHuyen").html(xmlhttp.responseText);
                        }
                        else {
                            //swal("Lỗi !", "", "error");
                        }

                    }
                }
                xmlhttp.open("GET", "../../Ajax.aspx?Action=slTinhThanh_onchange&value=" + value, true);
                xmlhttp.send();
            }
            function slQuanHuyen_onchange(value) {
                var xmlhttp;
                if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                    xmlhttp = new XMLHttpRequest();
                }
                else {// code for IE6, IE5
                    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                }
                xmlhttp.onreadystatechange = function () {
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                        if (xmlhttp.responseText != "")//
                        {
                            $("#slPhuongXa").html(xmlhttp.responseText);
                        }
                        else {
                            //swal("Lỗi !", "", "error");
                        }

                    }
                }
                xmlhttp.open("GET", "../../Ajax.aspx?Action=slQuanHuyen_onchange&value=" + value, true);
                xmlhttp.send();
            }
            function DeletePhongGiaoDuc(PhongGiaoDuc) {
                swal({
                    title: 'Bạn có chắc muốn xoá ?',
                    type: 'warning',
                    showCancelButton: true,
                    closeOnConfirm: false,
                    showLoaderOnConfirm: true,
                    confirmButtonColor: '#F44336',
                    cancelButtonColor: '#ef4848',
                    confirmButtonText: 'Xoá',
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
                                swal("Đã xoá!");
                                setTimeout(function () {
                                    window.location.reload();
                                }, 200);

                            }
                            else {
                                swal("Lỗi !", "", "error");
                            }
                        }
                    }
                    xmlhttp.open("GET", "../../Ajax.aspx?Action=DeletePhongGiaoDuc&PhongGiaoDuc=" + PhongGiaoDuc, true);
                    xmlhttp.send();
                });
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
                    <li class="active"><a href="../../Asp_page/SECTION_PHONGGIAODUC.aspx"><i class="fa fa-user m-r-10"></i>Quản lý Phòng giáo dục</a></li>
                </ol>
            </div>
            <div class="row clearfix">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="card">
                        <div class="header">
                            <div class="row">
                                <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
                                    <h4>QUẢN LÝ PHÒNG GIÁO DỤC</h4>
                                </div>
                                <br />
                                <br />
                            </div>
                            <div class="row">
                                <div class="col-lg-3 col-md-3 col-sm-12 col-xs-12">
                                    <div class="input-group">
                                        <span class="input-group-addon">
                                            <i class="material-icons">search</i>
                                        </span>
                                        <div class="form-line">
                                            <input type="text" class="form-control date" placeholder="Tìm kiếm" runat="server" id="txtSearch">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
                                    <select class="form-control" id="slSoGiaoDuc" style="width: 100%;" runat="server">
                                        <option>-- Chọn sở giáo dục --</option>
                                        <option value='0'>Sở A</option>
                                        <option value='1'>Sở B</option>
                                        <option value='2'>Sở C</option>
                                        <option value='3'>Sở D</option>
                                        <option value='4'>Sở E</option>
                                    </select>
                                </div>
                                <div class="col-lg-2 col-md-2 col-sm-6 col-xs-6">
                                    <!-- Call Search -->
                                    <asp:LinkButton OnClick="btnSearch_Click" runat="server" class="btn btn-warning waves-effect js-search" Style="width: 100%; box-shadow: none;"><i class="material-icons">search</i><span>Tìm kiếm</span></asp:LinkButton>
                                    <!-- #END# Call Search -->
                                </div>
                                <div class="col-lg-3 col-md-3 col-sm-6 col-xs-6 align-right">
                                    <a class="btn btn-warning waves-effect" href="javascript:OpenModal_AddPhongGiaoDuc();"><i class="material-icons">playlist_add</i> <span>THÊM MỚI</span></a>
                                </div>
                            </div>
                        </div>
                        <div class="body table-responsive">
                            <table class='table table-bordered table-hover'>
                                <thead>
                                    <tr>
                                        <th class='bg-cyan' style='min-width: 5rem;'>STT</th>
                                        <th class='bg-cyan' style='min-width: 15rem;'>PHÒNG GIÁO DỤC</th>
                                        <th class='bg-cyan' style='min-width: 10rem;'>ĐỊA CHỈ</th>
                                        <th class='bg-cyan align-center'></th>
                                    </tr>
                                </thead>
                                <tbody id="tbody_DSPhongGiaoDuc" runat="server">
                                    <%--///////////////////////////--%>
                                    <tr>
                                        <td>1</td>
                                        <td>Phòng giáo dục A</td>
                                        <td>Quận 1, TPHCM</td>
                                        <td class="text-nowrap align-center">
                                            <a href='javascript:OpenModal_EditPhongGiaoDuc();' class='btn bg-green waves-effect' style='padding: 0 7px 3px 7px;' data-toggle='tooltip' data-placement='top' title='' data-original-title='Sửa'><i class='fa fa-pencil'></i></a>
                                            <a href='javascript:void(0)' class='btn bg-red waves-effect' style='padding: 0 7px 3px 7px;' data-toggle='tooltip' data-placement='top' title='' data-original-title='Xoá'><i class='fa fa-trash'></i></a>
                                        </td>
                                    </tr>
                                    <%--///////////////////////////--%>
                                    <%--///////////////////////////--%>
                                    <tr>
                                        <td>2</td>
                                        <td>Phòng giáo dục B</td>
                                        <td>Quận 2, TPHCM</td>
                                        <td class="text-nowrap align-center">
                                            <a href='javascript:OpenModal_EditPhongGiaoDuc();' class='btn bg-green waves-effect' style='padding: 0 7px 3px 7px;' data-toggle='tooltip' data-placement='top' title='' data-original-title='Sửa'><i class='fa fa-pencil'></i></a>
                                            <a href='javascript:void(0)' class='btn bg-red waves-effect' style='padding: 0 7px 3px 7px;' data-toggle='tooltip' data-placement='top' title='' data-original-title='Xoá'><i class='fa fa-trash'></i></a>
                                        </td>
                                    </tr>
                                    <%--///////////////////////////--%>
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td colspan="15" class="footertable align-center">
                                            <ul class="pagination margin-0">
                                                <li><a href="SECTION_PhongGIaoDuc.aspx?Page=1" class="waves-effect"><i class="material-icons">chevron_left</i></a></li>
                                                <li class="active"><a href="SECTION_PhongGIaoDuc.aspx?Page=1" class="waves-effect bg-cyan">1</a></li>
                                                <li class="hidden"><a href="SECTION_PhongGIaoDuc.aspx?Page=" class="waves-effect"></a></li>
                                                <li class="hidden"><a href="SECTION_PhongGIaoDuc.aspx?Page=" class="waves-effect"></a></li>
                                                <li class="hidden"><a href="SECTION_PhongGIaoDuc.aspx?Page=" class="waves-effect"></a></li>
                                                <li class="hidden"><a href="SECTION_PhongGIaoDuc.aspx?Page=" class="waves-effect"></a></li>
                                                <li><a href="SECTION_PhongGIaoDuc.aspx?Page=1" class="waves-effect"><i class="material-icons">chevron_right</i></a></li>
                                            </ul>
                                        </td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <!-- vertical Modal -->
            <div class="modal fade" id="verticalModal" tabindex="-1" role="dialog" aria-labelledby="verticalModal" data-keyboard="false" data-backdrop="static">
                <div class="modal-dialog" role="document">
                    <div class="modal-content" style="border-radius: 10px;">
                        <div class="modal-header">
                            <h4 class="modal-title" id="myModalTile">THÊM MỚI</h4>
                        </div>
                        <div class="modal-body">

                            <div class="row">
                                <div class="col-md-8 col-lg-8">
                                    <div class="form-group form-float">
                                        <div class="form-line" id="fltxtTenPhongGiaoDuc">
                                            <input type="text" class="form-control" id="txtTenPhongGiaoDuc">
                                            <label class="form-label">Tên phòng <span style="display: inline-block; font-size: 10px;">(<i class="fa fa-certificate"></i>)</span></label>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4 col-lg-4">
                                    <div class="form-group form-float">
                                        <div class="form-line" id="fltxtSTT">
                                            <input type="text" class="form-control" id="txtSTT">
                                            <label class="form-label">Số thứ tự  </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12 col-lg-12">
                                    <h5 class="card-inside-title " style="margin-bottom: 5px; margin-top: 0; visibility: hidden;">Tên đường</h5>
                                    <div class="form-group form-float">
                                        <div class="form-line" id="fltxtTenDuong">
                                            <input type="text" class="form-control" id="txtTenDuong">
                                            <label class="form-label">Địa chỉ <span style="display: inline-block; font-size: 10px;">(<i class="fa fa-certificate"></i>)</span></label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 col-lg-6">
                                    <h5 class="card-inside-title " style="margin-bottom: 5px; margin-top: 0;">Tỉnh/Thành phố</h5>
                                    <select class="form-control" id="slTinhThanh" style="width: 100%;" onchange="slTinhThanh_onchange(this.value);" runat="server">
                                        <option value="">── Chọn tỉnh/thành phố ──</option>
                                    </select>
                                </div>
                                <div class="col-md-6 col-lg-6">
                                    <h5 class="card-inside-title " style="margin-bottom: 5px; margin-top: 0;">Quận/Huyện</h5>
                                    <select class="form-control" id="slQuanHuyen" style="width: 100%;" onchange="slQuanHuyen_onchange(this.value);">
                                        <option value="">── Chọn quận/huyện ──</option>
                                    </select>
                                </div>
                                <div class="col-md-6 col-lg-6 hidden">
                                    <h5 class="card-inside-title " style="margin-bottom: 5px; margin-top: 0;">Phường/Xã</h5>
                                    <select class="form-control" id="slPhuongXa" style="width: 100%;">
                                        <option value="">── Chọn phường/xã ──</option>
                                    </select>
                                </div>
                            </div>

                        </div>
                        <div class="modal-footer">
                            <a class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times m-r-10"></i>HUỶ</a>
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

        $("#ContentMaster_slSoGiaoDuc,#ContentMaster_slTinhThanh,#slQuanHuyen,#slPhuongXa").select2();

        //datetimepicker jquery
        jQuery.datetimepicker.setLocale('vi');//chỉ cần dòng này là có thể đổi được ngôn ngữ

        $('#txtTuNgay,#txtDenNgay').datetimepicker({
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
