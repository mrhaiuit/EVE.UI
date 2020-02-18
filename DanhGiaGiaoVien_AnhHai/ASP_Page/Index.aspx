<%@ Page Language="C#" MasterPageFile="~/Layout/MasterPage.master" AutoEventWireup="true" CodeFile="Index.aspx.cs" Inherits="ASP_Page_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentMaster" runat="Server">
    <section class="content">
        <div class="container-fluid">
            <div class="block-header">
                <h2>DASHBOARD</h2>
            </div>

            <!-- Widgets -->
            <div class="row clearfix">
                <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                    <div class="info-box bg-pink hover-expand-effect">
                        <div class="icon">
                            <i class="material-icons">playlist_add_check</i>
                        </div>
                        <div class="content">
                            <div class="text">NEW TASKS</div>
                            <div class="number count-to" data-from="0" data-to="1997" data-speed="2000" data-fresh-interval="100"></div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                    <div class="info-box bg-cyan hover-expand-effect">
                        <div class="icon">
                            <i class="material-icons">help</i>
                        </div>
                        <div class="content">
                            <div class="text">NEW TICKETS</div>
                            <div class="number count-to" data-from="0" data-to="257" data-speed="1000" data-fresh-interval="20"></div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                    <div class="info-box bg-light-green hover-expand-effect">
                        <div class="icon">
                            <i class="material-icons">forum</i>
                        </div>
                        <div class="content">
                            <div class="text">NEW COMMENTS</div>
                            <div class="number count-to" data-from="0" data-to="243" data-speed="1000" data-fresh-interval="20"></div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                    <div class="info-box bg-orange hover-expand-effect">
                        <div class="icon">
                            <i class="material-icons">person_add</i>
                        </div>
                        <div class="content">
                            <div class="text">NEW VISITORS</div>
                            <div class="number count-to" data-from="0" data-to="1225" data-speed="1000" data-fresh-interval="20"></div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- #END# Widgets -->
            <!-- CPU Usage -->
            <div class="row clearfix">
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div class="card">
                        <div class="header">
                            <div class="row clearfix">
                                <div class="col-xs-12 col-sm-6">
                                    <h2>CPU USAGE (%)</h2>
                                </div>
                                <div class="col-xs-12 col-sm-6 align-right">
                                    <div class="switch panel-switch-btn">
                                        <span class="m-r-10 font-12">REAL TIME</span>
                                        <label>OFF<input type="checkbox" id="realtime" checked><span class="lever switch-col-cyan"></span>ON</label>
                                    </div>
                                </div>
                            </div>
                            <ul class="header-dropdown m-r--5">
                                <li class="dropdown">
                                    <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                                        <i class="material-icons">more_vert</i>
                                    </a>
                                    <ul class="dropdown-menu pull-right">
                                        <li><a href="javascript:void(0);">Action</a></li>
                                        <li><a href="javascript:void(0);">Another action</a></li>
                                        <li><a href="javascript:void(0);">Something else here</a></li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                        <div class="body">
                            <div id="real_time_chart" class="dashboard-flot-chart"></div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- #END# CPU Usage -->
            <div class="row clearfix">
                <!-- Visitors -->
                <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">
                    <div class="card">
                        <div class="body bg-pink">
                            <div class="sparkline" data-type="line" data-spot-radius="4" data-highlight-spot-color="rgb(233, 30, 99)" data-highlight-line-color="#fff"
                                data-min-spot-color="rgb(255,255,255)" data-max-spot-color="rgb(255,255,255)" data-spot-color="rgb(255,255,255)"
                                data-offset="90" data-width="100%" data-height="92px" data-line-width="2" data-line-color="rgba(255,255,255,0.7)"
                                data-fill-color="rgba(0, 188, 212, 0)">
                                1,2,3,6,9,8,5,2,3,6,5,4,1,5
                            </div>
                            <ul class="dashboard-stat-list">
                                <li>TODAY
                                    <span class="pull-right"><b>1 200</b> <small>USERS</small></span>
                                </li>
                                <li>YESTERDAY
                                    <span class="pull-right"><b>3 872</b> <small>USERS</small></span>
                                </li>
                                <li>LAST WEEK
                                    <span class="pull-right"><b>26 582</b> <small>USERS</small></span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <!-- #END# Visitors -->
                <!-- Latest Social Trends -->
                <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">
                    <div class="card">
                        <div class="body bg-cyan">
                            <div class="m-b--35 font-bold">LATEST SOCIAL TRENDS</div>
                            <ul class="dashboard-stat-list">
                                <li>#socialtrends
                                    <span class="pull-right">
                                        <i class="material-icons">trending_up</i>
                                    </span>
                                </li>
                                <li>#materialdesign
                                    <span class="pull-right">
                                        <i class="material-icons">trending_up</i>
                                    </span>
                                </li>
                                <li>#adminbsb</li>
                                <li>#freeadmintemplate</li>
                                <li>#bootstraptemplate</li>
                                <li>#freehtmltemplate
                                    <span class="pull-right">
                                        <i class="material-icons">trending_up</i>
                                    </span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <!-- #END# Latest Social Trends -->
                <!-- Answered Tickets -->
                <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">
                    <div class="card">
                        <div class="body bg-teal">
                            <div class="font-bold m-b--35">ANSWERED TICKETS</div>
                            <ul class="dashboard-stat-list">
                                <li>TODAY
                                    <span class="pull-right"><b>12</b> <small>TICKETS</small></span>
                                </li>
                                <li>YESTERDAY
                                    <span class="pull-right"><b>15</b> <small>TICKETS</small></span>
                                </li>
                                <li>LAST WEEK
                                    <span class="pull-right"><b>90</b> <small>TICKETS</small></span>
                                </li>
                                <li>LAST MONTH
                                    <span class="pull-right"><b>342</b> <small>TICKETS</small></span>
                                </li>
                                <li>LAST YEAR
                                    <span class="pull-right"><b>4 225</b> <small>TICKETS</small></span>
                                </li>
                                <li>ALL
                                    <span class="pull-right"><b>8 752</b> <small>TICKETS</small></span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <!-- #END# Answered Tickets -->
            </div>

            <div class="row clearfix">
                <!-- Task Info -->
                <div class="col-xs-12 col-sm-12 col-md-8 col-lg-8">
                    <div class="card">
                        <div class="header">
                            <h2>TASK INFOS</h2>
                            <ul class="header-dropdown m-r--5">
                                <li class="dropdown">
                                    <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                                        <i class="material-icons">more_vert</i>
                                    </a>
                                    <ul class="dropdown-menu pull-right">
                                        <li><a href="javascript:void(0);">Action</a></li>
                                        <li><a href="javascript:void(0);">Another action</a></li>
                                        <li><a href="javascript:void(0);">Something else here</a></li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                        <div class="body">
                            <div class="table-responsive">
                                <table class="table table-hover dashboard-task-infos">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Task</th>
                                            <th>Status</th>
                                            <th>Manager</th>
                                            <th>Progress</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>1</td>
                                            <td>Task A</td>
                                            <td><span class="label bg-green">Doing</span></td>
                                            <td>John Doe</td>
                                            <td>
                                                <div class="progress">
                                                    <div class="progress-bar bg-green" role="progressbar" aria-valuenow="10" aria-valuemin="0" aria-valuemax="100" style="width: 10%"></div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>2</td>
                                            <td>Task B</td>
                                            <td><span class="label bg-blue">To Do</span></td>
                                            <td>John Doe</td>
                                            <td>
                                                <div class="progress">
                                                    <div class="progress-bar bg-blue" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width: 40%"></div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>3</td>
                                            <td>Task C</td>
                                            <td><span class="label bg-light-blue">On Hold</span></td>
                                            <td>John Doe</td>
                                            <td>
                                                <div class="progress">
                                                    <div class="progress-bar bg-light-blue" role="progressbar" aria-valuenow="72" aria-valuemin="0" aria-valuemax="100" style="width: 72%"></div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>4</td>
                                            <td>Task D</td>
                                            <td><span class="label bg-orange">Wait Approvel</span></td>
                                            <td>John Doe</td>
                                            <td>
                                                <div class="progress">
                                                    <div class="progress-bar bg-orange" role="progressbar" aria-valuenow="95" aria-valuemin="0" aria-valuemax="100" style="width: 95%"></div>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>5</td>
                                            <td>Task E</td>
                                            <td>
                                                <span class="label bg-red">Suspended</span>
                                            </td>
                                            <td>John Doe</td>
                                            <td>
                                                <div class="progress">
                                                    <div class="progress-bar bg-red" role="progressbar" aria-valuenow="87" aria-valuemin="0" aria-valuemax="100" style="width: 87%"></div>
                                                </div>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- #END# Task Info -->
                <!-- Browser Usage -->
                <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">
                    <div class="card">
                        <div class="header">
                            <h2>BROWSER USAGE</h2>
                            <ul class="header-dropdown m-r--5">
                                <li class="dropdown">
                                    <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                                        <i class="material-icons">more_vert</i>
                                    </a>
                                    <ul class="dropdown-menu pull-right">
                                        <li><a href="javascript:void(0);">Action</a></li>
                                        <li><a href="javascript:void(0);">Another action</a></li>
                                        <li><a href="javascript:void(0);">Something else here</a></li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                        <div class="body">
                            <div id="donut_chart" class="dashboard-donut-chart"></div>
                        </div>
                    </div>
                </div>
                <!-- #END# Browser Usage -->
            </div>
        </div>
    </section>
    <section class="content">
        <div class="container-fluid">
            <div class="block-header">
                <h2>JQUERY KNOB
                    <small>Taken from <a href="https://github.com/aterrien/jQuery-Knob" target="_blank">github.com/aterrien/jQuery-Knob</a></small>
                </h2>
            </div>

            <!-- Basic Example -->
            <div class="row clearfix">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="card">
                        <div class="header">
                            <h2>BASIC EXAMPLES</h2>
                            <ul class="header-dropdown m-r--5">
                                <li class="dropdown">
                                    <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                                        <i class="material-icons">more_vert</i>
                                    </a>
                                    <ul class="dropdown-menu pull-right">
                                        <li><a href="javascript:void(0);">Action</a></li>
                                        <li><a href="javascript:void(0);">Another action</a></li>
                                        <li><a href="javascript:void(0);">Something else here</a></li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                        <div class="body">
                            <div class="row clearfix">
                                <div class="col-md-2">
                                    <input type="text" class="knob" value="86" data-width="125" data-height="125" data-thickness="0.25" data-fgcolor="#F44336">
                                </div>
                                <div class="col-md-2">
                                    <input type="text" class="knob" value="92" data-width="125" data-height="125" data-thickness="0.25" data-fgcolor="#E91E63">
                                </div>
                                <div class="col-md-2">
                                    <input type="text" class="knob" value="93" data-width="125" data-height="125" data-thickness="0.25" data-fgcolor="#00BCD4">
                                </div>
                                <div class="col-md-2">
                                    <input type="text" class="knob" value="89" data-width="125" data-height="125" data-thickness="0.25" data-fgcolor="#009688">
                                </div>
                                <div class="col-md-2">
                                    <input type="text" class="knob" value="91" data-width="125" data-height="125" data-thickness="0.25" data-fgcolor="#FF9800">
                                </div>
                                <div class="col-md-2">
                                    <input type="text" class="knob" value="93" data-width="125" data-height="125" data-thickness="0.25" data-fgcolor="#9C27B0">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- #END# Basic Example -->
            <!-- Rounded Corners -->
            <div class="row clearfix">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="card">
                        <div class="header">
                            <h2>ROUNDED CORNERS</h2>
                            <ul class="header-dropdown m-r--5">
                                <li class="dropdown">
                                    <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                                        <i class="material-icons">more_vert</i>
                                    </a>
                                    <ul class="dropdown-menu pull-right">
                                        <li><a href="javascript:void(0);">Action</a></li>
                                        <li><a href="javascript:void(0);">Another action</a></li>
                                        <li><a href="javascript:void(0);">Something else here</a></li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                        <div class="body">
                            <div class="row clearfix">
                                <div class="col-md-2">
                                    <input type="text" class="knob" data-linecap="round" value="42" data-width="125" data-height="125" data-thickness="0.25"
                                        data-fgcolor="#F44336">
                                </div>
                                <div class="col-md-2">
                                    <input type="text" class="knob" data-linecap="round" value="56" data-width="125" data-height="125" data-thickness="0.25"
                                        data-fgcolor="#E91E63">
                                </div>
                                <div class="col-md-2">
                                    <input type="text" class="knob" data-linecap="round" value="48" data-width="125" data-height="125" data-thickness="0.25"
                                        data-fgcolor="#00BCD4">
                                </div>
                                <div class="col-md-2">
                                    <input type="text" class="knob" data-linecap="round" value="65" data-width="125" data-height="125" data-thickness="0.25"
                                        data-fgcolor="#009688">
                                </div>
                                <div class="col-md-2">
                                    <input type="text" class="knob" data-linecap="round" value="72" data-width="125" data-height="125" data-thickness="0.25"
                                        data-fgcolor="#FF9800">
                                </div>
                                <div class="col-md-2">
                                    <input type="text" class="knob" data-linecap="round" value="18" data-width="125" data-height="125" data-thickness="0.25"
                                        data-fgcolor="#9C27B0">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- #END# Rounded Corners -->
            <!-- Different Sizes -->
            <div class="row clearfix">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="card">
                        <div class="header">
                            <h2>DIFFERENT SIZES</h2>
                            <ul class="header-dropdown m-r--5">
                                <li class="dropdown">
                                    <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                                        <i class="material-icons">more_vert</i>
                                    </a>
                                    <ul class="dropdown-menu pull-right">
                                        <li><a href="javascript:void(0);">Action</a></li>
                                        <li><a href="javascript:void(0);">Another action</a></li>
                                        <li><a href="javascript:void(0);">Something else here</a></li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                        <div class="body">
                            <div class="row clearfix">
                                <div class="col-md-2">
                                    <input type="text" class="knob" value="86" data-width="90" data-height="90" data-thickness="0.1" data-fgcolor="#F44336">
                                </div>
                                <div class="col-md-2">
                                    <input type="text" class="knob" value="92" data-width="120" data-height="120" data-thickness="0.32" data-fgcolor="#E91E63">
                                </div>
                                <div class="col-md-2">
                                    <input type="text" class="knob" value="93" data-width="120" data-height="120" data-thickness="0.50" data-fgcolor="#00BCD4">
                                </div>
                                <div class="col-md-2">
                                    <input type="text" class="knob" value="89" data-width="80" data-height="80" data-thickness="0.16" data-fgcolor="#009688">
                                </div>
                                <div class="col-md-2">
                                    <input type="text" class="knob" value="91" data-width="75" data-height="75" data-thickness="0.2" data-fgcolor="#FF9800">
                                </div>
                                <div class="col-md-2">
                                    <input type="text" class="knob" value="93" data-width="120" data-height="120" data-thickness="0.12" data-fgcolor="#9C27B0">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- #END# Different Sizes -->
            <!-- Different Angles & Offsets -->
            <div class="row clearfix">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="card">
                        <div class="header">
                            <h2>DIFFERENT ANGLES & OFFSETS</h2>
                            <ul class="header-dropdown m-r--5">
                                <li class="dropdown">
                                    <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                                        <i class="material-icons">more_vert</i>
                                    </a>
                                    <ul class="dropdown-menu pull-right">
                                        <li><a href="javascript:void(0);">Action</a></li>
                                        <li><a href="javascript:void(0);">Another action</a></li>
                                        <li><a href="javascript:void(0);">Something else here</a></li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                        <div class="body">
                            <div class="row clearfix">
                                <div class="col-md-2">
                                    <input type="text" class="knob" value="35" data-width="125" data-height="125" data-thickness="0.25" data-anglearc="250" data-angleoffset="-125"
                                        data-fgcolor="#F44336">
                                </div>
                                <div class="col-md-2">
                                    <input type="text" class="knob" value="45" data-width="125" data-height="125" data-thickness="0.25" data-anglearc="250" data-angleoffset="-305"
                                        data-fgcolor="#E91E63">
                                </div>
                                <div class="col-md-2">
                                    <input type="text" class="knob" value="40" data-width="125" data-height="125" data-thickness="0.25" data-anglearc="250" data-angleoffset="-35"
                                        data-fgcolor="#00BCD4">
                                </div>
                                <div class="col-md-2">
                                    <input type="text" class="knob" value="36" data-width="125" data-height="125" data-thickness="0.25" data-anglearc="250" data-angleoffset="145"
                                        data-fgcolor="#009688">
                                </div>
                                <div class="col-md-2">
                                    <input type="text" class="knob" value="43" data-width="125" data-height="125" data-thickness="0.25" data-anglearc="270" data-angleoffset="-0"
                                        data-fgcolor="#FF9800">
                                </div>
                                <div class="col-md-2">
                                    <input type="text" class="knob" value="52" data-width="125" data-height="125" data-thickness="0.25" data-anglearc="270" data-angleoffset="90"
                                        data-fgcolor="#9C27B0">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- #END# Different Angles & Offsets -->
            <!-- Readonly -->
            <div class="row clearfix">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="card">
                        <div class="header">
                            <h2>READ-ONLY</h2>
                            <ul class="header-dropdown m-r--5">
                                <li class="dropdown">
                                    <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                                        <i class="material-icons">more_vert</i>
                                    </a>
                                    <ul class="dropdown-menu pull-right">
                                        <li><a href="javascript:void(0);">Action</a></li>
                                        <li><a href="javascript:void(0);">Another action</a></li>
                                        <li><a href="javascript:void(0);">Something else here</a></li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                        <div class="body">
                            <div class="row clearfix">
                                <div class="col-md-2">
                                    <input type="text" class="knob" value="42" data-width="125" data-height="125" data-thickness="0.25" data-fgcolor="#F44336"
                                        readonly>
                                </div>
                                <div class="col-md-2">
                                    <input type="text" class="knob" value="56" data-width="125" data-height="125" data-thickness="0.25" data-fgcolor="#E91E63"
                                        readonly>
                                </div>
                                <div class="col-md-2">
                                    <input type="text" class="knob" value="48" data-width="125" data-height="125" data-thickness="0.25" data-fgcolor="#00BCD4"
                                        readonly>
                                </div>
                                <div class="col-md-2">
                                    <input type="text" class="knob" value="65" data-width="125" data-height="125" data-thickness="0.25" data-fgcolor="#009688"
                                        readonly>
                                </div>
                                <div class="col-md-2">
                                    <input type="text" class="knob" value="72" data-width="140" data-height="140" data-thickness="0.20" data-fgcolor="#FF9800"
                                        data-skin="tron" readonly>
                                </div>
                                <div class="col-md-2">
                                    <input type="text" class="knob" value="18" data-width="125" data-height="125" data-thickness="0.25" data-fgcolor="#9C27B0"
                                        data-anglearc="250" data-angleoffset="-125" readonly>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- #END# Readonly -->
            <!-- Tron Style -->
            <div class="row clearfix">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="card">
                        <div class="header">
                            <h2>TRON STYLE</h2>
                            <ul class="header-dropdown m-r--5">
                                <li class="dropdown">
                                    <a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                                        <i class="material-icons">more_vert</i>
                                    </a>
                                    <ul class="dropdown-menu pull-right">
                                        <li><a href="javascript:void(0);">Action</a></li>
                                        <li><a href="javascript:void(0);">Another action</a></li>
                                        <li><a href="javascript:void(0);">Something else here</a></li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                        <div class="body">
                            <div class="row clearfix">
                                <div class="col-md-2">
                                    <input type="text" class="knob" data-skin="tron" value="45" data-width="135" data-height="135" data-thickness="0.2" data-fgcolor="#F44336">
                                </div>
                                <div class="col-md-2">
                                    <input type="text" class="knob" data-skin="tron" value="58" data-width="135" data-height="135" data-thickness="0.2" data-fgcolor="#E91E63">
                                </div>
                                <div class="col-md-2">
                                    <input type="text" class="knob" data-skin="tron" value="45" data-width="135" data-height="135" data-thickness="0.2" data-fgcolor="#00BCD4">
                                </div>
                                <div class="col-md-2">
                                    <input type="text" class="knob" data-skin="tron" value="42" data-width="135" data-height="135" data-thickness="0.2" data-fgcolor="#009688">
                                </div>
                                <div class="col-md-2">
                                    <input type="text" class="knob" data-skin="tron" value="100" data-width="135" data-height="135" data-thickness="0.2" data-anglearc="270"
                                        data-angleoffset="90" data-fgcolor="#FF9800">
                                </div>
                                <div class="col-md-2">
                                    <input type="text" class="knob" data-skin="tron" value="100" data-width="135" data-height="135" data-thickness="0.2" data-anglearc="250"
                                        data-angleoffset="-125" data-fgcolor="#9C27B0">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- #END# Tron Style -->
        </div>
    </section>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FooterMaster" runat="Server">
    <!-- Jquery CountTo Plugin Js -->
    <script src="../../plugins/jquery-countto/jquery.countTo.js"></script>

    <!-- Morris Plugin Js -->
    <script src="../../plugins/raphael/raphael.min.js"></script>
    <script src="../../plugins/morrisjs/morris.js"></script>

    <!-- ChartJs -->
    <script src="../../plugins/chartjs/Chart.bundle.js"></script>

    <!-- Flot Charts Plugin Js -->
    <script src="../../plugins/flot-charts/jquery.flot.js"></script>
    <script src="../../plugins/flot-charts/jquery.flot.resize.js"></script>
    <script src="../../plugins/flot-charts/jquery.flot.pie.js"></script>
    <script src="../../plugins/flot-charts/jquery.flot.categories.js"></script>
    <script src="../../plugins/flot-charts/jquery.flot.time.js"></script>

    <!-- Knob Charts Plugin Js -->
    <script src="../../plugins/jquery-knob/jquery.knob.min.js"></script>
    <!-- Sparkline Chart Plugin Js -->
    <script src="../../plugins/jquery-sparkline/jquery.sparkline.js"></script>

    <!-- Custom Js -->
    <script src="../../js/DanhMuc/index.js"></script>
    <script src="../js/DanhMuc/charts/jquery-knob.js"></script>

</asp:Content>
