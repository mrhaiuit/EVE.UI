<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Home_Login" %>

<!DOCTYPE html>

<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Favicon-->
    <link rel="icon" href="../favicon.ico" type="image/x-icon">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Roboto:400,700&subset=latin,cyrillic-ext" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" type="text/css">
    <!-- Bootstrap Core Css -->
    <link href="../plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <!-- Waves Effect Css -->
    <link href="../plugins/node-waves/waves.css" rel="stylesheet" />
    <!-- Animation Css -->
    <link href="../plugins/animate-css/animate.css" rel="stylesheet" />
    <!-- Bootstrap Material Datetime Picker Css -->
    <link href="../plugins/bootstrap-material-datetimepicker/css/bootstrap-material-datetimepicker.css" rel="stylesheet" />
    <!-- font-awesome Css -->
    <link href="../plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" />
    <!-- Wait Me Css -->
    <link href="../plugins/waitme/waitMe.css" rel="stylesheet" />
    <!-- Bong bóng bay Css -->
    <link href="../plugins/css bong bong bay/particle-background.css" rel="stylesheet" />
    <!-- Custom Css -->
    <link href="../css/style.css" rel="stylesheet">
    <!-- AdminBSB Themes. You can choose a theme from css/themes instead of get all themes -->
    <link href="../css/themes/all-themes.css" rel="stylesheet" />
    <style>
        html {
            background: url('../images/login-background.jpg') no-repeat left center fixed;
            -webkit-background-size: cover;
            -moz-background-size: cover;
            -o-background-size: cover;
            background-size: cover;
        }

        html {
            height: 100%;
            min-height: 100%;
        }

        .formForgot,.formLogin {
            position: absolute;
            top: 40%;
            left: 50%;
            width: 40rem;
            background-color: rgba(255, 255, 255, 0.6313725490196078);
            transform: translate(-50%, -40%);
            border-radius: 5px;
            box-shadow: 1px 1px 11px 4px;
            padding: 65px 25px 25px 25px;
        }
        .formForgot{
            width:36rem;
        }


        .form-group .form-control {
            background-color: rgba(0, 0, 0, 0.2);
            border-radius: 5px;
            font-size: 20px;
            color: white;
        }

        .form-group .form-line:after {
            border-bottom: 3px solid white;
        }

        .form-group .form-line {
            border-bottom: 2px solid #848275;
        }

            .form-group .form-line .form-label {
                color: black;
                font-size: 18px;
            }

        .cirlcleBrand {
            position: absolute;
            top: 0%;
            left: 50%;
            width: 13rem;
            height: 13rem;
            background-image: url(/images/logo.png);
            background-repeat: no-repeat;
            background-size: contain;
            background-position: center;
            background-color: rgba(255, 255, 255, 0.6313725490196078);
            transform: translate(-50%, -60%);
            border-radius: 50%;
            box-shadow: 1px 1px 11px 4px;
        }

        .form-group span {
            font-weight: 600;
            color: #ca0000;
            font-size: 16px;
            display: none;
        }
        .form-group
        {
            margin-bottom:15px;
        }

        @media (max-width: 400px) {
            .formLogin {
                width: 95%;
            }
        }
    </style>
    <script>
        function btnLogin_clickJS() {
            var Username = $("#txtUsername").val().trim();
            var Password = $("#txtPassword").val().trim();
            var flag = true;
            if (Username == "") {
                $("#spUsername").html("Vui lòng nhập tên đăng nhập !");
                $("#spUsername").css('display', 'block');
                $("#txtUsername").addClass("animated shake");
                setTimeout(function () {
                    $("#txtUsername").removeClass("animated shake");
                }, 1000);
                flag = false;
            }
            else
                $("#spUsername").css('display', 'none');

            if (Password == "") {
                $("#spPassword").html("Vui lòng nhập mật khẩu !");
                $("#spPassword").css('display', 'block');
                $("#txtPassword").addClass("animated shake");
                setTimeout(function () {
                    $("#txtPassword").removeClass("animated shake");
                }, 1000);
                flag = false;
            }
            else
                $("#spPassword").css('display', 'none');

            /////////////////////////
            if (hasUnicode(Username)) {
                $("#spUsername").html("Tên đăng nhập không được có dấu !");
                $("#spUsername").css('display', 'block');
                $("#txtUsername").addClass("animated shake");
                setTimeout(function () {
                    $("#txtUsername").removeClass("animated shake");
                }, 1000);
                flag = false;
            }

            if (hasUnicode(Password)) {
                $("#spPassword").html("Mật khẩu không được có dấu !");
                $("#spPassword").css('display', 'block');
                $("#txtPassword").addClass("animated shake");
                setTimeout(function () {
                    $("#txtPassword").removeClass("animated shake");
                }, 1000);
                flag = false;
            }

            if (!flag)
                return;
            document.getElementById("btnLogin").click();
        }
        function hasUnicode(str) {
            for (var i = 0; i < str.length; i++) {
                if (str.charCodeAt(i) > 127) return true;
            }
            return false;
        }
    </script>
    <title>ĐĂNG NHẬP | Công Ty Tư Vấn Thiết Kế Xây Dựng Thương Mại Ngọc Thanh</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div id="particle-container">
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
                <div class="particle"></div>
            </div>
            <div class="formLogin animated zoomIn">
                <div class="row clearfix">
                    <div class="cirlcleBrand animated zoomIn">
                    </div>
                    <div class="col-sm-12">
                        <div class="form-group form-float">
                            <div class="form-line">
                                <input type="text" class="form-control" id="txtUsername" runat="server" onkeypress="javascript:if(event.keyCode == 13) document.getElementById('btnLogin').click();">
                                <label class="form-label">Tên đăng nhập</label>
                            </div>
                            <span id="spUsername">Error</span>
                        </div>
                    </div>
                    <div class="col-sm-12">
                        <div class="form-group form-float">
                            <div class="form-line">
                                <input type="password" class="form-control" id="txtPassword" runat="server" onkeypress="javascript:if(event.keyCode == 13) document.getElementById('btnLogin').click();">
                                <label class="form-label">Mật khẩu</label>
                            </div>
                            <span id="spPassword">Error</span>
                        </div>
                    </div>
                    <div class="col-sm-12">
                        <select class="form-group form-control" id="slUserGroup" runat="server"></select>
                    </div>
                    <div class="col-sm-12">
                        <a href="javascript:$('.formLogin').fadeOut().hide(); $('.formForgot').removeAttr('style').addClass('animated shake');"><i class="fa fa-key m-r-10"></i> Quên mật khẩu</a> 
                    </div>
                    <div class="col-sm-12">
                        <a class="btn btn-default waves-effect" style="float: right; font-size: 18px; padding: 5px 20px;" onclick="btnLogin_clickJS();"><i class="fa fa-sign-in m-r-20"></i>ĐĂNG NHẬP</a>
                        <asp:LinkButton ID="btnLogin" OnClick="btnLogin_Click" runat="server" Style="display: none;"></asp:LinkButton>
                    </div>
                </div> 
            </div>

            <div class="formForgot animated zoomIn" style="display:none;">
                <div class="row clearfix">
                    <div class="cirlcleBrand animated zoomIn">
                    </div>
                    <div class="col-sm-12">
                        <div class="form-group form-float">
                            <div class="form-line">
                                <input type="text" class="form-control" id="Text1" runat="server" onkeypress="javascript:if(event.keyCode == 13) document.getElementById('btnLogin').click();">
                                <label class="form-label">Số điện thoại</label>
                            </div> 
                        </div>
                    </div>
                    <div class="col-sm-12">
                        <div class="form-group form-float">
                            <div class="form-line">
                                <input type="text" class="form-control" id="Text2" runat="server" onkeypress="javascript:if(event.keyCode == 13) document.getElementById('btnLogin').click();">
                                <label class="form-label">Email</label>
                            </div> 
                        </div>
                    </div>
                    <div class="col-sm-12">
                        <div class="form-group form-float">
                            <div class="form-line">
                                <input type="password" class="form-control" id="Password1" runat="server" onkeypress="javascript:if(event.keyCode == 13) document.getElementById('btnLogin').click();">
                                <label class="form-label">Mật khẩu mới</label>
                            </div> 
                        </div>
                    </div>
                    <div class="col-sm-12">
                        <a href="javascript:$('.formForgot').fadeOut().hide(); $('.formLogin').removeAttr('style').addClass('animated shake');"><i class="fa fa-sign-in m-r-10"></i> Về đăng nhập</a> 
                    </div>
                    <div class="col-sm-12">
                        <a class="btn btn-default waves-effect" style="float: right; font-size: 18px; padding: 5px 20px;" onclick=""><i class="fa fa-refresh m-r-20"></i>KHÔI PHỤC</a>
                        <asp:LinkButton ID="LinkButto1"  runat="server" Style="display: none;"></asp:LinkButton>
                    </div> 
                </div>

            </div>

        </div>
    </form>
    <!-- Jquery Core Js -->
    <script src="../plugins/jquery/jquery.min.js"></script>
    <!-- Bootstrap Core Js -->
    <script src="../plugins/bootstrap/js/bootstrap.min.js"></script>
    <!-- Slimscroll Plugin Js -->
    <script src="../plugins/jquery-slimscroll/jquery.slimscroll.js"></script>
    <!-- Waves Effect Plugin Js -->
    <script src="../plugins/node-waves/waves.js"></script>
    <!-- Autosize Plugin Js -->
    <script src="../plugins/autosize/autosize.js"></script>
    <!-- Moment Plugin Js -->
    <script src="../plugins/momentjs/moment.js"></script>
    <!-- Bootstrap Material Datetime Picker Plugin Js -->
    <script src="../plugins/bootstrap-material-datetimepicker/js/bootstrap-material-datetimepicker.js"></script>

    <!-- Demo Js -->
    <script src="../js/demo.js"></script>
    <script src="../js/pages/forms/basic-form-elements.js"></script>
    <script src="../js/admin.js"></script>
    <!-- Custom Js -->
    <script src="../js/pages/ui/dialogs.js"></script>
</body>
</html>
