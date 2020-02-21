<%@ Page Language="C#" Async="true" MasterPageFile="~/Layout/MasterPage.master" AutoEventWireup="true" CodeFile="SECTION_TieuChuanTieuChi.aspx.cs" Inherits="ASP_Page_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .form-group span {
            color: #ca0000;
            font-size: 13px;
        }

        .tr-header {
            font-size: 11px;
            font-weight: bold;
            cursor: pointer;
            background-color: antiquewhite;
        }

        .popover {
            max-width: 750px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentMaster" runat="Server">

    <section class="content">
        <div class="container-fluid">
            <div class="block-header hidden">
                <ol class="breadcrumb" id="breadscrumColor" runat="server">
                    <li><a href="../../Asp_page/index.aspx"><i class="material-icons">home</i> Trang chủ</a></li>
                    <li class="active"><a href="../../Asp_page/DanhMuc/SECTION_TIEUCHUANTIEUCHI.aspx"><i class="fa fa-user m-r-10"></i>QL Tiêu chuẩn/tiêu chí</a></li>
                </ol>
            </div>
            <div class="row clearfix">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="card">
                        <div class="header">
                            <div class="row">
                                <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
                                    <h4>QUẢN LÝ TIÊU CHUẨN VÀ TIÊU CHÍ ĐÁNH GIÁ</h4>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-3 col-md-3 col-sm-12 col-xs-12">
                                    <select class="form-control" id="slLoaiTieuChuan" runat="server" style="width: 100%;">
                                        <option>── Chọn loại tiêu chuẩn ──</option>
                                    </select>
                                </div>
                                <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
                                    <select class="form-control" id="slCapGiaoDuc" runat="server" style="width: 100%;">
                                        <option>── Chọn cấp giáo dục ──</option>
                                    </select>
                                </div>
                                <div class="col-lg-2 col-md-2 col-sm-6 col-xs-6">
                                    <!-- Call Search -->
                                    <asp:LinkButton runat="server" OnClick="btnSearch_Click" class="btn btn-warning waves-effect js-search" data-close="true" Style="width: 100%; box-shadow: none;"><i class="material-icons">search</i><span>Tìm kiếm</span></asp:LinkButton>
                                    <!-- #END# Call Search -->
                                </div>
                                <div class="col-lg-3 col-md-3 col-sm-6 col-xs-6 align-right">
                                    <a class="btn btn-warning waves-effect" href="javascript:OpenModal_AddNewTieuChuan();"><i class="material-icons">playlist_add</i> <span>THÊM MỚI</span></a>
                                </div>
                            </div>
                        </div>
                        <div class="body table-responsive">
                            <table class='table table-bordered'>
                                <thead>
                                    <tr>
                                        <th class='bg-cyan' style='max-width: 5rem;'>#</th>
                                        <th class='bg-cyan' style='min-width: 10rem;'>TIÊU CHUẨN</th>
                                        <th class='bg-cyan'>GHI CHÚ</th>
                                        <th class='bg-cyan align-center'></th>
                                    </tr>
                                </thead>
                                <tbody id="tbody_DSTieuChuan" runat="server">
                                    <%--///////////////////////////--%>
                                    <tr class="tr-header">
                                        <td>1</td>
                                        <td>PHẨM CHẤT NGHỀ NGHIỆP <b><i class='fa fa-chevron-right'></i></b></td>
                                        <td>1</td>
                                        <td class="text-nowrap align-center">
                                            <a href='javascript:OpenModal_AddNewTieuChi();' class='btn bg-yellow waves-effect' style='padding: 0 7px 3px 7px;' data-toggle='tooltip' data-placement='top' title='' data-original-title='Thêm Tiêu chí'><i class='fa fa-plus'></i></a>
                                            <a href='javascript:OpenModal_EditTieuChuan(1);' class='btn bg-green waves-effect' style='padding: 0 7px 3px 7px;' data-toggle='tooltip' data-placement='top' title='' data-original-title='Sửa'><i class='fa fa-pencil'></i></a>
                                            <a href='javascript:Xoa();' class='btn bg-red waves-effect' style='padding: 0 7px 3px 7px;' data-toggle='tooltip' data-placement='top' title='' data-original-title='Xoá'><i class='fa fa-trash'></i></a>
                                        </td>
                                    </tr>
                                    <tr style="display: none;">
                                        <td colspan="4">
                                            <table class='table table-bordered table-hover'>
                                                <thead>
                                                    <tr>
                                                        <th class='bg-orange' style='max-width: 3rem;'>#</th>
                                                        <th class='bg-orange' style='min-width: 10rem;'>TIÊU CHÍ</th>
                                                        <th class='bg-orange align-center'></th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td>1</td>
                                                        <td>Đạo đức nghề nghiệp</td>
                                                        <td class="text-nowrap  align-center">
                                                            <a href='javascript:OpenModal_EditTieuChi(1);' class='btn bg-green waves-effect' style='padding: 0 7px 3px 7px;' data-toggle='tooltip' data-placement='top' title='' data-original-title='Sửa'><i class='fa fa-pencil'></i></a>
                                                            <a href='javascript:Xoa();' class='btn bg-red waves-effect' style='padding: 0 7px 3px 7px;' data-toggle='tooltip' data-placement='top' title='' data-original-title='Xoá'><i class='fa fa-trash'></i></a>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>2</td>
                                                        <td>Tư tưởng mới trong lãnh đạo</td>
                                                        <td class="text-nowrap  align-center">
                                                            <a href='javascript:OpenModal_EditTieuChi(1);' class='btn bg-green waves-effect' style='padding: 0 7px 3px 7px;' data-toggle='tooltip' data-placement='top' title='' data-original-title='Sửa'><i class='fa fa-pencil'></i></a>
                                                            <a href='javascript:Xoa();' class='btn bg-red waves-effect' style='padding: 0 7px 3px 7px;' data-toggle='tooltip' data-placement='top' title='' data-original-title='Xoá'><i class='fa fa-trash'></i></a>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </td>
                                    </tr>
                                    <%--///////////////////////////--%>
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td colspan="15" class="footertable align-center">
                                            <ul class="pagination margin-0">
                                                <li><a href="SECTION_TieuChuanTIeuChi.aspx?Page=1" class="waves-effect"><i class="material-icons">chevron_left</i></a></li>
                                                <li class="active"><a href="SECTION_PSECTION_TieuChuanTIeuChihongGIaoDuc.aspx?Page=1" class="waves-effect bg-cyan">1</a></li>
                                                <li class="hidden"><a href="SECTION_TieuChuanTIeuChi.aspx?Page=" class="waves-effect"></a></li>
                                                <li class="hidden"><a href="SECTION_TieuChuanTIeuChi.aspx?Page=" class="waves-effect"></a></li>
                                                <li class="hidden"><a href="SECTION_TieuChuanTIeuChi.aspx?Page=" class="waves-effect"></a></li>
                                                <li class="hidden"><a href="SECTION_TieuChuanTIeuChi.aspx?Page=" class="waves-effect"></a></li>
                                                <li><a href="SECTION_TieuChuanTIeuChi.aspx?Page=1" class="waves-effect"><i class="material-icons">chevron_right</i></a></li>
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
                            <div class="row m-b-15">
                                <div class="col-md-6 col-lg-6">
                                    <h5 class="card-inside-title " style="margin-bottom: 10px; margin-top: 0;">Loại tiêu chuẩn <span style="display: inline-block; font-size: 10px; color: #ca0000;">(<i class="fa fa-certificate"></i>)</span></h5>
                                    <select id="slLoaiTieuChuan_modal" runat="server" style="width: 100%;"></select>
                                </div>
                                <div class="col-md-6 col-lg-6">
                                    <h5 class="card-inside-title " style="margin-bottom: 10px; margin-top: 0;">Cấp giáo dục <span style="display: inline-block; font-size: 10px; color: #ca0000;">(<i class="fa fa-certificate"></i>)</span></h5>
                                    <select id="slCapGiaoDuc_modal" runat="server" style="width: 100%;"></select>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12 col-lg-12">
                                    <div class="form-group form-float">
                                        <div class="form-line" id="fltxtTenTieuChuan_modal">
                                            <input type="text" class="form-control" id="txtTenTieuChuan_modal" />
                                            <label class="form-label">Tên tiêu chuẩn  <span style="display: inline-block; font-size: 10px; color: #ca0000;">(<i class="fa fa-certificate"></i>)</span></label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12 col-lg-12">
                                    <div class="form-group form-float">
                                        <div class="form-line" id="fltxtGhiChu_modal">
                                            <textarea cols="40" rows="3" class="form-control" id="txtGhiChu_modal"></textarea>
                                            <label class="form-label">Ghi chú </label>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div id="dvTable_TieuChi">

                                <div class="row">
                                    <div class="col-md-6 col-lg-6">
                                        <div class="form-group form-float">
                                            <div class="form-line" id="fltxtTenTieuChi_modal">
                                                <input type="text" class="form-control" id="txtTenTieuChi_modal" />
                                                <label class="form-label">Tên tiêu chí <span style="display: inline-block; font-size: 10px; color: #ca0000;">(<i class="fa fa-certificate"></i>)</span></label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-2 col-lg-2">
                                        <div class="form-group form-float">
                                            <div class="form-line" id="fltxtSTT_modal">
                                                <input type="text" class="form-control" id="txtSTT_modal" oninput='DinhDangTien(this.id)' onkeypress='onlyNumber(event)' />
                                                <label class="form-label">Số thứ tự </label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3 col-lg-3">
                                        <a class="btn btn-success waves-effect" href="javascript:void(0);" id="btnThemTieuChi_TrongTieuChuan"><i class="material-icons">playlist_add</i> <span>THÊM TIÊU CHÍ</span></a>
                                    </div>
                                </div>

                                <div class="row" style="overflow: auto; height: 180px;">
                                    <table class='table table-bordered table-hover'>
                                        <thead>
                                            <tr>
                                                <th class='bg-orange' style='max-width: 3rem;'>#</th>
                                                <th class='bg-orange' style='min-width: 10rem;'>TIÊU CHÍ</th>
                                                <th class='bg-orange align-center'></th>
                                            </tr>
                                        </thead>
                                        <tbody id="tbody_TieuChi_modal">
                                            <tr>
                                                <td>1</td>
                                                <td>Tổ chức xây dựng kế hoạch phát</td>
                                                <td class="text-nowrap  align-center">
                                                    <a href='javascript:Xoa();' class='btn bg-red waves-effect' style='padding: 0 7px 3px 7px;' data-toggle='tooltip' data-placement='top' title='' data-original-title='Xoá'><i class='fa fa-trash'></i></a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>2</td>
                                                <td>Quản trị hoạt động dạy học và giáo dục</td>
                                                <td class="text-nowrap  align-center">
                                                    <a href='javascript:Xoa();' class='btn bg-red waves-effect' style='padding: 0 7px 3px 7px;' data-toggle='tooltip' data-placement='top' title='' data-original-title='Xoá'><i class='fa fa-trash'></i></a>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
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

            <!-- vertical Modal 2 -->
            <div class="modal fade" id="verticalModal_TieuChi" tabindex="-1" role="dialog" aria-labelledby="verticalModal_TieuChi" data-keyboard="false" data-backdrop="static">
                <div class="modal-dialog" role="document">
                    <div class="modal-content" style="border-radius: 10px;">
                        <div class="modal-header">
                            <h4 class="modal-title" id="myModalTile_TieuChi">THÊM MỚI</h4>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-10 col-lg-10">
                                    <div class="form-group form-float">
                                        <div class="form-line" id="fltxtTenTieuChi_modalTieuChi">
                                            <input type="text" class="form-control" id="txtTenTieuChi_modalTieuChi" />
                                            <label class="form-label">Tên tiêu chí</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-2 col-lg-2">
                                    <div class="form-group form-float">
                                        <div class="form-line" id="fltxtSTT_modalTieuChi">
                                            <input type="text" class="form-control" id="txtSTT_modalTieuChi" oninput='DinhDangTien(this.id)' onkeypress='onlyNumber(event)' />
                                            <label class="form-label">Số thứ tự</label>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <div class="modal-footer">
                            <a class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times m-r-10"></i>ĐÓNG</a>
                            <a class="btn btn-success" id="btnModalSave_TieuChi"><i class="fa fa-check m-r-10"></i>LƯU</a>
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
        $("#ContentMaster_slLoaiTieuChuan,#ContentMaster_slCapGiaoDuc,#ContentMaster_slLoaiTieuChuan_modal,#ContentMaster_slCapGiaoDuc_modal").select2();
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
        function DeleteTieuChuan(TieuChuan) {
            swal({
                title: 'Bạn có chắc muốn xoá không ?',
                type: 'warning',
                showCancelButton: true,
                closeOnConfirm: false,
                showLoaderOnConfirm: true,
                confirmButtonColor: '#F44336',
                cancelButtonColor: '#ef4848',
                confirmButtonText: 'Xoá',
                cancelButtonText: 'Không'
            }, function () //
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
                xmlhttp.open("GET", "../../Ajax.aspx?Action=DeleteTieuChuan&TieuChuan=" + TieuChuan, true);
                xmlhttp.send();
            });
        }
        function OpenModal_AddNewTieuChuan() {
            $("#txtTenTieuChuan_modal,#txtGhiChu_modal,#txtTenTieuChi_modal").val("");
            $("#ContentMaster_slLoaiTieuChuan_modal,#ContentMaster_slCapGiaoDuc_modal").val("").trigger('change');
            $("#tbody_TieuChi_modal").html("");
            $("#dvTable_TieuChi").hide();
            $("#btnModalSave").attr('onclick', "AddTieuChuan();");

            $("#myModalTile").html('THÊM MỚI TIÊU CHUẨN');
            $("#verticalModal").modal('show');
            $("#verticalModal").css({ 'display': 'flex', 'align-items': 'center' });
        }
        function AddTieuChuan() {
            var LoaiTieuChuan = $("#ContentMaster_slLoaiTieuChuan_modal").val();
            var CapGiaoDuc = $("#ContentMaster_slCapGiaoDuc_modal").val();
            var TenTieuChuan = $("#txtTenTieuChuan_modal").val();
            var GhiChu = $("#txtGhiChu_modal").val();

            var flag_OK = true;
            if (TenTieuChuan == "")//
            {
                $("#txtTenTieuChuan_modal").notify("Vui lòng nhập Tiêu chuẩn!", { position: "top", className: "error", autoHideDelay: 5000, });
                $("#fltxtTenTieuChuan_modal").addClass("animated shake");
                setTimeout(function () {
                    $("#fltxtTenTieuChuan_modal").removeClass("animated shake");
                }, 1000);
                flag_OK = false;
            }
            if (LoaiTieuChuan == "")//
            {
                $("#ContentMaster_slLoaiTieuChuan_modal").notify("Vui lòng chọn Loại tiêu chuẩn!", { position: "top", className: "error", autoHideDelay: 5000, });
                $("#ContentMaster_slLoaiTieuChuan_modal").addClass("animated shake");
                setTimeout(function () {
                    $("#ContentMaster_slLoaiTieuChuan_modal").removeClass("animated shake");
                }, 1000);
                flag_OK = false;
            }
            if (CapGiaoDuc == "")//
            {
                $("#ContentMaster_slCapGiaoDuc_modal").notify("Vui lòng chọn Cấp giáo dục !", { position: "top", className: "error", autoHideDelay: 5000, });
                $("#ContentMaster_slCapGiaoDuc_modal").addClass("animated shake");
                setTimeout(function () {
                    $("#ContentMaster_slCapGiaoDuc_modal").removeClass("animated shake");
                }, 1000);
                flag_OK = false;
            }

            var value = TenTieuChuan + "@_@" + GhiChu + "@_@" + LoaiTieuChuan + "@_@" + CapGiaoDuc;
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
            xmlhttp.open("GET", "../../Ajax.aspx?Action=AddTieuChuan&value=" + value, true);
            xmlhttp.send();
        }
        function OpenModal_EditTieuChuan(value) {
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
                        $("#fltxtTenTieuChuan_modal,#fltxtGhiChu_modal").addClass("focused");

                        //0 : TenTieuChuan
                        //1 : GhiChu 
                        //2 : Cap giao duc 
                        //3 : LoaiTieuChuan
                        var arr = xmlhttp.responseText.split("@_@");
                        $("#txtTenTieuChuan_modal").val(arr[0]);
                        $("#txtGhiChu_modal").val(arr[1]);
                        $("#ContentMaster_slLoaiTieuChuan_modal").val(arr[2]).trigger('change');
                        $("#ContentMaster_slCapGiaoDuc_modal").val(arr[3]).trigger('change');

                        $("#dvTable_TieuChi").show();
                        $("#txtTenTieuChi_modal").val("");

                        $("#btnThemTieuChi_TrongTieuChuan").attr('onclick', 'AddTieuChi_TrongTieuChuan(' + value + ');');
                        $("#btnModalSave").attr('onclick', 'EditTieuChuan(' + value + ');');

                        $("#myModalTile").html('CHỈNH SỬA THÔNG TIN TIÊU CHUẨN');
                        $("#verticalModal").modal('show');
                        $("#verticalModal").css({ 'display': 'flex', 'align-items': 'center' });
                        LoadTieuChi_TrongTieuChuan(value);
                    }
                    else {
                        swal("Lỗi !", "", "error");
                    }
                }
            }
            xmlhttp.open("GET", "../../Ajax.aspx?Action=LoadTieuChuan&value=" + value, true);
            xmlhttp.send();
        }
        function EditTieuChuan(TieuChuan) {
            var LoaiTieuChuan = $("#ContentMaster_slLoaiTieuChuan_modal").val();
            var CapGiaoDuc = $("#ContentMaster_slCapGiaoDuc_modal").val();
            var TenTieuChuan = $("#txtTenTieuChuan_modal").val();
            var GhiChu = $("#txtGhiChu_modal").val();

            var flag_OK = true;
            if (TenTieuChuan == "")//
            {
                $("#txtTenTieuChuan_modal").notify("Vui lòng nhập Tiêu chuẩn!", { position: "top", className: "error", autoHideDelay: 5000, });
                $("#fltxtTenTieuChuan_modal").addClass("animated shake");
                setTimeout(function () {
                    $("#fltxtTenTieuChuan_modal").removeClass("animated shake");
                }, 1000);
                flag_OK = false;
            }
            if (LoaiTieuChuan == "")//
            {
                $("#ContentMaster_slLoaiTieuChuan_modal").notify("Vui lòng chọn Loại tiêu chuẩn!", { position: "top", className: "error", autoHideDelay: 5000, });
                $("#ContentMaster_slLoaiTieuChuan_modal").addClass("animated shake");
                setTimeout(function () {
                    $("#ContentMaster_slLoaiTieuChuan_modal").removeClass("animated shake");
                }, 1000);
                flag_OK = false;
            }
            if (CapGiaoDuc == "")//
            {
                $("#ContentMaster_slCapGiaoDuc_modal").notify("Vui lòng chọn Cấp giáo dục !", { position: "top", className: "error", autoHideDelay: 5000, });
                $("#ContentMaster_slCapGiaoDuc_modal").addClass("animated shake");
                setTimeout(function () {
                    $("#ContentMaster_slCapGiaoDuc_modal").removeClass("animated shake");
                }, 1000);
                flag_OK = false;
            }

            var value = TenTieuChuan + "@_@" + GhiChu + "@_@" + LoaiTieuChuan + "@_@" + CapGiaoDuc;
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
            xmlhttp.open("GET", "../../Ajax.aspx?Action=EditTieuChuan&value=" + value + "&TieuChuan=" + TieuChuan, true);
            xmlhttp.send();
        }
        function LoadTieuChi_TrongTieuChuan(TieuChuan)//
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
                        $("#tbody_TieuChi_modal").html(xmlhttp.responseText);
                        $('.page-loader-wrapper').fadeOut();//tắt hiệu ứng chờ
                    }
                    else {
                        $("#tbody_TieuChi_modal").html("");
                        $('.page-loader-wrapper').fadeOut();//tắt hiệu ứng chờ
                        //swal("Lỗi !", "", "error");
                    }
                }
            }
            xmlhttp.open("GET", "../../Ajax.aspx?Action=LoadTieuChi_TrongTieuChuan&TieuChuan=" + TieuChuan, true);
            xmlhttp.send();
        }
        function AddTieuChi_TrongTieuChuan(TieuChuan) {
            var TenTieuChi = $("#txtTenTieuChi_modal").val();
            var STT = $("#txtSTT_modal").val();

            var flag_OK = true;
            if (TenTieuChi == "")//
            {
                $("#txtTenTieuChi_modal").notify("Vui lòng nhập Tiêu chí!", { position: "top", className: "error", autoHideDelay: 5000, });
                $("#fltxtTenTieuChi_modal").addClass("animated shake");
                setTimeout(function () {
                    $("#fltxtTenTieuChi_modal").removeClass("animated shake");
                }, 1000);
                flag_OK = false;
            }
            if (STT == "")//
            {
                $("#txtSTT_modal").notify("Vui lòng nhập Số thứ tự!", { position: "top", className: "error", autoHideDelay: 5000, });
                $("#fltxtSTT_modal").addClass("animated shake");
                setTimeout(function () {
                    $("#fltxtSTT_modal").removeClass("animated shake");
                }, 1000);
                flag_OK = false;
            }

            var value = TenTieuChi + "@_@" + TieuChuan + "@_@" + STT;
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
                        LoadTieuChi_TrongTieuChuan(TieuChuan);
                    }
                    else {
                        $('.page-loader-wrapper').fadeOut();//tắt hiệu ứng chờ
                        swal("Lỗi !", "", "error");
                    }

                }
            }
            xmlhttp.open("GET", "../../Ajax.aspx?Action=AddTieuChi&value=" + value, true);
            xmlhttp.send();
        }
        //////////////////////////// 
        function DeleteTieuChi(TieuChi, Loai, TieuChuan) {
            swal({
                title: 'Bạn có chắc muốn xoá không ?',
                type: 'warning',
                showCancelButton: true,
                closeOnConfirm: false,
                showLoaderOnConfirm: true,
                confirmButtonColor: '#F44336',
                cancelButtonColor: '#ef4848',
                confirmButtonText: 'Xoá',
                cancelButtonText: 'Không'
            }, function () //
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
                        if (xmlhttp.responseText == "Success") {
                            swal("Đã xoá!");
                            if (Loai == "TrongTieuChuan")
                                LoadTieuChi_TrongTieuChuan(TieuChuan);
                            else
                            {
                                setTimeout(function () {
                                    window.location.reload();
                                }, 200);
                            }
                        }
                        else {
                            swal("Lỗi !", "", "error");
                        }
                    }
                }
                xmlhttp.open("GET", "../../Ajax.aspx?Action=DeleteTieuChi&TieuChi=" + TieuChi, true);
                xmlhttp.send();
            });
        }
        function OpenModal_AddNewTieuChi(TieuChuan) {
            $("#txtTenTieuChi_modalTieuChi,#txtSTT_modalTieuChi").val("");
            $("#btnModalSave_TieuChi").attr('onclick', "AddTieuChi(" + TieuChuan + ");");

            $("#myModalTile_TieuChi").html('THÊM MỚI TIÊU CHÍ');
            $("#verticalModal_TieuChi").modal('show');
            $("#verticalModal_TieuChi").css({ 'display': 'flex', 'align-items': 'center' });
        }
        function AddTieuChi(TieuChuan) {
            var TenTieuChi = $("#txtTenTieuChi_modalTieuChi").val();
            var STT = $("#txtSTT_modalTieuChi").val();

            var flag_OK = true;
            if (TenTieuChi == "")//
            {
                $("#txtTenTieuChi_modalTieuChi").notify("Vui lòng nhập Tiêu chí!", { position: "top", className: "error", autoHideDelay: 5000, });
                $("#fltxtTenTieuChi_modalTieuChi").addClass("animated shake");
                setTimeout(function () {
                    $("#fltxtTenTieuChi_modalTieuChi").removeClass("animated shake");
                }, 1000);
                flag_OK = false;
            }
            if (STT == "")//
            {
                $("#txtSTT_modalTieuChi").notify("Vui lòng nhập Số thứ tự!", { position: "top", className: "error", autoHideDelay: 5000, });
                $("#fltxtSTT_modalTieuChi").addClass("animated shake");
                setTimeout(function () {
                    $("#fltxtSTT_modalTieuChi").removeClass("animated shake");
                }, 1000);
                flag_OK = false;
            }

            var value = TenTieuChi + "@_@" + TieuChuan + "@_@" + STT;
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
            xmlhttp.open("GET", "../../Ajax.aspx?Action=AddTieuChi&value=" + value, true);
            xmlhttp.send();
        }
        function OpenModal_EditTieuChi(TieuChuan, value, TenTieuChuan) {
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
                        $("#fltxtTenTieuChi_modalTieuChi,#fltxtSTT_modalTieuChi").addClass("focused");
                        //0 : TenTieuChi
                        //1 : So thu tu 
                        var arr = xmlhttp.responseText.split("@_@");
                        $("#txtTenTieuChi_modalTieuChi").val(arr[0]);
                        $("#txtSTT_modalTieuChi").val(arr[1]);

                        $("#btnModalSave_TieuChi").attr('onclick', 'EditTieuChi(' + TieuChuan + ',' + value + ');');

                        $("#myModalTile_TieuChi").html('CHỈNH SỬA THÔNG TIN TIÊU CHÍ CỦA ' + TenTieuChuan.toUpperCase());
                        $("#verticalModal_TieuChi").modal('show');
                        $("#verticalModal_TieuChi").css({ 'display': 'flex', 'align-items': 'center' });
                    }
                    else {
                        swal("Lỗi !", "", "error");
                    }
                }
            }
            xmlhttp.open("GET", "../../Ajax.aspx?Action=LoadTieuChi&value=" + value, true);
            xmlhttp.send();
        }
        function EditTieuChi(TieuChuan, TieuChi) {
            var TenTieuChi = $("#txtTenTieuChi_modalTieuChi").val();
            var STT = $("#txtSTT_modalTieuChi").val();

            var flag_OK = true;
            if (TenTieuChi == "")//
            {
                $("#txtTenTieuChi_modalTieuChi").notify("Vui lòng nhập Tiêu chí!", { position: "top", className: "error", autoHideDelay: 5000, });
                $("#fltxtTenTieuChi_modalTieuChi").addClass("animated shake");
                setTimeout(function () {
                    $("#fltxtTenTieuChi_modalTieuChi").removeClass("animated shake");
                }, 1000);
                flag_OK = false;
            }
            if (STT == "")//
            {
                $("#txtSTT_modalTieuChi").notify("Vui lòng nhập Số thứ tự!", { position: "top", className: "error", autoHideDelay: 5000, });
                $("#fltxtSTT_modalTieuChi").addClass("animated shake");
                setTimeout(function () {
                    $("#fltxtSTT_modalTieuChi").removeClass("animated shake");
                }, 1000);
                flag_OK = false;
            }

            var value = TenTieuChi + "@_@" + TieuChuan + "@_@" + STT;
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
            xmlhttp.open("GET", "../../Ajax.aspx?Action=EditTieuChi&value=" + value + "&TieuChi=" + TieuChi, true);
            xmlhttp.send();
        }

        ////////////////////////////
    </script>
</asp:Content>
