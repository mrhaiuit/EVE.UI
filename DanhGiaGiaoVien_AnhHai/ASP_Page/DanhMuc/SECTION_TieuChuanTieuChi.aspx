<%@ Page Language="C#" MasterPageFile="~/Layout/MasterPage.master" AutoEventWireup="true" CodeFile="SECTION_TieuChuanTieuChi.aspx.cs" Inherits="ASP_Page_Default" %>

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
                                    <select class="form-control" id="slLoaiTieuChuan">
                                        <option>-- Chọn loại tiêu chuẩn --</option>
                                        <option>Loại tiêu chuẩn 1</option>
                                        <option>Loại tiêu chuẩn 2</option>
                                        <option>Loại tiêu chuẩn 3</option>
                                        <option>Loại tiêu chuẩn 4</option>
                                        <option>Loại tiêu chuẩn 5</option>
                                    </select>
                                </div>
                                <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
                                    <select class="form-control" id="slCapGiaoDuc">
                                        <option>-- Chọn cấp giáo dục --</option>
                                        <option>Cấp 1</option>
                                        <option>Cấp 2</option>
                                        <option>Cấp 3</option>
                                        <option>Cấp 4</option>
                                        <option>Cấp 5</option>
                                    </select>
                                </div>
                                <div class="col-lg-2 col-md-2 col-sm-9 col-xs-9">
                                    <!-- Call Search -->
                                    <a class="btn btn-warning waves-effect js-search" data-close="true" style="width: 100%; box-shadow: none;"><i class="material-icons">search</i><span>Tìm kiếm</span></a>
                                    <!-- #END# Call Search -->
                                </div> 
                                <div class="col-lg-3 col-md-3 col-sm-2 col-xs-2 align-right">
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
                                <tbody>
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
                                    <%--///////////////////////////--%>
                                    <tr class="tr-header">
                                        <td>2</td>
                                        <td>QUẢN TRỊ NHÀ TRƯỜNG <b><i class='fa fa-chevron-right'></i></b></td>
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
                                                        <td>Tổ chức xây dựng kế hoạch phát</td>
                                                        <td class="text-nowrap  align-center">
                                                            <a href='javascript:OpenModal_EditTieuChi(1);' class='btn bg-green waves-effect' style='padding: 0 7px 3px 7px;' data-toggle='tooltip' data-placement='top' title='' data-original-title='Sửa'><i class='fa fa-pencil'></i></a>
                                                            <a href='javascript:Xoa();' class='btn bg-red waves-effect' style='padding: 0 7px 3px 7px;' data-toggle='tooltip' data-placement='top' title='' data-original-title='Xoá'><i class='fa fa-trash'></i></a>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>2</td>
                                                        <td>Quản trị hoạt động dạy học và giáo dục</td>
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
                            <div class="row">
                                <div class="col-md-12 col-lg-12">
                                    <div class="form-group form-float">
                                        <div class="form-line" id="fltxtTenTieuChuan_modal">
                                            <input type="text" class="form-control" id="txtTenTieuChuan_modal" />
                                            <label class="form-label">Tên tiêu chuẩn</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12 col-lg-12">
                                    <div class="form-group form-float">
                                        <div class="form-line" id="fltxtGhiChu_modal">
                                            <textarea cols="40" rows="5" class="form-control" id="txtGhiChu_modal"></textarea>
                                            <label class="form-label">Ghi chú </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-7 col-lg-7">
                                    <div class="form-group form-float">
                                        <div class="form-line" id="fltxtTenTieuChi_modal">
                                            <input type="text" class="form-control" id="txtTenTieuChi_modal" />
                                            <label class="form-label">Tên tiêu chi</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-2 col-lg-2">
                                    <a class="btn btn-success waves-effect" href="javascript:void(0);"><i class="material-icons">playlist_add</i> <span>THÊM TIÊU CHÍ</span></a>
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
                                    <tbody>
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
                                <div class="col-md-12 col-lg-12">
                                    <div class="form-group form-float">
                                        <div class="form-line" id="fltxtTenTieuChi_modalTieuChi">
                                            <input type="text" class="form-control" id="txtTenTieuChi_modalTieuChi" />
                                            <label class="form-label">Tên tiêu chí</label>
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
        $("#slLoaiTieuChuan,#slCapGiaoDuc").select2();
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
        function Xoa() {
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
                swal("Đã xoá !");
                setTimeout(function () {
                    window.location.reload();
                }, 1000);

            });
        }
        function OpenModal_AddNewTieuChuan() {

            $("#btnModalSave").attr('onclick', "abc();");

            $("#myModalTile").html('THÊM MỚI TIÊU CHUẨN');
            $("#verticalModal").modal('show');
            $("#verticalModal").css({ 'display': 'flex', 'align-items': 'center' });
        }
        function OpenModal_EditTieuChuan(id) {

            $("#btnModalSave").attr('onclick', "abc();");

            $("#myModalTile").html('CHỈNH SỬA THÔNG TIN TIÊU CHUẨN');
            $("#verticalModal").modal('show');
            $("#verticalModal").css({ 'display': 'flex', 'align-items': 'center' });
        }


        ////////////////////////////
        function OpenModal_AddNewTieuChi(id) {

            $("#btnModalSave_TieuChi").attr('onclick', "abc();");

            $("#myModalTile_TieuChi").html('THÊM MỚI TIÊU CHÍ CỦA TIÊU CHUẨN ABC ABC');
            $("#verticalModal_TieuChi").modal('show');
            $("#verticalModal_TieuChi").css({ 'display': 'flex', 'align-items': 'center' });
        }
        function OpenModal_EditTieuChi(id) {

            $("#btnModalSave_TieuChi").attr('onclick', "abc();");

            $("#myModalTile_TieuChi").html('CHỈNH SỬA TIÊU CHÍ CỦA TIÊU CHUẨN ABC ABC');
            $("#verticalModal_TieuChi").modal('show');
            $("#verticalModal_TieuChi").css({ 'display': 'flex', 'align-items': 'center' });
        }
    </script>
</asp:Content>
