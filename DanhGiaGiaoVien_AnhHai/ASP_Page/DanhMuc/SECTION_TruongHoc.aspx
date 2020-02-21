<%@ Page Language="C#" MasterPageFile="~/Layout/MasterPage.master" Async="true" AutoEventWireup="true" CodeFile="SECTION_TruongHoc.aspx.cs" Inherits="ASP_Page_Default" %>

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
            window.onload = function ()//
            {
                var SGD = getQueryString("SGD");
                var PGD = getQueryString("PGD");
                if (SGD != "") 
                    $("#ContentMaster_slSoGiaoDuc").val(SGD).trigger('change');
                if (PGD != "")
                    setTimeout(function () { $("#ContentMaster_slPhongGiaoDuc").val(PGD).trigger('change'); }, 500); 
            }
            function OpenModal_AddTruongHoc() {
                $("#txtTenTruongHoc,#txtTenDuong").val("");
                $("#ContentMaster_slSoGiaoDuc_modal, #slPhongGiaoDuc_modal, #ContentMaster_slCapTruong_modal").val("").trigger('change');
                $("#ContentMaster_slTinhThanh, #slQuanHuyen, #slPhuongXa").val("").trigger('change');

                $("#btnModalSave").attr('onclick', 'AddTruongHoc();');
                $("#myModalTile").html('THÊM MỚI TRƯỜNG HỌC');
                $("#verticalModal").modal('show');
                $("#verticalModal").css({ 'display': 'flex', 'align-items': 'center' });
            }
            function AddTruongHoc() {
                var TenTruong = $("#txtTenTruongHoc").val();
                var TenDuong = $("#txtTenDuong").val();
                var EduProvince = $("#ContentMaster_slSoGiaoDuc_modal").val();
                var EduDepartment = $("#slPhongGiaoDuc_modal").val();
                var SchoolLevelCode = $("#ContentMaster_slCapTruong_modal").val();
                var Province = $("#ContentMaster_slTinhThanh").val();
                var District = $("#slQuanHuyen").val();
                var Ward = $("#slPhuongXa").val();

                var flag_OK = true;
                if (TenTruong == "")//
                {
                    $("#txtTenTruongHoc").notify("Vui lòng nhập tên Trường!", { position: "top", className: "error", autoHideDelay: 5000, });
                    $("#fltxtTenTruongHoc").addClass("animated shake");
                    setTimeout(function () {
                        $("#fltxtTenTruongHoc").removeClass("animated shake");
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
                if (SchoolLevelCode == "")//
                {
                    $("#ContentMaster_slCapTruong_modal").notify("Vui lòng chọn Cấp Trường!", { position: "top", className: "error", autoHideDelay: 5000, });
                    $("#ContentMaster_slCapTruong_modal").addClass("animated shake");
                    setTimeout(function () {
                        $("#ContentMaster_slCapTruong_modal").removeClass("animated shake");
                    }, 1000);
                    flag_OK = false;
                }
                if (Ward == "")//
                {
                    $("#slPhuongXa").notify("Vui lòng chọn Phường/Xã !", { position: "top", className: "error", autoHideDelay: 5000, });
                    $("#slPhuongXa").addClass("animated shake");
                    setTimeout(function () {
                        $("#slPhuongXa").removeClass("animated shake");
                    }, 1000);
                    flag_OK = false;
                }

                var value = TenTruong + "@_@" + TenDuong + "@_@" + EduProvince + "@_@" + EduDepartment + "@_@" + SchoolLevelCode + "@_@" + Province + "@_@" + District + "@_@" + Ward;
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
                xmlhttp.open("GET", "../../Ajax.aspx?Action=AddTruongHoc&value=" + value, true);
                xmlhttp.send();

            }
            function OpenModal_EditTruongHoc(value)//
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
                            $("#fltxtTenTruongHoc,#fltxtTenDuong").addClass("focused");

                            var arr = xmlhttp.responseText.split("@_@");
                            $("#ContentMaster_slSoGiaoDuc_modal").val(arr[0]).trigger('change');
                            setTimeout(function () { $("#slPhongGiaoDuc_modal").val(arr[1]).trigger('change'); }, 500);
                            $("#ContentMaster_slCapTruong_modal").val(arr[2]);
                            $("#txtTenTruongHoc").val(arr[3]);
                            $("#txtTenDuong").val(arr[4]);
                            $("#ContentMaster_slTinhThanh").val(arr[5]).trigger('change');
                            setTimeout(function () { $("#slQuanHuyen").val(arr[6]).trigger('change'); }, 300);
                            setTimeout(function () { $("#slPhuongXa").val(arr[7]).trigger('change'); }, 600);

                            $("#btnModalSave").attr('onclick', 'EditTruongHoc('+value+');');

                            $("#myModalTile").html('CHỈNH SỬA THÔNG TIN TRƯỜNG HỌC');
                            $("#verticalModal").modal('show');
                            $("#verticalModal").css({ 'display': 'flex', 'align-items': 'center' });
                        }
                        else {
                            swal("Lỗi !", "", "error");
                        }
                    }
                }
                xmlhttp.open("GET", "../../Ajax.aspx?Action=LoadTruongHoc&value=" + value, true);
                xmlhttp.send();
            }  
            function EditTruongHoc(TruongHoc) {
                var TenTruong = $("#txtTenTruongHoc").val();
                var TenDuong = $("#txtTenDuong").val();
                var EduProvince = $("#ContentMaster_slSoGiaoDuc_modal").val();
                var EduDepartment = $("#slPhongGiaoDuc_modal").val();
                var SchoolLevelCode = $("#ContentMaster_slCapTruong_modal").val();
                var Province = $("#ContentMaster_slTinhThanh").val();
                var District = $("#slQuanHuyen").val();
                var Ward = $("#slPhuongXa").val();

                var flag_OK = true;
                if (TenTruong == "")//
                {
                    $("#txtTenTruongHoc").notify("Vui lòng nhập tên Trường!", { position: "top", className: "error", autoHideDelay: 5000, });
                    $("#fltxtTenTruongHoc").addClass("animated shake");
                    setTimeout(function () {
                        $("#fltxtTenTruongHoc").removeClass("animated shake");
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
                if (SchoolLevelCode == "")//
                {
                    $("#ContentMaster_slCapTruong_modal").notify("Vui lòng chọn Cấp Trường!", { position: "top", className: "error", autoHideDelay: 5000, });
                    $("#ContentMaster_slCapTruong_modal").addClass("animated shake");
                    setTimeout(function () {
                        $("#ContentMaster_slCapTruong_modal").removeClass("animated shake");
                    }, 1000);
                    flag_OK = false;
                }
                if (Ward == "")//
                {
                    $("#slPhuongXa").notify("Vui lòng chọn Phường/Xã !", { position: "top", className: "error", autoHideDelay: 5000, });
                    $("#slPhuongXa").addClass("animated shake");
                    setTimeout(function () {
                        $("#slPhuongXa").removeClass("animated shake");
                    }, 1000);
                    flag_OK = false;
                }

                var value = TenTruong + "@_@" + TenDuong + "@_@" + EduProvince + "@_@" + EduDepartment + "@_@" + SchoolLevelCode + "@_@" + Province + "@_@" + District + "@_@" + Ward;
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
                xmlhttp.open("GET", "../../Ajax.aspx?Action=EditTruongHoc&value=" + value + "&TruongHoc=" + TruongHoc, true);
                xmlhttp.send();

            }
            function slSoGiaoDuc_onchange(value, id)//
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
                            if (id == "modal")
                                $("#slPhongGiaoDuc_modal").html(xmlhttp.responseText);
                            else
                                $("#ContentMaster_slPhongGiaoDuc").html(xmlhttp.responseText);
                        }
                        else {
                            //swal("Lỗi !", "", "error");
                        }

                    }
                }
                xmlhttp.open("GET", "../../Ajax.aspx?Action=slSoGiaoDuc_onchange&value=" + value, true);
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
            function DeleteTruongHoc(TruongHoc)
            {
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
                    xmlhttp.open("GET", "../../Ajax.aspx?Action=DeleteTruongHoc&TruongHoc=" + TruongHoc, true);
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
                    <li class="active"><a href="../../Asp_page/SECTION_TruongHoc.aspx"><i class="fa fa-user m-r-10"></i>Quản lý Trường học</a></li>
                </ol>
            </div>
            <div class="row clearfix">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="card">
                        <div class="header">
                            <div class="row">
                                <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
                                    <h4>QUẢN LÝ TRƯỜNG HỌC</h4>
                                </div>
                                <br />
                                <br />
                            </div>
                            <div class="row">
                                <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
                                    <div class="input-group">
                                        <span class="input-group-addon">
                                            <i class="material-icons">search</i>
                                        </span>
                                        <div class="form-line">
                                            <input type="text" class="form-control date" placeholder="Tìm kiếm" id="txtSearch" runat="server">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
                                    <select class="form-control" id="slSoGiaoDuc" style="width: 100%;" runat="server" onchange="slSoGiaoDuc_onchange(this.value,'select_timkiem');">
                                        <option>── Chọn sở giáo dục ──</option> 
                                    </select>
                                </div>
                                <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
                                    <select class="form-control" id="slPhongGiaoDuc" style="width: 100%;" runat="server" onchange="$('#ContentMaster_txtPhongGiaoDuc').val(this.value);">
                                        <option>── Chọn phòng giáo dục ──</option> 
                                    </select>
                                    <input type="hidden" id="txtPhongGiaoDuc" runat="server" />
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-2 col-md-2 col-sm-6 col-xs-6">
                                    <!-- Call Search -->
                                    <asp:LinkButton ID="btnSearch" OnClick="btnSearch_Click" runat="server" class="btn btn-warning waves-effect js-search" style="width: 100%; box-shadow: none;"><i class="material-icons">search</i><span>Tìm kiếm</span></asp:LinkButton>
                                    <!-- #END# Call Search -->
                                </div>
                                <div class="col-lg-10 col-md-10 col-sm-6 col-xs-6 align-right">
                                    <a class="btn btn-warning waves-effect" href="javascript:OpenModal_AddTruongHoc();"><i class="material-icons">playlist_add</i> <span>THÊM MỚI</span></a>
                                </div>
                            </div>
                        </div>
                        <div class="body table-responsive" id="dvDanhSach" runat="server">
                            <table class='table table-bordered table-hover'>
                                <thead>
                                    <tr>
                                        <th class='bg-cyan' style='max-width: 5rem;'>STT</th>
                                        <th class='bg-cyan' style='min-width: 5rem;'>PHÒNG GIÁO DỤC</th>
                                        <th class='bg-cyan align-center'>CẤP</th>
                                        <th class='bg-cyan' style='min-width: 15rem;'>TÊN TRƯỜNG</th>
                                        <th class='bg-cyan align-center' style='min-width: 10rem;'>ĐỊA CHỈ</th>
                                        <th class='bg-cyan align-center'></th>
                                    </tr>
                                </thead>
                                <tbody id="tbody_DSTruongHoc" runat="server">
                                    <%--///////////////////////////--%>
                                    <tr>
                                        <td>1</td>
                                        <td>Phòng giáo dục A</td>
                                        <td class="align-center">THPT</td>
                                        <td>Bình Tân</td>
                                        <td>Quận 1, TPHCM</td>
                                        <td class="text-nowrap align-center">
                                            <a href='javascript:OpenModal_EditTruongHoc();' class='btn bg-green waves-effect' style='padding: 0 7px 3px 7px;' data-toggle='tooltip' data-placement='top' title='' data-original-title='Sửa'><i class='fa fa-pencil'></i></a>
                                            <a href='javascript:void(0)' class='btn bg-red waves-effect' style='padding: 0 7px 3px 7px;' data-toggle='tooltip' data-placement='top' title='' data-original-title='Xoá'><i class='fa fa-trash'></i></a>
                                        </td>
                                    </tr>
                                    <%--///////////////////////////--%>
                                    <%--///////////////////////////--%>
                                    <tr>
                                        <td>2</td>
                                        <td>Phòng giáo dục B</td>
                                        <td class="align-center">THPT</td>
                                        <td>Bình Tân 2</td>
                                        <td>Quận 2, TPHCM</td>
                                        <td class="text-nowrap align-center">
                                            <a href='javascript:OpenModal_EditTruongHoc();' class='btn bg-green waves-effect' style='padding: 0 7px 3px 7px;' data-toggle='tooltip' data-placement='top' title='' data-original-title='Sửa'><i class='fa fa-pencil'></i></a>
                                            <a href='javascript:void(0)' class='btn bg-red waves-effect' style='padding: 0 7px 3px 7px;' data-toggle='tooltip' data-placement='top' title='' data-original-title='Xoá'><i class='fa fa-trash'></i></a>
                                        </td>
                                    </tr>
                                    <%--///////////////////////////--%>
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td colspan="15" class="footertable align-center">
                                            <ul class="pagination margin-0">
                                                <li><a href="SECTION_TruongHoc.aspx?Page=1" class="waves-effect"><i class="material-icons">chevron_left</i></a></li>
                                                <li class="active"><a href="SECTION_TruongHoc.aspx?Page=1" class="waves-effect bg-cyan">1</a></li>
                                                <li class="hidden"><a href="SECTION_TruongHoc.aspx?Page=" class="waves-effect"></a></li>
                                                <li class="hidden"><a href="SECTION_TruongHoc.aspx?Page=" class="waves-effect"></a></li>
                                                <li class="hidden"><a href="SECTION_TruongHoc.aspx?Page=" class="waves-effect"></a></li>
                                                <li class="hidden"><a href="SECTION_TruongHoc.aspx?Page=" class="waves-effect"></a></li>
                                                <li><a href="SECTION_TruongHoc.aspx?Page=1" class="waves-effect"><i class="material-icons">chevron_right</i></a></li>
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
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content" style="border-radius: 10px;">
                        <div class="modal-header">
                            <h4 class="modal-title" id="myModalTile">THÊM MỚI</h4>
                        </div>
                        <div class="modal-body">

                            <div class="row">
                                <div class="col-md-6 col-lg-6">
                                    <select class="form-control" id="slSoGiaoDuc_modal" style="width: 100%;" runat="server" onchange="slSoGiaoDuc_onchange(this.value,'modal');">
                                        <option>-- Chọn sở giáo dục --</option>
                                    </select>
                                </div>
                                <div class="col-md-6 col-lg-6">
                                    <select class="form-control" id="slPhongGiaoDuc_modal" style="width: 100%;">
                                        <option>-- Chọn phòng giáo dục --</option>
                                    </select>
                                </div>
                            </div>
                            <h5 class="card-inside-title " style="margin-bottom: 10px;">Cấp trường <span style="display: inline-block; font-size: 10px; color: #ca0000;">(<i class="fa fa-certificate"></i>)</span></h5>
                            <div class="row">
                                <div class="col-md-3 col-lg-3">
                                    <select class="form-control" id="slCapTruong_modal" style="width: 100%;" runat="server">
                                        <option>-- Chọn cấp trường --</option>
                                        <option>Nhà trẻ</option>
                                        <option>Tiểu học</option>
                                        <option>THCS</option>
                                        <option>THPT</option>
                                    </select>
                                </div>
                                <div class="col-md-9 col-lg-9">
                                    <div class="form-group form-float">
                                        <div class="form-line" id="fltxtTenTruongHoc">
                                            <input type="text" class="form-control" id="txtTenTruongHoc">
                                            <label class="form-label">Tên trường <span style="display: inline-block; font-size: 10px;">(<i class="fa fa-certificate"></i>)</span></label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <h5 class="card-inside-title " style="margin-bottom: 10px;">Địa chỉ</h5>
                            <div class="row">
                                <div class="col-md-3 col-lg-3">
                                    <div class="form-group form-float">
                                        <div class="form-line" id="fltxtTenDuong">
                                            <input type="text" class="form-control" id="txtTenDuong">
                                            <label class="form-label">Tên đường <span style="display: inline-block; font-size: 10px;">(<i class="fa fa-certificate"></i>)</span></label>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3 col-lg-3">
                                    <select class="form-control" id="slTinhThanh" style="width: 100%;" runat="server" onchange="slTinhThanh_onchange(this.value);">
                                        <option>-- Chọn tỉnh/thành phố --</option>
                                    </select>
                                </div>
                                <div class="col-md-3 col-lg-3">
                                    <select class="form-control" id="slQuanHuyen" style="width: 100%;" onchange="slQuanHuyen_onchange(this.value);">
                                        <option>-- Chọn quận/huyện --</option>
                                    </select>
                                </div>
                                <div class="col-md-3 col-lg-3">
                                    <select class="form-control" id="slPhuongXa" style="width: 100%;">
                                        <option>-- Chọn phường/xã --</option>
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

        $("#ContentMaster_slSoGiaoDuc_modal,#slPhongGiaoDuc_modal, #ContentMaster_slSoGiaoDuc,#ContentMaster_slPhongGiaoDuc,#ContentMaster_slTinhThanh,#slQuanHuyen,#slPhuongXa").select2();

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
