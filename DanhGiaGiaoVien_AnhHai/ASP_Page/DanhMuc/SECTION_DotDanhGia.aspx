﻿<%@ Page Language="C#" Async="true" MasterPageFile="~/Layout/MasterPage.master" AutoEventWireup="true" CodeFile="SECTION_DotDanhGia.aspx.cs" Inherits="ASP_Page_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .form-group span {
            color: #ca0000;
            font-size: 13px;
        }

        .select2-container .select2-selection--single {
            height: 37px !important;
        }

        .tr-header {
            font-size: 11px;
            font-weight: bold;
            cursor: pointer;
            background-color: antiquewhite;
        }

        .My-td::before {
            content: "● ";
        }

        .modal-lg {
            width: 80%;
        }
    </style>
    <script>
        {
            window.onload = function ()//
            {
                collapesSideBar();

                var CapSo = getQueryString("CapSo");
                var CapPhong = getQueryString("CapPhong");
                var CapTruong = getQueryString("CapTruong");

                if (CapSo != "")
                {
                    $("#ContentMaster_slEduProvince_TimKiem").val(CapSo).trigger('change');
                    //$("#ContentMaster_txtEduProvince_TimKiem").val(CapSo);
                }
                if (CapPhong != "")
                    setTimeout(function () { $("#ContentMaster_slEduDepartment_TimKiem").val(CapPhong).trigger('change');   }, 500);
                if (CapTruong != "")
                    setTimeout(function () { $("#ContentMaster_slEduSchoold_TimKiem").val(CapTruong).trigger('change');   }, 900);
            }
            function OpenModal_AddDotDanhGia() {
                var d = new Date();
                //var month = d.getMonth() + 1;
                //var day = d.getDate();
                //var today = (day < 10 ? '0' : '') + day + '/' + (month < 10 ? '0' : '') + month + '/' + d.getFullYear();

                $("#txtTenDotDanhGia,#txtTuNgay, #txtDenNgay").val("");
                $("#slNam_Modal, #ContentMaster_slEduProvince, #ContentMaster_slEduDepartment, #ContentMaster_slEduSchoold, #ContentMaster_slEvalType").val("").trigger('change');
                $("#slNam_Modal").val(d.getFullYear()).trigger('change');

                $("#btnModalSave").attr('onclick', 'AddDotDanhGia();');
                $("#myModalTile").html('THÊM MỚI ĐỢT ĐÁNH GIÁ');
                $("#verticalModal").modal('show');
                $("#verticalModal").css({ 'display': 'flex', 'align-items': 'center' });
                LoadInfoNhanVien();
            }
            function AddDotDanhGia() {
                var TenDotDanhGia = $("#txtTenDotDanhGia").val();
                var TuNgay = $("#txtTuNgay").val();
                var DenNgay = $("#txtDenNgay").val();

                var Nam = $("#slNam_Modal").val();
                var TruongHoc = $("#ContentMaster_slEduSchoold").val();
                var EvalType = $("#ContentMaster_slEvalType").val();

                var flag_OK = true;
                if (TenDotDanhGia == "")//
                {
                    $("#txtTenDotDanhGia").notify("Vui lòng nhập tên Đợt đánh giá!", { position: "top", className: "error", autoHideDelay: 5000, });
                    $("#fltxtTenDotDanhGia").addClass("animated shake");
                    setTimeout(function () {
                        $("#fltxtTenDotDanhGia").removeClass("animated shake");
                    }, 1000);
                    flag_OK = false;
                }
                if (EvalType == "")//
                {
                    $("#ContentMaster_slEvalType").notify("Vui lòng chọn loại Đợt đánh giá!", { position: "top", className: "error", autoHideDelay: 5000, });
                    $("#ContentMaster_slEvalType").addClass("animated shake");
                    setTimeout(function () {
                        $("#ContentMaster_slEvalType").removeClass("animated shake");
                    }, 1000);
                    flag_OK = false;
                }
                if (TuNgay == "")//
                {
                    $("#txtTuNgay").notify("Vui lòng chọn Ngày bắt đầu !", { position: "top", className: "error", autoHideDelay: 5000, });
                    $("#fltxtTuNgay").addClass("animated shake");
                    setTimeout(function () {
                        $("#fltxtTuNgay").removeClass("animated shake");
                    }, 1000);
                    flag_OK = false;
                }
                if (DenNgay == "")//
                {
                    $("#txtDenNgay").notify("Vui lòng chọn Ngày kết thúc !", { position: "top", className: "error", autoHideDelay: 5000, });
                    $("#fltxtDenNgay").addClass("animated shake");
                    setTimeout(function () {
                        $("#fltxtDenNgay").removeClass("animated shake");
                    }, 1000);
                    flag_OK = false;
                }
                if (TruongHoc == "")//
                {
                    $("#ContentMaster_slEduSchoold").notify("Vui lòng chọn Trường!", { position: "top", className: "error", autoHideDelay: 5000, });
                    $("#ContentMaster_slEduSchoold").addClass("animated shake");
                    setTimeout(function () {
                        $("#ContentMaster_slEduSchoold").removeClass("animated shake");
                    }, 1000);
                    flag_OK = false;
                }

                var value = TenDotDanhGia + "@_@" + TuNgay + "@_@" + DenNgay + "@_@" + Nam + "@_@" + TruongHoc + "@_@" + EvalType;
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
                xmlhttp.open("GET", "../../Ajax.aspx?Action=AddDotDanhGia&value=" + value, true);
                xmlhttp.send();
            }

            function OpenModal_EditDotDanhGia(value) {

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
                            $("#fltxtTuNgay,#fltxtTenDotDanhGia,#fltxtDenNgay").addClass("focused");

                            //0 : TenDotDanhGia
                            //1 : TuNgay
                            //2 : DenNgay
                            //3 : Nam
                            //4 : Sở ID 
                            //5 : Phòng ID 
                            //6 : Trường ID   
                            var arr = xmlhttp.responseText.split("@_@");
                            $("#txtTenDotDanhGia").val(arr[0]);
                            $("#txtTuNgay").val(arr[1]);
                            $("#txtDenNgay").val(arr[2]);
                            $("#slNam_Modal").val(arr[3]).trigger('change');

                            $("#ContentMaster_slEduProvince").val(arr[4]).trigger('change');
                            setTimeout(function () { $("#ContentMaster_slEduDepartment").val(arr[5]).trigger('change'); }, 500);
                            setTimeout(function () { $("#ContentMaster_slEduSchoold").val(arr[6]).trigger('change'); }, 1000);
                            $("#ContentMaster_slEvalType").val(arr[7]).trigger('change');
                             
                            $("#btnModalSave").attr('onclick', 'EditDotDanhGia(' + value + ');');

                            $("#myModalTile").html('CHỈNH SỬA THÔNG TIN ĐỢT ĐÁNH GIÁ');
                            $("#verticalModal").modal('show');
                            $("#verticalModal").css({ 'display': 'flex', 'align-items': 'center' });
                        }
                        else {
                            swal("Lỗi !", "", "error");
                        }
                    }
                }
                xmlhttp.open("GET", "../../Ajax.aspx?Action=LoadDotDanhGia&value=" + value, true);
                xmlhttp.send();
            }
            function EditDotDanhGia(DotDanhGia) {
                var TenDotDanhGia = $("#txtTenDotDanhGia").val();
                var TuNgay = $("#txtTuNgay").val();
                var DenNgay = $("#txtDenNgay").val();

                var Nam = $("#slNam_Modal").val();
                var TruongHoc = $("#ContentMaster_slEduSchoold").val();
                var EvalType = $("#ContentMaster_slEvalType").val();

                var flag_OK = true;
                if (TenDotDanhGia == "")//
                {
                    $("#txtTenDotDanhGia").notify("Vui lòng nhập tên Đợt đánh giá!", { position: "top", className: "error", autoHideDelay: 5000, });
                    $("#fltxtTenDotDanhGia").addClass("animated shake");
                    setTimeout(function () {
                        $("#fltxtTenDotDanhGia").removeClass("animated shake");
                    }, 1000);
                    flag_OK = false;
                }
                if (EvalType == "")//
                {
                    $("#ContentMaster_slEvalType").notify("Vui lòng chọn loại Đợt đánh giá!", { position: "top", className: "error", autoHideDelay: 5000, });
                    $("#ContentMaster_slEvalType").addClass("animated shake");
                    setTimeout(function () {
                        $("#ContentMaster_slEvalType").removeClass("animated shake");
                    }, 1000);
                    flag_OK = false;
                }
                if (TuNgay == "")//
                {
                    $("#txtTuNgay").notify("Vui lòng chọn Ngày bắt đầu !", { position: "top", className: "error", autoHideDelay: 5000, });
                    $("#fltxtTuNgay").addClass("animated shake");
                    setTimeout(function () {
                        $("#fltxtTuNgay").removeClass("animated shake");
                    }, 1000);
                    flag_OK = false;
                }
                if (DenNgay == "")//
                {
                    $("#txtDenNgay").notify("Vui lòng chọn Ngày kết thúc !", { position: "top", className: "error", autoHideDelay: 5000, });
                    $("#fltxtDenNgay").addClass("animated shake");
                    setTimeout(function () {
                        $("#fltxtDenNgay").removeClass("animated shake");
                    }, 1000);
                    flag_OK = false;
                }
                if (TruongHoc == "")//
                {
                    $("#ContentMaster_slEduSchoold").notify("Vui lòng chọn Trường!", { position: "top", className: "error", autoHideDelay: 5000, });
                    $("#ContentMaster_slEduSchoold").addClass("animated shake");
                    setTimeout(function () {
                        $("#ContentMaster_slEduSchoold").removeClass("animated shake");
                    }, 1000);
                    flag_OK = false;
                }

                var value = TenDotDanhGia + "@_@" + TuNgay + "@_@" + DenNgay + "@_@" + Nam + "@_@" + TruongHoc + "@_@" + EvalType;
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
                xmlhttp.open("GET", "../../Ajax.aspx?Action=EditDotDanhGia&value=" + value + "&DotDanhGia=" + DotDanhGia, true);
                xmlhttp.send();
            }

            function DeleteDotDanhGia(DotDanhGia) {
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
                    xmlhttp.open("GET", "../../Ajax.aspx?Action=DeleteDotDanhGia&DotDanhGia=" + DotDanhGia, true);
                    xmlhttp.send();
                });
            }
            function slEduProvince_onchange(value, Loai) {
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
                            if (Loai != "" && Loai != undefined)
                                $("#ContentMaster_slEduDepartment" + Loai).html(xmlhttp.responseText);
                            else
                                $("#ContentMaster_slEduDepartment").html(xmlhttp.responseText);
                        }
                    }
                }
                xmlhttp.open("GET", "../../Ajax.aspx?Action=Load_EduDepartment&IDEduProvince=" + value, true);
                xmlhttp.send();
            }
            function slEduDepartment_onchange(value,Loai) {
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
                            if (Loai != "" && Loai != undefined)
                                $("#ContentMaster_slEduSchoold" + Loai).html(xmlhttp.responseText);
                            else
                            $("#ContentMaster_slEduSchoold").html(xmlhttp.responseText);
                        }
                    }
                }
                xmlhttp.open("GET", "../../Ajax.aspx?Action=Load_EduSchoold&IDEduDepartment=" + value, true);
                xmlhttp.send();
            }
            function LoadInfoNhanVien() {
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
                            $("#ContentMaster_slEduProvince").val(arr[10]).trigger('change');
                            setTimeout(function () {
                                $("#ContentMaster_slEduDepartment").val(arr[11]).trigger('change');
                            }, 1000);
                            setTimeout(function () {
                                $("#ContentMaster_slEduSchoold").val(arr[12]).trigger('change');
                            }, 1500);
                        }
                    }
                }
                xmlhttp.open("GET", "../../Ajax.aspx?Action=LoadInfoNhanVien", true);
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
                    <li class="active"><a href="../../Asp_page/SECTION_DOTDANHGIA.aspx"><i class="fa fa-user m-r-10"></i>Quản lý Đợt đánh giá</a></li>
                </ol>
            </div>
            <div class="row clearfix">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="card"> 
                        <div class="header">
                            <div class="row">
                                <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
                                    <h4>QUẢN LÝ ĐỢT ĐÁNH GIÁ</h4>
                                    <input type="hidden" name="name" value="" id="ND" runat="server" />
                                </div>
                                <br />
                                <br />
                            </div>

                            <div class="row m-b-10">
                                <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
                                    <h5 class="card-inside-title " style="margin-bottom: 5px;">Năm đánh giá</h5>
                                    <select class="form-control" id="slNam" style="width: 100%;" runat="server">
                                        <option value="">── Chọn tìm năm đánh giá ──</option>
                                        <option value='2020'>2020</option>
                                        <option value='2021'>2021</option>
                                        <option value='2022'>2022</option>
                                        <option value='2023'>2023</option>
                                        <option value='2024'>2024</option>
                                    </select>
                                </div>
                                <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
                                    <h5 class="card-inside-title " style="margin-bottom: 5px;">Loại đánh giá</h5>
                                    <select class="form-control" id="slEvalType_TimKiem" style="width: 100%;" runat="server">
                                        <option value="">── Chọn loại năm đánh giá ──</option>  
                                    </select>
                                </div>
                            </div>
                            <div class="row m-b-10">
                                <div class="col-lg-4 col-md-3 col-sm-12 col-xs-12">
                                    <h5 class="card-inside-title " style="margin-bottom: 5px;">Cấp sở</h5>
                                    <select class="form-control" id="slEduProvince_TimKiem" runat="server" style="width: 100%;" onchange="slEduProvince_onchange(this.value,'_TimKiem'); $('#ContentMaster_txtEduProvince_TimKiem').val(this.value);">
                                    </select>
                                    <input type="hidden" id="txtEduProvince_TimKiem" runat="server" />
                                </div>
                                <div class="col-lg-4 col-md-3 col-sm-12 col-xs-12">
                                    <h5 class="card-inside-title " style="margin-bottom: 5px;">Cấp phòng</h5>
                                    <select class="form-control" id="slEduDepartment_TimKiem" runat="server" style="width: 100%;" onchange="slEduDepartment_onchange(this.value,'_TimKiem'); $('#ContentMaster_txtEduDepartment_TimKiem').val(this.value);">
                                    </select>
                                    <input type="hidden" id="txtEduDepartment_TimKiem" runat="server" />
                                </div>
                                <div class="col-lg-4 col-md-3 col-sm-12 col-xs-12">
                                    <h5 class="card-inside-title " style="margin-bottom: 5px;">Cấp trường</h5>
                                    <select class="form-control" id="slEduSchoold_TimKiem" runat="server" style="width: 100%;" onchange="$('#ContentMaster_txtEduSchoold_TimKiem').val(this.value);">
                                    </select>
                                    <input type="hidden" id="txtEduSchoold_TimKiem" runat="server" />
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-lg-2 col-md-2 col-sm-12 col-xs-12">
                                    <!-- Call Search -->
                                    <asp:LinkButton OnClick="btnSearch_Click" runat="server" class="btn btn-warning waves-effect js-search" Style="width: 100%;"><i class="material-icons">search</i><span>Tìm kiếm</span></asp:LinkButton>
                                    <!-- #END# Call Search -->
                                </div>
                                <div class="col-lg-2 col-md-2 col-sm-3 col-xs-6">
                                    <a class="btn bg-purple waves-effect" href="javascript:void(0);"><i class="material-icons">file_download</i> <span>XUẤT EXCEL</span></a>
                                </div>
                                <div class="col-lg-8 col-md-8 col-sm-4 col-xs-6 align-right">
                                    <a class="btn btn-warning waves-effect" href="javascript:OpenModal_AddDotDanhGia();"><i class="material-icons">playlist_add</i> <span>THÊM MỚI</span></a>
                                </div>
                            </div>
                        </div>
                        <div class="body table-responsive">
                            <table class='table table-bordered table-hover'>
                                <thead>
                                    <tr>
                                        <th class='bg-cyan' style='min-width: 5rem;'>STT</th>
                                        <th class='bg-cyan align-center'>NĂM</th>
                                        <th class='bg-cyan' style='min-width: 15rem;'>KỲ ĐÁNH GIÁ</th>
                                        <th class='bg-cyan align-center' style='min-width: 10rem;'>THỜI HẠN</th>
                                        <th class='bg-cyan align-center' style=''>TRẠNG THÁI</th>
                                        <th class='bg-cyan align-center' style=''>THAM GIA</th>
                                        <th class='bg-cyan align-center' style=''>KHÔNG ĐẠT</th>
                                        <th class='bg-cyan align-center' style=''>ĐẠT</th>
                                        <th class='bg-cyan align-center' style=''>KHÁ</th>
                                        <th class='bg-cyan align-center' style=''>TỐT</th>
                                        <th class='bg-cyan align-center'></th>
                                    </tr>
                                </thead>
                                <tbody id="tbody_DSDotDanhGia" runat="server">
                                    <%--///////////////////////////--%>
                                    <tr>
                                        <td>1</td>
                                        <td>2019</td>
                                        <td>Đánh giá giáo viên 2019 lần 1</td>
                                        <td class="align-center text-nowrap">01/01/2019 - 01/02/2019</td>
                                        <td class='align-center'>Đã hoàn thành</td>
                                        <td class='align-center'>100</td>
                                        <td class='align-center'>1</td>
                                        <td class='align-center'>50</td>
                                        <td class='align-center'>40</td>
                                        <td class='align-center'>9</td>
                                        <td class="text-nowrap">
                                            <a href='javascript:OpenModal_EditDotDanhGia();' class='btn bg-green waves-effect' style='padding: 0 7px 3px 7px;' data-toggle='tooltip' data-placement='top' title='' data-original-title='Sửa'><i class='fa fa-pencil'></i></a>
                                            <a href='javascript:void(0)' class='btn bg-red waves-effect' style='padding: 0 7px 3px 7px;' data-toggle='tooltip' data-placement='top' title='' data-original-title='Xoá'><i class='fa fa-trash'></i></a>
                                        </td>
                                    </tr>
                                    <%--///////////////////////////--%>
                                    <%--///////////////////////////--%>
                                    <tr>
                                        <td>2</td>
                                        <td>2019</td>
                                        <td>Đánh giá giáo viên 2019 lần 2</td>
                                        <td class="align-center text-nowrap">01/12/2019 - 31/12/2019</td>
                                        <td class='align-center'>Đang thực hiện</td>
                                        <td class='align-center'>100</td>
                                        <td class='align-center'>1</td>
                                        <td class='align-center'>50</td>
                                        <td class='align-center'>40</td>
                                        <td class='align-center'>9</td>
                                        <td class="text-nowrap">
                                            <a href='javascript:OpenModal_EditDotDanhGia();' class='btn bg-green waves-effect' style='padding: 0 7px 3px 7px;' data-toggle='tooltip' data-placement='top' title='' data-original-title='Sửa'><i class='fa fa-pencil'></i></a>
                                            <a href='javascript:void(0)' class='btn bg-red waves-effect' style='padding: 0 7px 3px 7px;' data-toggle='tooltip' data-placement='top' title='' data-original-title='Xoá'><i class='fa fa-trash'></i></a>
                                        </td>
                                    </tr>
                                    <%--///////////////////////////--%>
                                    <%--///////////////////////////--%>
                                    <tr>
                                        <td>3</td>
                                        <td>2019</td>
                                        <td>Đánh giá giáo viên 2019 lần 1</td>
                                        <td class="align-center text-nowrap">01/01/2019 - 01/02/2019</td>
                                        <td class='align-center'>Chưa thực hiện</td>
                                        <td class='align-center'>0</td>
                                        <td class='align-center'>0</td>
                                        <td class='align-center'>0</td>
                                        <td class='align-center'>0</td>
                                        <td class='align-center'>0</td>
                                        <td class="text-nowrap">
                                            <a href='javascript:OpenModal_EditDotDanhGia();' class='btn bg-green waves-effect' style='padding: 0 7px 3px 7px;' data-toggle='tooltip' data-placement='top' title='' data-original-title='Sửa'><i class='fa fa-pencil'></i></a>
                                            <a href='javascript:void(0)' class='btn bg-red waves-effect' style='padding: 0 7px 3px 7px;' data-toggle='tooltip' data-placement='top' title='' data-original-title='Xoá'><i class='fa fa-trash'></i></a>
                                        </td>
                                    </tr>
                                    <%--///////////////////////////--%>
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td colspan="15" class="footertable align-center">
                                            <ul class="pagination margin-0">
                                                <li><a href="SECTION_DotDanhGia.aspx?Page=1" class="waves-effect"><i class="material-icons">chevron_left</i></a></li>
                                                <li class="active"><a href="SECTION_DotDanhGia.aspx?Page=1" class="waves-effect bg-cyan">1</a></li>
                                                <li class="hidden"><a href="SECTION_DotDanhGia.aspx?Page=" class="waves-effect"></a></li>
                                                <li class="hidden"><a href="SECTION_DotDanhGia.aspx?Page=" class="waves-effect"></a></li>
                                                <li class="hidden"><a href="SECTION_DotDanhGia.aspx?Page=" class="waves-effect"></a></li>
                                                <li class="hidden"><a href="SECTION_DotDanhGia.aspx?Page=" class="waves-effect"></a></li>
                                                <li><a href="SECTION_DotDanhGia.aspx?Page=1" class="waves-effect"><i class="material-icons">chevron_right</i></a></li>
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
                                <div class="col-md-6 col-lg-6">
                                    <h5 class="card-inside-title " style="margin-bottom: 5px; margin-top: 0;">Loại đánh giá <span style="display: inline-block; font-size: 10px;color:red;">(<i class="fa fa-certificate"></i>)</span></h5>
                                    <select class="form-control" id="slEvalType" style="width: 100%;" runat="server">
                                        <option value="">── Chọn loại đánh giá ──</option> 
                                    </select>
                                </div>
                                <div class="col-md-6 col-lg-6">
                                    <h5 class="card-inside-title " style="margin-bottom: 5px; margin-top: 0;">Năm đánh giá <span style="display: inline-block; font-size: 10px;color:red;">(<i class="fa fa-certificate"></i>)</span></h5>
                                    <select class="form-control" id="slNam_Modal" style="width: 100%;">
                                        <option value="">── Chọn năm đánh giá ──</option>
                                        <option value='2020'>2020</option>
                                        <option value='2021'>2021</option>
                                        <option value='2022'>2022</option>
                                        <option value='2023'>2023</option>
                                        <option value='2024'>2024</option>
                                    </select>
                                </div>
                             </div>

                            <div class="row">
                                <div class="col-md-12 col-lg-12">
                                    <h5 class="card-inside-title " style="margin-bottom: 5px; margin-top: 0; visibility: hidden;">Tên đợt đánh giá <span style="display: inline-block; font-size: 10px;color:red;">(<i class="fa fa-certificate"></i>)</span></h5>
                                    <div class="form-group form-float">
                                        <div class="form-line" id="fltxtTenDotDanhGia">
                                            <input type="text" class="form-control" id="txtTenDotDanhGia">
                                            <label class="form-label">Tên đợt đánh giá <span style="display: inline-block; font-size: 10px;color:red;">(<i class="fa fa-certificate"></i>)</span></label>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 col-lg-6">
                                    <div class="form-group form-float">
                                        <div class="form-line" id="fltxtTuNgay">
                                            <input type="text" class="form-control" id="txtTuNgay">
                                            <label class="form-label">Từ ngày <span style="display: inline-block; font-size: 10px;color:red;">(<i class="fa fa-certificate"></i>)</span></label>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 col-lg-6">
                                    <div class="form-group form-float">
                                        <div class="form-line" id="fltxtDenNgay">
                                            <input type="text" class="form-control" id="txtDenNgay">
                                            <label class="form-label">Đến ngày <span style="display: inline-block; font-size: 10px;color:red;">(<i class="fa fa-certificate"></i>)</span></label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 col-lg-6" hidden>
                                    <select class="form-control" id="slEduMinistry" runat="server" style="width: 100%;">
                                    </select>
                                </div>
                                <div class="col-md-6 col-lg-6">
                                    <h5 class="card-inside-title " style="margin-bottom: 10px;">Cấp sở</h5>
                                    <select class="form-control" id="slEduProvince" runat="server" style="width: 100%;" onchange="slEduProvince_onchange(this.value,'');">
                                    </select>
                                </div>
                                <div class="col-md-6 col-lg-6">
                                    <h5 class="card-inside-title " style="margin-bottom: 10px;">Cấp phòng</h5>
                                    <select class="form-control" id="slEduDepartment" runat="server" style="width: 100%;" onchange="slEduDepartment_onchange(this.value,'');">
                                    </select>
                                </div>
                                <div class="col-md-12 col-lg-12">
                                    <h5 class="card-inside-title " style="margin-bottom: 10px;">Cấp trường</h5>
                                    <select class="form-control" id="slEduSchoold" runat="server" style="width: 100%;">
                                    </select>
                                </div>
                            </div>
                            <hr />
                            <div class="row hidden">
                                <div class="col-md-3 col-lg-3">
                                    <a class="btn btn-success"><i class="fa fa-check m-r-10"></i>TẠO DỮ LIỆU</a>
                                </div>
                            </div>

                            <div class="row hidden m-t-20" style="overflow: auto; height: 250px; box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);">
                                <table class='table table-bordered table-hover'>
                                    <thead>
                                        <tr>
                                            <th class='bg-cyan' style='min-width: 20rem;'>TIÊU CHUẨN/TIÊU CHÍ</th>
                                            <th class='bg-cyan align-center' style=''>KHÔNG ĐẠT</th>
                                            <th class='bg-cyan align-center' style=''>ĐẠT</th>
                                            <th class='bg-cyan align-center' style=''>KHÁ</th>
                                            <th class='bg-cyan align-center' style=''>TỐT</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%--///////////////////////////--%>
                                        <tr class="tr-header">
                                            <td colspan="5">Tiêu chuẩn 1: PHẨM CHẤT NGHỀ NGHIỆP <b><i class='fa fa-chevron-down'></i></b></td>
                                        </tr>
                                        <tr>
                                            <td class="My-td">Tiêu chí 1. Đạo đức nghề nghiệp</td>
                                            <td>1</td>
                                            <td>2</td>
                                            <td>3</td>
                                            <td>4</td>
                                        </tr>
                                        <tr>
                                            <td class="My-td">Tiêu chí 2. Tư tưởng đổi mới trong lãnh đạo</td>
                                            <td>1</td>
                                            <td>2</td>
                                            <td>3</td>
                                            <td>4</td>
                                        </tr>
                                        <%--///////////////////////////--%>

                                        <%--///////////////////////////--%>
                                        <tr class="tr-header">
                                            <td colspan="5">Tiêu chuẩn 2: QUẢN TRỊ NHÀ TRƯỜNG <b><i class='fa fa-chevron-down'></i></b></td>
                                        </tr>
                                        <tr>
                                            <td class="My-td">Tiêu chí 4. Tổ chức xây dựng kế hoạch phát</td>
                                            <td>1</td>
                                            <td>2</td>
                                            <td>3</td>
                                            <td>4</td>
                                        </tr>
                                        <tr>
                                            <td class="My-td">Tiêu chí 5. Quản trị hoạt động dạy học, giáo dục</td>
                                            <td>1</td>
                                            <td>2</td>
                                            <td>3</td>
                                            <td>4</td>
                                        </tr>
                                        <%--///////////////////////////--%>
                                    </tbody>
                                </table>
                            </div>

                        </div>
                        <div class="modal-footer">
                            <a class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times m-r-10"></i>HUỶ</a>
                            <a class="btn btn-success" id="btnModalSave"><i class="fa fa-check m-r-10"></i>LƯU CHI TIẾT</a>
                        </div>
                    </div>
                </div>
            </div>
            <!-- END vertical Modal -->
        </div>
    </section>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FooterMaster" runat="Server">
    <link href="../../css_ALL/jquery.datetimepicker.min.css" rel="stylesheet" />
    <script src="../../js_ALL/jquery.datetimepicker.full.min.js"></script>
    <script> 
        $('.tr-header').click(function () {
            var $this = $(this);
            $(this).nextUntil('tr.tr-header').slideToggle(100).promise().done(function () {
                var i = $this.find('b').children("i").attr("class");
                if (i == "fa fa-chevron-down")
                    $this.find('b').children("i").attr("class", "fa fa-chevron-right");
                else
                    $this.find('b').children("i").attr("class", "fa fa-chevron-down");
            });
        });

        $("#ContentMaster_slNam,#slNam_Modal").select2();
        $("#ContentMaster_slEduMinistry,#ContentMaster_slEduProvince,#ContentMaster_slEduDepartment,#ContentMaster_slEduSchoold").select2();
        $("#ContentMaster_slEduProvince_TimKiem,#ContentMaster_slEduDepartment_TimKiem,#ContentMaster_slEduSchoold_TimKiem,#ContentMaster_slEvalType,#ContentMaster_slEvalType_TimKiem").select2();

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
