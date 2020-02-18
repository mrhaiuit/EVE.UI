<%@ Page Language="C#" MasterPageFile="~/Layout/MasterPage.master" AutoEventWireup="true" CodeFile="DanhGiaGiaoVien.aspx.cs" Inherits="ASP_Page_Default" %>

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

        .My-td::before {
            content: "● ";
        }
        .popover
        {
            max-width:750px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentMaster" runat="Server">

    <section class="content">
        <div class="container-fluid">
            <div class="block-header hidden">
                <ol class="breadcrumb" id="breadscrumColor" runat="server">
                    <li><a href="../../Asp_page/index.aspx"><i class="material-icons">home</i> Trang chủ</a></li>
                    <li class="active"><a href="../../Asp_page/DANHGIAGIAOVIEN.aspx"><i class="fa fa-user m-r-10"></i>Đánh giá giáo viên</a></li>
                </ol>
            </div>
            <div class="row clearfix">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="card">
                        <div class="header">
                            <div class="row">
                                <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
                                    <h4>ĐÁNH GIÁ GIÁO VIÊN</h4>
                                    <br />
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-3 col-md-3 col-sm-12 col-xs-12">
                                    <h5 class="card-inside-title " style="margin-bottom: 5px;">Chọn kỳ đánh giá</h5>
                                    <select class="form-control" id="slKyDanhGia">
                                        <option>-- Chọn kỳ --</option>
                                        <option>Đánh giá kỳ 1</option>
                                        <option>Đánh giá kỳ 2</option>
                                        <option>Đánh giá kỳ 3</option>
                                        <option>Đánh giá kỳ 4</option>
                                        <option>Đánh giá kỳ 5</option>
                                    </select>
                                </div>
                                <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
                                    <h5 class="card-inside-title " style="margin-bottom: 5px;">Chọn giáo viên</h5>
                                    <select class="form-control" id="slGiaoVien">
                                        <option>-- Chọn giáo viên --</option>
                                        <option>Lê Văn A</option>
                                        <option>Lê Văn B</option>
                                        <option>Lê Văn C</option>
                                        <option>Lê Văn D</option>
                                        <option>Lê Văn E</option>
                                    </select>
                                </div>
                                <div class="col-lg-5 col-md-5 col-sm-12 col-xs-12  align-right">
                                    <h5 class="card-inside-title " style="margin-bottom: 5px;visibility:hidden;">A</h5>
                                    <a class="btn btn-success waves-effect m-r-10" href="javascript:void(0);"><i class="material-icons">done_all</i> <span>LƯU</span></a>
                                    <a class="btn bg-red  waves-effect" href="javascript:HuyDanhGia();"><i class="material-icons">clear</i> <span>HUỶ</span></a>
                                </div>
                            </div>
                        </div>
                        <div class="body table-responsive">
                            <table class='table table-bordered table-hover'>
                                <thead>
                                    <tr>
                                        <th class='bg-cyan' style='min-width: 20rem;'>TIÊU CHUẨN/TIÊU CHÍ</th>
                                        <th class='bg-cyan' style='min-width: 15rem;'>MỨC ĐÁNH GIÁ TIÊU CHÍ</th>
                                        <th class='bg-cyan' style='min-width: 10rem;'>MINH CHỨNG</th>
                                        <th class='bg-cyan align-center'>ĐÍNH KÈM</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%--///////////////////////////--%>
                                    <tr class="tr-header">
                                        <td colspan="4">Tiêu chuẩn 1: PHẨM CHẤT NGHỀ NGHIỆP <b><i class='fa fa-chevron-down'></i></b></td>
                                    </tr>
                                    <tr>
                                        <td class="My-td">Tiêu chí 1. Đạo đức nghề nghiệp</td>
                                        <td>
                                            <select class="form-control" style="width: 63%; display: inline-block;">
                                                <option>-- Chọn mức đánh giá --</option>
                                                <option>Mức 1</option>
                                                <option>Mức 2</option>
                                                <option>Mức 3</option>
                                                <option>Mức 4</option>
                                            </select>
                                            <button onclick="return false;" class='btn bg-green waves-effect' data-trigger="focus" data-container="body" data-content="Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum." data-toggle="popover" data-placement="bottom" title="" data-original-title="Diễn giải tiêu chí và mức đánh giá">Chi tiết</button>
                                        </td>
                                        <td>
                                            <input class="form-control" id="txtMinhChung1" type="text" placeholder="Nhập minh chứng ... " onclick="ShowPopup_NhapMinhChung(this.id);" /></td>
                                        <td>
                                            <a class='btn bg-green waves-effect' href="javascript:document.getElementById('file_DinhKem1').click();">Upload</a>
                                            <input type="file" class="hidden" id="file_DinhKem1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="My-td">Tiêu chí 2. Tư tưởng đổi mới trong lãnh đạo</td>
                                        <td>
                                            <select class="form-control" style="width: 63%; display: inline-block;">
                                                <option>-- Chọn mức đánh giá --</option>
                                                <option>Mức 1</option>
                                                <option>Mức 2</option>
                                                <option>Mức 3</option>
                                                <option>Mức 4</option>
                                            </select>
                                            <button onclick="return false;" class='btn bg-green waves-effect' data-trigger="focus" data-container="body" data-content="Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum." data-toggle="popover" data-placement="bottom" title="" data-original-title="Diễn giải tiêu chí và mức đánh giá">Chi tiết</button>
                                        </td>
                                        <td>
                                            <input class="form-control" id="txtMinhChung2" type="text" placeholder="Nhập minh chứng ... " onclick="ShowPopup_NhapMinhChung(this.id);" /></td>
                                        <td>
                                            <a class='btn bg-green waves-effect' href="javascript:document.getElementById('file_DinhKem2').click();">Upload</a>
                                            <input type="file" class="hidden" id="file_DinhKem2" />
                                        </td>
                                    </tr>
                                    <%--///////////////////////////--%>

                                    <%--///////////////////////////--%>
                                    <tr class="tr-header">
                                        <td colspan="4">Tiêu chuẩn 2: QUẢN TRỊ NHÀ TRƯỜNG <b><i class='fa fa-chevron-down'></i></b></td>
                                    </tr>
                                    <tr>
                                        <td class="My-td">Tiêu chí 4. Tổ chức xây dựng kế hoạch phát</td>
                                        <td>
                                            <select class="form-control" style="width: 63%; display: inline-block;">
                                                <option>-- Chọn mức đánh giá --</option>
                                                <option>Mức 1</option>
                                                <option>Mức 2</option>
                                                <option>Mức 3</option>
                                                <option>Mức 4</option>
                                            </select>
                                            <button onclick="return false;" class='btn bg-green waves-effect' data-trigger="focus" data-container="body" data-content="Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum." data-toggle="popover" data-placement="bottom" title="" data-original-title="Diễn giải tiêu chí và mức đánh giá">Chi tiết</button>
                                        </td>
                                        <td>
                                            <input class="form-control" id="txtMinhChung3" type="text" placeholder="Nhập minh chứng ... " onclick="ShowPopup_NhapMinhChung(this.id);" /></td>
                                        <td>
                                            <a class='btn bg-green waves-effect' href="javascript:document.getElementById('file_DinhKem3').click();">Upload</a>
                                            <input type="file" class="hidden" id="file_DinhKem3" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="My-td">Tiêu chí 5. Quản trị hoạt động dạy học, giáo dục</td>
                                        <td>
                                            <select class="form-control" style="width: 63%; display: inline-block;">
                                                <option>-- Chọn mức đánh giá --</option>
                                                <option>Mức 1</option>
                                                <option>Mức 2</option>
                                                <option>Mức 3</option>
                                                <option>Mức 4</option>
                                            </select>
                                            <button onclick="return false;" class='btn bg-green waves-effect' data-trigger="focus" data-container="body" data-content="Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum." data-toggle="popover" data-placement="bottom" title="" data-original-title="Diễn giải tiêu chí và mức đánh giá">Chi tiết</button>
                                        </td>
                                        <td>
                                            <input class="form-control" id="txtMinhChung4" type="text" placeholder="Nhập minh chứng ... " onclick="ShowPopup_NhapMinhChung(this.id);" /></td>
                                        <td>
                                            <a class='btn bg-green waves-effect' href="javascript:document.getElementById('file_DinhKem4').click();">Upload</a>
                                            <input type="file" class="hidden" id="file_DinhKem4" />
                                        </td>
                                    </tr>
                                    <%--///////////////////////////--%>
                                    <%--///////////////////////////--%>
                                    <tr class="tr-header">
                                        <td colspan="4">Tiêu chuẩn 3: PHẨM CHẤT NGHỀ NGHIỆP <b><i class='fa fa-chevron-down'></i></b></td>
                                    </tr>
                                    <tr>
                                        <td class="My-td">Tiêu chí 1. Đạo đức nghề nghiệp</td>
                                        <td>
                                            <select class="form-control" style="width: 63%; display: inline-block;">
                                                <option>-- Chọn mức đánh giá --</option>
                                                <option>Mức 1</option>
                                                <option>Mức 2</option>
                                                <option>Mức 3</option>
                                                <option>Mức 4</option>
                                            </select>
                                            <button onclick="return false;" class='btn bg-green waves-effect' data-trigger="focus" data-container="body" data-content="Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum." data-toggle="popover" data-placement="bottom" title="" data-original-title="Diễn giải tiêu chí và mức đánh giá">Chi tiết</button>
                                        </td>
                                        <td>
                                            <input class="form-control" id="txtMinhChung5" type="text" placeholder="Nhập minh chứng ... " onclick="ShowPopup_NhapMinhChung(this.id);" /></td>
                                        <td>
                                            <a class='btn bg-green waves-effect' href="javascript:document.getElementById('file_DinhKem5').click();">Upload</a>
                                            <input type="file" class="hidden" id="file_DinhKem5" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="My-td">Tiêu chí 2. Tư tưởng đổi mới trong lãnh đạo</td>
                                        <td>
                                            <select class="form-control" style="width: 63%; display: inline-block;">
                                                <option>-- Chọn mức đánh giá --</option>
                                                <option>Mức 1</option>
                                                <option>Mức 2</option>
                                                <option>Mức 3</option>
                                                <option>Mức 4</option>
                                            </select>
                                            <button onclick="return false;" class='btn bg-green waves-effect' data-trigger="focus" data-container="body" data-content="Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum." data-toggle="popover" data-placement="bottom" title="" data-original-title="Diễn giải tiêu chí và mức đánh giá">Chi tiết</button>
                                        </td>
                                        <td>
                                            <input class="form-control" id="txtMinhChung6" type="text" placeholder="Nhập minh chứng ... " onclick="ShowPopup_NhapMinhChung(this.id);" /></td>
                                        <td>
                                            <a class='btn bg-green waves-effect' href="javascript:document.getElementById('file_DinhKem6').click();">Upload</a>
                                            <input type="file" class="hidden" id="file_DinhKem6" />
                                        </td>
                                    </tr>
                                    <%--///////////////////////////--%>

                                    <%--///////////////////////////--%>
                                    <tr class="tr-header">
                                        <td colspan="4">Tiêu chuẩn 4: QUẢN TRỊ NHÀ TRƯỜNG <b><i class='fa fa-chevron-down'></i></b></td>
                                    </tr>
                                    <tr>
                                        <td class="My-td">Tiêu chí 4. Tổ chức xây dựng kế hoạch phát</td>
                                        <td>
                                            <select class="form-control" style="width: 63%; display: inline-block;">
                                                <option>-- Chọn mức đánh giá --</option>
                                                <option>Mức 1</option>
                                                <option>Mức 2</option>
                                                <option>Mức 3</option>
                                                <option>Mức 4</option>
                                            </select>
                                            <button onclick="return false;" class='btn bg-green waves-effect' data-trigger="focus" data-container="body" data-content="Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum." data-toggle="popover" data-placement="bottom" title="" data-original-title="Diễn giải tiêu chí và mức đánh giá">Chi tiết</button>
                                        </td>
                                        <td>
                                            <input class="form-control" id="txtMinhChung7" type="text" placeholder="Nhập minh chứng ... " onclick="ShowPopup_NhapMinhChung(this.id);" /></td>
                                        <td>
                                            <a class='btn bg-green waves-effect' href="javascript:document.getElementById('file_DinhKem7').click();">Upload</a>
                                            <input type="file" class="hidden" id="file_DinhKem7" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="My-td">Tiêu chí 5. Quản trị hoạt động dạy học, giáo dục</td>
                                        <td>
                                            <select class="form-control" style="width: 63%; display: inline-block;">
                                                <option>-- Chọn mức đánh giá --</option>
                                                <option>Mức 1</option>
                                                <option>Mức 2</option>
                                                <option>Mức 3</option>
                                                <option>Mức 4</option>
                                            </select>
                                            <button onclick="return false;" class='btn bg-green waves-effect' data-trigger="focus" data-container="body" data-content="Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum." data-toggle="popover" data-placement="bottom" title="" data-original-title="Diễn giải tiêu chí và mức đánh giá">Chi tiết</button>
                                        </td>
                                        <td>
                                            <input class="form-control" id="txtMinhChung8" type="text" placeholder="Nhập minh chứng ... " onclick="ShowPopup_NhapMinhChung(this.id);" /></td>
                                        <td>
                                            <a class='btn bg-green waves-effect' href="javascript:document.getElementById('file_DinhKem8').click();">Upload</a>
                                            <input type="file" class="hidden" id="file_DinhKem8" />
                                        </td>
                                    </tr>
                                    <%--///////////////////////////--%> 
                                </tbody>
                                <tfoot>
                                    <tr style="background-color:lightsalmon;color:black;">
                                        <td class="align-right">Tổng kết</td>
                                        <td class="align-center">Tổng điểm : <b>40 điểm</b></td>
                                        <td class="align-center">Xếp loại : <b>Đạt</b> </td>
                                        <td></td>
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
                        <div class="modal-header hidden">
                            <h4 class="modal-title" id="myModalTile">THÊM MỚI</h4>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-12 col-lg-12">
                                    <div class="form-group form-float">
                                        <div class="form-line" id="fltxtMinhChung">
                                            <textarea cols="40" rows="8" class="form-control" id="txtMinhChung_Modal"></textarea>
                                            <label class="form-label">Minh chứng </label>
                                        </div>
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

        $("#slKyDanhGia,#slGiaoVien").select2();
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
        function HuyDanhGia()
        {
            swal({
                title: 'Bạn có chắc muốn huỷ không ?',
                type: 'warning',
                showCancelButton: true,
                closeOnConfirm: false,
                showLoaderOnConfirm: true,
                confirmButtonColor: '#F44336',
                cancelButtonColor: '#ef4848',
                confirmButtonText: 'Huỷ',
                cancelButtonText: 'Không'
            }, function () //
            {
                swal("Đã huỷ bài đánh giá!");
                setTimeout(function () {
                    window.location.reload();
                }, 1000);

            });
        }
        function ShowPopup_NhapMinhChung(id) {
            $("#fltxtMinhChung_Modal").addClass('focused');
            $('#txtMinhChung_Modal').val($('#' + id).val());
            $("#btnModalSave").attr('onclick', "$('#" + id + "').val($('#txtMinhChung_Modal').val()); $('#verticalModal').modal('hide');");

            //$("#myModalTile").html('THÊM MỚI');
            $("#verticalModal").modal('show');
            $("#verticalModal").css({ 'display': 'flex', 'align-items': 'center' });
        } 
    </script>
</asp:Content>
