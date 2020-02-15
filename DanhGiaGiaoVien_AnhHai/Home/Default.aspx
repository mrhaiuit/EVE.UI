<%@ Page Title="" Language="C#" MasterPageFile="~/Layout/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Home_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"> 
    <script>
        window.onload = function () {
            window.location.href = "../Home/Default.html";
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentMaster" Runat="Server">
    <div class="content-wrapper" background-size: 100%;">
    <!-- Content Header (Page header) -->
    <!-- Main content -->
     <section class="content">
        <div style="padding:10px"> 
            <div class=" field">   
            </div> 
        </div>
    </section>
    <!-- /.content -->
  </div> 
</asp:Content>

