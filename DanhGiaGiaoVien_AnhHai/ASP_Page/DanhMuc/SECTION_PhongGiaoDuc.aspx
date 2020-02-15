<%@ Page Language="C#" MasterPageFile="~/Layout/MasterPage.master" AutoEventWireup="true" CodeFile="SECTION_PhongGiaoDuc.aspx.cs" Inherits="ASP_Page_Default" %>

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
                $("#btnModalSave").attr('onclick', 'AddPhongGiaoDuc();');

                $("#myModalTile").html('THÊM MỚI PHÒNG GIÁO DỤC');
                $("#verticalModal").modal('show');
                $("#verticalModal").css({ 'display': 'flex', 'align-items': 'center' });
            }
            function OpenModal_EditPhongGiaoDuc() {
                $("#btnModalSave").attr('onclick', 'EditPhongGiaoDuc();');

                $("#myModalTile").html('CHỈNH SỬA THÔNG TIN PHÒNG GIÁO DỤC');
                $("#verticalModal").modal('show');
                $("#verticalModal").css({ 'display': 'flex', 'align-items': 'center' });
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
                                            <input type="text" class="form-control date" placeholder="Tìm kiếm">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-3 col-md-3 col-sm-7 col-xs-7">
                                    <select class="form-control" id="slSoGiaoDuc" style="width: 100%;">
                                        <option>-- Chọn sở giáo dục --</option>
                                        <option value='0'>Sở A</option>
                                        <option value='1'>Sở B</option>
                                        <option value='2'>Sở C</option>
                                        <option value='3'>Sở D</option>
                                        <option value='4'>Sở E</option>
                                    </select>
                                </div>
                                <div class="col-lg-2 col-md-2 col-sm-5 col-xs-5">
                                    <!-- Call Search -->
                                    <a class="btn btn-warning waves-effect js-search" style="width: 100%; box-shadow: none;"><i class="material-icons">search</i><span>Tìm kiếm</span></a>
                                    <!-- #END# Call Search -->
                                </div> 
                                <div class="col-lg-4 col-md-4 col-sm-8 col-xs-8 align-right">
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
                                        <th class='bg-cyan align-center' style='min-width: 10rem;'>ĐỊA CHỈ</th>
                                        <th class='bg-cyan align-center'></th>
                                    </tr>
                                </thead>
                                <tbody>
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
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content" style="border-radius: 10px;">
                        <div class="modal-header">
                            <h4 class="modal-title" id="myModalTile">THÊM MỚI</h4>
                        </div>
                        <div class="modal-body">

                            <div class="row">
                                <div class="col-md-12 col-lg-12">
                                    <div class="form-group form-float">
                                        <div class="form-line" id="fltxtTenPhongGiaoDuc">
                                            <input type="text" class="form-control" id="txtTenPhongGiaoDuc">
                                            <label class="form-label">Tên phòng <span style="display: inline-block; font-size: 10px;">(<i class="fa fa-certificate"></i>)</span></label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <h5 class="card-inside-title " style="margin-bottom: 10px;">Chọn địa chỉ</h5>
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
                                    <select class="form-control" id="slTinhThanh" style="width: 100%;">
                                        <option>-- Chọn tỉnh/thành phố --</option>
                                    </select>
                                </div>
                                <div class="col-md-3 col-lg-3">
                                    <select class="form-control" id="slQuanHuyen" style="width: 100%;">
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

        $("#slSoGiaoDuc,#slSoGiaoDuc_Modal,#slTinhThanh,#slQuanHuyen,#slPhuongXa").select2();

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
