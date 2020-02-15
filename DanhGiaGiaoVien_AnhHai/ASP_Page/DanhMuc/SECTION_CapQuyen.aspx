<%@ Page Language="C#" MasterPageFile="~/Layout/MasterPage.master" AutoEventWireup="true" CodeFile="SECTION_CapQuyen.aspx.cs" Inherits="ASP_Page_Default" %>

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
            function OpenModal_AddPhanQuyen() {
                $("#btnModalSave").attr('onclick', 'AddPhanQuyen();');

                $("#myModalTile").html('CẤP QUYỀN CHO NHÂN VIÊN');
                $("#verticalModal").modal('show');
                $("#verticalModal").css({ 'display': 'flex', 'align-items': 'center' });
            }
            function OpenModal_EditPhanQuyen() {
                $("#btnModalSave").attr('onclick', 'EditPhanQuyen();');

                $("#myModalTile").html('CHỈNH SỬA QUYỀN CỦA NHÂN VIÊN');
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
                    <li class="active"><a href="../../Asp_page/SECTION_CAPQUYEN.aspx"><i class="fa fa-user m-r-10"></i>Quản lý Phân quyền</a></li>
                </ol>
            </div>
            <div class="row clearfix">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="card">
                        <div class="header">
                            <div class="row">
                                <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
                                    <h4>QUẢN LÝ PHÂN QUYỀN</h4>
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
                                    <select class="form-control" id="slNhomQuyen" style="width: 100%;">
                                        <option>-- Chọn nhóm quyền --</option>
                                        <option value='0'>Nhóm 1</option>
                                        <option value='1'>Nhóm 2</option>
                                        <option value='2'>Nhóm 3</option>
                                        <option value='3'>Nhóm 4</option>
                                        <option value='4'>Nhóm 5</option>
                                    </select>
                                </div>
                                <div class="col-lg-2 col-md-2 col-sm-5 col-xs-5">
                                    <!-- Call Search -->
                                    <a class="btn btn-warning waves-effect js-search" style="width: 100%; box-shadow: none;"><i class="material-icons">search</i><span>Tìm kiếm</span></a>
                                    <!-- #END# Call Search -->
                                </div>
                                <div class="col-lg-4 col-md-4 col-sm-8 col-xs-8 align-right">
                                    <a class="btn btn-warning waves-effect" href="javascript:OpenModal_AddPhanQuyen();"><i class="material-icons">playlist_add</i> <span>THÊM MỚI</span></a>
                                </div>
                            </div>
                        </div>
                        <div class="body table-responsive">
                            <table class='table table-bordered table-hover'>
                                <thead>
                                    <tr>
                                        <th class='bg-cyan' style='min-width: 5rem;'>STT</th>
                                        <th class='bg-cyan' style='min-width: 15rem;'>NHÂN VIÊN</th>
                                        <th class='bg-cyan align-center' style='min-width: 10rem;'>MÃ TÀI KHOẢN</th>
                                        <th class='bg-cyan align-center' style='min-width: 10rem;'>CHỨC VỤ</th>
                                        <th class='bg-cyan' style='min-width: 10rem;'>EMAIL</th>
                                        <th class='bg-cyan align-center'>LOCK</th>
                                        <th class='bg-cyan align-center'></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%--///////////////////////////--%>
                                    <tr>
                                        <td>1</td>
                                        <td>Nguyễn trần A</td>
                                        <td class='align-center'>TranA</td>
                                        <td class='align-center'>Administrator</td>
                                        <td>Administrator@gmail.com</td>
                                        <td class='align-center'>
                                            <span class="label label-danger font-17" id="spLock_1" onclick="ChangeLockAccount(this.id,0);" style="cursor:pointer;"  data-toggle='tooltip' data-placement='top' title='' data-original-title='Unlock'><i class="fa fa-lock"></i></span>
                                        </td>
                                        <td class="text-nowrap align-center">
                                            <a href='javascript:OpenModal_EditPhanQuyen();' class='btn bg-green waves-effect' style='padding: 0 7px 3px 7px;' data-toggle='tooltip' data-placement='top' title='' data-original-title='Sửa'><i class='fa fa-pencil'></i></a>
                                            <a href='javascript:void(0)' class='btn bg-red waves-effect' style='padding: 0 7px 3px 7px;' data-toggle='tooltip' data-placement='top' title='' data-original-title='Xoá'><i class='fa fa-trash'></i></a>
                                        </td>
                                    </tr>
                                    <%--///////////////////////////--%>
                                    <%--///////////////////////////--%>
                                    <tr>
                                        <td>2</td>
                                        <td>Nguyễn trần A</td>
                                        <td class='align-center'>TranA</td>
                                        <td class='align-center'>Administrator</td>
                                        <td>Administrator@gmail.com</td>
                                        <td class='align-center'>
                                            <span class="label label-success font-17" id="spLock_2" onclick="ChangeLockAccount(this.id,1);" style="cursor:pointer;"  data-toggle='tooltip' data-placement='top' title='' data-original-title='Lock'><i class="fa fa-unlock"></i></span>
                                        </td>
                                        <td class="text-nowrap align-center">
                                            <a href='javascript:OpenModal_EditPhanQuyen();' class='btn bg-green waves-effect' style='padding: 0 7px 3px 7px;' data-toggle='tooltip' data-placement='top' title='' data-original-title='Sửa'><i class='fa fa-pencil'></i></a>
                                            <a href='javascript:void(0)' class='btn bg-red waves-effect' style='padding: 0 7px 3px 7px;' data-toggle='tooltip' data-placement='top' title='' data-original-title='Xoá'><i class='fa fa-trash'></i></a>
                                        </td>
                                    </tr>
                                    <%--///////////////////////////--%>
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td colspan="15" class="footertable align-center">
                                            <ul class="pagination margin-0">
                                                <li><a href="SECTION_CapQuyen.aspx?Page=1" class="waves-effect"><i class="material-icons">chevron_left</i></a></li>
                                                <li class="active"><a href="SECTION_CapQuyen.aspx?Page=1" class="waves-effect bg-cyan">1</a></li>
                                                <li class="hidden"><a href="SECTION_CapQuyen.aspx?Page=" class="waves-effect"></a></li>
                                                <li class="hidden"><a href="SECTION_CapQuyen.aspx?Page=" class="waves-effect"></a></li>
                                                <li class="hidden"><a href="SECTION_CapQuyen.aspx?Page=" class="waves-effect"></a></li>
                                                <li class="hidden"><a href="SECTION_CapQuyen.aspx?Page=" class="waves-effect"></a></li>
                                                <li><a href="SECTION_CapQuyen.aspx?Page=1" class="waves-effect"><i class="material-icons">chevron_right</i></a></li>
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
                                    <select class="form-control" id="slNhanVien" style="width: 100%;">
                                        <option>-- Chọn nhân viên --</option>
                                        <option>Nhân viên A</option>
                                        <option>Nhân viên B</option>
                                        <option>Nhân viên C</option>
                                        <option>Nhân viên D</option>
                                    </select>
                                </div>
                                <div class="col-md-6 col-lg-6">
                                    <select class="form-control" id="slNhomQuyen_modal" style="width: 100%;">
                                        <option>-- Chọn nhóm quyền --</option>
                                        <option>Nhóm A</option>
                                        <option>Nhóm B</option>
                                        <option>Nhóm C</option>
                                        <option>Nhóm D</option>
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
        function ChangeLockAccount(id, status)//
        { 
            if (status == "0") {
                $("#" + id).html("<i class='fa fa-unlock'></i>");
                $("#" + id).attr('class', 'label label-success font-17');
                $("#" + id).attr('onclick', "ChangeLockAccount(\"" + id + "\",1)");
                $("#" + id).attr('data-original-title', "Lock"); 
            }
            else//
            {
                $("#" + id).html("<i class='fa fa-lock'></i>");
                $("#" + id).attr('class', 'label label-danger font-17');
                $("#" + id).attr('onclick', "ChangeLockAccount(\"" + id + "\",0)");
                $("#" + id).attr('data-original-title', "Unlock");
            }
        }
        $("#slNhomQuyen,#slNhomQuyen_modal,#slNhanVien").select2();

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
