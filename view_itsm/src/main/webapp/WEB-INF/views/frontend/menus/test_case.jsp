<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="kr.co.inssuf.itsm.util.*"%>
<%
	// jsp properties
	String titleValue = SessionUtil.getProperties("mes.thema");
	// String pageTitle = SessionUtil.getProperties("mes.company");
	String member_id = SessionUtil.getMemberId(request);
	String member_nm = SessionUtil.getMemberNm(request);
	String dept_cd = SessionUtil.getDeptCd(request);
	String dept_nm = SessionUtil.getDeptNm(request);
	String role_cd = SessionUtil.getRoleCd(request);
	String role_nm = SessionUtil.getRoleNm(request);
	
	String company_cd = SessionUtil.getCompanyCd(request);
	String company_nm = SessionUtil.getCompanyNm(request);
	
	String cmdRequestID = request.getParameter("cmdRequestID");
	
	String request_seq = (String)request.getAttribute("request_seq");
	String request_seq_dtl = (String)request.getAttribute("request_seq_dtl");
// 	String request_id = (String)request.getAttribute("request_id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title><%= titleValue %></title>
<!-- Tell the browser to be responsive to screen width -->
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">

<jsp:include page="/common/header_inc" flush="true">
	<jsp:param name="page_title" value="0" />
</jsp:include>

<jsp:include page="/WEB-INF/views/common/froalaJs.jsp" />
</head>


<link href="/res/itsm/itsm_commStyle.css" type="text/css" rel="stylesheet">
<link href="/res/itsm/itsm_gridStyle.css" type="text/css" rel="stylesheet">

<style>

/*  chart hover */
 .chartHolders svg > g > g:last-child { pointer-events: none }

/* jqGrid Select 박스 (선택 박스) 세로 가운데 정렬 */
#jqgh_grid_user_p_cb, #jqgh_grid_partner_cb {
	padding: 0px;
    text-align: center;
}

.w2field_list {
	background-image: none;
	height: 34px;
}

textarea {
	min-height: 30px;
}

.fr-wrapper {
	border-top: 1px solid #aaaaaa;
	border-radius: 5px;
}

/* 2021 12 01 ★새로 추가 */
/* 2021 12 01 ★새로 추가 */
.w2ui-grid {
	border-radius: 5px;
	border: 2px solid #DDDDDD;
}

/* 컬럼명 전체  */
.w2ui-grid .w2ui-grid-body table .w2ui-head {
	background: #f6f6f6
		url("/res/plugins/jQueryUI/images/ui-bg_glass_100_f6f6f6_1x400.png")
		50% 50% repeat-x;
	border-right: 1px solid #E3E3E3; /* none; */ /* 제목 우측 선 제거 */
	/* 2021 12 01 ★새로 추가 */
	font-family: Trebuchet MS, Tahoma, Verdana, Arial, sans-serif;
	color: #777;
	padding: 6px 0px;
}

/* 레코드 흰색 지정 */
/* 2021 12 01 ★새로 추가 레코드 jqgrid와 같은 색 */
	.w2ui-grid .w2ui-grid-body .w2ui-grid-records table tr.w2ui-even,
	.w2ui-grid .w2ui-grid-body .w2ui-grid-frecords table tr.w2ui-even {
	background-color: #F9F9F9;
}

/* 레코드 왼쪽 선 제거, 하단 선 생성 */
.w2ui-grid .w2ui-grid-body table td {
	border-bottom: 1px solid #D6D5D7;
}

#grid_grid_master_fcolumns .w2ui-head.w2ui-col-expand,
	#grid_grid_main_fcolumns .w2ui-head.w2ui-col-expand,
	#grid_grid_newDown_fcolumns .w2ui-col-select {
	height: 40px;
}

/* 제목 폰트 */
.w2ui-grid .w2ui-grid-body div.w2ui-col-header {
	font-size: 10pt;
	text-align: center;
}

/* 2021 12 02 새로 추가 */
.w2ui-grid .w2ui-grid-body table .w2ui-col-number div, .w2ui-grid .w2ui-grid-body table td.w2ui-grid-data>div
	{
	font-size: 10pt;
}

.border-circle {
	width: 100px; /* 10%; */
/* 	width: 9.9%; */
	border: 5px solid gray;
	border-radius: 50%;
	height: 100px;
}

.border-circle label {
/* 	margin-top: 25px; */
	margin-top: 29px;
}

.circle-row {
	border-bottom: 4px solid gray;
	height: 52px;
}

.etc {
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

.detail_case_div .fr-second-toolbar {
	border-radius: 0px;
}

/* 	$(".fr-second-toolbar").css("display","none"); */
.fr-second-toolbar {
	display: none;
}

/* 	$(".gray-theme.fr-box.fr-basic .fr-element").css("padding","10px"); */
/* .subGridStyle .w2ui-grid .w2ui-grid-body .w2ui-grid-records table tr.w2ui-odd:hover, */
/* 	.subGridStyle .w2ui-grid .w2ui-grid-body .w2ui-grid-frecords table tr.w2ui-odd:hover, */
/* 	.subGridStyle .w2ui-grid .w2ui-grid-body .w2ui-grid-records table tr.w2ui-odd.w2ui-record-hover, */
/* 	.subGridStyle .w2ui-grid .w2ui-grid-body .w2ui-grid-frecords table tr.w2ui-odd.w2ui-record-hover, */
/* 	.subGridStyle .w2ui-grid .w2ui-grid-body .w2ui-grid-records table tr.w2ui-even:hover, */
/* 	.subGridStyle .w2ui-grid .w2ui-grid-body .w2ui-grid-frecords table tr.w2ui-even:hover, */
/* 	.subGridStyle .w2ui-grid .w2ui-grid-body .w2ui-grid-records table tr.w2ui-even.w2ui-record-hover, */
/* 	.subGridStyle .w2ui-grid .w2ui-grid-body .w2ui-grid-frecords table tr.w2ui-even.w2ui-record-hover */
/* 	{ */
/* 	background-color: #F9FBFF; */
/* } */

#grid_main.w2ui-grid .w2ui-grid-body .w2ui-grid-records table tr.w2ui-odd, 
#grid_main.w2ui-grid .w2ui-grid-body .w2ui-grid-frecords table tr.w2ui-odd, 
#grid_master.w2ui-grid .w2ui-grid-body .w2ui-grid-records table tr.w2ui-odd, 
#grid_master.w2ui-grid .w2ui-grid-body .w2ui-grid-frecords table tr.w2ui-odd {
	background-color: #DCDCDC;
}

#grid_main.w2ui-grid .w2ui-grid-body .w2ui-grid-records table tr.w2ui-even, 
#grid_main.w2ui-grid .w2ui-grid-body .w2ui-grid-frecords table tr.w2ui-even, 
#grid_master.w2ui-grid .w2ui-grid-body .w2ui-grid-records table tr.w2ui-even, 
#grid_master.w2ui-grid .w2ui-grid-body .w2ui-grid-frecords table tr.w2ui-even {
	background-color: #EDEDED;
}

.subGridStyle.w2ui-grid .w2ui-grid-body .w2ui-grid-records table tr.w2ui-even, 
.subGridStyle.w2ui-grid .w2ui-grid-body .w2ui-grid-frecords table tr.w2ui-even {
	background-color: #F9F9F9;
}

.subGridStyle.w2ui-grid .w2ui-grid-body .w2ui-grid-records table tr.w2ui-odd, 
.subGridStyle.w2ui-grid .w2ui-grid-body .w2ui-grid-frecords table tr.w2ui-odd {
	background-color: #F9FBFF;
}

.comChartStyle {
/* 	font-size: 12pt; */
	font-size: 8pt;
}

.piechartStyle {
	font-size: 8pt;
}

/* --- */
/* w2grid 각 컬럼 선택시 hover 기능 */
/* .w2ui-grid .w2ui-grid-body table td:hover { */
/* w2grid 각 row 선택시 hover 기능 */

/* .w2ui-grid .w2ui-grid-body .w2ui-odd:hover,  
 .w2ui-grid .w2ui-grid-body .w2ui-even:hover { 
 	background-color: #8C49F5;
} */


/* 
.w2ui-grid .w2ui-grid-body .w2ui-grid-records table tr.w2ui-odd:hover, 
.w2ui-grid .w2ui-grid-body .w2ui-grid-frecords table tr.w2ui-odd:hover, 
.w2ui-grid .w2ui-grid-body .w2ui-grid-records table tr.w2ui-even:hover, 
.w2ui-grid .w2ui-grid-body .w2ui-grid-frecords table tr.w2ui-even:hover
{ 
 	background-color: #8C49F5; 
}
 */
 
 /* 레코드 오버 기능 */
 /* 글자로 hover 기능 2022-01-17- > 내일 화욜에 확인하자 */
 /* 	color: #8C49F5; */
.w2ui-grid .w2ui-grid-body .w2ui-grid-records table tr.w2ui-odd:hover,
.w2ui-grid .w2ui-grid-body .w2ui-grid-records table tr.w2ui-even:hover {
	color: #CD201D;
	font-weight: 700;
}

/* --- */
</style>

<!-- 
<link rel="stylesheet"
	href="/res/plugins/rMateChartH5/Assets/Css/rMateChartH5.css">
<script src="/res/plugins/rMateChartH5/rMateChartH5License.js"></script>
<script src="/res/plugins/rMateChartH5/JS/rMateChartH5.js"></script>
 -->
<script src="https://www.gstatic.com/charts/loader.js"></script>

<body class="hold-transition skin-purple sidebar-mini">
	<div class="wrapper">
		<jsp:include page="/common/top_menu_inc" flush="true">
			<jsp:param name="fb_div" value="F" />
			<jsp:param name="page_title" value="0" />
		</jsp:include>

		<jsp:include page="/common/sidebar_menu_inc" flush="true">
			<jsp:param name="menu_div" value="F" />
			<jsp:param name="selected_menu_p_cd" value="1020" />
			<jsp:param name="selected_menu_cd" value="1042" />
		</jsp:include>

		<div class="content-wrapper">
			<section class="content-header" id="section_header"
				style="padding-bottom: 0px; padding-left: 3%; display:none; ">
				<h1 class="text-bold form-group" style="font-size: 35px;">Case 처리</h1>
			</section>

			<section class="row content">
				<div class="box" style="border-color: #27144a;">
					<input type="hidden" id="hiddenRow"
						class="form-control input-sm border-radius-5">

					<div id="mainDiv" class="col-sm-12"
						style="padding: 0px; padding-top: 15px; display:none;">
<!-- 						style="padding: 0px; padding-top: 15px; display: block;"> -->
						<div class="col-sm-9">
							<div id="c_clickCircle_div" class="row text-center" style="margin: 40px 0px;">
								<div class="row text-center" style="display: inline-block;">
									<input type="hidden" id="clickCircle" name="clickCircle" >
										
									<div id="alt_05_div" class="col-sm-3 border-circle">
										<label id="alt_05_label">Open<br>
											(<span id="alt_05">13</span>)
										</label>
									</div>
									<div class="col-sm-1" style="width: 1%;">
										<div class="row circle-row"></div>
									</div>
	
									<div id="alt_06_div" class="col-sm-3 border-circle">
										<label id="alt_06_label">Accept<br>
											(<span id="alt_06">3</span>)
										</label>
									</div>
									<div class="col-sm-1" style="width: 1%;">
										<div class="row circle-row"></div>
									</div>
	
									<div id="alt_10_div" class="col-sm-3 border-circle">
										<label id="alt_10_label"><span style="margin-left: -9px">Proceeding</span><br>
											(<span id="alt_10">1242</span>)
										</label>
									</div>
<!-- 									<div class="col-sm-1" style="width: 1%;"> -->
<!-- 										<div class="row circle-row"></div> -->
<!-- 									</div> -->
<!-- 									<div id="alt_14_div" class="col-sm-3 border-circle"> -->
<!-- 										<label id="alt_14_label" style="margin-top: 19px;">Deploy (Test)<br> -->
<!-- 											(<span id="alt_14">3</span>) -->
<!-- 										</label> -->
<!-- 									</div> -->
									<div class="col-sm-1" style="width: 1%;">
										<div class="row circle-row"></div>
									</div>
	
									<div id="alt_03_div" class="col-sm-3 border-circle">
										<label id="alt_03_label">Test<br>
											(<span id="alt_03">1242</span>)
										</label>
									</div>
									<div class="col-sm-1" style="width: 1%;">
										<div class="row circle-row"></div>
									</div>
	
									<div id="alt_12_div" class="col-sm-3 border-circle">
										<label id="alt_12_label" style="margin-top: 19px;">
											User Confirm<br>(<span id="alt_12">1242</span>)
										</label>
									</div>
									
									<div class="col-sm-1" style="width: 1%;">
										<div class="row circle-row"></div>
									</div>
									
									<div id="alt_15_div" class="col-sm-3 border-circle">
										<label id="alt_15_label">Deploy<br>
											(<span id="alt_15">0</span>)
										</label>
									</div>
									<div class="col-sm-1" style="width: 1%;">
										<div class="row circle-row"></div>
									</div>
									
<!-- 									<div id="alt_16_div" class="col-sm-3 border-circle"> -->
<!-- 										<label id="alt_16_label" style="margin-top: 19px;">Test (Prod)<br> -->
<!-- 											(<span id="alt_16">0</span>) -->
<!-- 										</label> -->
<!-- 									</div> -->
<!-- 									<div class="col-sm-1" style="width: 1%;"> -->
<!-- 										<div class="row circle-row"></div> -->
<!-- 									</div> -->
									<div id="alt_02_div" class="col-sm-3 border-circle">
										<label id="alt_02_label">Closed<br>
											(<span id="alt_02">0</span>)
										</label>
									</div>
									<div class="col-sm-1" style="width: 1%;">
										<div class="row circle-row"></div>
									</div>
	
									<div id="Hold_div" class="col-sm-3 border-circle">
										<label id="Hold_label">Hold<br>
											(<span id="Hold">1242</span>)
										</label>
									</div>
								</div>
							</div>

							<div id="searchRow" class="row form-group" style="margin-bottom: 4px;">
								<input type="hidden" id="sysInfo" name="sysInfo">
								<input type="hidden" id="priorityCode" name="priorityCode">
								<input type="hidden" id="getDateCode" name="getDateCode">
								
								<div class="col-sm-3 no-padding" style="width:184px;">
									<div class="" style="width: 260px; margin-top: 5px;">
									<label class="col-sm-6 radio_1" style="padding: none;">
				                  		| 최근1년&nbsp;&nbsp; Y
					               		<input type="radio" name="rdo_all_data_yn" class="flat-red rdo_all_data_yn1" value="N" checked>
					                </label>
					                <label class="col-sm-6 radio_2" style="padding: none;">
					                	N
					               		<input type="radio" name="rdo_all_data_yn" class="flat-red rdo_all_data_yn2" value="Y">
					                </label>
									</div>
								</div>
								
								<div class="col-sm-3" style="width: 180px;">
									<label style="margin-top: 5px">| 처리자 </label>
									<select id="sel_owner" name="sel_owner"
										onchange="loadList();" style="height: 30px; width: 103px; float: right; margin-right: -9px;" 
										class="col-sm-12 selectbox color-black form-control border-radius-5">
									</select>
								</div>
								<div class="col-sm-3 no-padding" style="width: 176px; margin-right: 10px; margin-left: 7px;">
									<label style="margin-top: 5px">| 상태</label> <select id="status_nm_info" name="status_nm_info"
										onchange="loadList();" style="height: 30px; width: 137px; float: right; margin-right: -9px;" 
										class="col-sm-12 selectbox color-black form-control border-radius-5">
									</select>
								</div>
								<div class="col-sm-3 no-padding" style="width: 200px; margin-right: 10px; margin-left: 7px;">
									<label style="margin-top: 5px">| 통제 분류</label> <select id="sel_ct_gubun" name="sel_ct_gubun"
										onchange="loadList();" style="height: 30px; width: 137px; float: right; margin-right: -9px;" 
										class="col-sm-12 selectbox color-black form-control border-radius-5">
									</select>
								</div>
							</div>
							<div class="row" style="margin-top: 15px;">
								<div class="col-sm-3 no-padding" style="width: 300px; margin-left:16px;">
									<label style="float:left; margin-top: 5px;">| 요청일</label>
									<div class="input-group" style="right: 26px;">
										<input type="text" id="process_date" placeholder="날짜 선택" style="width: 178px; float:right;"
											onkeypress="if(event.keyCode==13) {loadList(); return false;}"
											class="form-control input-sm border-radius-5 range_date">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
									</div>
								</div>
								
								<div class="col-sm-3 no-padding" style="width: 300px; margin-left:11px; right: 20px;">
									<label style="float:left; margin-top: 5px;">| 처리일</label>
									<div class="input-group" style="right: 26px;">
										<input type="text" id="date_updated" placeholder="날짜 선택" style="width: 178px; float:right;"
											onkeypress="if(event.keyCode==13) {loadList(); return false;}"
											class="form-control input-sm border-radius-5 range_date">
										<div class="input-group-addon">
											<i class="fa fa-calendar"></i>
										</div>
									</div>
								</div>
								<div class="col-sm-3" style="width: 377px; right: 44px">
									<label style="float:left; margin-top: 5px; margin-right: 13px;">| 검색</label>
									<div class="col-sm-8 text-right no-padding" style="width: 150px;">
										<input type="text" id="hap_search" name="hap_search"
											placeholder="" style="height: 30px;" 
											onkeypress="if(event.keyCode==13) {loadList(); return false;}"
											class="form-control input-sm border-radius-5 w2field_list">
									</div>
									<div class="col-sm-4 text-right" style="width: 150px;padding-left: 0px;">
										<button type="button" id="" onclick="loadList();"
											class="btn btn-danger btn-sm">검색</button>
										<button type="button" id="" onclick="fnResetChart();"
											class="btn btn-danger btn-sm">검색 초기화</button>
									</div>
								</div>
								<div class="col-sm-3 no-padding" style="width: 137px; right: 54px;">
									<div class="col-sm-4" style="width: 150px; padding-left: 0px; width: 200px;">
										<label>| 내보내기</label> 
										<button type="button" id="btn_mcode_add"
										class="btn btn-danger btn-sm" onclick="excelFileDownload();">Export</button>
										<label style="margin-left: 5px;"><input type="checkbox" id="chk_top"> 상세 </label>
									</div>
								</div>
								<div class="text-right"
									style="padding-right: 15px; line-height: 30px;">
<!-- 									style="padding-right: 15px; line-height: 56px;"> -->
									<button type="button" id="" onclick="fnCaseAdd();"
										style="vertical-align: bottom;" class="btn btn-danger btn-sm">새 Case</button>
								</div>
							</div>

							<div class="row" style="margin-top: 15px;">
								<div class="col-md-12">
									<div id="grid_main" style="width: 100%; min-height: 460px;"></div>
								</div>
							</div>
						</div>
						<!-- Left Main Div -->

						<div class="col-sm-3">
							<div class="col-sm-12"
								style="border: 1px solid #CCCCCC; min-height: 60px; height: 100%; padding-top: 10px; margin-bottom: 10px;">
								<!-- 
						<div class="col-sm-12 text-right" style="padding: 5px 0px">
		            		<button type="button" id="" onclick="fnResetChart();"
		            			class="btn btn-danger btn-sm">Reset</button>
		            	</div>
		            	 -->
								<div class="col-sm-12"
									style="border: 1px solid #CCCCCC; margin-bottom: 10px;">
									<div class="box-header with-border form-group"
										style="padding: 5px;">
										<h3 class="box-title text-bold">완료 기한</h3>
									</div>
									<div class="col-sm-12 no-padding">
										<div id="chartHolder1" class="chartHolders" 
											style="width: 100%; height: 150px; text-align: center; overflow-x: hidden; overflow-y: hidden;"></div>
									</div>
								</div>

								<div class="col-sm-12"
									style="border: 1px solid #CCCCCC; margin-bottom: 10px;">
									<div class="box-header with-border form-group"
										style="padding: 5px;">
										<h3 class="box-title text-bold">중요도</h3>
									</div>
									<div class="col-sm-12 no-padding">
										<div id="chartHolder2" class="chartHolders" 
											style="width: 100%; height: 150px; text-align: center; overflow-x: hidden; overflow-y: hidden;"></div>
											<!-- margin-bottom: 10px; -->
									</div>
								</div>

								<div class="col-sm-12"
									style="border: 1px solid #CCCCCC; margin-bottom: 10px;">
									<div class="box-header with-border form-group"
										style="padding: 5px;">
										<h3 class="box-title text-bold">요청 대상</h3>
									</div>
									<div class="col-sm-12 no-padding">
										<div id="chartHolder3" class="chartHolders" 
											style="width: 100%; min-height: 250px; text-align: center; margin-bottom: 10px;"></div>
									</div>
								</div>

								<div class="col-sm-12"
									style="border: 1px solid #CCCCCC; margin-bottom: 10px;">
									<div class="box-header with-border form-group"
										style="padding: 5px;">
										<h3 class="box-title text-bold">처리자</h3>
									</div>
									<div class="col-sm-12 no-padding">
										<div id="chartHolder4" class="chartHolders" 
											style="width: 100%; min-height: 200px; text-align: center; margin-bottom: 10px;"></div>
									</div>
								</div>


							</div>
						</div>
						<!-- Right Main Div -->
					</div>
					<!-- Main Div -->

					<div id="selDiv" class="col-sm-12"
						style="padding: 0px; padding-top: 15px; display: none;">
						<input type="hidden" id="grid_name" disabled="disabled" /> <input
							type="hidden" id="sel_request_id" disabled="disabled" /> <input
							type="hidden" id="sel_gubun" disabled="disabled" />

						<div id="detail_div" class="row">
							<!--  style="box-shadow: 0 1px 1px rgb(0 0 0 / 10%);" -->
							<input type="hidden" id="sel_request_seq" disabled="disabled" />
							<input type="hidden" id="sel_service_process_id" disabled="disabled" /> 
							<input type="hidden" id="sel_service_process_seq" disabled="disabled" />

							<div id="detail_left_div" class="col-sm-8 form-group">

								<div id="detail_caseInfo_div" class="col-sm-12 form-group"
									style="border: 1px solid #DCDCDC;">
									<div class="box-header with-border" style="padding: 10px 0px;">
										<h3 class="box-title text-bold">Case 정보</h3>
									</div>

									<div class="row form-group" style="margin-top: 10px;">
										<div class="col-sm-5 no-padding" style="width: 33%;">
											<div class="col-sm-12">
												<label>| 제목</label>
											</div>
											<div class="col-sm-12">
												<input type="text" id="detail_title" value=""
													disabled="disabled"
													class="form-control input-sm border-radius-5 list_check"
													maxlength="200" />
											</div>
										</div>

										<div class="col-sm-2 no-padding" style="width: 134px;"><!-- width: 160px; > 18%; -->
											<div class="col-sm-12 no-padding">
												<label>| 상태</label>
											</div>
											<div class="col-sm-12 no-padding">
												<input type="hidden" id="detail_status" disabled="disabled" />
												<input type="text" id="detail_status_nm" value=""
													disabled="disabled"
													class="form-control input-sm border-radius-5 list_check"
													maxlength="200" />
											</div>
										</div>

										<div class="col-sm-3 no-padding" style="width: 210px; width: 20%;">
											<div class="col-sm-12">
												<label>| 작업 분류</label>
											</div>

											<div class="col-sm-12">
												<select id="detail_sel_process" name="sel_process"
													onchange="loadPrForm();" style="height: 30px;"
													class="col-sm-12 selectbox color-black form-control border-radius-5">
												</select>
											</div>
										</div>
										
										<div class="col-sm-3 no-padding" style="width: 152px;">
											<div class="col-sm-12" style="padding-left: 0px;">
												<label>| 통제 분류</label>
											</div>

											<div class="col-sm-12" style="padding-left: 0px;">
												<select id="detail_sel_control" name="sel_control"
													onchange="fnContronChange();" style="height: 30px;"
													class="col-sm-12 selectbox color-black form-control border-radius-5">
												</select>
											</div>
										</div>
										
										<div class="col-sm-2 no-padding" style="width: 95px;"> 
											<div class="col-sm-12 no-padding">
												<label>| 작업 중요도</label>
											</div>
											
											<div class="col-sm-12 no-padding" style="width: 95px;">
												<select id="detail_sel_priority2" name="sel_priority2" style="height: 30px;" 
													class="col-sm-12 selectbox color-black form-control border-radius-5">
													<option value="h">상</option>
													<option value="m">중</option>
													<option value="l">하</option>
												</select>	
											</div>
										</div>
										
										<div class="col-sm-2 no-padding" style="width: 122px;"> <!-- (no-padding)95px > 122px; -->
											<div class="col-sm-12 ">
												<label>| 예상 완료일</label>
											</div>

											<div class="col-sm-12" style="width: 122px;">
												<input type="text" id="detail_plan_due_date" maxlength="10" autocomplete="off"
													class="form-control input-sm border-radius-5 single_date" />
											</div> <!-- autocomplete="off" -->
										</div>
										
										
									</div>
								</div>

								<div id="detail_desc_div" class="col-sm-12 no-padding"
									style="border: 1px solid #DCDCDC;">
									<div class="box-header with-border" style="padding: 10px;">
										<div class="col-sm-6 text-left no-padding">
											<h3 class="box-title text-bold">단계 상세</h3>
										</div>
										<div class="col-sm-6 text-right no-padding">
											<button type="button" id="btn_detail_done"
												style="line-height: 12px;" class="btn btn-danger btn-sm"
												onclick="fnDetailStatus();">
												In Progress
											</button>
										</div>
									</div>

									<div class="row" style="margin-top: 10px;">
										<div class="col-sm-12 form-group">
											<div class="col-sm-2" style="line-height: 25px; width: 80px;"> <!--  width: 8%; -->
												<label>| 단계</label>
											</div>
											<div class="col-sm-2 no-padding" style="width: 20%; width: 180px;">
												<select id="detail_sel_levelType" name="sel_levelType"
													onchange="checkWorkStatus();" disabled="disabled"
													class="col-sm-12 selectbox color-black form-control border-radius-5">
												</select>
											</div>


											<div class="col-sm-2" style="line-height: 25px; width: 90px;"> <!--  width: 10%; -->
												<label>| 상태</label>
											</div>
											<div class="col-sm-2 no-padding" style="width: 200px;"> <!-- width: 23%; -->
												<input type="hidden" id="detail_old_status" disabled="disabled" />
												<input type="hidden" id="detail_old_status_nm" value=""
													disabled="disabled"
													class="form-control input-sm border-radius-5 list_check"
													maxlength="200" />
											
												<input type="hidden" id="detail_done_status"
													disabled="disabled"
													class="form-control input-sm border-radius-5" /> 
												<input
													type="text" id="detail_done_status_nm" value=""
													disabled="disabled"
													class="form-control input-sm border-radius-5 list_check"
													maxlength="200" />
											</div>

											<div class="col-sm-2" style="line-height: 25px; width: 80px;"> <!--  width: 10%; -->
												<label>| 처리자</label>
											</div>
											<div class="col-sm-2 no-padding" style="width: 145px;"> <!-- width: 23%; -->
												<input type="hidden" id="detail_owner_id"
													disabled="disabled"
													class="form-control input-sm border-radius-5" /> <input
													type="text" id="detail_owner_nm" disabled="disabled"
													class="form-control input-sm border-radius-5" />
											</div>
											
											<div class="col-sm-2 partner_div" style="line-height: 25px; width: 90px;">
												<label>| 협력사</label>
											</div>
											<div class="col-sm-2 no-padding partner_div" style="width: 200px;">
												<input type="hidden" id="detail_partner_id"
													disabled="disabled"
													class="form-control input-sm border-radius-5" /> <input
													type="text" id="detail_partner_nm" disabled="disabled"
													class="form-control input-sm border-radius-5" />
											</div>

										</div>
									</div>

									<div class="row ">
										<div class="col-sm-12 form-group">
											<div class="col-sm-12 detail_case_div">
												<textarea id='desc_case_1' style="margin-top: 30px;"
													placeholder="Type some text">
					                    		</textarea>
											</div>
											<div class="col-sm-12">
												<div class="col-sm-12 no-padding" style="border: 1px solid #CCCCCC; border-top: none; min-height: 60px; height: 100%;
													border-bottom-left-radius: 5px; border-bottom-right-radius: 5px;">
													
													<table class="col-sm-12 no-padding" style="min-height: 60px;">
														<tr>
															<td class="col-sm-2 text-center no-padding" style="vertical-align: middle; border-right: 1px solid #EFEFEF;">
																첨부 자료
															</td>
															
															<td class="col-sm-8">
																<div id="append_down" class="row" style="padding-top: 5px;">
																</div>
															</td>
															
															<td class="col-sm-2 text-center no-padding" style="vertical-align: middle; border-left: 1px solid #EFEFEF;">
																<div id="progress" class="progress"
																	style="margin: 0px; display: none;">
																	<div class="progress-bar progress-bar-warning"></div>
																</div>
				
																<div class="col-sm-12 text-center">
																	<span
																		class="btn btn-danger btn-sm fileinput-button file_group_span btnEditDown">
																		자료 첨부 <input id="file_group" class="fileupload"
																		type="file" name="files[]" multiple="multiple">
																	</span>
																</div>
															</td>
															
														</tr>
													</table>
													
													<!-- 
													<div class="col-sm-2 text-center" style="padding-top: 5px;">
														<label>Attachements</label>
													</div>
													<div class="col-sm-8"
														style="border-left: 1px solid #CCCCCC; border-right: 1px solid #CCCCCC; min-height: 60px;">
														<div id="append_down" class="row"
															style="padding-top: 5px;">
															<div id="div_ap_down_1" class="col-sm-12 form-group"
																style="margin-bottom: 5px;">
																<span id="span_ap_down_1" style="padding-right: 5px;">1.</span>
																<span style="padding-right: 5px; color: #74A4BB;">Attached
																	File No.1.pdf</span>
																<button type="button" id="btn_del_down_1"
																	class="btn btn-danger btn-sm"
																	style="line-height: 10px;" onclick="delDown('1');">Del</button>
															</div>

															<div id="div_ap_down_2" class="col-sm-12 form-group"
																style="margin-bottom: 5px;">
																<span id="span_ap_down_2" style="padding-right: 5px;">2.</span>
																<span style="padding-right: 5px; color: #74A4BB;">Attached
																	File No.2.pdf</span>
																<button type="button" id="btn_del_down_2"
																	class="btn btn-danger btn-sm"
																	style="line-height: 10px;" onclick="delDown('2');">Del</button>
															</div>
														</div>
													</div>

													<div class="col-sm-2" style="padding-top: 5px;">
														<div id="progress" class="progress"
															style="margin: 0px; display: none;">
															<div class="progress-bar progress-bar-warning"></div>
														</div>

														<div class="col-sm-12 text-center">
															<span
																class="btn btn-danger btn-sm fileinput-button file_group_span btnEditDown">
																Attach File <input id="file_group" class="fileupload"
																type="file" name="files[]" multiple="multiple">
															</span>
														</div>
													</div>
													 -->
												</div>
											</div>

										</div>
									</div>
								</div>


							</div>

							<div id="detail_right_top_div" class="col-sm-4 form-group"
								style="padding-left: 0px;">
								<div id="detail_btn_div" class="col-md-12 no-padding form-group"
									style="border: 1px solid #DCDCDC; min-height: 128px;">

									<div class="box-header with-border">
										<h3 class="box-title text-bold">기능</h3>
									</div>

									<div class="col-md-12" style="padding: 10px;">
										<div class="box-tools pull-left">
											<!-- <button type="button" id="detail_next_btn" 
										class="btn btn-danger btn-sm" onclick="fnNextBtn();">
										Next</button> 미션중-->
											<input class="" type="text" id="input_text" value="" style="display:none">
											<input class="" type="text" id="input_text_dtl" value="" style="display:none">
<!-- 										<textarea class="hidden" id="textArea"></textarea> -->
											<button type="button" id="detail_save_btn"
												class="btn btn-primary btn-sm" onclick="saveCaseInfo();">
												저장</button>
											<button type="button" id=""
												class="btn btn-primary btn-sm" onclick="copyLink();">
											Link 복사</button>

											<button type="button" id="detail_delete_btn"
												class="btn btn-danger btn-sm " onclick="deleteCaseInfo();">
												삭제</button>
												
											<button type="button" id="detail_owner_btn"
												class="btn btn-danger btn-sm " onclick="openUser('owner');"> <!-- onclick="openCaseOwner();" -->
												처리자 변경</button>
										</div>
									</div>
									
									<div class="col-md-12" style="padding: 10px;">
										<span id="save_check" style="color: red; display: none;"></span>
									</div>
								</div>

								<div id="detail_requestInfo_div"
									class="col-md-12 no-padding form-group"
									style="border: 1px solid #DCDCDC;">
									<div class="box-header with-border form-group">
										<h3 class="box-title text-bold">요청 분류</h3>
									</div>
									<div class="col-sm-12 form-group no-padding"
										style="padding-right: 15px !important;">
										<div class="col-sm-4" style="padding-right: 0px;">
											<label>| 대분류</label>
										</div>
										<div class="col-sm-4" style="padding-right: 0px;">
											<label>| 중분류</label>
										</div>

										<div class="col-sm-4" style="padding-right: 0px;">
											<label>| 소분류</label>
										</div>

										<div class="col-sm-4" style="padding-right: 0px;">
											<select id="detail_selR_type" name="selR_type" onchange="fnChangeType();"
												class="selRequest col-sm-12 selectbox color-black form-control border-radius-5">
											</select>
										</div>
										<div class="col-sm-4" style="padding-right: 0px;">
											<select id="detail_selR_category" name="selR_category" onchange="fnChangeCategory();"
												class="selRequest col-sm-12 selectbox color-black form-control border-radius-5">
											</select>
										</div>
										<div class="col-sm-4" style="padding-right: 0px;">
											<select id="detail_selR_categoryItem" name="selR_categoryItem" onchange="fnChangeCategoryItem();"
												class="selRequest col-sm-12 selectbox color-black form-control border-radius-5">
											</select>
										</div>
									</div>

									<div class="col-sm-12 form-group no-padding"
										style="padding-right: 15px !important;">
										<div class="col-sm-4" style="padding-right: 0px;">
											<label>| 대상</label>
										</div>
										<div class="col-sm-4" style="padding-right: 0px;">
											<label>| 중요도</label>
										</div>
										<div class="col-sm-4" style="padding-right: 0px;">
											<label>| 희망 완료일</label>
										</div>

										<div class="col-sm-4" style="padding-right: 0px;">
											<select id="detail_sel_syInfo" name="sel_syInfo"
												disabled="disabled"
												class="col-sm-12 selectbox color-black form-control border-radius-5">
											</select>
										</div>

										<div class="col-sm-4" style="padding-right: 0px;">
											<select id="detail_sel_priority" name="sel_priority"
												class="col-sm-12 selectbox color-black form-control border-radius-5">
												<option value="h">상</option>
												<option value="m">중</option>
												<option value="l">하</option>
											</select>
										</div>

										<div class="col-sm-4" style="padding-right: 0px;">
											<input type="text" id="detail_request_due_date" value=""
												class="form-control input-sm border-radius-5 single_date"
												maxlength="200" />
										</div>

									</div>

								</div>

								<div id="detail_history_div"
									class="col-md-12 no-padding form-group"
									style="border: 1px solid #DCDCDC;">
									<!-- max-height: 240px;  -->
									<div style="overflow-y: auto; overflow-x: hidden;">
										<div class="box-header with-border form-group"
											style="padding: 5px; padding-left: 0px;">
											<div class="col-sm-6 text-left" style="line-height: 30px;">
												<h3 class="box-title text-bold">Case 이력</h3>
											</div>
											<div class="col-sm-6 text-right no-padding">
												<button type="button" id="btn_detail_next_history"
													class="btn btn-danger btn-sm" onclick="fnNextCase();">새 단계 Case</button>
											</div>
										</div>

										<div class="col-sm-12 form-group">
											<!-- 167px --><!--  border-bottom: none; -->
											<div id="grid_master" style="width: 100%; min-height: 76px; border-bottom-left-radius: 0px; border-bottom-right-radius: 0px;"></div>
											<div id="subGridO" class="subGridStyle" style="width: 100%; min-height: 123px; border-top: none; border-top-left-radius: 0px; border-top-right-radius: 0px;"></div>
										</div>
									</div>
								</div>
								<!-- 
								<div id="edit_cmt_div" class="form-group"
									style="overflow-y: auto; overflow-x: hidden; padding: 10px; border: 1px solid #CCCCCC">
								 -->
								
								<div id="edit_cmt_div" class="col-sm-12 no-padding form-group" >
									
									
									<div id="edit_appr_div" style="border: 1px solid #DCDCDC;">
										<div class="box-header with-border form-group"
											style="padding: 5px; padding-left: 0px;">
											<div class="col-sm-8 text-left" style="line-height: 30px;">
												<h3 class="box-title text-bold">승인</h3>
											</div>
											<div class="col-sm-4 text-right no-padding">
												<!-- 서브만( fnSelDivD() ), 상관없이 (헤더가 (승인 요청), (협업 요청), (보류), (완료) 상태면 x) -->
												<button type="button" id="edit_apprI_btn"
													class="btn btn-danger btn-sm" onclick="apprCheck('edit');">승인 추가</button>
											</div>
										</div>

										<div class="row" style="min-height: 70px;">

											<div id="edit_appr_status_div"
												class="col-sm-12 form-group text-right">
												<div class="col-sm-12">
<!-- 													<label style="margin: 0px 5px;">| Status</label>  -->
													<input
														type="hidden" id="edit_appr_status" disabled="disabled"
														class="form-control input-sm border-radius-5" /> 
													<input
														type="text" id="edit_appr_status_nm" disabled="disabled"
														style="display: none; width: 150px; margin: 0px 5px;"
														class="form-control input-sm border-radius-5" />
													<!-- display: inline; -->
													<button type="button" id="edit_apprRst_btn"
														class="btn btn-danger btn-sm"
														onclick="fnAppEditStatus('승인 취소');">요청 회수</button>
														
													<button type="button" id="edit_appr_btn"
														class="btn btn-danger btn-sm"
														onclick="fnAppEditStatus('승인');">승인</button>

													<button type="button" id="edit_apprX_btn"
														class="btn btn-danger btn-sm"
														onclick="fnAppEditStatus('반려');">반려</button>
												</div>
											</div>

											<div id="edit_comment_approver" class="col-sm-12 form-group">
												<div class="col-sm-12 text-left no-padding">
													<div class="col-sm-4 no-padding">
														<div class="col-sm-12" style="line-height: 25px;">
															<label>| 요청자</label>
														</div>
														<div class="col-sm-12">
															<input type="hidden" id="edit_appr_requester_id"
																disabled="disabled"
																class="form-control input-sm border-radius-5" /> <input
																type="text" id="edit_appr_requester_nm"
																disabled="disabled"
																class="form-control input-sm border-radius-5" />
														</div>
													</div>

													<div class="col-sm-8 no-padding">
														<div class="col-sm-7">
															<label>| 요청 의견</label>
														</div>
														<div class="col-sm-5">
															<input type="text" id="edit_appr_req_date"
																disabled="disabled"
																class="form-control input-sm border-radius-5"
																style="font-size: 8pt; padding: 0px; text-align: center; height: 25px; margin-bottom: 5px;" />
														</div>

														<div class="col-sm-12">
															<textarea id="edit_appr_req_comment"
																class="form-control input-sm pull-right clear_val border-radius-5"
																rows="1" maxlength="200"
																style="resize: none; font-size: 10pt;"
																oninput="maxLengthCheck(this);"></textarea>
														</div>
													</div>

												</div>
											</div>

											<div id="edit_comment_approver2" class="col-sm-12">
												<div class="col-sm-4 no-padding">
													<div class="col-sm-12" style="line-height: 25px;">
														<label>| 승인자</label>
													</div>
													<div class="col-sm-12">
														<input type="hidden" id="edit_appr_approver_id"
															disabled="disabled"
															class="form-control input-sm border-radius-5" /> <input
															type="text" id="edit_appr_approver_nm"
															disabled="disabled"
															class="form-control input-sm border-radius-5 form-group" />
													</div>
												</div>

												<div id="edit_responseCmtDiv" class="col-sm-8 no-padding">
													<div class="col-sm-7">
														<label>| 승인 의견</label>
													</div>
													<div class="col-sm-5">
														<input type="text" id="edit_appr_rep_date"
															disabled="disabled"
															class="form-control input-sm border-radius-5"
															style="font-size: 8pt; padding: 0px; text-align: center; height: 25px; margin-bottom: 5px;" />
													</div>
													<div class="col-sm-12">
														<textarea id="edit_appr_rep_comment"
															class="form-control input-sm pull-right clear_val border-radius-5"
															rows="1" maxlength="200"
															style="resize: none; font-size: 10pt;"
															oninput="maxLengthCheck(this);"></textarea>
													</div>
												</div>

											</div>

										</div>
									</div>

									<!-- request -->
									<div id="edit_request_div" style="border: 1px solid #DCDCDC;">
										<!--  margin-top: 10px; -->
										<div class="box-header with-border">
											<h3 class="box-title text-bold">확인 요청</h3>
										</div>
										<div class="row" style="margin-top: 10px;">

											<div id="edit_request_status_div"
												class="col-sm-12 form-group text-right">
												<div class="col-sm-12">
<!-- 													<label>| Status</label>  -->
													<input type="hidden"
														id="edit_request_status" disabled="disabled"
														class="form-control input-sm border-radius-5" /> 
													<input
														type="text" id="edit_request_status_nm"
														disabled="disabled"
														style="display: inline; width: 150px; margin: 0px 5px;"
														class="form-control input-sm border-radius-5" />
												</div>
											</div>

											<div class="col-sm-12 form-group">
												<div class="col-sm-12 text-left no-padding">
													<div class="col-sm-4 no-padding">
														<div class="col-sm-12" style="line-height: 25px;">
															<label>| 처리자</label>
														</div>
														<div class="col-sm-12">
															<input type="hidden" id="edit_request_requester_id"
																disabled="disabled"
																class="form-control input-sm border-radius-5" /> <input
																type="text" id="edit_request_requester_nm"
																disabled="disabled"
																class="form-control input-sm border-radius-5" />
														</div>
													</div>

													<div class="col-sm-8 no-padding">
														<div class="col-sm-7">
															<label>| 처리 의견</label>
														</div>
														<div class="col-sm-5">
															<input type="text" id="edit_request_req_date"
																disabled="disabled"
																class="form-control input-sm border-radius-5"
																style="font-size: 8pt; padding: 0px; text-align: center; height: 25px; margin-bottom: 5px;" />
														</div>
														<div class="col-sm-12">
															<textarea id="edit_request_req_comment"
																disabled="disabled"
																class="form-control input-sm pull-right clear_val"
																rows="1" maxlength="200"
																style="resize: none; font-size: 10pt;"
																oninput="maxLengthCheck(this);"></textarea>
														</div>
													</div>

												</div>
											</div>

											<div class="col-sm-12 form-group">
												<div class="col-sm-4 no-padding">
													<div class="col-sm-12" style="line-height: 25px;">
														<label>| 확인자</label>
													</div>
													<div class="col-sm-12">
														<input type="text" id="edit_request_approver_nm"
															disabled="disabled"
															class="form-control input-sm border-radius-5" />
													</div>
												</div>

												<div id="edit_responseCmtDiv" class="col-sm-8 no-padding">
													<div class="col-sm-7">
														<label>| 확인 의견</label>
													</div>
													<div class="col-sm-5">
														<input type="text" id="edit_request_rep_date"
															disabled="disabled"
															class="form-control input-sm border-radius-5"
															style="font-size: 8pt; padding: 0px; text-align: center; height: 25px; margin-bottom: 5px;" />
													</div>
													<div class="col-sm-12">
														<textarea id="edit_request_rep_comment"
															disabled="disabled"
															class="form-control input-sm pull-right clear_val"
															rows="1" maxlength="200"
															style="resize: none; font-size: 10pt;"
															oninput="maxLengthCheck(this);"></textarea>
													</div>
												</div>

											</div>

										</div>
									</div>
								</div>

								<!-- <div id="new_cmt_div" class="form-group"
									style="overflow-y: auto; overflow-x: hidden; padding: 10px; border: 1px solid #DCDCDC;">
									 -->
								<div id="new_cmt_div" class="col-sm-12 no-padding form-group" >
									
									<div id="new_appr_div" style="border: 1px solid #DCDCDC;">
										<div class="box-header with-border">
											<div class="col-sm-8 text-left no-padding">
												<h3 class="box-title text-bold">승인</h3>
											</div>
											<div class="col-sm-4 text-right no-padding">
												<button type="button" id="new_apprI_btn"
													class="btn btn-danger btn-sm" onclick="apprCheck('new');">승인 추가</button>
											</div>
										</div>

										<div class="row" style="margin-top: 10px; min-height: 70px;">
											<div id="new_comment_approver" class="col-sm-12 form-group">
												<div class="col-sm-4 no-padding form-group">	
													<div class="col-sm-12" style="line-height: 25px;"><label>| 요청자</label></div>
													<div class="col-sm-12">
														<input type="text" id="new_appr_requester_nm"
															disabled="disabled"
															class="form-control input-sm border-radius-5" />
													</div>
												</div>
												
<!-- 											<div id="new_comment_approver2" class="col-sm-12 form-group"> -->
												<div class="col-sm-8 no-padding form-group">
													<div class="col-sm-7" style="line-height: 25px;"><label>| 요청 의견</label></div>
													<div class="col-sm-5">
														<input type="text" id="new_appr_req_date"
															disabled="disabled"
															class="form-control input-sm border-radius-5"
															style="font-size: 8pt; padding: 0px; text-align: center; height: 25px; margin-bottom: 5px;" />
													</div>
													<div class="col-sm-12">
														<textarea id="new_appr_req_comment"
															class="form-control input-sm pull-right clear_val border-radius-5"
															rows="1" maxlength="200"
															style="resize: none; font-size: 10pt;"
															oninput="maxLengthCheck(this);"></textarea>
														</div>
												</div>
<!-- 											</div> -->
												
												<div class="col-sm-4 no-padding form-group">	
													<div class="col-sm-12" style="line-height: 25px;"><label>| 승인자</label></div>
													<div class="col-sm-12">
														<input type="hidden" id="new_appr_approver_id"
															disabled="disabled"
															class="form-control input-sm border-radius-5" /> 
														<input
															type="text" id="new_appr_approver_nm" disabled="disabled"
															class="form-control input-sm border-radius-5" />
													</div>
												</div>
												
												<div id="new_responseCmtDiv" class="col-sm-8 no-padding">
													<div class="col-sm-7">
														<label>| 승인 의견</label>
													</div>
													<div class="col-sm-5">
														<input type="text" id="new_appr_rep_date"
															disabled="disabled"
															class="form-control input-sm border-radius-5"
															style="font-size: 8pt; padding: 0px; text-align: center; height: 25px; margin-bottom: 5px;" />
													</div>
													<div class="col-sm-12">
														<textarea id="new_appr_rep_comment" disabled="disabled"
															class="form-control input-sm pull-right clear_val border-radius-5"
															rows="1" maxlength="200"
															style="resize: none; font-size: 10pt; min-height: 30px;"
															oninput="maxLengthCheck(this);"></textarea>
													</div>
												</div>
												
											</div>
											
										</div>
									</div>

									<div id="new_request_div" style="border: 1px solid #DCDCDC;">
										<div class="box-header with-border">
											<h3 class="box-title text-bold">확인 요청</h3>
										</div>

										<div class="row" style="margin-top: 10px;">
											<div id="new_comment_request" class="col-sm-12 form-group">
												<div class="col-sm-4 no-padding">
													<div class="col-sm-12" style="line-height: 25px;"><label>| 처리자</label></div>
													<div class="col-sm-12">
														<input type="text" id="new_request_requester_nm"
															disabled="disabled"
															class="form-control input-sm border-radius-5" />
													</div>
												</div>
												
												<div class="col-sm-8 no-padding form-group">
													<div class="col-sm-7" style="line-height: 25px;"><label>| 처리 의견</label></div>
													<div class="col-sm-5">
														<input type="text" id=""
															disabled="disabled"
															class="form-control input-sm border-radius-5"
															style="font-size: 8pt; padding: 0px; text-align: center; height: 25px; margin-bottom: 5px;" />
													</div>
													<div class="col-sm-12 text-left">
														<textarea id="new_request_req_comment"
															class="form-control input-sm pull-right clear_val border-radius-5"
															rows="1" maxlength="200"
															style="resize: none; font-size: 10pt;"
															oninput="maxLengthCheck(this);"></textarea>
													</div>
												</div>
												
												<div class="col-sm-4 no-padding form-group">
													<div class="col-sm-12" style="line-height: 25px;"><label>| 확인자</label></div>
													<div class="col-sm-12">
														<input type="hidden" id="new_request_approver_id"
															disabled="disabled"
															class="form-control input-sm border-radius-5" /> 
														<input type="text" id="new_request_approver_nm"
															disabled="disabled"
															class="form-control input-sm border-radius-5" />
													</div>
												</div>
												
												<div id="new_responseCmtDiv" class="col-sm-8 no-padding">
													<div class="col-sm-7">
														<label>| 확인 의견</label>
													</div>
													<div class="col-sm-5">
														<input type="text" id=""
															disabled="disabled"
															class="form-control input-sm border-radius-5"
															style="font-size: 8pt; padding: 0px; text-align: center; height: 25px; margin-bottom: 5px;" />
													</div>
													<div class="col-sm-12">
														<textarea id="" disabled="disabled"
															class="form-control input-sm pull-right clear_val border-radius-5"
															rows="1" maxlength="200"
															style="resize: none; font-size: 10pt; min-height: 30px;"
															oninput="maxLengthCheck(this);"></textarea>
													</div>
												</div>
											</div>

											
										</div>
									</div>
								</div>
								<!-- 
								<div id="partner_div" class="form-group" style="overflow-y: auto; overflow-x: hidden; 
																				padding: 10px; border: 1px solid #DCDCDC;">
								 -->												
								
								<div id="partner_div" class="col-sm-12 no-padding form-group" >
																				
																				
									<div id="partner_border" style="border: 1px solid #DCDCDC;">
										<div class="box-header with-border">
											<div class="col-sm-8 text-left no-padding">
												<h3 class="box-title text-bold">협력사 참조</h3>
											</div>
											<div class="col-sm-4 text-right no-padding">
												<button type="button" id="btn_partner" class="btn btn-danger btn-sm" 
						            					onclick="openPartner();">협력사 추가</button>
											</div>
										</div>

										<div class="row" style="margin-top: 10px; min-height: 35px;">
											<div class="col-sm-12">
												<div id="append_user" class="col-sm-12 no-padding" 
													style="padding-right: 15px !important;">
													
												</div>
											</div>
										</div>
									</div>
								</div>
								
							</div>
							
						</div>
						<!-- editDiv -->

					</div>

				</div>
			</section>
		</div>
		
		<!-- user -->
		<div class="modal fade" id="modal_user" data-backdrop="static">
			<div class="modal-dialog" style="width: 900px;">
				<!-- 700px -->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="modal_user_title">승인 추가</h4>
					</div>
					<div class="modal-body" id="modal_user_body">
						<div class="box box-warning box-solid">
							<div class="box-header with-border">
								<h3 class="box-title">승인 정보</h3>
								<div class="box-tools pull-right">
									<button type="button" id="btn_user_save"
										onclick="fnUserInsert();" class="btn btn-success btn-sm">Save</button>
								</div>
							</div>

							<div class="box-body">
								<div class="col-sm-12 no-padding">
									<div class="box-body">
										<div class="input-group input-group-sm"
											style="margin-bottom: 15px;">
											<input type="text" id="user_nm_search" name="user_nm_search"
												class="form-control pull-right"
												placeholder="이름 검색"
												onkeypress="if(event.keyCode==13) {fnSearchUserGrid(true); return false;}">
											<div class="input-group-btn">
												<button type="button" id="btn_user_search"
													class="btn btn-default" onclick="fnSearchUserGrid();">
													<i class="fa fa-search"></i>
												</button>
											</div>
										</div>
									</div>
								</div>

								<div class="col-sm-12 no-padding">
									<div id="dv_grid_user" class="box-body form-group">
										<div class="no-padding col-sm-12 text-center" style="">
											<input type="hidden" id="user_gubun" disabled="disabled" />
											<!-- new, edit -->
											<table id="grid_user"></table>
											<div id="grid_user_pager"></div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- user -->
		
		<div class="modal fade" id="modal_partner" data-backdrop="static">
		    <div class="modal-dialog" style="width: 900px;"><!-- 700px -->
		      <div class="modal-content">
		        <div class="modal-header">
		          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		            <span aria-hidden="true">&times;</span>
		          </button>
		         	<h4 class="modal-title">협력사 추가</h4>
		        </div>
		        <div class="modal-body" id="modal_partner_body">
		          <div class="box box-warning box-solid">
		            <div class="box-header with-border">
		              <h3 class="box-title">협력사 정보</h3>
		              <div class="box-tools pull-right">
			              <button type="button" id="btn_partner_save" 
				              	  onclick="fnAddPartner();" 
				              	  class="btn btn-success btn-sm">Save</button>
		              </div>
		            </div>
		
		              <div class="box-body">
		                	<div class="input-group input-group-sm" style="margin-bottom: 15px;">
		                		<input type="text" id="user_nm_search_p" name="user_nm_search_p" 
			                 			onkeypress="if(event.keyCode==13) {fnSearchUserGrid_p(true); return false;}" 
			                 			class="form-control pull-right" placeholder="이름 검색">
								<div class="input-group-btn">
				            		<button type="button" id="btn_user_search_p" 
				            				onclick="fnSearchUserGrid_p();" class="btn btn-default">
				            		<i class="fa fa-search"></i>
				            		</button>
				            	</div>
		                	</div>
		                	
		                	<div class="col-sm-12 no-padding">
		                		
					        	<div id="dv_grid_user_p" class="box-body form-group">
					        		<div class="no-padding col-sm-6 text-left">	
			                			<span class="modal-title">사용자 목록</span>
			                		</div>
			                		<div class="no-padding col-sm-6 text-right form-group">		          
										<span onclick="plus();" class="btn btn-success btn-sm" style="margin-right: 5px; width: 40px;"> 
											<i class="glyphicon glyphicon-plus"></i> 
										</span>
									</div>
									<div class="no-padding col-sm-12 text-center" style="">	
					        			<table id="grid_user_p"></table>
						        		<div id="grid_user_p_pager"></div>
					        		</div>
						        </div>
						        
						        
								<div id="dv_grid_partner" class="box-body form-group">
									<div class="no-padding col-sm-6 text-left">	
			                			<span class="modal-title">협력사 목록</span>
			                		</div>
			                		<div class="no-padding col-sm-6 text-right form-group">
										<span onclick="minus();" class="btn btn-danger btn-sm" style="margin-left: 5px; width: 40px;"> 
											<i class="glyphicon glyphicon-minus"></i> 
										</span>
									</div>
									<div class="no-padding col-sm-12 text-center">	
					        			<table id="grid_partner"></table>
					        		</div>
						        </div>
					        </div>
		              </div>
		          </div>
		        </div>
		      </div>
		    </div>
	  </div>
		

		<jsp:include page="/common/footer_inc" flush="true">
			<jsp:param name="page_title" value="0" />
		</jsp:include>

		<jsp:include page="/common/sidebar_rview_inc" flush="true">
			<jsp:param name="page_title" value="0" />
		</jsp:include>

	</div>

	<script type="text/javascript">
	var member_id 	= "<%=member_id%>";
	var member_nm 	= "<%=member_nm%>";
	var role_cd		= "<%=role_cd%>";
	var role_nm 	= "<%=role_nm%>";
	var dept_cd 	= "<%=dept_cd%>";
	var dept_nm 	= "<%=dept_nm%>";
	
	var company_cd 	= "<%=company_cd%>";
	var company_nm 	= "<%=company_nm%>";
	
	var cmdRequestID = "<%=cmdRequestID%>";
	var page_request_seq = "<%=request_seq%>";
	var page_request_seq_dtl = "<%=request_seq_dtl%>";
<%-- 	var page_request_id = "<%=request_id%>"; --%>
	
	let circleLoadData = { 
		"alt_06" : 0, 
		"alt_02" : 0, 
		"alt_09" : 0, 
		"Hold" : 0, 
		"alt_11" : 0, 
		"alt_05" : 0,
		"alt_10" : 0, 
		"alt_03" : 0, 
		"alt_12" : 0,
		"alt_14" : 0,
		"alt_15" : 0,
		"alt_16" : 0
	};
	
	let usertData;
	
	let levelData = [];
	let controlLevelData = [];
	let controlApprData = [];
	let controlApprData_as = [];
	
	let chartData = [];
	let ownerchartData = [];
	
	let layoutStr_1 = "";
	let dateData = [];
	let chart1;
	let data1Value = [];
	
	let layoutStr_2 = "";
	let priorityData = [];
	// google chart 
	let chart2;
	let data2Value = [];
	
	let layoutStr_3 = "";
	let sysInfoData = [];
	let chart3;
	let data3Value = [];
	
	let layoutStr_4 = "";
	let ownerData = [];
	let chart4;
	let data4Value = [];
	
	let user_list = [];
	
	let loadData = [];
	let apprLoadData = [];
	let userLoadData = [];
	
	let prtLoadData = [];
	let lstPrtData = [];
	let partner_yn = "";
	
	let selectData = [];
	
	let descEditor;
	
	let myGubun = "admin"; // user
	
	let gridStatus = [];
	
	let excel_request_id = ''; // 엑셀을 다운받을 때 헤더의 자식들 까지 가져오기 위해 헤더의 request_id를 담아 줄 변수
	
//	console.log("cmdRequestID 1 = ", cmdRequestID);
	
	if(cmdRequestID && cmdRequestID != 'null') {
		$("#mainDiv").css("display", "none");
		$("#selDiv").css("display", "");
	} else {
		$("#mainDiv").css("display", "");
		$("#selDiv").css("display", "none");
	}
	history.pushState(null, null, location.href);
	window.onpopstate = function(event) {
// 		console.log("event = ", event);
		fnReset();
		history.go(1);
	};
	if(document.getElementsByClassName("active").length != 2){ // 사이드바에 메뉴가 없다면
		$("#mainDiv").css("display", "none");
		fnMessageModalAlert("Notification", "입력한 URL이 올바르지 않습니다.");
		setTimeout(function () {
			page_move("/frontend/location/menus/new_1");
         }, 800);
	}
	$(document).ready(function () {
		console.log('page_request_seq',page_request_seq);
		console.log('page_request_seq_dtl',page_request_seq_dtl);
// 		console.log('page_request_id',page_request_id);
		if(cmdRequestID && cmdRequestID != 'null') {
// 			$("#selDiv").css("display", "");
			fnSetGrid();
			fnSetSubGrid();
			
			// 첨 load될때 있던 값으로.
			fnSelUser("select[name=sel_owner]");
			fnUser(member_id);
			
			fnDate("all");
			fndescEditor();
			
			fnSelRequest("type", "");		
			fnSelLevel("select[name=sel_levelType]", myGubun);
			fnSelProcess("select[name=sel_process]");
			fnSelControl("select[name=sel_control]");
			fnSelSyInfo("select[name=sel_syInfo]");
// 			fnStatus("select[name=status_nm_info]");
			
			$("#hiddenRow").val(cmdRequestID);
			loadList2();
        	loadList2_sub();
        	
        	let mstDt = w2ui["grid_master"].get(1);
        	fnSelRequest("category", mstDt.request_type);
            fnSelRequest("categoryItem", mstDt.request_category);
            
            setTimeout(function () {
        		w2ui['grid_master'].refresh();
        		setTimeout(function () {
               		w2ui['grid_master'].select(1);
            	}, 300);
        	}, 200);
		} else {
// 			$("#mainDiv").css("display", "");
			// 첨 load될때 있던 값으로.
			fnSelUser("select[name=sel_owner]");
			fnUser(member_id);
			
			fndescEditor();
			fnSetGrid();
			fnSetSubGrid();
			
			fnDate("all");
			
			fnSelRequest("type", "");		
			fnSelLevel("select[name=sel_levelType]", myGubun);
			fnSelProcess("select[name=sel_process]");
			fnSelControl("select[name=sel_control]");
			fnSelSyInfo("select[name=sel_syInfo]");
// 			fnStatus("select[name=status_nm_info]");
		}
		
		$('#modal_message button.btn-warning').css("display","none");
		
		window.addEventListener("resize", displayWindowSize);
		//  $(window).resize(function(){
		
		$('input[type="radio"].rdo_all_data_yn1').iCheck({
		    checkboxClass: 'icheckbox_flat-green',
		    radioClass: 'iradio_flat-green rdo_all_data_yn1',
		    handle: 'radio'
		  });
		$('input[type="radio"].rdo_all_data_yn2').iCheck({
		    checkboxClass: 'icheckbox_flat-green',
		    radioClass: 'iradio_flat-green rdo_all_data_yn2',
		    handle: 'radio'
		  });
		$(".radio_1 , .radio_2").click(function(){
			loadList();
		});
		$(".iCheck-helper").click(function(){
			loadList();
		});
		fnMainGrid();
		
// 		console.log( gridStatus.findIndex(x => x.n_owner_id === member_id) );
// 		console.log( gridStatus.findIndex(x => x.n_owner_id === 'ddd') );
// 		console.log( gridStatus.findIndex(x => x.n_owner_id === '2011111') );
		
		if( gridStatus.findIndex(x => x.n_owner_id === member_id) >= 0 ){
			$("#sel_owner").val(member_id).prop("selected", true);
		} else {
			$("#sel_owner option:eq(0)").prop("selected", true);
		}
		
//     	fnLoadUserGrid();
//     	fnLoadUserGrid_p();
    	
		fnLoadFileHandler();
		/* 
		if(cmdRequestID && cmdRequestID != 'null') {
			console.log("******");
			$("#hiddenRow").val(cmdRequestID);
			loadList2();
        	loadList2_sub();
        	
        	let mstDt = w2ui["grid_master"].get(1);
        	fnSelRequest("category", mstDt.request_type);
            fnSelRequest("categoryItem", mstDt.request_category);
            
            $("#selDiv").css("display", "");
            setTimeout(function () {
        		w2ui['grid_master'].refresh();
        		setTimeout(function () {
               		$("#mainDiv").css("display", "none");
               		w2ui['grid_master'].select(1);
            	}, 300);
        	}, 200);
		}
		 */
		 
		 if(sessionStorage.length == 0){
			 if(page_request_seq == null || page_request_seq == 'null'){
// 			 if(page_request_id == null || page_request_id == 'null'){
				$("#alt_05_div").css("background-color", "#FFD25F");
				$("#clickCircle").val("alt_05");
				loadList("alt_05");
			 }
		 }
		
		let length = w2ui['grid_main'].records.length;
		$("#rds_rows").text(length+"");
		w2ui['grid_main'].fixedBody = true;
// 		$("#grid_main").height("430px");
		
		
		// 메인 > 상세
// 		if(cmdRequestID && cmdRequestID != 'null') {
// 			w2ui['grid_main'].select(cmdRequestID);
// 		}
	});
		
	$('#modal_user, #modal_partner').on('hidden.bs.modal', function (e) { // 모달창 닫혔을 때
		console.log('모달창 닫힘',this.id);
		if(this.id == 'modal_user'){
			$('#grid_user').jqGrid('clearGridData');
		}else{
			$('#grid_user_p').jqGrid('clearGridData');
			$('#grid_partner').jqGrid('clearGridData');
		}
// 		w2ui['m_grid_master_all'].clear();
	});
		
	
	function displayWindowSize(){
		 event.preventDefault();
		 var inner_height = window.innerHeight;
		 console.log("displayWindowSize!");
// 		 console.log(inner_height);
		 $("#grid_main").css("height",inner_height/2);
		 setTimeout (function(){
				$('#grid_main').resize();
// 				$('#grid_main').refersh();
			}, 200);
		 let hiddenRow = $("#hiddenRow").val();
		 if(hiddenRow){
			 w2ui['grid_master'].refresh();
			 w2ui['subGridO'].refresh();
		 } else {
			 fnCharts();
			 w2ui['grid_main'].refresh();
			 setTimeout(function () {
				 w2ui['grid_main'].refresh();
 			}, 100);
		 }
	}
	
	function fndescEditor() {
		descEditor = new FroalaEditor('#desc_case_1', {
			language: 'ko', 
			key: frLicenseKey, 
			wordPasteModal : false, 
			placeholderText : '내용을 입력해 주세요!', 
			heightMin : 250, 
			theme: 'gray', 
			quickInsertEnabled: false, 
			inlineMode: false, 
		    plainPaste: true, 
		    pastePlain: true, 
			imageAllowedTypes: ['jpeg', 'jpg', 'png'],
			toolbarSticky: false, 
			toolbarButtons: [ 'undo', 'redo', '|', 
							  'textColor', 'backgroundColor', 'fontFamily', 'fontSize', 'bold', 'italic', 
							  'underline', 'strikeThrough', '|',  
							  'insertImage', 'insertHR', 'insertTable', '-', 
							  'clearFormatting', 'paragraphFormat', 'align', 'insertHTML' // , 'html'
			], 
		    imageEditButtons: ['imageReplace', 'imageAlign', 'imageRemove', '|', 
		                       'imageLink', 'linkOpen', 'linkEdit', 'linkRemove', '-', 
		                       'imageDisplay', 'imageStyle', 'imageAlt', 'imageSize'], 
            events: {
			    'image.inserted': function ($img, response) {
   				     let blobT = $img[0].currentSrc;
   			         let imgA = $img[0]; 
   			         blobImg(imgA, blobT);
   			    }, 
	   			 'paste.before': function (original_event) {
	   		      // Do something here.
	   		      // this is the editor instance.
	   		      console.log(this);
	   		    }, 
		   		 'paste.after': function () {
		   	      // Do something here.
		   	      // this is the editor instance.
		   	      console.log(this);
		   	    }, 
			   	 'paste.wordPaste': function (clipboard_html) {
			         // Do something here.
			         // this is the editor instance.
			         console.log(this);
			       }
   			}
		});
	}
	
	function blobImg(imgA, blobT) {
		var preview = imgA;
		var file    =  blobToFile(blobT);
		var reader  = new FileReader();
		var blob = new Blob( [blobT], { type: "image/png" } ); 
		
		const createImageFromBase64 = function(event) {
			preview.src = this.result;
		};
		
		const onLoadReadBlobAsBase64 = function(event) {
			const blobRp = this.response;
			const reader = new FileReader();
			reader.onloadend = createImageFromBase64;
			reader.readAsDataURL(blobRp);
		};
		
		var xhr = new XMLHttpRequest();
		xhr.open("GET", blobT);
		xhr.responseType = "blob";
		xhr.onload = onLoadReadBlobAsBase64;
		xhr.send();
	}

	function blobToFile(blobT) {
		var file_object = fetch(blobT).then(r => r.blob()).then(blob => {
            var file_name = Math.random().toString(36).substring(6) + '_froala.png'; //e.g ueq6ge1j_froala.png
            var file_object = new File([blob], file_name, {type: 'image/png'});
         });
	}
	
	$("div.border-circle").click(function() {
// 		console.log("event id = ", event.target.children[1].id);
		
		let clickId = (event.target.id).replace(/_div|_label/gi, "");
		console.log(event);
		console.log(clickId);
		$(".border-circle").css("background-color", "white");
		
		if($("#clickCircle").val() != clickId ) {
			$("#"+clickId+"_div").css("background-color", "#FFD25F");
			$("#clickCircle").val(clickId);
			
			if(clickId == "Hold"){
				loadList("Hold");
			} else {
				loadList(clickId);
			}
		} else {
			$("#clickCircle").val('');
			loadList();
		}
		
	});
	
	function fnDate(gubun) {
		let mdTemp = new Date();
        let minDate = getFormatDate(mdTemp);
   	
//         if(gubun == "all" || gubun == "hm") {
	   		$('.hhmm_date').daterangepicker({
	           opens: 'right', 
	           singleDatePicker: false, 
	           timePicker : true, 
			   timePicker24Hour : true, 
	           locale: {
	               format: 'YYYY-MM-DD HH:mm', 
	               monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	               daysOfWeek: ["일", "월", "화", "수", "목", "금", "토"],
	               showMonthAfterYear: true, 
	               yearSuffix: '년', 
	               orientation: "top left"
	           },
	           startDate: moment(minDate)
	       });
	   		$(".hhmm_date").val('');
//         } else if (gubun == "all" || gubun == "range") {
        	$('.range_date').daterangepicker({
                opens: 'right', 
                singleDatePicker: false, 
                locale: {
                    format: 'YYYY-MM-DD', 
                    monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
                    daysOfWeek: ["일", "월", "화", "수", "목", "금", "토"],
                    showMonthAfterYear: true,
                    yearSuffix: '년', 
                    orientation: "top left"
                },
                startDate: moment(minDate)
            });
       		$(".range_date").val('');
//         } else if (gubun == "all" || gubun == "single") {
        	$('.single_date').daterangepicker({
                opens: 'right', 
                singleDatePicker: true, 
                locale: {
                    format: 'YYYY-MM-DD', 
                    monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
                    daysOfWeek: ["일", "월", "화", "수", "목", "금", "토"],
                    showMonthAfterYear: true, 
                    yearSuffix: '년', 
                    orientation: "top left"
                },
                startDate: moment(minDate)
            });
       		$(".single_date").val('');
//         }
			
       		$('#process_date, #date_updated').on('apply.daterangepicker', function(ev, picker) {
           		loadList();
            });
       		$('#process_date, #date_updated').on('cancel.daterangepicker', function(ev, picker) {
                $(this).val('');
                loadList();
            });
	}
	
	function saveCaseInfo() {
		let gubun = $("#sel_gubun").val();
		var page_link;
		if(w2ui['grid_master'].get(w2ui['grid_master'].getSelection()).length == 1 || gubun == 'new'){
			page_link = $("#input_text").val();
		}else{
			page_link = $("#input_text_dtl").val();
		}
		
		
		if(gubun=="new" && lstPrtData.filter(item => item.partner_id == member_id ).length > 0 	){
			newPartnerCase();
		} else if(gubun=="new"){
			newCase(page_link);
		} else if( $("#grid_name").val() == "grid_master" && gubun=="edit"){
			editCaseHeader(page_link);
		} else if(gubun=="edit" && selectData.partner_id == member_id ){
			editPartnerCase(page_link);
		} else if(gubun=="edit"){
			editCase(page_link);
		}
	}
	
	function newPartnerCase() {
		console.log('newPartnerCase');
// 		fnMessageModalConfirm("Notification", "입력한 내용을 등록하시겠습니까?", function(result) {
//			if(result) {
			let admin_level_type_code = $("#detail_sel_levelType option:selected").val();
			let status = $("#detail_done_status").val();
			let title = $("#detail_title").val();
			
			let plan_due_date = $("#detail_plan_due_date").val();
			let request_due_date = $("#detail_request_due_date").val();
			let priority_code = $("#detail_sel_priority option:selected").val();
			// ㅌㅈ ㅂㄹ
			let control_gubun = $("#detail_sel_control option:selected").val();
			
			let processed_type_code = $("#detail_sel_process option:selected").val();
			
			
			let file_group = "";
			let allCount = Number($("#append_down")[0].childElementCount);
			
			for(var i=0; i<allCount; i++ ) {
				let href = $("#append_down")[0].childNodes[i].childNodes[1].href;
				let fileGroup = href.substring( href.indexOf('file_group=')+11, href.indexOf('&file_name=') );
				if(i == 0) {
					file_group = fileGroup;
				} else {
					file_group = file_group + "," + fileGroup;
				}
			}
			
			let save_checkT = "";
			
			if($.trim(admin_level_type_code).length == 0) {
				save_checkT = save_checkT+"단계, ";
			} 
			if($.trim(status).length == 0) {
				save_checkT = save_checkT+"상태, ";
			}
			
			if (save_checkT) {
				$("#save_check").css('display', '');
				let tttttt = "다음 입력란을 작성하세요: "+save_checkT.substring(0, save_checkT.length-2);
				$("#save_check").text(tttttt);
				return;
			} else {
				$("#save_check").text('');
			}
			
			let request_id = $("#sel_request_id").val();
			
			let owner_id = lstPrtData[0].owner_id;
			let owner_nm = lstPrtData[0].owner_nm;
			
			let partner_id = $("#detail_owner_id").val();
			let partner_nm = $("#detail_owner_nm").val();
			
			let html_length =  (descEditor.html.get()).length;
			let html_data =  descEditor.html.get();
			
			// 추가 ★
			// Powered by Froala Editor 지우기.
			let text = '<p data-f-id="pbf" style="text-align: center; font-size: 14px; margin-top: 30px; opacity: 0.65; font-family: sans-serif;">Powered by <a href="https://www.froala.com/wysiwyg-editor?pb=1" title="Froala Editor">Froala Editor</a></p>';
			let frContext = descEditor.html.get();
			while(true)	{
				let idx = frContext.indexOf(text);
				frContext = frContext.replace(text, "");
				if ( frContext.indexOf(text) < 0 ) {
					break; 
				}
			}
			html_length =  (frContext).length;
			html_data = frContext;
			
			let sendData = { 
				body_data				: JSON.stringify(html_data), 
				frData	 				: html_data, 
				
				request_id				: request_id, 
				
				title					: title,
				plan_due_date			: plan_due_date, 
				request_due_date		: request_due_date, 
				priority_code			: priority_code, 
				processed_type_code		: processed_type_code, 
				
				control_gubun			: control_gubun, 
				
				owner_id				: owner_id, 
				owner_nm				: owner_nm, 
				
				partner_id				: partner_id, 
				partner_nm				: partner_nm, 
				
				admin_level_type_code	: admin_level_type_code, 
				status					: status, 
				
				file_group				: file_group, 
				
				cmd						: "I"
			};
			var page_url = "/case/admin/insertPartnerCase";
			
			$.ajax({
				url : page_url,
				type : 'POST',
				data : sendData, 
				dataType : 'json',
				async : false,
				success : function( data ) {
					if(data.status == 200 ) {
						fnMessageModalAlert("Notification", "Case 저장이 완료되었습니다.");
						
						loadList2();
						loadList2_sub();
					} else {
						fnMessageModalAlert("Error", "실패했습니다. 다시 등록해 주세요.");
					}
				},
				complete: function () {
					setTimeout(function(){ 
						$('#modal_message button.close').click();
						$("#btn_detail_next_history").attr("disabled", true);
					}, 600);
                	setTimeout(function () {
		        		w2ui['grid_master'].selectNone();
		        		w2ui['subGridO'].select( (w2ui['subGridO'].records).length);
        			}, 300);
				}
			});
	}
	
	function newCase(page_link) {
// 		fnMessageModalConfirm("Notification", "입력한 내용을 등록하시겠습니까?", function(result) {
// 			if(result) {
		console.log('newCase');
				let gmGetDt = w2ui["grid_master"].get(1); // 헤더
				let gmGetStep = gmGetDt.work_status;
				let gmGetOwner_id = gmGetDt.owner_id; 
				
				let admin_level_type_code = $("#detail_sel_levelType option:selected").val();
				let admin_level_type_name = $("#detail_sel_levelType option:selected").text();
				let status = $("#detail_done_status").val();
				let title = $("#detail_title").val();
				let plan_due_date = $("#detail_plan_due_date").val();
				let request_due_date = $("#detail_request_due_date").val();
				let priority_code = $("#detail_sel_priority2 option:selected").val();
				let processed_type_code = $("#detail_sel_process option:selected").val();
				// ㅌㅈ ㅂㄹ
				let control_gubun = $("#detail_sel_control option:selected").val();
				
				// 대,중,소분류, 대상
				let system_info_code = $("#detail_sel_syInfo option:selected").val();
				let request_type = $("#detail_selR_type option:selected").val();
				let request_category = $("#detail_selR_category option:selected").val();
				let request_category_item = $("#detail_selR_categoryItem option:selected").val();
				
				let approver_id = "";
				let approver_nm = "";
				let comment = "";
				
				let file_group = "";
				let allCount = Number($("#append_down")[0].childElementCount);
				
				for(var i=0; i<allCount; i++ ) {
					let href = $("#append_down")[0].childNodes[i].childNodes[1].href;
					let fileGroup = href.substring( href.indexOf('file_group=')+11, href.indexOf('&file_name=') );
					if(i == 0) {
						file_group = fileGroup;
					} else {
						file_group = file_group + "," + fileGroup;
					}
				}
				
				let save_checkT = "";
				
				if($.trim(title).length == 0) {
// 					fnMessageModalAlert("Notification", "Title을 입력하세요.");
					save_checkT = save_checkT+"제목, ";
// 					return;
				} 
				if($.trim(processed_type_code).length == 0) {
// 					fnMessageModalAlert("Notification", "Process Type을 선택하세요.");
					save_checkT = save_checkT+"작업 분류, ";
// 					return;
				}
				
				// // 통제 필수
				if($.trim(control_gubun).length == 0) {
					save_checkT = save_checkT+"통제 분류, ";
				}
				if( !plan_due_date ) {
					save_checkT = save_checkT+"예상 완료일, ";
				}
				if($.trim(admin_level_type_code).length == 0) {
// 					fnMessageModalAlert("Notification", "Step을 선택하세요.");
					save_checkT = save_checkT+"단계, ";
// 					return;
				} 
				if($.trim(status).length == 0) {
// 					fnMessageModalAlert("Notification", "Status를 선택하세요.");
					save_checkT = save_checkT+"상태, ";
// 					return;
				}
				
				if (save_checkT) {
					$("#save_check").css('display', '');
					
					let tttttt = "다음 입력란을 작성하세요: "+save_checkT.substring(0, save_checkT.length-2);
					$("#save_check").text(tttttt);
					return;
				} else {
					$("#save_check").text('');
				}
				
				let prtUser = $("input[name=hidden_prt_user]");
				let prtuserData = [];
				for(var i=0; i<prtUser.length; i++){
					let idIdx = $("input[name=hidden_prt_user]")[i].id;
					idIdx = idIdx.substring(("hidden_prt_user_no_").length);
					prtuserData.push(
						{ 
							user_no : $("#hidden_prt_user_no_"+idIdx).val(), 
							user_id : $("#hidden_prt_user_id_"+idIdx).val(), 
							user_nm : $("#label_prt_user_"+idIdx).text().substring(0, $("#label_prt_user_"+idIdx).text().length-1 )
						}		
					);
				}
				
				if( status == "MD1266" ) { // 승인 요청 등록
					approver_id = $("#new_appr_approver_id").val();
					approver_nm = $("#new_appr_approver_nm").val();
					comment = $("#new_appr_req_comment").val();
					if ( $.trim(comment).length == 0 ) {
						$("#new_appr_req_comment").val("승인 요청드립니다.");
					}
					comment = $("#new_appr_req_comment").val();
				} else if ( admin_level_type_code == "alt_12" ) { // 협업
					approver_id = $("#new_request_approver_id").val();
					approver_nm = $("#new_request_approver_nm").val();
					comment = $("#new_request_req_comment").val();
					if ( $.trim(comment).length == 0 ) {
						$("#new_request_req_comment").val("협업 요청드립니다.");
					}
					comment = $("#new_request_req_comment").val();
				}
				
				let request_id = $("#sel_request_id").val();
				let request_nm = $("#detail_owner_nm").val();
				let request_seq = $('#sel_request_seq').val();
				
				let html_length =  (descEditor.html.get()).length;
				let html_data =  descEditor.html.get();
				
				// 추가 ★
				// Powered by Froala Editor 지우기.
				let text = '<p data-f-id="pbf" style="text-align: center; font-size: 14px; margin-top: 30px; opacity: 0.65; font-family: sans-serif;">Powered by <a href="https://www.froala.com/wysiwyg-editor?pb=1" title="Froala Editor">Froala Editor</a></p>';
				let frContext = descEditor.html.get();
				while(true)	{
					let idx = frContext.indexOf(text);
					frContext = frContext.replace(text, "");
					if ( frContext.indexOf(text) < 0 ) {
						break; 
					}
				}
				html_length =  (frContext).length;
				html_data = frContext;
				
				let sendData = { 
					body_data				: JSON.stringify(html_data), 
					frData	 				: html_data, 
					request_id				: request_id,
					request_nm				: request_nm, 
					
					admin_level_type_code	: admin_level_type_code, 
					status					: status, 
					processed_type_code		: processed_type_code,
					approver_id				: approver_id, 
					approver_nm				: approver_nm, 
					
					control_gubun		: control_gubun, 
					
					comment					: comment, 
					
					file_group				: file_group, 
					
					plan_due_date			: plan_due_date, 
					request_due_date		: request_due_date, 
					priority_code			: priority_code, 
					
					// 대,중,소분류, 대상
					system_info_code 		: system_info_code, 
					request_type 			: request_type, 
					request_category 		: request_category, 
					request_category_item 	: request_category_item, 
					
					title					: title,
					cmd						: "I", 
					
					prtuserData				: JSON.stringify(prtuserData)
				};
				var page_url = "/case/admin/insertCase";
				
				$.ajax({
					url : page_url,
					type : 'POST',
					data : sendData, 
					dataType : 'json',
					async : false,
					success : function( data ) {
						if(data.status == 200 ) {
							fnMessageModalAlert("Notification", "Case 저장이 완료됐습니다.");
							loadList2();
							loadList2_sub();
							
							// 등록이니 owner_id가 당연히 member_id
							if( gmGetOwner_id != member_id) {
								// Case의 상태가 Open에서 Open이 아니게 바뀔 때(최초 서브일때)
// 								if ( gmGetStep == "alt_05" && gmGetStep != admin_level_type_code ) {
								if ( gmGetStep =="OPEN" ) {
									var textUDN = admin_level_type_name;
									if( textUDN == "Open" ) {
										textUDN = "OPEN";
									} else if( textUDN == "open" ) {
										textUDN = "OPEN";
									}
									
									if ( "OPEN" != textUDN ) {
										var page_link_u = page_link.replace('test_case', 'new_1');
										fnMailSend("/mail/mailSending_6", request_seq, status, page_link_u);
									}
								}
								// 협업 확인 요청일때 if
								if ( admin_level_type_code == "alt_12" ) {
	// 								comment = $("#new_request_req_comment").val();
									var page_link_u = page_link.replace('test_case', 'new_1');
									fnMailSend("/mail/mailSending_4", gmGetDt.request_seq, status, member_nm, page_link_u); // 메인 Case 요청자
								}
								
							}
							// 일단은 request와 owner가 같아도 승인 요청자만 조건 걸자. >> 메일 받는건 다른 사람이니.
							// 승인 요청일때 if
							if( status == "MD1266" && approver_id != member_id ) { // 승인 요청 등록
// 								comment = $("#new_appr_req_comment").val();
								page_link = page_link.replace('test_case', 'appr_admin_list');
								fnMailSend("/mail/mailSending_2", data.request_seq, status, '', comment, member_nm, page_link);
							}
							
						} else {
							fnMessageModalAlert("Error", "실패했습니다. 다시 등록해 주세요.");
						}
					},
					complete: function () {
// 	                	w2ui["grid_master"].expand(1);
						setTimeout(function(){ 
							$('#modal_message button.close').click();
						}, 600);
	                	setTimeout(function () {
			        		w2ui['grid_master'].selectNone();
// 			        		w2ui['subGridO'].selectNone();
			        		w2ui['subGridO'].select( (w2ui['subGridO'].records).length);
	        			}, 300);
					}
				});
// 			}
// 		});
	}
	
	// 순서 지키는 save
	function old_old_fnStepCheck(foLoadData) {
		let save_checkT = "";
		let stepCheckObj = {};
		
		// loadData를 for문 돌려서 해당 단계 순서가 맞으면 idxV가 올라감.
		var foLevelIdx = 0;
		
		for(var i=0; i<foLoadData.length; i++) {
				// 승인 통제가 있다면
				if( controlApprData.length > 0 ) {
					if( controlApprData[0][(foLoadData[i].admin_level_type_code)] != undefined ) { // 해당 건에 대한 통제가 있으면	
						if( foLoadData[i].status == "MD1267" || foLoadData[i].status == "MD1268" ) {
							// stepCheckObj에 값이 있으면 승인자 관련에서 해당 값이 맞는게 있는지 확인.
							// 승인자가 맞으면 gubun_yn을 Y로 해줌
							for( var p=0; p<controlApprData[0][(foLoadData[i].admin_level_type_code)].length; p++ ) {
								// 값이 들어가 있음
								if( stepCheckObj[ (foLoadData[i].admin_level_type_code) ] != undefined ) {
									var obj = { };
									var gubunArrayDt = [];
									for( var p=0; p< (stepCheckObj[ (foLoadData[i].admin_level_type_code) ].appr).length; p++ ) {
										var ggggggss  = (stepCheckObj[ (foLoadData[i].admin_level_type_code) ].appr);
										
										if( ggggggss[p].gubun_yn == "N" ) {
											
											var pGbYn = "";
											
											if( ggggggss[p].control_approver_id == "CA001" ) { 
												// 요청자 승인
												if( foLoadData[i].approver_id == selectData.owner_id ) {
													pGbYn = "Y";
													ggggggss[p].gubun_yn = "Y";
												} 
											}  else if( ggggggss[p].control_approver_id == "CA002" ) { 
												// 요청자 팀장 승인 : 팀장이 없거나 값이 같으면
												if( !(selectData.dept_owner_id) || foLoadData[i].approver_id == selectData.dept_owner_id ) {
													pGbYn = "Y";
													ggggggss[p].gubun_yn = "Y";
												} 
											} else if( ggggggss[p].control_approver_id == "CA003" ) { 
												// 처리자 승인
												if( foLoadData[i].approver_id == selectData.n_owner_id ) {
													pGbYn = "Y";
													ggggggss[p].gubun_yn = "Y";
												} 
											} else if( ggggggss[p].control_approver_id == "CA004" ) { 
												// 처리자 팀장 승인 : 팀장이 없거나 값이 같으면
												if( !(loadData[(loadData.length-1)].dept_owner_id) || foLoadData[i].approver_id == loadData[(loadData.length-1)].dept_owner_id ) {
													pGbYn = "Y";
													ggggggss[p].gubun_yn = "Y";
												} 
											}
										}	
									}
								} else if( stepCheckObj[ (foLoadData[i].admin_level_type_code) ] == undefined ) {
									// 안넣었음.
									var obj = { };
									var gubunArrayDt = [];
									
									var forGbYn = ""; // 전체 조회했는데 승인자랑 일치함
									var forGbNm = ""; // 값이 없었던 승인자.
									// 뭔가 여기서 일듯 Final Review 가 안보임
									for( var p=0; p<controlApprData[0][(foLoadData[i].admin_level_type_code)].length; p++ ) {
										var ggggggss  = controlApprData[0][(foLoadData[i].admin_level_type_code)];
										var pGbYn = "N";
										
										if( ggggggss[p].control_approver_id == "CA001" ) { 
											// 요청자 승인
											
											if( foLoadData[i].approver_id == selectData.owner_id ) {
												pGbYn = "Y";
											} 
										} else if( ggggggss[p].control_approver_id == "CA002" ) { 
											// 요청자 팀장 승인 : 팀장이 없거나 값이 같으면
											
											if( !(selectData.dept_owner_id) || foLoadData[i].approver_id == selectData.dept_owner_id ) {
												pGbYn = "Y";
											} 
										} else if( ggggggss[p].control_approver_id == "CA003" ) { 
											// 처리자 승인
											
											if( foLoadData[i].approver_id == selectData.n_owner_id ) {
												pGbYn = "Y";
											} 
										} else if( ggggggss[p].control_approver_id == "CA004" ) { 
											// 처리자 승인 : 팀장이 없거나 값이 같으면
											
											if( !(loadData[(loadData.length-1)].dept_owner_id) || foLoadData[i].approver_id == loadData[(loadData.length-1)].dept_owner_id ) {
												pGbYn = "Y";
											} 
										}
										
										// 값이 맞는데 승인자가 하나면 바로 Y 쳐주기.
										// 그런데 값이 2개 이상이면 ""
										if(pGbYn){
											if(ggggggss.length == 1) {
												forGbYn = "Y";
												forGbNm = (ggggggss[0].control_approver_nm);
											} else {
												forGbYn = "";
												forGbNm = (ggggggss[1].control_approver_nm);
											}
										}
										
										gubunArrayDt.push(
											{ 
												control_approver_id : ggggggss[p].control_approver_id, 
												control_approver_nm : ggggggss[p].control_approver_nm, 
												level_order : ggggggss[p].level_order, 
												admin_level_type_code : ggggggss[p].admin_level_type_code, 
												admin_level_type_nm : ggggggss[p].admin_level_type_nm,
												gubun_yn : pGbYn// 
											}
										);
									}
									
									if(forGbYn) {
										obj.gubun = "승인됨";
									} else {
										obj.gubun = "승인좀";
									}
									
									obj.gubunNm = forGbNm;
									obj.appr = gubunArrayDt;
									
									stepCheckObj[ foLoadData[i].admin_level_type_code ] = obj;
								}
							}
						} else {
							if( stepCheckObj[ (foLoadData[i].admin_level_type_code) ] != undefined ) {
								// 이미 넣었으면 패스.
							} else if( stepCheckObj[ (foLoadData[i].admin_level_type_code) ] == undefined ) {
								// 안넣었음.
								var obj = { };
								var gubunArrayDt = [];
								for( var p=0; p<controlApprData[0][(foLoadData[i].admin_level_type_code)].length; p++ ) {
									var ggggggss  = controlApprData[0][(foLoadData[i].admin_level_type_code)];
									gubunArrayDt.push(
										{ 
											control_approver_id : ggggggss[p].control_approver_id, 
											control_approver_nm : ggggggss[p].control_approver_nm, 
											level_order : ggggggss[p].level_order, 
											admin_level_type_code : ggggggss[p].admin_level_type_code, 
											admin_level_type_nm : ggggggss[p].admin_level_type_nm,
											gubun_yn : "N"
										}
									);
								}
								obj.gubun = "승인좀";
								obj.gubunNm = (controlApprData[0][(foLoadData[i].admin_level_type_code)][0].control_approver_nm);
								obj.appr = gubunArrayDt;
								
								stepCheckObj[ foLoadData[i].admin_level_type_code ] = obj;
							}
						}
					}
				}
				//
				
				if( controlLevelData.length > foLevelIdx ) {
					if( foLoadData[i].admin_level_type_code == controlLevelData[foLevelIdx].admin_level_type_code ) {
						foLevelIdx++;
					} else if( i>0 && foLoadData[i].admin_level_type_code == controlLevelData[foLevelIdx-1].admin_level_type_code ) {
						// 처음이 아닌데 그 전 값이 같으면
					} else { // 같지 않으면.
						// 마지막이라면
						if( i != (foLoadData.length-1) ) {
							foLevelIdx = 0;
						}
					}
				}
		}
		
		// controlLevelData 전체 for문 해서 s 부터는 순서 넣어주기. 그 ㅈ ㅓㄴ에는 단계 있으면 단계 넣어주기로
		for( var s=0; s<controlLevelData.length; s++ ) {
			// 순서 중간마다 들어가서 킵해놓은 data 찾기.
			if( s >= foLevelIdx ) {
				if( stepCheckObj[(controlLevelData[s].admin_level_type_code)] != undefined ) {
					var appData = (stepCheckObj[(controlLevelData[s].admin_level_type_code)].appr).filter(item => item.gubun_yn == 'N');
					
					if( appData.length > 0 ) {
						save_checkT = save_checkT+ appData[0].admin_level_type_nm + " (" + appData[0].control_approver_nm +"), ";
					} else {
						save_checkT = save_checkT+ controlLevelData[s].admin_level_type_nm +" (요청자 팀장 승인), ";
					}
				} else {
					save_checkT = save_checkT+ controlLevelData[s].admin_level_type_nm +" (요청자 팀장 승인), ";
				}
			} else {
				if( stepCheckObj[(controlLevelData[s].admin_level_type_code)] != undefined ) {
					var appData = (stepCheckObj[(controlLevelData[s].admin_level_type_code)].appr).filter(item => item.gubun_yn == 'N');
					if( appData.length > 0 ) {
						save_checkT = save_checkT+ appData[0].admin_level_type_nm + " (" + appData[0].control_approver_nm +"), ";
					}
					// == 0 이면... 승인함으로 바꿔도 될듯?
				}
			}
		}
		return save_checkT;
	}
	
	// 이제 순서 상관 없음. 순서 안 지키는 save > 단계는 순서 지킴
	function fnStepCheck(foLoadData) {
		let save_checkT = "";
		let stepCheckObj = {};
		
		// loadData를 for문 돌려서 해당 단계 순서가 맞으면 idxV가 올라감.
		var foLevelIdx = 0;
		
		// ★
		// 이제부터는 모든 단계에서 마지막 단계인 것만  승인 요청 확인함/
		// 1번 test 승인 완료 4번 test 승인 반려면 < 안된걸로 함.
		// foLoadData[0] 의 단계는 무조건 open 으로 값 쳐있음.
		for(var i=0; i<foLoadData.length; i++) {
				// 승인 통제가 있다면
				if( controlApprData.length > 0 ) {
					if( controlApprData[0][(foLoadData[i].admin_level_type_code)] != undefined ) { // 해당 건에 대한 통제가 있으면	
						
						// 헤더면 상태가 apprLoadData를 봐야함.
						var altStatus = foLoadData[i].status;
						if(  foLoadData[i].admin_level_type_code == "alt_05" && foLoadData[i].service_process_id == "SER_00" ) {
							if( apprLoadData.length > 0 ) {
								altStatus = apprLoadData[apprLoadData.length-1].status;
							}
						}
						
						if( ( foLoadData[i].service_process_id == "SER_00" && altStatus == "MD1267" ) || foLoadData[i].status == "MD1267" ) {//  미션중 원본 주석해제
// 						if( foLoadData[i].status == "MD1267" || foLoadData[i].status == "MD1268" ) {
							// stepCheckObj에 값이 있으면 승인자 관련에서 해당 값이 맞는게 있는지 확인.
							// 승인자가 맞으면 gubun_yn을 Y로 해줌
							for( var p=0; p<controlApprData[0][(foLoadData[i].admin_level_type_code)].length; p++ ) {
								// 값이 들어가 있음
								if( stepCheckObj[ (foLoadData[i].admin_level_type_code) ] != undefined ) {
									var obj = { };
									var gubunArrayDt = [];
									var ggggggss  = (stepCheckObj[ (foLoadData[i].admin_level_type_code) ].appr);
									console.log('gggggggss : ',ggggggss);
									for( var p=0; p< ggggggss.length; p++ ) {
										
										var pGbYn = "N";
										ggggggss[p].gubun_yn = "N";
										
										// 이게 0번째 index 조회할 때는 apprLoadData[apprLoadData.length-1].status 를 사용해야함.
										// foLoadData의 0번은 무조건 open인 처음꺼니까.. 
										// 근데 중간에 있을 수 있으니 단계가 alt_05 open 이면
										// 여기에서 apprLoadData[apprLoadData.length-1].status 사용하자.
										var foLoadData_appr = foLoadData[i];
										var foLoadDataStatus = foLoadData[i].status;
										
										if( foLoadData[i].admin_level_type_code == "alt_05" && foLoadData[i].service_process_id == "SER_00" ) {  // << 0번째는 으로 변경하자. // service_process_id: "SER_00"
											foLoadDataStatus = apprLoadData[apprLoadData.length-1].status;
											foLoadData_appr = apprLoadData[apprLoadData.length-1];
										}
										
										// 반려 "MD1268" 은 안됨.
										if( foLoadDataStatus == "MD1267" ) {
											
											if( ggggggss[p].control_approver_id == "CA001" ) { 
												// 요청자 승인
												if( foLoadData_appr.approver_id == selectData.owner_id ) {
													pGbYn = "Y";
													ggggggss[p].gubun_yn = "Y";
												} 
											}  else if( ggggggss[p].control_approver_id == "CA002" ) { 
												// 요청자 팀장 승인 : 팀장이 없거나 값이 같으면
												if( !(selectData.dept_owner_id) || foLoadData_appr.approver_id == selectData.dept_owner_id ) {
													pGbYn = "Y";
													ggggggss[p].gubun_yn = "Y";
												} 
											} else if( ggggggss[p].control_approver_id == "CA003" ) { 
												// 처리자 승인 >> 해당 sub-case의 처리자일 수 있음.
// 												if( foLoadData_appr.approver_id == selectData.n_owner_id ) {
												if( foLoadData_appr.approver_id == foLoadData_appr.owner_id ) {
													pGbYn = "Y";
													ggggggss[p].gubun_yn = "Y";
												} 
											} else if( ggggggss[p].control_approver_id == "CA004" ) { 
												// 처리자 팀장 승인 : 팀장이 없거나 값이 같으면
// 												if( !(loadData[(loadData.length-1)].dept_owner_id) || foLoadData_appr.approver_id == loadData[(loadData.length-1)].dept_owner_id ) {
												if( !(foLoadData_appr.dept_owner_id) || foLoadData_appr.approver_id == foLoadData_appr.dept_owner_id ) {
													pGbYn = "Y";
													ggggggss[p].gubun_yn = "Y";
												} 
											}
										}	
										
									}
								} else if( stepCheckObj[ (foLoadData[i].admin_level_type_code) ] == undefined ) {
									// 안넣었음.
									var obj = { };
									var gubunArrayDt = [];
									
									var forGbYn = ""; // 전체 조회했는데 승인자랑 일치함
									var forGbNm = ""; // 값이 없었던 승인자.
									// 뭔가 여기서 일듯 Final Review 가 안보임
									for( var p=0; p<controlApprData[0][(foLoadData[i].admin_level_type_code)].length; p++ ) {
										var ggggggss  = controlApprData[0][(foLoadData[i].admin_level_type_code)];
										var pGbYn = "N";
										
										// 이게 0번째 index 조회할 때는 apprLoadData[apprLoadData.length-1].status 를 사용해야함.
										// foLoadData의 0번은 무조건 open인 처음꺼니까.. 
										// 근데 중간에 있을 수 있으니 단계가 alt_05 open 이면
										// 여기에서 apprLoadData[apprLoadData.length-1].status 사용하자.
										var foLoadData_appr = foLoadData[i];
										var foLoadDataStatus = foLoadData[i].status;
										if( foLoadData[i].admin_level_type_code == "alt_05" && foLoadData[i].service_process_id == "SER_00" ) {
											foLoadDataStatus = apprLoadData[apprLoadData.length-1].status;
											foLoadData_appr = apprLoadData[apprLoadData.length-1];
										}
										
										// 반려 "MD1268" 은 안됨.
										if( foLoadDataStatus == "MD1267" ) {
											if( ggggggss[p].control_approver_id == "CA001" ) { 
												// 요청자 승인
												if( foLoadData_appr.approver_id == selectData.owner_id ) {
													pGbYn = "Y";
												} 
											} else if( ggggggss[p].control_approver_id == "CA002" ) { 
												// 요청자 팀장 승인 : 팀장이 없거나 값이 같으면
												
												if( !(selectData.dept_owner_id) || foLoadData_appr.approver_id == selectData.dept_owner_id ) {
													pGbYn = "Y";
												} 
											} else if( ggggggss[p].control_approver_id == "CA003" ) { 
												// 처리자 승인
												
												if( foLoadData_appr.approver_id == selectData.n_owner_id ) {
													pGbYn = "Y";
												} 
											} else if( ggggggss[p].control_approver_id == "CA004" ) { 
												// 처리자 승인 : 팀장이 없거나 값이 같으면
												
												if( !(loadData[(loadData.length-1)].dept_owner_id) || foLoadData_appr.approver_id == loadData[(loadData.length-1)].dept_owner_id ) {
// 												if( !(foLoadData_appr.dept_owner_id) || foLoadData_appr.approver_id == foLoadData_appr.dept_owner_id ) {
													pGbYn = "Y";
												} 
											}
										}	
										
										// 값이 맞는데 승인자가 하나면 바로 Y 쳐주기.
										// 그런데 값이 2개 이상이면 ""
												console.log('ggggggss ggggggss : ',ggggggss); 
										if(pGbYn){
											if(ggggggss.length == 1) {
												forGbYn = "Y";
												forGbNm = (ggggggss[0].control_approver_nm);
											} else {
												forGbYn = "";
												forGbNm = (ggggggss[1].control_approver_nm);
											}
										}
										
										gubunArrayDt.push(
											{ 
												control_approver_id : ggggggss[p].control_approver_id, 
												control_approver_nm : ggggggss[p].control_approver_nm, 
												level_order : ggggggss[p].level_order, 
												admin_level_type_code : ggggggss[p].admin_level_type_code, 
												admin_level_type_nm : ggggggss[p].admin_level_type_nm,
												gubun_yn : pGbYn// 
											}
										);
									}
									
									if(forGbYn) {
										obj.gubun = "승인됨";
									} else {
										obj.gubun = "승인좀";
									}
									
									obj.gubunNm = forGbNm;
									obj.appr = gubunArrayDt;
									
									stepCheckObj[ foLoadData[i].admin_level_type_code ] = obj;
								}
							}
						} else {
							if( stepCheckObj[ (foLoadData[i].admin_level_type_code) ] != undefined ) {
								// 이미 넣었으면 패스. > 아님 이제 무조건 취소됨.
								var ggggggss  = (stepCheckObj[ (foLoadData[i].admin_level_type_code) ].appr);
// 								console.log("ggggggss = ", ggggggss);
								for( var p=0; p< ggggggss.length; p++ ) {
// 									console.log("ggggggss[p] = ", ggggggss[p]);
									var pGbYn = "N";
									ggggggss[p].gubun_yn = "N";
								}
								//
							} else if( stepCheckObj[ (foLoadData[i].admin_level_type_code) ] == undefined ) {
								// 안넣었음.
								var obj = { };
								var gubunArrayDt = [];
								for( var p=0; p<controlApprData[0][(foLoadData[i].admin_level_type_code)].length; p++ ) {
									var ggggggss  = controlApprData[0][(foLoadData[i].admin_level_type_code)];
									gubunArrayDt.push(
										{ 
											control_approver_id : ggggggss[p].control_approver_id, 
											control_approver_nm : ggggggss[p].control_approver_nm, 
											level_order : ggggggss[p].level_order, 
											admin_level_type_code : ggggggss[p].admin_level_type_code, 
											admin_level_type_nm : ggggggss[p].admin_level_type_nm,
											gubun_yn : "N"
										}
									);
								}
								obj.gubun = "승인좀";
								obj.gubunNm = (controlApprData[0][(foLoadData[i].admin_level_type_code)][0].control_approver_nm);
								obj.appr = gubunArrayDt;
								
								stepCheckObj[ foLoadData[i].admin_level_type_code ] = obj;
							}
						}
					}
				}
				//
				
				if( controlLevelData.length > foLevelIdx ) {
					if( foLoadData[i].admin_level_type_code == controlLevelData[foLevelIdx].admin_level_type_code ) {
						foLevelIdx++;
					}
				}
		}
		for(var cld = 0; cld < controlLevelData.length; cld++){
			for(var cad = 0; cad < controlApprData_as.length; cad++){
				if(controlLevelData[cld].admin_level_type_code == controlApprData_as[cad].admin_level_type_code){
					controlLevelData[cld].control_approver_nm = controlApprData_as[cad].control_approver_nm;
					controlLevelData[cld].control_approver_id = controlApprData_as[cad].control_approver_id;
				
				}
				
			}
				
		}
	
		// console.log("stepCheckObj = ", stepCheckObj);
		// controlLevelData 전체 for문 해서 s 부터는 순서 넣어주기. 그 ㅈ ㅓㄴ에는 단계 있으면 단계 넣어주기로
		for( var s=0; s<controlLevelData.length; s++ ) {
			// 순서 중간마다 들어가서 킵해놓은 data 찾기.
			if( s >= foLevelIdx ) {
				if( stepCheckObj[(controlLevelData[s].admin_level_type_code)] != undefined ) {
					var appData = (stepCheckObj[(controlLevelData[s].admin_level_type_code)].appr).filter(item => item.gubun_yn == 'N');
					
					if( appData.length > 0 ) {
						save_checkT = save_checkT+ appData[0].admin_level_type_nm + " (" + appData[0].control_approver_nm +"), ";
					} 
// 					else {
// 						save_checkT = save_checkT+ controlLevelData[s].admin_level_type_nm +", ";
// 					}
				} else {
					if(controlLevelData[s].control_approver_nm){
						save_checkT = save_checkT+ controlLevelData[s].admin_level_type_nm +" ("+controlLevelData[s].control_approver_nm+"), ";
					}
					else{
						save_checkT = save_checkT+ controlLevelData[s].admin_level_type_nm +", ";
					}
				}
			} else { // 미션중
				var get_grid = w2ui[$("#grid_name").val()].get(w2ui[$("#grid_name").val()].getSelection()[0]);
				console.log('마지막 else stepCheckObj[(controlLevelData[s].admin_level_type_code)]: ',stepCheckObj[(controlLevelData[s].admin_level_type_code)]);
				if( stepCheckObj[(controlLevelData[s].admin_level_type_code)] != undefined ) {
					var appData = (stepCheckObj[(controlLevelData[s].admin_level_type_code)].appr).filter(item => item.gubun_yn == 'N');
					console.log('마지막 else appData : ',appData);
					if( appData.length > 0 ) {
						if(get_grid.admin_level_type_code != 'alt_05' && appData[0].admin_level_type_code == "alt_05"){
							 continue;
						}
						// 단계가 open을 넘어갔는데도 필요승인단계에 open이 뜨기 때문에 추가해줌	
						if(get_grid.admin_level_type_code == appData[0].admin_level_type_code){
							if(!$("#edit_appr_rep_comment").val()){ // 승인요청 텍스트박스
								save_checkT = save_checkT+ appData[0].admin_level_type_nm + " (" + appData[0].control_approver_nm +"), ";
							}
						}else{
							save_checkT = save_checkT+ appData[0].admin_level_type_nm + " (" + appData[0].control_approver_nm +"), ";
						}
					}
					// == 0 이면... 승인함으로 바꿔도 될듯?
				}
			}
		}
		return save_checkT;
	}
	
	// 이제 순서 상관 없음. 순서 안 지키는 save
	function old_fnStepCheck(foLoadData) {
		let save_checkT = "";
		let stepCheckObj = {};
		
		// loadData를 for문 돌려서 해당 단계 순서가 맞으면 idxV가 올라감.
		var foLevelIdx = 0;
		
		// ★
		// 이제부터는 모든 단계에서 마지막 단계인 것만  승인 요청 확인함/
		// 1번 test 승인 완료 4번 test 승인 반려면 < 안된걸로 함.
		
		for(var i=0; i<foLoadData.length; i++) {
				// 승인 통제가 있다면
				if( controlApprData.length > 0 ) {
					if( controlApprData[0][(foLoadData[i].admin_level_type_code)] != undefined ) { // 해당 건에 대한 통제가 있으면	
						if( foLoadData[i].status == "MD1267" || foLoadData[i].status == "MD1268" ) {
							// stepCheckObj에 값이 있으면 승인자 관련에서 해당 값이 맞는게 있는지 확인.
							// 승인자가 맞으면 gubun_yn을 Y로 해줌
							for( var p=0; p<controlApprData[0][(foLoadData[i].admin_level_type_code)].length; p++ ) {
								// 값이 들어가 있음
								if( stepCheckObj[ (foLoadData[i].admin_level_type_code) ] != undefined ) {
									var obj = { };
									var gubunArrayDt = [];
									for( var p=0; p< (stepCheckObj[ (foLoadData[i].admin_level_type_code) ].appr).length; p++ ) {
										var ggggggss  = (stepCheckObj[ (foLoadData[i].admin_level_type_code) ].appr);
										
										if( ggggggss[p].gubun_yn == "N" ) {
											
											var pGbYn = "";
											
											if( ggggggss[p].control_approver_id == "CA001" ) { 
												// 요청자 승인
												if( foLoadData[i].approver_id == selectData.owner_id ) {
													pGbYn = "Y";
													ggggggss[p].gubun_yn = "Y";
												} 
											}  else if( ggggggss[p].control_approver_id == "CA002" ) { 
												// 요청자 팀장 승인 : 팀장이 없거나 값이 같으면
												if( !(selectData.dept_owner_id) || foLoadData[i].approver_id == selectData.dept_owner_id ) {
													pGbYn = "Y";
													ggggggss[p].gubun_yn = "Y";
												} 
											} else if( ggggggss[p].control_approver_id == "CA003" ) { 
												// 처리자 승인
												if( foLoadData_appr.approver_id == foLoadData_appr.owner_id ) {
													pGbYn = "Y";
													ggggggss[p].gubun_yn = "Y";
												} 
											} else if( ggggggss[p].control_approver_id == "CA004" ) { 
												// 처리자 팀장 승인 : 팀장이 없거나 값이 같으면
												if( !(foLoadData_appr.dept_owner_id) || foLoadData_appr.approver_id == foLoadData_appr.dept_owner_id ) {
													pGbYn = "Y";
													ggggggss[p].gubun_yn = "Y";
												} 
											}
										}	
									}
								} else if( stepCheckObj[ (foLoadData[i].admin_level_type_code) ] == undefined ) {
									// 안넣었음.
									var obj = { };
									var gubunArrayDt = [];
									
									var forGbYn = ""; // 전체 조회했는데 승인자랑 일치함
									var forGbNm = ""; // 값이 없었던 승인자.
									// 뭔가 여기서 일듯 Final Review 가 안보임
									for( var p=0; p<controlApprData[0][(foLoadData[i].admin_level_type_code)].length; p++ ) {
										var ggggggss  = controlApprData[0][(foLoadData[i].admin_level_type_code)];
										var pGbYn = "N";
										
										if( ggggggss[p].control_approver_id == "CA001" ) { 
											// 요청자 승인
											
											if( foLoadData[i].approver_id == selectData.owner_id ) {
												pGbYn = "Y";
											} 
										} else if( ggggggss[p].control_approver_id == "CA002" ) { 
											// 요청자 팀장 승인 : 팀장이 없거나 값이 같으면
											
											if( !(selectData.dept_owner_id) || foLoadData[i].approver_id == selectData.dept_owner_id ) {
												pGbYn = "Y";
											} 
										} else if( ggggggss[p].control_approver_id == "CA003" ) { 
											// 처리자 승인
											
											if( foLoadData[i].approver_id == selectData.n_owner_id ) {
												pGbYn = "Y";
											} 
										} else if( ggggggss[p].control_approver_id == "CA004" ) { 
											// 처리자 승인 : 팀장이 없거나 값이 같으면
											
											if( !(loadData[(loadData.length-1)].dept_owner_id) || foLoadData[i].approver_id == loadData[(loadData.length-1)].dept_owner_id ) {
												pGbYn = "Y";
											} 
										}
										
										// 값이 맞는데 승인자가 하나면 바로 Y 쳐주기.
										// 그런데 값이 2개 이상이면 ""
										if(pGbYn){
											if(ggggggss.length == 1) {
												forGbYn = "Y";
												forGbNm = (ggggggss[0].control_approver_nm);
											} else {
												forGbYn = "";
												forGbNm = (ggggggss[1].control_approver_nm);
											}
										}
										
										gubunArrayDt.push(
											{ 
												control_approver_id : ggggggss[p].control_approver_id, 
												control_approver_nm : ggggggss[p].control_approver_nm, 
												level_order : ggggggss[p].level_order, 
												admin_level_type_code : ggggggss[p].admin_level_type_code, 
												admin_level_type_nm : ggggggss[p].admin_level_type_nm,
												gubun_yn : pGbYn// 
											}
										);
									}
									
									if(forGbYn) {
										obj.gubun = "승인됨";
									} else {
										obj.gubun = "승인좀";
									}
									
									obj.gubunNm = forGbNm;
									obj.appr = gubunArrayDt;
									
									stepCheckObj[ foLoadData[i].admin_level_type_code ] = obj;
								}
							}
						} else {
							if( stepCheckObj[ (foLoadData[i].admin_level_type_code) ] != undefined ) {
								// 이미 넣었으면 패스.
							} else if( stepCheckObj[ (foLoadData[i].admin_level_type_code) ] == undefined ) {
								// 안넣었음.
								var obj = { };
								var gubunArrayDt = [];
								for( var p=0; p<controlApprData[0][(foLoadData[i].admin_level_type_code)].length; p++ ) {
									var ggggggss  = controlApprData[0][(foLoadData[i].admin_level_type_code)];
									gubunArrayDt.push(
										{ 
											control_approver_id : ggggggss[p].control_approver_id, 
											control_approver_nm : ggggggss[p].control_approver_nm, 
											level_order : ggggggss[p].level_order, 
											admin_level_type_code : ggggggss[p].admin_level_type_code, 
											admin_level_type_nm : ggggggss[p].admin_level_type_nm,
											gubun_yn : "N"
										}
									);
								}
								obj.gubun = "승인좀";
								obj.gubunNm = (controlApprData[0][(foLoadData[i].admin_level_type_code)][0].control_approver_nm);
								obj.appr = gubunArrayDt;
								
								stepCheckObj[ foLoadData[i].admin_level_type_code ] = obj;
							}
						}
					}
				}
				//
				
				if( controlLevelData.length > foLevelIdx ) {
					if( foLoadData[i].admin_level_type_code == controlLevelData[foLevelIdx].admin_level_type_code ) {
						foLevelIdx++;
					}
				}
		}
		
		// controlLevelData 전체 for문 해서 s 부터는 순서 넣어주기. 그 ㅈ ㅓㄴ에는 단계 있으면 단계 넣어주기로
		for( var s=0; s<controlLevelData.length; s++ ) {
			// 순서 중간마다 들어가서 킵해놓은 data 찾기.
			if( s >= foLevelIdx ) {
				if( stepCheckObj[(controlLevelData[s].admin_level_type_code)] != undefined ) {
					var appData = (stepCheckObj[(controlLevelData[s].admin_level_type_code)].appr).filter(item => item.gubun_yn == 'N');
					
					if( appData.length > 0 ) {
						save_checkT = save_checkT+ appData[0].admin_level_type_nm + " (" + appData[0].control_approver_nm +"), ";
					} else {
						save_checkT = save_checkT+ controlLevelData[s].admin_level_type_nm +" (요청자 팀장 승인), ";
					}
				} else {
					save_checkT = save_checkT+ controlLevelData[s].admin_level_type_nm +" (요청자 팀장 승인), ";
				}
			} else {
				if( stepCheckObj[(controlLevelData[s].admin_level_type_code)] != undefined ) {
					var appData = (stepCheckObj[(controlLevelData[s].admin_level_type_code)].appr).filter(item => item.gubun_yn == 'N');
					if( appData.length > 0 ) {
						save_checkT = save_checkT+ appData[0].admin_level_type_nm + " (" + appData[0].control_approver_nm +"), ";
					}
					// == 0 이면... 승인함으로 바꿔도 될듯?
				}
			}
		}
		return save_checkT;
	}
	
	// 헤더 수정 부분.
	function editCaseHeader(page_link) {
// 		fnMessageModalConfirm("Notification", "입력한 내용을 수정하시겠습니까?", function(result) {
// 			if(result) {
		console.log('editCaseHeader');
				let save_checkT = "";
				
				let status = $("#detail_done_status").val();
				
				// Header의 단계가 Closed (Success) 이고, 상태를 Completed로 변경하여 저장할 때
				if( selectData.admin_level_type_code == "alt_02" && status == "MD1258" ) {
					if( controlLevelData.length > 0 ) {
						// 무조건 level 순서대로 가게 되어 있음.
						var foLoadData = [];
						// sub-case에서 특정 Step값을 가진 배열만 뽑아서 그걸로 for문해서
						for(var i=0; i<loadData.length; i++) {
							for(var j=0; j<controlLevelData.length; j++) {
								if( loadData[i].admin_level_type_code == controlLevelData[j].admin_level_type_code ) {
									foLoadData.push( loadData[i] );
								}
							}
						}

						// 0516 0602_1
						// ★★★★★★★★★★★★★★★★★★★★★★★ 헤더 케이스를 수정했을 때
						// 이제 여기 step 통제 순서 부분이 순서가 1 2 3 2 4 1 5 라 해도 > 12345 OK 가 되도록.
						// 전체 for문을 돌려서 해당 인덱스가 맞으면..??
						// 다음 step 이 맞으면 ++ 아니면 idx 냅두기.
						// open에서도 appr 확인해야하니
						// json.parse() < 로 현재 sub 가져오고 거기에 메인 case get한 값 alt_05로 하고 0인덱스에 합쳐서 for문하기 ㅇㅇ
						let getGData = JSON.parse(JSON.stringify( w2ui["grid_master"].get(1) ));
						getGData.admin_level_type_code = "alt_05";
						getGData.admin_level_type_nm = "Open";
						
						foLoadData.splice(0, 0, getGData);
						// console.log("foLoadData = ", foLoadData);
						
						save_checkT = fnStepCheck(foLoadData);
						
						if (save_checkT) {
							$("#save_check").css('display', '');
							// ★★
							let tttttt = "필요 단계 및 승인: "+save_checkT.substring(0, save_checkT.length-2);
							$("#save_check").text(tttttt);
							return;
						}
					}
				}	
				
				let title = $("#detail_title").val();
				if($.trim(title).length == 0) {
					save_checkT = save_checkT+"제목, ";
				}

				let processed_type_code = $("#detail_sel_process option:selected").val();
				if( selectData.admin_level_type_code != "alt_05" && $.trim(processed_type_code).length == 0 ) {
					save_checkT = save_checkT+"작업 분류, ";
				}
				
				// 통제 필수
				// ㅌㅈ ㅂㄹ
				let control_gubun = $("#detail_sel_control option:selected").val();
				if( $.trim(control_gubun).length == 0 ) {
					save_checkT = save_checkT+"통제 분류, ";
				}
				
				
				let plan_due_date = $("#detail_plan_due_date").val();
				if( selectData.admin_level_type_code != "alt_05" && $.trim(plan_due_date).length == 0 ) {
					save_checkT = save_checkT+"예상 완료일, ";
				}
				
				let old_status = $("#detail_old_status").val();
				
				if( !status ) {
// 					status = $("#detail_old_status").val();
// 					fnMessageModalAlert("Notification", "Status를 선택하세요.");
					save_checkT = save_checkT+"상태, ";
				}
				
				if (save_checkT) {
					$("#save_check").css('display', '');
					
					let tttttt = "다음 입력란을 작성하세요: "+save_checkT.substring(0, save_checkT.length-2);
					$("#save_check").text(tttttt);
					return;
				} else {
					$("#save_check").text('');
				}
				
				let priority_code = $("#detail_sel_priority2 option:selected").val();
				
				// 대,중,소분류, 대상
				let system_info_code = $("#detail_sel_syInfo option:selected").val();
				let request_type = $("#detail_selR_type option:selected").val();
				let request_category = $("#detail_selR_category option:selected").val();
				let request_category_item = $("#detail_selR_categoryItem option:selected").val();
				
				let request_id = $('#sel_request_id').val();
				let service_process_id = $('#sel_service_process_id').val();
				let request_seq = $('#sel_request_seq').val();
				
				let requester_id = $('#edit_appr_requester_id').val();
				let requester_nm = $('#edit_appr_requester_nm').val();
				
				let approver_id = "";
				let approver_nm = "";
				let req_comment = "";
				let rep_comment = "";
				
				if( status == "MD1267" || status == "MD1268" ) { // 승인, 승인 반려
					approver_id = $("#edit_appr_approver_id").val();
					approver_nm = $("#edit_appr_approver_nm").val();
					req_comment = $("#edit_appr_req_comment").val();
					rep_comment = $("#edit_appr_rep_comment").val();
				}
				
				let sendData = { 
					request_id			: request_id, 
					service_process_id	: service_process_id, 
					
					title				: title, 
					plan_due_date		: plan_due_date, 
					processed_type_code	: processed_type_code, 
					requester_id		: requester_id,
					requester_nm		: requester_nm, 
					req_comment			: req_comment, 
					
					control_gubun		: control_gubun, 
					
					// 대,중,소분류, 대상
					system_info_code 		: system_info_code, 
					request_type 			: request_type, 
					request_category 		: request_category, 
					request_category_item 	: request_category_item, 
					
					priority_code		: priority_code,
					
					approver_id			: approver_id, 
					approver_nm			: approver_nm, 
					rep_comment			: rep_comment, 					
					
					status				: status
				};
				
				var page_url = "/case/admin/updateCase_header_all";
				
				$.ajax({
					url : page_url,
					type : 'POST',
					data : sendData, 
					dataType : 'json',
					async : false,
					success : function( data ) {
						if(data.status == 200 ) {
							fnMessageModalAlert("Notification", "헤더 Case 변경이 완료되었습니다.");
							
							loadList2();
							loadList2_sub();
							
							fnControlStep(control_gubun);
							fnControlAppr(control_gubun);
							
							// 헤더 owner_id가 member_id 이면 작성자니... 완료 상관없
							if(w2ui["grid_master"].get(1).owner_id != member_id) {
								if( old_status != status && status == "MD1258" ) { // 헤더 Case의 상태가 Completed가 아닌 것에서 Completed가 될 때
									var page_link_u = page_link.replace('test_case','new_1');
									fnMailSend("/mail/mailSending_7", request_seq, status, member_nm, page_link_u);
								}
							}
							// 일단은 request와 owner가 같아도 승인 요청자만 조건 걸자. >> 메일 받는건 다른 사람이니.
							if ( (status == "MD1267" || status == "MD1268") && requester_id != member_id ) { // 승인자가 요청된 승인을 저장할 때
								page_link = page_link.replace('test_case','new_1');
								fnMailSend("/mail/mailSending_3", request_seq, status, rep_comment, req_comment, requester_id, page_link);
							}
						} else {
							fnMessageModalAlert("Error", "실패했습니다. 다시 등록해 주세요.");
						}
					},
					complete: function () {
// 	                	w2ui["grid_master"].expand(1);
						setTimeout(function(){
							$('#modal_message button.close').click();
						}, 600);
	                	setTimeout(function () {
			        		w2ui['grid_master'].selectNone();
			        		w2ui['subGridO'].selectNone();
			        		w2ui['grid_master'].select(1);
	        			}, 300);
					}
				});
// 			}
// 		});
	}
	
	function editPartnerCase() {
		console.log('editPartnerCase');
			let recid = w2ui[$("#grid_name").val()].getSelection()[0];
			
			let request_id = $('#sel_request_id').val();
			let service_process_id = $('#sel_service_process_id').val();
			let service_process_seq = $('#sel_service_process_seq').val();
			let request_seq = $('#sel_request_seq').val();
			// ㅌㅈ ㅂㄹ
			let control_gubun = $("#detail_sel_control option:selected").val();
			
			let file_group = "";
			let allCount = Number($("#append_down")[0].childElementCount);
			
			for(var i=0; i<allCount; i++ ) {
				let href = $("#append_down")[0].childNodes[i].childNodes[1].href;
				let fileGroup = href.substring( href.indexOf('file_group=')+11, href.indexOf('&file_name=') );
				if(i == 0) {
					file_group = fileGroup;
				} else {
					file_group = file_group + "," + fileGroup;
				}
			}
// 			let owner_id = $('#detail_owner_id').val();
// 			let owner_nm = $('#detail_owner_nm').val();
			
			let html_length =  (descEditor.html.get()).length;
			let html_data =  descEditor.html.get();
			
			// 추가 ★
			// Powered by Froala Editor 지우기.
			let text = '<p data-f-id="pbf" style="text-align: center; font-size: 14px; margin-top: 30px; opacity: 0.65; font-family: sans-serif;">Powered by <a href="https://www.froala.com/wysiwyg-editor?pb=1" title="Froala Editor">Froala Editor</a></p>';
			let frContext = descEditor.html.get();
			while(true)	{
				let idx = frContext.indexOf(text);
				frContext = frContext.replace(text, "");
				if ( frContext.indexOf(text) < 0 ) {
					break; 
				}
			}
			html_length =  (frContext).length;
			html_data = frContext;
			
			let sendData = { 
				body_data			: JSON.stringify(html_data), 
				frData	 			: html_data, 
				
				request_id			: request_id, 
				service_process_id	: service_process_id, 
				service_process_seq : service_process_seq, 
				
				control_gubun		: control_gubun, 
				
				file_group			: file_group
// 				, status				: status, 
				
// 				owner_id			: owner_id,
// 				owner_nm			: owner_nm,
			};
			
			var page_url = "/case/admin/updatePartnerCase";
			
			$.ajax({
				url : page_url,
				type : 'POST',
				data : sendData, 
				dataType : 'json',
				async : false,
				success : function( data ) {
					if(data.status == 200 ) {
						fnMessageModalAlert("Notification", "Case 변경이 완료되었습니다.");
						loadList2();
						loadList2_sub();
					} else {
						fnMessageModalAlert("Error", "실패했습니다. 다시 등록해 주세요.");
					}
				},
				complete: function () {
					setTimeout(function(){ 
						$('#modal_message button.close').click();
					}, 600);
                	setTimeout(function () {
		        		w2ui['grid_master'].selectNone();
		        		w2ui['subGridO'].selectNone();
		        		w2ui[ $("#grid_name").val() ].select(recid);
            			w2ui[ $("#grid_name").val() ].scrollIntoView(recid);
        			}, 300);
				}
			});
	}
	
	function editCase(page_link) {
// 		fnMessageModalConfirm("Notification", "입력한 내용을 수정하시겠습니까?", function(result) {
// 			if(result) {
			console.log('editCase');
				let save_checkT = "";
				
				let title = $("#detail_title").val();
				let processed_type_code = $("#detail_sel_process option:selected").val();
				let status = $("#detail_done_status").val();
				
				if($.trim(title).length == 0) {
					save_checkT = save_checkT+"제목, ";
// 					fnMessageModalAlert("Notification", "Title을 입력하세요.");
// 					return;
				}
				
				// 이전도 현재도 승인 요청이면..
				if( $("#detail_old_status").val() == "MD1266" && status == "MD1266" ) {
// 					if( $("#detail_old_status").val() == "MD1266" ) {
						save_checkT = save_checkT+"승인, ";
// 						fnMessageModalAlert("Notification", "Approval Info를 입력해 주세요.");
// 						return;
// 					} else {
// 						status = $("#detail_old_status").val();
// 					}
				}
				if ( $('#detail_sel_process').attr('disabled') == undefined ) {
					if($.trim(processed_type_code).length == 0) {
						save_checkT = save_checkT+"작업 분류, ";
// 						fnMessageModalAlert("Notification", "Process Type을 선택하세요.");
// 						return;
					}
				}
				
				// ㅌㅈ ㅂㄹ
				let control_gubun = $("#detail_sel_control option:selected").val();
				if ( $("#detail_sel_control").attr('disabled') == undefined ) {
					if($.trim(control_gubun).length == 0) {
						save_checkT = save_checkT+"통제 분류, ";
					}
				}
				
				let plan_due_date = $("#detail_plan_due_date").val();
				if( !plan_due_date ) {
					save_checkT = save_checkT+"예상 완료일, ";
				}
				
				if (save_checkT) {
					$("#save_check").css('display', '');
					
					let tttttt = "다음 입력란을 작성하세요: "+save_checkT.substring(0, save_checkT.length-2);
					$("#save_check").text(tttttt);
					return;
				} else {
					$("#save_check").text('');
				}
				
				let priority_code = $("#detail_sel_priority2 option:selected").val();
				
				// 대,중,소분류, 대상
				let system_info_code = $("#detail_sel_syInfo option:selected").val();
				let request_type = $("#detail_selR_type option:selected").val();
				let request_category = $("#detail_selR_category option:selected").val();
				let request_category_item = $("#detail_selR_categoryItem option:selected").val();
				
				let recid = w2ui[$("#grid_name").val()].getSelection()[0];
				
				let request_id = $('#sel_request_id').val();
				let service_process_id = $('#sel_service_process_id').val();
				let service_process_seq = $('#sel_service_process_seq').val();
				let request_seq = $('#sel_request_seq').val();
				
				let file_group = "";
				let allCount = Number($("#append_down")[0].childElementCount);
				
				for(var i=0; i<allCount; i++ ) {
					let href = $("#append_down")[0].childNodes[i].childNodes[1].href;
					let fileGroup = href.substring( href.indexOf('file_group=')+11, href.indexOf('&file_name=') );
					if(i == 0) {
						file_group = fileGroup;
					} else {
						file_group = file_group + "," + fileGroup;
					}
				}
				
				let prtUser = $("input[name=hidden_prt_user]");
				let prtuserData = [];
				for(var i=0; i<prtUser.length; i++){
					let idIdx = $("input[name=hidden_prt_user]")[i].id;
					idIdx = idIdx.substring(("hidden_prt_user_no_").length);
					prtuserData.push(
						{ 
							user_no : $("#hidden_prt_user_no_"+idIdx).val(), 
							user_id : $("#hidden_prt_user_id_"+idIdx).val(), 
							user_nm : $("#label_prt_user_"+idIdx).text().substring(0, $("#label_prt_user_"+idIdx).text().length-1 )
						}		
					);
				}
				
				let owner_id = $('#detail_owner_id').val();
				let owner_nm = $('#detail_owner_nm').val();
				
				let requester_id = $('#edit_appr_requester_id').val();
				let requester_nm = $('#edit_appr_requester_nm').val();
				
				let approver_id = "";
				let approver_nm = "";
				let comment = "";
				let req_comment = "";
				let rep_comment = "";
				
				if( status == "MD1266" ) { // 승인 요청 수정
					approver_id = $("#edit_appr_approver_id").val();
					approver_nm = $("#edit_appr_approver_nm").val();
					if ( $.trim($("#edit_appr_req_comment").val()).length == 0 ) {
						$("#edit_appr_req_comment").val("승인 요청드립니다.");
					}
					comment = $("#edit_appr_req_comment").val();
				} else if( status == "MD1267" || status == "MD1268" ) { // 승인, 승인 반려
					approver_id = $("#edit_appr_approver_id").val();
					approver_nm = $("#edit_appr_approver_nm").val();
					req_comment = $("#edit_appr_req_comment").val();
					rep_comment = $("#edit_appr_rep_comment").val();
				}
				
				let html_length =  (descEditor.html.get()).length;
				let html_data =  descEditor.html.get();
				
				// 추가 ★
				// Powered by Froala Editor 지우기.
				let text = '<p data-f-id="pbf" style="text-align: center; font-size: 14px; margin-top: 30px; opacity: 0.65; font-family: sans-serif;">Powered by <a href="https://www.froala.com/wysiwyg-editor?pb=1" title="Froala Editor">Froala Editor</a></p>';
				let frContext = descEditor.html.get();
				while(true)	{
					let idx = frContext.indexOf(text);
					frContext = frContext.replace(text, "");
					if ( frContext.indexOf(text) < 0 ) {
						break; 
					}
				}
				html_length =  (frContext).length;
				html_data = frContext;
				
				let sendData = { 
					body_data			: JSON.stringify(html_data), 
					frData	 			: html_data, 
					
					request_id			: request_id, 
					service_process_id	: service_process_id, 
					service_process_seq : service_process_seq, 
					
					title				: title, 
					processed_type_code	: processed_type_code, 
					plan_due_date		: plan_due_date, 
					
					priority_code		: priority_code, 
					
					control_gubun		: control_gubun, 
					
					// 대,중,소분류, 대상
					system_info_code 		: system_info_code, 
					request_type 			: request_type, 
					request_category 		: request_category, 
					request_category_item 	: request_category_item, 
					
					file_group			: file_group, 
					status				: status, 
					
					owner_id			: owner_id,
					owner_nm			: owner_nm,
					
					requester_id		: requester_id,
					requester_nm		: requester_nm, 
					
					approver_id			: approver_id, 
					approver_nm			: approver_nm, 
					
					comment				: comment, 
					req_comment			: req_comment, 
					rep_comment			: rep_comment, 
					
					prtuserData			: JSON.stringify(prtuserData)
				};
				
				var page_url = "/case/admin/updateCase";
				
				$.ajax({
					url : page_url,
					type : 'POST',
					data : sendData, 
					dataType : 'json',
					async : false,
					success : function( data ) {
						if(data.status == 200 ) {
							fnMessageModalAlert("Notification", "Case 변경이 완료되었습니다.");
							
							loadList2();
							loadList2_sub();
							
							// 일단은 request와 owner가 같아도 승인 요청자만 조건 걸자. >> 메일 받는건 다른 사람이니.
							// 승인 요청일때 if
							if( status == "MD1266" && approver_id != member_id ) { // 승인 요청 등록
// 								comment = $("#new_appr_req_comment").val();
								page_link = page_link.replace('test_case', 'appr_admin_list');
								fnMailSend("/mail/mailSending_2", request_seq, status, '', comment, member_nm, page_link);
							} else if ( (status == "MD1267" || status == "MD1268") && requester_id != member_id ) { // 승인자가 요청된 승인을 저장할 때
// 								page_link = page_link.replace('test_case', 'appr_admin_list');
								fnMailSend("/mail/mailSending_3", request_seq, status, rep_comment, req_comment, requester_id, page_link);
							}
							
							
						} else {
							fnMessageModalAlert("Error", "실패했습니다. 다시 변경해 주세요.");
						}
					},
					complete: function () {
// 	                	w2ui["grid_master"].expand(1);
						setTimeout(function(){ 
							$('#modal_message button.close').click();
						}, 600);
	                	setTimeout(function () {
			        		w2ui['grid_master'].selectNone();
			        		w2ui['subGridO'].selectNone();
			        		w2ui[ $("#grid_name").val() ].select(recid);
                			w2ui[ $("#grid_name").val() ].scrollIntoView(recid);
	        			}, 300);
					}
				});
// 			}
// 		});
	}
	
	function deleteCaseInfo() {
		fnMessageModalConfirm("Notification", "선택한 Case를 삭제하시겠습니까?", function(result) {
			if(result) {
				let request_id = $('#sel_request_id').val();
				let service_process_id = $('#sel_service_process_id').val();
				
				let sendData = { 
					request_id			: request_id,
					service_process_id	: service_process_id,
					status 				: "MD1256",
					use_yn 				: "N"
				};
				
				var page_url = "/case/admin/deleteCase";
				
				$.ajax({
					url : page_url,
					type : 'POST',
					data : sendData, 
					dataType : 'json',
					async : false,
					success : function( data ) {
						if(data.status == 200 ) {
							fnMessageModalAlert("Notification", "삭제가 완료됐습니다.");
							
							$("#append_user").empty();
							$("#detail_delete_btn").css("display", "none");
							$("#detail_owner_btn").css("display", "none");
							loadList2();
							loadList2_sub();
						} else {
							fnMessageModalAlert("Error", "실패했습니다. 다시 시도해 주세요.");
						}
					},
					complete: function () {
// 	                	w2ui["grid_master"].expand(1);
						setTimeout(function(){ 
							$('#modal_message button.close').click();
						}, 600);
	                	setTimeout(function () {
			        		w2ui['grid_master'].selectNone();
			        		w2ui['subGridO'].selectNone();
			        		w2ui['grid_master'].select(1);
	        			}, 300);
					}
				});
			}
		});
	}
	
	function fnMainGrid() {
		$('#grid_main').w2grid({
			name: 'grid_main',
			fixedBody : true,
			recordHeight : 30, // 60, 
			style: 'font-size:15pt;',
			show: {
				selectColumn: false,
				lineNumbers : false,
				expandColumn: true, 
				footer: false
			},
			multiSort : true, 
			multiSelect : false, 
			columns: [
					{ field: 'request_seq', caption: 'Case번호', size: '8%', name:'excelExportList',
					  style: 'text-align:center', sortable: true }, 
					
					{ field: 'n_approver_id', caption: 'New Approver Id', size: '40%', 
					  style: 'text-align:center', sortable: true, hidden: true }, 
					  
					{ field: 'n_approver_nm', caption: 'New Approver Nm', size: '12%', 
					  style: 'text-align:center', sortable: true, hidden: true }, 	
		
		            { field: 'process_date', caption: '요청 일시', size: '12%', name:'excelExportList',
				      style: 'text-align:center', sortable: true }, 
// 		            { field: 'request_date', caption: '요청 일시', size: '12%', 
// 				      style: 'text-align:center', sortable: true }, 
		            
		            { field: 'owner_id', caption: 'Requester', size: '14%', 
				      style: 'text-align:center', sortable: true, hidden: true }, 
		            
		            { field: 'owner_nm', caption: '요청자', size: '7%', name:'excelExportList',
				      style: 'text-align:center', sortable: true }, 
			            
		            { field: 'system_info_nm', caption: '요청 대상', size: '12%', name:'excelExportList',
				      style: 'text-align:center', sortable: true }, 
		            	
			        { field: 'request_type_nm', caption: '요청 분류', size: '14%', name:'excelExportList',
				      style: 'text-align:center;', sortable: true }, 
				    	
					{ field: 'title', caption: '제목', size: '30%', name:'excelExportList',
				      style: 'text-align:center', sortable: true }, 
		            
					{ field: 'context', caption: 'Context', size: '40%', 
					  style: 'text-align:center', sortable: true, hidden: true }, 
					
					{ field: 'n_owner_id', caption: 'Owner Id', size: '14%', 
					  style: 'text-align:center', sortable: true, hidden: true }, 
							
					{ field: 'value1', caption: '처리 일시', size: '12%', name:'excelExportList',
					  style: 'text-align:center', sortable: true }, 
					  
					{ field: 'n_owner_nm', caption: '처리자', size: '7%', name:'excelExportList',
					  style: 'text-align:center', sortable: true }, 
					
					{ field: 'control_gubun_nm', caption: '통제분류', size: '11%', name:'excelExportList',
					  style: 'text-align:center' }, 
					  
					{ field: 'file_group', caption: 'File No', size: '10%', 
					  style: 'text-align:center', hidden: true }, 
							
		            { field: 'work_status', caption: '단계', size: '10%', name:'excelExportList',
					  style: 'text-align:center', sortable: true }, 
		            
		            { field: 'status_nm', caption: '상태', size: '10%', style: 'text-align:center', name:'excelExportList',
						  sortable: true, 
						  render: function (record, index, col_index) {
	                        if (record.status == "MD1258") {
	                            return "Completed";
	                        } else {
	                        	return record.status_nm;
	                        }
	                     }
		            },
					{ field: 'requester_nm', caption: '승인요청자', size: '12%', name:'excelExportList', // 엑셀 보류 name:'excelExportList',
					  style: 'text-align:center', sortable: true, hidden: true }, 	
					  
	 		        { field: 'request_date', caption: '승인 요청일시', size: '12%', name:'excelExportList', // 엑셀 보류 원본 : 요청 일시 (주석처리 되어 있었음)
				      style: 'text-align:center', sortable: true, hidden: true }, 

				  	{ field: 'approver_id', caption: '승인자ID', size: '40%', 
					  style: 'text-align:center', sortable: true, hidden: true }, 
					  
					{ field: 'approver_nm', caption: '승인자', size: '12%', name:'excelExportList',// 엑셀 보류
					  style: 'text-align:center', sortable: true, hidden: true }, 	
					  
					{ field: 'date_updated', caption: '승인일시', size: '12%', name:'excelExportList',// 엑셀 보류
					  style: 'text-align:center', sortable: true, hidden: true }, 	
					  
					{ field: 'request_id', caption: 'Request Id', size: '40%', 
					  style: 'text-align:center', sortable: true, hidden: true }
			],
			records: [ ],
			onSelect: function (event) {
				let grid = this;
				// grid_main
				event.onComplete = function () {
			        let sel = grid.getSelection();
			        if (sel.length) {
			        	
			        	sessionStorage.setItem('clickCircle',$("#c_clickCircle_div #clickCircle").val());
			        	sessionStorage.setItem('rdo_all_data_yn',$(":radio[name='rdo_all_data_yn']:checked").val());
			        	sessionStorage.setItem('sel_owner',$("#sel_owner option:selected").val());
			        	sessionStorage.setItem('status_nm_info' ,$("#status_nm_info option:selected").val());
			        	sessionStorage.setItem('sel_ct_gubun' ,$("#sel_ct_gubun option:selected").val());
			        	sessionStorage.setItem('process_date' ,$("#process_date").val());
			        	sessionStorage.setItem('date_updated' ,$("#date_updated").val());
			        	sessionStorage.setItem('hap_search' ,$("#hap_search").val());
			        	
			        	let getData = grid.get(sel[0]);
			            $("#hiddenRow").val(getData.request_id);
			            
			            $("#input_text").val(window.location.origin+"/frontend/location/menus/test_case?request_seq=" + encodeURIComponent(getData.request_seq));
			            
	                	loadList2();
	                	loadList2_sub();
			            fnSelRequest("category", getData.request_type);
			            fnSelRequest("categoryItem", getData.request_category);
			            
// 			            w2ui['grid_master'].fixedBody = false;
// 	               		$("#grid_master").height("");
	               		$("#selDiv").css("display", "");
	               		
	                	setTimeout(function () {
	                		w2ui['grid_master'].refresh();
// 		                	w2ui["grid_master"].expand(1);
	                		setTimeout(function () {
			               		$("#mainDiv").css("display", "none");
			               		w2ui['grid_master'].select(1);
			               		setTimeout(function () {
				                	var sub_grid = w2ui['subGridO'].records;
				                	for(var i = 0; i < sub_grid.length; i++){
				                		if(sub_grid[i].request_seq == page_request_seq_dtl){
					                		w2ui['subGridO'].select(sub_grid[i].recid);
				                		}
				                	}
			               		}, 200);
		                	}, 300);
	                	}, 200);
			        } else {
			            select_customer = undefined;
			        }
		        }
		    }, 
		    onSort: function(event) {
		    	event.onComplete = function () {
		    		w2ui['grid_main'].reload();
		        }
		    }, 
		    onExpand: function (event) {
		    	if (w2ui.hasOwnProperty('mSubGrid-' + event.recid)) w2ui['mSubGrid-' + event.recid].destroy();
		        $('#' + event.box_id).css({ margin: '0px', padding: '0px', width: '100%' }).animate({ height: '100px' }, 100);
		        // grid_grid_main_rec_3_expanded
		        $('#grid_grid_main_rec_' + event.recid+'_expanded').addClass("subGridStyle");
		        
        		loadList_sub(event);
		    }	
		});
		loadList();
		var inner_height = window.innerHeight;
		 $("#grid_main").css("height",inner_height/2);
	}
	
	// descEditor.html.set(selData.request_form_context);
	
	// process로 바꾸자.
	function loadPrForm() {
		// select id 바꾸자
		let sel_process = $("#detail_sel_process option:selected").val();
		let sel_levelType = $("#detail_sel_levelType option:selected").val();
		if ( !sel_process || !sel_levelType ) {
			return;
		}
		var page_url = "/backend/code/selectProcessForm";
		var postData = {
			process_form_id	: sel_process, 
			admin_level_id	: sel_levelType, 
			use_yn			: "Y"
		};
		
// 		if( (descEditor.html.get()).length == 0 ) {
// 			descEditor.html.set('');
// 		}
		
		$.ajax({
			url:page_url, 
			type:'POST', 
			data : postData, 
			dataType: 'json', 
			async : false,
			success: function( data ) {
				if(data.status == "200" && (data.rows).length>0 ) {
					rowArr = data.rows;
					// 헤더 수정할때
					if( $("#sel_gubun").val() == "edit" && $("#grid_name").val() == "grid_master" ) {
						
					} else {
						descEditor.html.set(rowArr[0].process_form_context + descEditor.html.get());
// 						descEditor.html.set(descEditor.html.get() + rowArr[0].process_form_context);
					}
// 					descEditor.html.set(rowArr[0].process_form_context);
				}
			},
			complete: function() {
				
			}
		});
	}
	
	function fnSetGrid(){
	    $('#grid_master').w2grid({
	        name: 'grid_master',
// 	        fixedBody : true,
	        recordHeight : 30, // 60, 
	        style: 'font-size:15pt;',
	        show: {
	        	header : false, 
	            selectColumn: false,
	            lineNumbers : false,
// 		        expandColumn: true, 
	            footer: false
	        },
	        multiSort : false, 
	        multiSelect : false, 
	        columns: [
	             // 
				{ field: 'request_seq', caption : 'Case 번호', size : '13%', // 133px > 13%
					hidden: false, style : 'text-align:center', sortable : false }, 
				
				{ field: 'approver_id', caption : 'Approver Id', size : '40%', 
					hidden: true, style : 'text-align:center', sortable : false }, 
				{ field: 'approver_nm', caption : 'Approver Nm', size : '12%', 
					hidden: true, style : 'text-align:center', sortable : false }, 	
				
				{ field: 'request_id', caption : 'Request Id', size : '40%', 
					hidden: true, style : 'text-align:center', sortable : false }, 
				
				// 
	            { field: 'work_status', caption : '단계', size : '100px', style : 'text-align:center' }, // 10% 17%
					
				// owner_nm > 헤더
	            { field: 'n_owner_nm', caption : '처리자', size : '80px', // Requester // 14% 24% 20%
	            	style : 'text-align:center', sortable : false }, 
		            
	            { field: 'system_info_nm', caption : '요청 대상', size : '14%', 
            		hidden: true, style : 'text-align:center', sortable : false }, 
	            	
		        { field: 'request_type_nm', caption : '요청 분류', size : '14%',
           			hidden: true, style : 'text-align:center;', sortable : false}, 
			    
				{ field: 'title', caption : '제목', size : '36%', 
           			hidden: true, style : 'text-align:center', sortable : false }, 
	            
				{ field: 'context', caption : 'Context', size : '40%', 
					hidden: true, style : 'text-align:center', sortable : false}, 
				
				{ field: 'n_owner_id', caption : 'Owner Id', size : '14%', 
					hidden: true, style : 'text-align:center', sortable : false}, 
				
				{ field: 'n_owner_nm', caption : 'Owner', size : '14%', 
					hidden: true, style : 'text-align:center', sortable : false}, 
				
				{ field:'file_name', caption:'File Name', size:'10%', style:'text-align:center', hidden:true }, 
				{ field:'down_link', caption:'File', size:'10%', style:'text-align:center', hidden:true }, 
				{ field:'file_group', caption:'File No', size:'10%', style:'text-align:center', hidden: true }, 
				
	         	// 
	            { field: 'status_nm', caption : '상태', size : '140px', style : 'text-align:center', 
                   	render: function (record, index, col_index) {
                        if (record.status == "MD1258") {
                            return "Completed";
                        } else {
                        	return record.status_nm;
                        }
                     }
				}, // 10% 18%
	         	// 
	            { field: 'process_date', caption : '요청 일시', size : '19%', // 12% 
	            	style : 'text-align:center', sortable : false }
            	
	        ],
	        records: [ ],
	        onSelect: function (event) {
	            let grid = this;
	            event.onComplete = function () {
			        let sel = grid.getSelection();
			        if (sel.length) {
			        	// grid_master
			        	console.log('grid_master 선택 선택');
			        	$("#save_check").text('');
			        	$("#save_check").css('display', 'none');
			        	
			        	$("#grid_name").val(grid.name);
			        	$(".gray-theme.fr-box.fr-basic.fr-top .fr-wrapper").css({ "border-top":"1px solid #AAAAAA", "border-radius":"5px"});
			        	let getData = grid.get(sel[0]);
			        	selectData = JSON.parse(JSON.stringify( getData ));
			        	fnControlStep(selectData.control_gubun);
			        	fnControlAppr(selectData.control_gubun);
			        	
			        	var chk = document.getElementById('mainDiv').style.display;
// 			        	if( chk == "none" ) {
// 			        		w2ui["grid_master"].expand(1);
			        		w2ui['subGridO'].selectNone();
// 			        	}
			        	
			            $("#sel_request_seq").val(selectData.request_seq);
			            $("#sel_service_process_id").val(selectData.service_process_id);
			            $("#sel_service_process_seq").val(selectData.service_process_seq);
						
	               		apprLoadList( selectData.request_id, selectData.service_process_id );
	               		// 헤더 선택시에는 request_id만 가져가서 모든 case의 협업을 가져와야 할듯. ★
			        	userLoadList( selectData.request_id, selectData.service_process_id );
			        	prtLoadList( selectData.request_id, selectData.service_process_id );
						
			        	setTimeout(function () {
			        		ApprovalCheck(); // 0602 grid_master 선택 시 필요 단계 및 승인 문구 출력
			        	}, 200);
	                	setTimeout(function () {
	                		$("#append_user").empty();
	                		// 수정 이동.
		               		fnEditDivH(); // fnNewDivH();
	                	}, 300);
			            
			        } else {
			            select_customer = undefined;
			        }
		        }
	        },
	        onUnselect: function (event) { event.onComplete = function () { }  }, 
// 	        onExpand: function (event) {
// 	            /* if (w2ui.hasOwnProperty('subGrid-' + event.recid)) w2ui['subGrid-' + event.recid].destroy(); */
// 	            if (w2ui.hasOwnProperty('subGridO')) w2ui['subGridO'].destroy();
// 	            $('#' + event.box_id).css({ margin: '0px', padding: '0px', width: '100%' })
// 	            		.animate({ height: '100px' }, 100);
// 	            /* grid_grid_master_rec_1_expanded */
// 	            $('#grid_grid_master_rec_' + event.recid+'_expanded').addClass("subGridStyle");
	            
// 	          /* 여기서 ajax 로 값 가져와서 넣어주기 ㅇㅇ */
// 	           loadList2_sub(event);
// 	        }, 
	    	onCollpase: function(event) { }, 
	        onDblClick: function(event) {
	            event.preventDefault();
	        }
	    });
	    w2ui["grid_master"].refresh();
	}
	
	function fnSetSubGrid(){
            $('#subGridO').w2grid({
                name: 'subGridO', //  + eventData.recid,
                recordHeight : 30,
                show: { columnHeaders: false, scroll: true },
//                 fixedBody: false,
                multiSelect : false, 
                columns: [
					{ field: 'request_seq', caption : 'Number', size : '13%', // 13%
						hidden: false, style : 'text-align:right', sortable : false }, 

					{ field: 'approver_id', caption : 'Approver Id', size : '40%', 
						hidden: true, style : 'text-align:center', sortable : false }, 
					{ field: 'approver_nm', caption : 'Approver Nm', size : '12%', 
						hidden: true, style : 'text-align:center', sortable : false }, 	
						
					{ field: 'request_id', caption : 'Request Id', size : '40%', 
						hidden: true, style : 'text-align:center', sortable : false}, 
		            
					{ field: 'work_status', caption : 'Step', size : '100px', style : 'text-align:center'}, // 10% 17%
			        
		            { field: 'owner_nm', caption : 'Owner', size : '80px', // 14%
		            	style : 'text-align:center', sortable : false }, 
			            
		            { field: 'system_info_nm', caption : 'Sys Info', size : '14%', 
	            		hidden: true, style : 'text-align:center', sortable : false }, 
		            	
			        { field: 'request_type_nm', caption : 'Request Type Level 1', size : '14%',
            			hidden: true, style : 'text-align:center;', sortable : false }, 
				    	
					{ field: 'title', caption : 'Title', size : '36%', 
        				hidden: true, style : 'text-align:center', sortable : false }, 
					
					{ field: '', caption : '', size : '14%', 
            			hidden: true, style : 'text-align:center', sortable : false },
					
					{ field: 'context', caption : 'Context', size : '40%', 
						hidden: true, style : 'text-align:center', sortable : false}, 
					
					{ field:'file_name', caption:'File Name', size:'10%', style:'text-align:center', hidden:true }, 
					{ field:'down_link', caption:'File', size:'10%', style:'text-align:center', hidden:true }, 
					{ field:'file_group', caption:'File No', size:'10%', style:'text-align:center', hidden: true }, 	
					
		            { field: 'status_nm', caption : 'Status', size : '140px', style : 'text-align:center'}, // 10% 18%
						
					{ field: 'process_date', caption : 'Request date', size : '19%', // 12%
		            	style : 'text-align:center', sortable : false }
                ],
//                 records: loadData,
    	        onSelect: function (event) {
    	            let grid = this;
    	            event.onComplete = function () {
    	                let sel = grid.getSelection();
    	                if (sel.length) {
    	                	let getData = grid.get(sel[0]);
    	                	$("#save_check").text('');
    			        	$("#save_check").css('display', 'none');
    	                	
    	                	$("#grid_name").val(grid.name);
    	                	$(".gray-theme.fr-box.fr-basic.fr-top .fr-wrapper").css({ "border-top":"1px solid #AAAAAA", "border-radius":"5px"});
    	                	selectData = JSON.parse(JSON.stringify( getData ));
    	                	fnControlStep(selectData.control_gubun);
    	                	fnControlAppr(selectData.control_gubun);
    	                	
    	                	// subGridO 미션중
    	                	if( selectData.title == "No Data" && selectData.status == "" ){
    	                		w2ui['subGridO'].selectNone();
    	                		w2ui['grid_master'].select(1);
    	                		return;
			    			}
    	                	$("#input_text_dtl").val($("#input_text").val()+'&request_seq_dtl='+encodeURIComponent(getData.request_seq));
    			            $("#sel_request_seq").val(selectData.request_seq);
    			            $("#sel_service_process_id").val(selectData.service_process_id);
    			            $("#sel_service_process_seq").val(selectData.service_process_seq);
    			            
    			        	apprLoadList( selectData.request_id, selectData.service_process_id );
				        	userLoadList( selectData.request_id, selectData.service_process_id );
				        	prtLoadList( selectData.request_id, selectData.service_process_id );
				        	
//     	                	var chk = document.getElementById('mainDiv').style.display;
//     			        	if( chk == "none" && (w2ui['grid_master'].getSelection().length) > 0 ) {
    			        		w2ui['grid_master'].selectNone();
//     			        		w2ui['subGridO'].select(selectData.recid);
//     			        		return;
//     			        	}
							
    			        	setTimeout(function () {
     		               		loadPartner();
     		               		// 수정 이동.
    		               		fnEditDivD(); // fnNewDivD();
    		               		
    		           			////////////// 0602 subGridO 선택 시 필요 단계 및 승인 문구 출력
    		               		ApprovalCheck();
    		               		
    	                	}, 300);
    	                }
    	            }
    			},
    			onUnselect: function (event) { event.onComplete = function () { }  }
            });
	}
	
	function fnReset() {
		console.log('fnReset');
		prtLoadData = [];
		lstPrtData = [];
		partner_yn = "";
		
		$("#hiddenRow").val('');
		$("#grid_name").val('');
		$("#sel_request_id").val('');
		$("#sel_gubun").val('');
		
//// 		$("#clickCircle").val('');
// 		$(".border-circle").css("background-color", "white");
// 		$("#alt_05_div").css("background-color", "#FFD25F");
// 		$("#clickCircle").val("alt_05");
		
		$("#sel_request_seq").val('');
		$("#sel_service_process_id").val('');
		$("#sel_service_process_seq").val('');
		
		$("#sysInfo").val('');
		$("#priorityCode").val('');
		$("#getDateCode").val('');
		
// 		$("#process_date").val('');
// 		$("#date_updated").val('');
// 		$("#hap_search").val('');
// // 		$("#sel_owner").val(member_id).prop("selected", true);
// 		if( gridStatus.findIndex(x => x.n_owner_id === member_id) >= 0 ){
// 			$("#sel_owner").val(member_id).prop("selected", true);
// 		} else {
// 			$("#sel_owner option:eq(0)").prop("selected", true);
// 		}

// 		loadList("alt_05");// loadList();
		
		console.log('sessionStorage 길이 :',sessionStorage.length);
		if(sessionStorage.length != 0){
			$(".border-circle").css("background-color", "white");
			
			var circle_id = sessionStorage.getItem('clickCircle')+'_div';
			$("#"+circle_id).css("background-color", "#FFD25F");
			$("#clickCircle").val(sessionStorage.getItem('clickCircle'));
			if(sessionStorage.getItem('rdo_all_data_yn') == "Y"){
				$(".rdo_all_data_yn2").click();
			}
			if(sessionStorage.getItem('rdo_all_data_yn') == "N"){
				$(".rdo_all_data_yn1").click();
			}
			$("#sel_owner").val(sessionStorage.getItem('sel_owner')).prop("selected", true); 
			$("#status_nm_info").val(sessionStorage.getItem('status_nm_info')).prop("selected", true); 
			$("#sel_ct_gubun").val(sessionStorage.getItem('sel_ct_gubun')).prop("selected", true); 
			$("#process_date").val(sessionStorage.getItem('process_date'));
			$("#date_updated").val(sessionStorage.getItem('date_updated'));
			$("#hap_search").val(sessionStorage.getItem('hap_search'));
			
			loadList(sessionStorage.getItem('clickCircle'));
			
			sessionStorage.clear();
		}
		
		$("#mainDiv").css("display", "");
   		$("#selDiv").css("display", "none");
	}
	
	// 차트 초기화 후 재로드
	function fnResetChart() {
		$("#clickCircle").val('');
		
		$("#sysInfo").val('');
		$("#priorityCode").val('');
		$("#getDateCode").val('');
		$(".rdo_all_data_yn1").click();
		
// 		$("#sel_owner option:eq(0)").prop("selected", true);
		$("#sel_owner").val(member_id).prop("selected", true);
		$("#status_nm_info option:eq(0)").prop("selected", true);
		$("#sel_ct_gubun option:eq(0)").prop("selected", true);
		$("#process_date").val('');
		$("#date_updated").val('');
		$("#hap_search").val('');
		
		loadList();
	}
	
	function checkWorkStatus() {
		loadPrForm();
		
		let workValue = $("#detail_sel_levelType option:selected").val();
		
		// Confirm 
		if( workValue == "alt_12" ){
// 			$("#detail_sel_levelType").val(workValue).prop("selected", true);
			$("#new_apprI_btn").text('승인 추가');
			resetUser('new');
				
			let gmGetDt = w2ui["grid_master"].get(1); // 헤더
			
			$('#detail_done_status').val("MD1258"); // "MD1269"
			$('#detail_done_status_nm').val("Done"); // Confirm
			$('#new_request_requester_nm').val(member_nm);
			
			$('#new_request_approver_id').val(gmGetDt.owner_id);
			$('#new_request_approver_nm').val(gmGetDt.owner_nm);
			$('#new_request_req_comment').val('');
			
			$("#new_request_div").css("display", "");
			$('#new_appr_div').css('display', 'none');
			
			$('#btn_partner').css('display', 'none');
			$("#append_user").empty();
			
			// 협업이면 버튼 비활성화 + 자동 Done니 진행중으로 변경
			$("#btn_detail_done").text("In Progress");
			$("#btn_detail_done").attr("disabled", true);
			descEditor.html.set( 
				'<span style="color:red;">Step이 User Confirm 일때, 여기에 작성된 내용은 Owner만 확인 가능합니다.</span><p style="color:black;"></p>' 
				+ descEditor.html.get() 
			);
			
		} else {
			// 상태가 승인 요청이 아니면
			if( $("#detail_done_status").val() != "MD1266" ){
				$("#new_request_div").css("display", "none");
				$("#new_appr_div").css("display", "");
				
				if ($("input[name=hidden_prt_user]").length == 0 ) {
					$("#new_apprI_btn").css("display", "");
				}
				$('#btn_partner').css('display', '');
			}
			
			// 협업이면 버튼 활성화 
			if(lstPrtData.filter(item => item.partner_id == member_id ).length == 0 ){
				$("#btn_detail_done").attr("disabled", false);
			} else {
				$('#btn_partner').css('display', 'none');
				$("#new_apprI_btn").css("display", "none");
			}
			//
			let html_length =  (descEditor.html.get()).length;
			let html_data =  descEditor.html.get();
			// Froala Editor 지우기.
			let text = '<span style="color:red;">Step이 User Confirm 일때, 여기에 작성된 내용은 Owner만 확인 가능합니다.</span>';
			let frContext = descEditor.html.get();
			while(true)	{
				let idx = frContext.indexOf(text);
				frContext = frContext.replace(text, "");
				if ( frContext.indexOf(text) < 0 ) {
					break; 
				}
			}
			descEditor.html.set(frContext);
			//
		}
	}
	
	function fnDetailStatus() {
		let status = $("#detail_done_status").val();
// 		if($("#grid_name").val() == "subGridO") {
		if($("#grid_name").val() == "grid_master" && $("#sel_gubun").val() == "edit" ) {
			if(status == "MD1258") {
				$("#detail_done_status").val("MD1256");
				$("#detail_done_status_nm").val("In Progress");
				
				$("#btn_detail_done").text("Hold");
			} else if(status == "MD1256") {
				$("#detail_done_status").val("MD1257");
				$("#detail_done_status_nm").val("Hold");
				
				$("#btn_detail_done").text("Completed");
			} else if(status == "MD1257") {
				$("#detail_done_status").val("MD1258");
				$("#detail_done_status_nm").val("Completed");
				
				$("#btn_detail_done").text("In Progress");
			} else {
				$("#detail_done_status").val("MD1256");
				$("#detail_done_status_nm").val("In Progress");
				
				$("#btn_detail_done").text("Hold");
			}
		} else {
			$("#new_apprI_btn").text('승인 추가');
			$("#edit_apprI_btn").text('승인 추가');
			
			if(status == "MD1258") {
				$("#detail_done_status").val("MD1256");
				$("#detail_done_status_nm").val("In Progress");
				
				$("#btn_detail_done").text("Done");
			} else if(status == "MD1256") {
				$("#detail_done_status").val("MD1258");
				$("#detail_done_status_nm").val("Done");
				
				$("#btn_detail_done").text("In Progress");
			} else {
				$("#detail_done_status").val("MD1256");
				$("#detail_done_status_nm").val("In Progress");
				
				$("#btn_detail_done").text("Done");
			}
			$("#new_appr_approver_id").val('');
			$("#new_appr_approver_nm").val('');
			$("#new_request_approver_id").val('');
			$("#new_request_approver_nm").val('');
			
			$('#new_appr_div').css('display', '');
			$('#new_comment_approver').css('display', 'none');
// 			$('#new_comment_approver2').css('display', 'none');
			$("#new_appr_req_comment").val('');
			
			$('#new_request_div').css('display', 'none');
			
			//
			$("#edit_appr_approver_id").val('');
			$("#edit_appr_approver_nm").val('');
			$("#edit_request_approver_id").val('');
			$("#edit_request_approver_nm").val('');
			
			$('#edit_appr_div').css('display', '');
			$('#edit_comment_approver').css('display', 'none');
			$('#edit_comment_approver2').css('display', 'none');
			$("#edit_appr_req_comment").val('');
			
			$('#edit_request_div').css('display', 'none');
			
			let workValue = $("#detail_sel_levelType option:selected").val();
			if( workValue == "alt_12" ){
				$("#detail_sel_levelType option:eq(0)").prop("selected", true);
			}
		}
		
	}
	
	function fnAppEditStatus(gubun){
		var status = "";
		var code = "";
		var value = $("#edit_appr_rep_comment").val();
		// fnAppEditStatus('승인 취소'); << 기능 추가하자. 버튼 display 여부는 다함
		
		if( gubun == "승인 취소" ) {
			apprCancelCase();
		} else {
			if(gubun == "승인") {
				code = "MD1267";
				status = "Approval";
			} else if(gubun == "반려") {
				code = "MD1268";
				status = "Reject";
			}
			
			if( (value).length == 0 || value == "반려합니다." || value == "승인합니다." ){
				$("#edit_appr_rep_comment").val(gubun+"합니다.");
			}
			$("#detail_done_status").val(code);
			$("#detail_done_status_nm").val(status);
			
			saveCaseInfo();
		}
	}
	
	function apprCancelCase(){
		fnMessageModalConfirm("Notification", "선택한 Case의 승인 요청을 회수하시겠습니까?", function(result) {
			if(result) {
				let gridNm = $("#grid_name").val();
				
				let gridKey = w2ui[gridNm].getSelection()[0];
				
				let status = $("#detail_done_status").val();
				
				let request_id = $('#sel_request_id').val();
				let service_process_id = $('#sel_service_process_id').val();
				let service_process_seq = apprLoadData[apprLoadData.length-1].service_process_seq;
				let request_seq = $('#sel_request_seq').val();
				
				let requester_id = $('#edit_appr_requester_id').val();
				let requester_nm = $('#edit_appr_requester_nm').val();
				
				let approver_id = $("#edit_appr_approver_id").val();
				let approver_nm = $("#edit_appr_approver_nm").val();;
				
				let sendData = { 
					request_seq			: request_seq, 
					request_id			: request_id, 
					service_process_id	: service_process_id, 
					service_process_seq	: service_process_seq, 
					
					requester_id		: requester_id, 
					requester_nm		: requester_nm, 
					
					approver_id			: approver_id, 
					approver_nm			: approver_nm, 
					
					status				: status
				};
				
				var page_url = "/case/admin/apprCancelCase";
				
				$.ajax({
					url : page_url,
					type : 'POST',
					data : sendData, 
					dataType : 'json',
					async : false,
					success : function( data ) {
						if(data.status == 200 ) {
							fnMessageModalAlert("Notification", "해당 Case의 요청이 회수되었습니다.");
							
							loadList2();
							loadList2_sub();
							
							// 요청이 자신인데 취소하면... 굳이 메일 안보냄.
							if ( approver_id != member_id ) {
		// 						fnMailSend("/mail/mailSending_3", request_seq, status, rep_comment, req_comment, requester_id);
							}
						} else {
							fnMessageModalAlert("Error", "실패했습니다. 다시 등록해 주세요.");
						}
					},
					complete: function () {
						setTimeout(function(){
							$('#modal_message button.close').click();
						}, 600);
		            	setTimeout(function () {
			        		w2ui['grid_master'].selectNone();
			        		w2ui['subGridO'].selectNone();
			        		w2ui[gridNm].select(gridKey);
		    			}, 300);
					}
				});
			}
		});
	}
	
	function fnNewDiv() {
		w2ui['grid_master'].selectNone();
		w2ui['subGridO'].selectNone();
		
		$("#save_check").text('');
    	$("#save_check").css('display', 'none');
		$("#sel_gubun").val("new");
		
		$("#btn_detail_done").css("display", "");
		$("#btn_detail_done").text("Done");
		$("#detail_done_status").val('MD1256');
		$("#detail_done_status_nm").val('In Progress');
		
		$("#detail_sel_priority2").val( $("#detail_sel_priority option:selected").val() ).prop("selected", true);
// 		$("#detail_sel_priority2 option:eq(0)").prop("selected", true);
		$("#detail_sel_priority2").attr("disabled", false);
		
		descEditor.html.set('');
		loadPrForm();
		
// 		$("#detail_title").attr("disabled", false);
		
		// 헤더, 등록에서만 등록 가능.
		$("#detail_sel_control").attr("disabled", false);
		
		$("#detail_sel_process").attr("disabled", false);
		$("#detail_plan_due_date").attr("disabled", false);
		$("#detail_request_due_date").attr("disabled", false);
		
		// 대,중,소분류 대상 
		$("#detail_sel_syInfo").attr("disabled", false);
		$("#detail_selR_type").attr("disabled", false);
		$("#detail_selR_category").attr("disabled", false);
		$("#detail_selR_categoryItem").attr("disabled", false);
		
		// 03 08 추가
		$("#detail_sel_priority2").attr("disabled", false);
		
		$("#detail_sel_levelType").attr("disabled", false);
// 		$("#detail_sel_priority").attr("disabled", false);
		
		$("#detail_old_status").val('');
		$("#detail_old_status_nm").val('');
		
		$("#new_appr_approver_id").val('');
		$("#new_appr_approver_nm").val('');
		
// 		$("#detail_plan_due_date").val('');
// 		$("#detail_request_due_date").val('');
		
		$("#detail_owner_id").val(member_id);
		$("#detail_owner_nm").val(member_nm);
		
		
		descEditor.edit.on();
		descEditor.toolbar.show();
		$("#append_down").empty();
		$(".btnEditDown").css("display", "");
		$("#new_apprI_btn").css("display", "");
		
		$("#detail_sel_priority").attr("disabled", true);
		$("#detail_plan_due_date").attr("disabled", false);
		$("#detail_request_due_date").attr("disabled", true);
		$("#detail_sel_levelType option[value*='alt_12']"). prop('disabled', false);
		
		if(lstPrtData.filter(item => item.partner_id == member_id ).length > 0 ){
			$("#btn_detail_done").attr("disabled", true); 
			$("#btn_detail_done").css("display", "none");
			
			$('#detail_done_status').val("MD1258");
			$('#detail_done_status_nm').val("Done");
			$("#btn_detail_done").text("In Progress");
			
			$("#detail_sel_levelType option[value*='alt_12']"). prop('disabled',true);
			
			$("#btn_partner").css("display", "none");
			$("#new_apprI_btn").css("display", "none");
			
// 			$("#detail_save_btn").attr("disabled", true);
			$("#detail_sel_control").attr("disabled", true);
			$("#detail_sel_process").attr("disabled", true);
			$("#detail_plan_due_date").attr("disabled", true);
			
			// 대,중,소분류 대상 
			$("#detail_sel_syInfo").attr("disabled", true);
			$("#detail_selR_type").attr("disabled", true);
			$("#detail_selR_category").attr("disabled", true);
			$("#detail_selR_categoryItem").attr("disabled", true);
			
			// 03 08 추가
			$("#detail_sel_priority2").attr("disabled", true);
		}
		
		
		let getEdData = "";
		if ( w2ui['subGridO'].records.length == 1 && w2ui['subGridO'].records[0].title == 'No Data' ) {
			getEdData = w2ui['grid_master'].get(1).context;
		} else {
			getEdData = w2ui['subGridO'].get(w2ui['subGridO'].records.length).context;
		}
		
		descEditor.html.insert('<p><br></p><hr>' +  getEdData );
		
	}
	
	// ★★★
	function fnControlStep(gb) {
		controlLevelData = [];
		
		// selectData에서 통제분류 값을 구해와서 그 값으로 step 가져온다. control_type_level
		// ajax : selectControlTypeLevel
		let stepV = [];
	
		let gbV = selectData.control_gubun;
		if(gb){
			gbV = gb;
		}
	
		if( gbV ) {
// 		if( selectData.control_gubun ) {
			var page_url = "/backend/code/selectControlTypeLevel";
			var postData = {
				control_type_code : gbV
			};
			
			$.ajax({
				url:page_url, 
				type:'POST', 
				data : postData, 
				dataType: 'json', 
				async : false,
				success: function( data ) {
					if(data.status == "200" && (data.rows).length>0 ) {
						stepV = data.rows;
						
						controlLevelData = stepV;
					}
				},
				complete: function() {
					
				}
			});
		}
		return stepV;
	}
	
	function fnControlAppr(gb) {
		controlApprData = [];
		controlApprData_as = [];
		let stepV = [];
	
		let gbV = selectData.control_gubun;
		if(gb){
			gbV = gb;
		}
	
// 		if( selectData.control_gubun ) { 원본 : 주석해제
			var page_url = "/backend/code/selectControlTypeApprover";
			var postData = {
				control_type_code : gbV
			};
			
			$.ajax({
				url:page_url, 
				type:'POST', 
				data : postData, 
				dataType: 'json', 
				async : false,
				success: function( data ) {
					if(data.status == "200" && (data.rows).length>0 ) {
						stepV = data.rows;
						controlApprData_as = stepV;
						var obj = {};
						var array = [];
						for(var i=0; i<stepV.length; i++) { 
							if(i==0) {
								array.push( stepV[i] );
							} else {
								if( stepV[i].admin_level_type_code != stepV[(i-1)].admin_level_type_code ) {
									obj[(stepV[i-1].admin_level_type_code)] = array;
									array = []
								}
								array.push( stepV[i] );
							}
						}
						obj[(stepV[(stepV.length-1)].admin_level_type_code)] = array;
						
						controlApprData.push(obj);
					}
				},
				complete: function() {
					
				}
			});
// 		}
		return stepV;
	}
	// ★★★
	function fnControlStepCss(ggbb) {
		// 통제 분류가 선택 되어 있으면 해당 통제의 Step 을 가져오고 순서도 가져온다.
		// 대충 통제 step인 거는 단계 selectData 에서 빼고 젤 앞에 놓고 push 반복
		// 근데 svcData로 진행된 순서를 확인하고 진행된 순서 다음 거 만 보이고 나머지 이후 단계는 삭제
		// svcData가 여기에선 loadData인듯?
		// 통제 단계 Step은 bold;
		// console.log("fnControlStepCss ggbb = ", ggbb);
		let stepV = fnControlStep(ggbb);
		
		// gggg
		setTimeout(function () {
			// console.log("stepV = ", stepV);
			///
			if( stepV.length > 0 ) {
				initOptions("#detail_sel_levelType");
			}
			let levelDataV = JSON.parse(JSON.stringify( levelData ));
			
			if( stepV.length > 0 ) {
				var levelIdx = 0; 
				// [{name:"1"},2,3,4,{name:"5"},6].findIndex(i => i.name == "5");
	// 			for(var i=stepV.length-1; i>=0; i--){
				
				// 이 방식은 모든 sub-case에서 제일 높은 step을 구함.
				// 단계가 Accept > Accept > Prodeeding > Test > Accept 일 때  User Confirm 가능!
				/* 
				for( var i=0; i<stepV.length; i++ ){
					for( var j=0; j<loadData.length; j++ ) {
						if( stepV[i].admin_level_type_code == loadData[j].admin_level_type_code ) {
							levelIdx = (i+1);
							// 값이 1~2개인데 그 위치를 넘게 되면 그냥 i로
							if(levelIdx > stepV.length-1 ){
								levelIdx = i;
							}
						}
					}
				}
				 */
				 
				// Control Step중에서 제일 최근에 사용한 Step이 뭔지.
				// 단계가 Accept > Accept > Prodeeding > Test > Accept 일 때  User Confirm 불가능!
				levelIdx = fnLevelIdx(loadData, stepV);
				/* 
				for(var i=loadData.length-1; i>=0; i--){
					for( var j=0; j<stepV.length; j++ ){
						if( stepV[j].admin_level_type_code == loadData[i].admin_level_type_code ) {
							levelIdx = (j+1);
							
							console.log("levelIdx = ", levelIdx);
							console.log("stepV.length-1 = ", stepV.length-1);
							
							// 값이 1~2개인데 그 위치를 넘게 되면 그냥 i로
							if(levelIdx >= stepV.length-1 ){
								levelIdx = j;
							}
							return;
						}
					}
				}
				 */
				 
				// 없을 수도 있음. 딱 이 data만 append에 표시되어야함.
				
				for( var i=0; i<levelDataV.length; i++ ) {
					var levelG = "O";
					for( var j=0; j<stepV.length; j++ ) {
						if(i == 0) {
	// 						controlLevelData.push( stepV[j] );
							// idxOf로 위치 찾기. < 위치 없으면 첨 하나만 가능. 위치 있으면 다음 위치까지만 가능.
							if( levelIdx >= j ) {
								// name="sel_levelType"
								$("#detail_sel_levelType").append('<option style="font-weight: 700 !important;" value=' 
										+ stepV[j].admin_level_type_code + '>' 
										+ stepV[j].admin_level_type_nm + '</option>');
							}
						}
						if( levelDataV[i].admin_level_type_code == stepV[j].admin_level_type_code ) {
							levelG = "";
						}
					}
					if( levelG ) {
						$("#detail_sel_levelType").append('<option value=' 
								+ levelDataV[i].admin_level_type_code + '>' 
								+ levelDataV[i][myGubun+"_level_type_nm"] + '</option>');
					}
				}
				
			}
			///
		 }, 300);
		// gggg
		
		
	}
		
	function old_fnLevelIdx(loadData, stepV) {
		
		var levelIdx = 0; 
		for(var i=loadData.length-1; i>=0; i--){
			for( var j=0; j<stepV.length; j++ ){
				if( stepV[j].admin_level_type_code == loadData[i].admin_level_type_code ) {
					levelIdx = (j+1);
// 					console.log("levelIdx(j+1) = ", levelIdx);
					// 값이 1~2개인데 그 위치를 넘게 되면 그냥 i로
					if(levelIdx > stepV.length-1 ){
						levelIdx = j;
					}
					return levelIdx;
				}
			}
		}
		return levelIdx;
	}
	
	
	function fnLevelIdx(loadData, stepV) {
		var gmGetDt = w2ui["grid_master"].get(1);
		
		var sbLoadData = JSON.parse(JSON.stringify( loadData ));
						
		sbLoadData.splice(0, 0, gmGetDt);
		sbLoadData[0].admin_level_type_code = "alt_05";
		sbLoadData[0].admin_level_type_nm = "Open";
		
		var levelIdx = 0; 
		var levelOrder = 0; 
		for(var i=sbLoadData.length-1; i>=0; i--){
			for( var j=0; j<stepV.length; j++ ){
				if( stepV[j].admin_level_type_code == sbLoadData[i].admin_level_type_code ) {
					
					if( Number(levelOrder) < Number(stepV[j].level_order) ){
						levelIdx = (j+1);
						levelOrder = Number(stepV[j].level_order);
// 						console.log("levelIdx(j+1) = ", levelIdx);
						// 값이 1~2개인데 그 위치를 넘게 되면 그냥 i로
						if(levelIdx > stepV.length-1 ){
							levelIdx = j;
						}
					}
// 					return levelIdx;
				}
			}
		}
		return levelIdx;
	}
	
	function fnContronChange() {
		//  $("#grid_name").val() != "grid_master" ||
		if( $("#sel_gubun").val() == "new" ) {
			fnSelLevel("select[name=sel_levelType]", myGubun);
	// 		통제 분류에 따른 단계 css
			var ggbb = $("#detail_sel_control").val();
			// console.log("ggbb = ", ggbb);
			if(ggbb) {
				fnControlStepCss(ggbb);
				$("#detail_sel_levelType").attr("disabled", false);
			} else {
				// console.log("else");
// 				initOptions("#detail_sel_levelType");
				$("#detail_sel_levelType").attr("disabled", true);
			}
			// detail_sel_control
			checkWorkStatus();
		}
		
		ApprovalCheck(); // 통제분류 변경 시 필요 단계 및 승인 문구 출력
		
	}
	
	function fnNextCase() {
		// w2ui['grid_name'].get(w2ui['grid_name'].getSelection()[0]);
		// 새로운 걸 만들거면 통제 분류부터 만들어.. >  헤더 저장할 때 체크 안함.
// 		let selectDataStatus = selectData.status;
// 		if( !selectDataStatus || selectData.admin_level_type_code == "alt_05" ) {
// 			let save_checkT = "";
// 			let control_gubun = selectData.control_gubun; // $("#detail_sel_control").val();
			
// 			if($.trim(control_gubun).length == 0) {
// 				save_checkT = save_checkT+"통제 분류, ";
// 			}
			
// 			if (save_checkT) {
// 				$("#save_check").css('display', '');
				
// 				let tttttt = "다음 입력란을 저장하세요: "+save_checkT.substring(0, save_checkT.length-2);
// 				$("#save_check").text(tttttt);
// 				return;
// 			} else {
// 				$("#save_check").text('');
// 			}
// 		}
		
		fnSelLevel("select[name=sel_levelType]", myGubun);
		
// 		통제 분류에 따른 단계 css
		fnControlStepCss();
		
		let seq = Number($("#sel_service_process_seq").val());
		$("#append_user").empty();
		// Company Type이 본사면 or company_code이 뷰웍스면(MD1244)
		if( usertData.company_gubun_code == "MD1242" ) {
			$("#btn_partner").css("display", "");
			$(".button_prt_user").css("display", "");
			$(".button_prt_user").attr("disabled", false);
		} else {
			$("#btn_partner").css("display", "none");
			$(".button_prt_user").css("display", "none");
			$(".button_prt_user").attr("disabled", true);
		}
		
		$("#detail_partner_id").val("");
		$("#detail_partner_nm").val("");
		$(".partner_div").css("display", "none");
		
		// 0 header, 1~ sub
		$("#btn_detail_next_history").css("display", "none");
		
		$("#detail_save_btn").css("display", "");		// 등록 o
		$("#detail_save_btn").attr("disabled", false); // 등록 가능
		$("#btn_detail_done").attr("disabled", false); // 종료 가능
		
		$("#detail_sel_levelType option:eq(0)").prop("selected", true);
// 		$("#detail_sel_process option:eq(0)").prop("selected", true);
// 		$("#detail_sel_priority option:eq(0)").prop("selected", true);
		
		$("#detail_delete_btn").css("display", "none"); // 삭제 x
		$("#detail_owner_btn").css("display", "none"); // Owner 바꾸기 X
		
		$("#edit_cmt_div").css("display", "none");
		$("#new_cmt_div").css("display", "");
		
		$("#new_appr_div").css("display", "");
		$("#new_comment_approver").css("display", "none");
// 		$("#new_comment_approver2").css("display", "none");
		
		$("#new_request_div").css("display", "none");
		// 
		$("#new_apprI_btn").text('승인 추가');
		$("#edit_apprI_btn").text('승인 추가');
		
		// ★
		$("#detail_selR_type").val(selectData.request_type).prop("selected", true); 
		fnSelRequest("category", selectData.request_type);
		$("#detail_selR_category").val(selectData.request_category).prop("selected", true); 
        fnSelRequest("categoryItem", selectData.request_category);
		$("#detail_selR_categoryItem").val(selectData.request_category_item).prop("selected", true); 
		$("#detail_sel_syInfo").val(selectData.system_info_code).prop("selected", true);
		
		// 새로 등록시 기존의 통제 분류로.
// 		$("#detail_sel_control").val(selectData.control_gubun).prop("selected", true);
		$("#detail_sel_control").val(selectData.control_gubun).prop("selected", false);
// 		if (seq == 0) {
			fnNewDiv();
		
		if( $("#detail_sel_control").val() ) {
			$("#detail_sel_levelType").attr("disabled", false);
		} else {
			$("#detail_sel_levelType").attr("disabled", true);
		}
		
		ApprovalCheck(); // 새 단계 Case 클릭 시 필요 단계 및 승인 문구 출력
		
// 		} else {
// 			fnNewDivD();			
// 		}
	}
	
	function fnEditDivH() {
		$("#sel_gubun").val("edit");
		fnEditData();
		$(".btnEditDown").css("display", "none"); // 삭제 금지
		$("#btn_detail_done").css("display", "");
		
		$("#btn_partner").css("display", "none");
		$(".button_prt_user").css("display", "none");
		$(".button_prt_user").attr("disabled", true);
		
		$("#detail_status").val(selectData.status);
		
		// $("#btn_detail_done").text("In Progress");
		if(selectData.status == "MD1258") {
			$("#btn_detail_done").text("In Progress");
		} else if(selectData.status == "MD1256") {
			$("#btn_detail_done").text("Hold");
		} else if(selectData.status == "MD1257") {
			$("#btn_detail_done").text("Completed");
		} else {
			$("#btn_detail_done").text("Completed");
		}
		
		if (selectData.status == "MD1258") {
			$("#detail_status_nm").val("Completed");
		} else {
			$("#detail_status_nm").val(selectData.status_nm);
		}
		
		$("#detail_title").val(selectData.title);
		$("#detail_plan_due_date").val(selectData.plan_due_date);
		$("#detail_request_due_date").val(selectData.request_due_date);
		
// 		selectData // 헤더
		let allData = w2ui['subGridO'].records;
		
		let lastData = w2ui['subGridO'].get(allData[allData.length-1].recid); // 라스트
		
		lstPrtData = prtLoadData.filter(item => item.service_process_id == lastData.service_process_id );
		
		let selectDataStatus = selectData.status;
		let lastDataStatus = lastData.status;

		$("#detail_sel_priority").val(selectData.priority_code).prop("selected", true);
		$("#detail_sel_priority2").val(selectData.priority_code).prop("selected", true);
		
		$("#detail_sel_control").attr("disabled", false); // control code 변경
		$("#detail_sel_process").attr("disabled", false); // process code 변경
 		$("#detail_plan_due_date").attr("disabled", false); // plan due date 변경
 		
 		// 대,중,소분류 대상 변경
		$("#detail_sel_syInfo").attr("disabled", false);
		$("#detail_selR_type").attr("disabled", false);
		$("#detail_selR_category").attr("disabled", false);
		$("#detail_selR_categoryItem").attr("disabled", false);
		
		$("#detail_sel_priority2").attr("disabled", false);
 		
		// 새로 등록이면 process code, plan due date 변경 불가
	 	if( !selectDataStatus || selectData.admin_level_type_code == "alt_05" ) {
 			
	 		$("#btn_detail_next_history").attr("disabled", false); // 등록 가능
	 		$("#btn_detail_done").attr("disabled", false); // 종료 가능
	 		
// 	 		$("#detail_title").attr("disabled", false); // 제목 변경
	 		$("#detail_sel_control").attr("disabled", true); // Open일 때는 똑같이 변경 불가능하다.
	 		$("#detail_sel_process").attr("disabled", true);
	 		$("#detail_plan_due_date").attr("disabled", true);
	 		
	 		// 대,중,소분류 대상 
			$("#detail_sel_syInfo").attr("disabled", true);
			$("#detail_selR_type").attr("disabled", true);
			$("#detail_selR_category").attr("disabled", true);
			$("#detail_selR_categoryItem").attr("disabled", true);
			
			$("#detail_sel_priority2").attr("disabled", true);
			

	 		$("#detail_save_btn").css("display", ""); // 저장 가능
	 		$("#detail_save_btn").attr("disabled", false); // 헤더 상태 변경 가능.
	 	}
		if ( selectDataStatus == "MD1256" ){ // 헤더가 진행중이면
	 		if( selectData.allApprCount == 0 ) {
	 			// 라스트 값이 없거나 완료, 승인, 반려면
	 			if ( !lastDataStatus || (lastDataStatus == "MD1258") || (lastDataStatus == "MD1267") || (lastDataStatus == "MD1268") ){ 
	 				$("#btn_detail_next_history").attr("disabled", false); // 등록 가능
	 		 		$("#btn_detail_done").attr("disabled", false); // 종료 가능
	 		 		$("#detail_save_btn").css("display", "");
	 		 		$("#detail_save_btn").attr("disabled", false); // 헤더 상태 변경 가능.
	 			}
	 		}
// 	 		$("#detail_title").attr("disabled", false); // 제목 변경
// 	 		$("#detail_sel_process").attr("disabled", false); // process code 변경
// 	 		$("#detail_plan_due_date").attr("disabled", false); // plan due date 변경
	 		$("#detail_save_btn").css("display", ""); // 저장 가능
	 		$("#detail_save_btn").attr("disabled", false); // 헤더 상태 변경 가능.
	 		
	 		// ★★
	 		// 이 헤더는 승인 요청이 있어요~
	 		if( apprLoadData.length > 0 ) {
	 			$("#edit_appr_status_div").css("display", "none"); // 서브는 보여줘도 됨. 마찬가지로 승인 요청 버튼도.
		 		$("#edit_comment_approver").css("display", "");
		 		$("#edit_responseCmtDiv").css("display", "");
		 		$("#edit_appr_req_comment").attr("disabled", true); // 요청 메시지 비활성화
		 		$("#edit_comment_approver2").css("display", "");
		 		$("#edit_appr_rep_comment").attr("disabled", true); // 응답 메시지 비활성화
		 		
		 		// 승인 요청
				let getAppr = apprLoadData[apprLoadData.length-2];
		 		
				$("#edit_appr_requester_id").val( getAppr.requester_id );
				$("#edit_appr_requester_nm").val( getAppr.requester_nm );
				
				$("#edit_appr_req_comment").val( getAppr.comment );
				$("#edit_appr_req_date").val( (getAppr.date_created).substring(0, 16) );
				
				// 승인자
				let getAppr2 = apprLoadData[apprLoadData.length-1];
				$("#edit_appr_approver_id").val( getAppr2.approver_id );
				$("#edit_appr_approver_nm").val( getAppr2.approver_nm );
				
				$("#edit_appr_rep_comment").val( getAppr2.comment );
				$("#edit_appr_rep_date").val( (getAppr2.date_created).substring(0, 16) );
	 		}
	 		
	 	} else if ( selectDataStatus == "MD1269" ) { // User Confirm

	 		$("#detail_title").attr("disabled", true);
	 		$("#detail_sel_process").attr("disabled", true);
	 		$("#detail_sel_control").attr("disabled", true);
	 		$("#detail_plan_due_date").attr("disabled", true);
	 		$("#detail_save_btn").css("display", "none");
	 		
	 		// 대,중,소분류 대상 
			$("#detail_sel_syInfo").attr("disabled", true);
			$("#detail_selR_type").attr("disabled", true);
			$("#detail_selR_category").attr("disabled", true);
			$("#detail_selR_categoryItem").attr("disabled", true);
			
			$("#detail_sel_priority2").attr("disabled", true);
	 		
	 		$("#btn_detail_next_history").attr("disabled", true);
	 		$("#btn_detail_done").attr("disabled", true);
	 		
	 	} else if ( selectDataStatus == "MD1266" ) { // 승인 요청 상태면
// 	 		$("#edit_appr_div").css("display", "");
	 		$("#edit_appr_status_div").css("display", "");
	 		$("#edit_comment_approver").css("display", "");
	 		$("#edit_comment_approver2").css("display", "");
	 		$("#edit_responseCmtDiv").css("display", "");
// 	 		$("#edit_appr_rep_date").css("display", "none"); // 승인 요청 완료 날짜는 안보이게.
	 		
	 		$("#detail_save_btn").attr("disabled", false); // 마지막 수정은 저장 버튼 활성화
	 		
	 		$("#btn_detail_next_history").attr("disabled", true);
	 		$("#btn_detail_done").attr("disabled", true);
	 		
	 		let getAppr = apprLoadData[apprLoadData.length-1];
	 		
	 		$("#edit_appr_status").val( '' ); // getAppr.status
			$("#edit_appr_status_nm").val( '' ); // getAppr.status_nm
			
			$("#edit_appr_requester_id").val( getAppr.requester_id );
			$("#edit_appr_requester_nm").val( getAppr.requester_nm );
			
			$("#edit_appr_approver_id").val( getAppr.approver_id );
			$("#edit_appr_approver_nm").val( getAppr.approver_nm );
			
			$("#edit_appr_req_comment").val( getAppr.comment );
			$("#edit_appr_req_date").val( (getAppr.date_created).substring(0, 16) );
			
			$("#edit_appr_req_comment").attr("disabled", true); // 요청 메시지 비활성화
			
			if ( getAppr.approver_id != member_id ){ // 승인 요청이 같지 않다면 
				$("#edit_appr_status_div").css("display", "none");
				$("#edit_appr_rep_comment").attr("disabled", true);
				$("#detail_save_btn").css("display", "none");
				
				$("#detail_title").attr("disabled", true);
		 		$("#detail_sel_process").attr("disabled", true);
		 		$("#detail_sel_control").attr("disabled", true);
		 		$("#detail_plan_due_date").attr("disabled", true);
		 		$("#detail_save_btn").css("display", "none");

		 		// 대,중,소분류 대상 
				$("#detail_sel_syInfo").attr("disabled", true);
				$("#detail_selR_type").attr("disabled", true);
				$("#detail_selR_category").attr("disabled", true);
				$("#detail_selR_categoryItem").attr("disabled", true);
				
				$("#detail_sel_priority2").attr("disabled", true);
				
				if(getAppr.requester_id == member_id ) {
					$("#edit_appr_status_div").css("display", "");
					$("#edit_appr_btn").css("display", "none");
					$("#edit_apprX_btn").css("display", "none");
					$("#edit_apprRst_btn").css("display", "none");
				}
			} else {
				$("#edit_appr_status_div").css("display", "");
				$("#edit_appr_btn").css("display", "");
				$("#edit_apprX_btn").css("display", "");
				
// 				if(getAppr.requester_id != member_id ) {
					$("#edit_apprRst_btn").css("display", "none");
// 				} else {
// 					$("#edit_apprRst_btn").css("display", "");
// 				}
				
				$("#edit_appr_rep_comment").attr("disabled", false);
				$("#detail_save_btn").css("display", "");

// 		 		$("#detail_title").attr("disabled", false); // 제목 변경
// 		 		$("#detail_sel_process").attr("disabled", false); // process code 변경
// 		 		$("#detail_plan_due_date").attr("disabled", false); // plan due date 변경
		 		$("#detail_save_btn").css("display", ""); // 저장 가능
		 		$("#detail_save_btn").attr("disabled", false); // 헤더 상태 변경 가능.
			}
	 	} else if( (selectDataStatus == "MD1267") || (selectDataStatus == "MD1268") ){ // 승인 완료거나 반려면
// 	 		$("#edit_appr_div").css("display", "");
	 		$("#edit_appr_status_div").css("display", "none"); // 서브는 보여줘도 됨. 마찬가지로 승인 요청 버튼도.
	 		$("#edit_comment_approver").css("display", "");
	 		$("#edit_responseCmtDiv").css("display", "");
	 		$("#edit_appr_req_comment").attr("disabled", true); // 요청 메시지 비활성화
	 		$("#edit_comment_approver2").css("display", "");
	 		$("#edit_appr_rep_comment").attr("disabled", true); // 응답 메시지 비활성화
	 		
// 	 		$("#detail_title").attr("disabled", false); // 제목 변경
// 	 		$("#detail_sel_process").attr("disabled", false); // process code 변경
// 	 		$("#detail_plan_due_date").attr("disabled", false); // plan due date 변경
	 		$("#detail_save_btn").css("display", ""); // 저장 가능
	 		$("#detail_save_btn").attr("disabled", false); // 헤더 상태 변경 가능.
	 		
	 		$("#btn_detail_next_history").attr("disabled", false);
	 		$("#btn_detail_done").attr("disabled", false);
	 		
	 		// 승인 완료면 save할 게 없음.
// 	 		$("#edit_appr_rep_date").css("display", ""); // 승인 요청 완료 날짜는 보이게.
	 		
	 		if( selectData.allApprCount == 0 ) {
	 			// 라스트 값이 없거나 완료, 승인, 반려면
	 			if ( !lastDataStatus || (lastDataStatus == "MD1258") || (lastDataStatus == "MD1267") || (lastDataStatus == "MD1268") ){ 
	 				$("#btn_detail_next_history").attr("disabled", false); // 등록 가능
	 		 		$("#btn_detail_done").attr("disabled", false); // 종료 가능
	 		 		$("#detail_save_btn").css("display", "");
	 		 		$("#detail_save_btn").attr("disabled", false); // 헤더 상태 변경 가능.
	 			}
	 		}
	 		
	 		// 승인 요청
			let getAppr = apprLoadData[apprLoadData.length-2];
	 		
			$("#edit_appr_requester_id").val( getAppr.requester_id );
			$("#edit_appr_requester_nm").val( getAppr.requester_nm );
			
			$("#edit_appr_req_comment").val( getAppr.comment );
			$("#edit_appr_req_date").val( (getAppr.date_created).substring(0, 16) );
			
			// 승인자
			let getAppr2 = apprLoadData[apprLoadData.length-1];
			
			$("#edit_appr_approver_id").val( getAppr2.approver_id );
			$("#edit_appr_approver_nm").val( getAppr2.approver_nm );
			
			$("#edit_appr_rep_comment").val( getAppr2.comment );
			$("#edit_appr_rep_date").val( (getAppr2.date_created).substring(0, 16) );
			
	 	}  else if ( (selectDataStatus == "MD1257") || (selectDataStatus == "MD1258") ) { // 상태가 Hold Done
 			$("#btn_detail_done").attr("disabled", false); // 종료 가능
	 		$("#detail_save_btn").css("display", "");
	 		$("#detail_save_btn").attr("disabled", false); // 헤더 상태 변경 가능.
	 		
	 		$("#btn_detail_next_history").attr("disabled", true); // 등록 불가
	 		
	 		$("#detail_title").attr("disabled", true);
	 		$("#detail_sel_process").attr("disabled", true);
	 		$("#detail_sel_control").attr("disabled", true);
	 		$("#detail_plan_due_date").attr("disabled", true);
	 		
	 		// 대,중,소분류 대상 
			$("#detail_sel_syInfo").attr("disabled", true);
			$("#detail_selR_type").attr("disabled", true);
			$("#detail_selR_category").attr("disabled", true);
			$("#detail_selR_categoryItem").attr("disabled", true);
			
			$("#detail_sel_priority2").attr("disabled", true);

	 		// ★★
	 		// 이 헤더는 승인 요청이 있어요~
	 		if( apprLoadData.length > 0 ) {
	 			$("#edit_appr_status_div").css("display", "none"); // 서브는 보여줘도 됨. 마찬가지로 승인 요청 버튼도.
		 		$("#edit_comment_approver").css("display", "");
		 		$("#edit_responseCmtDiv").css("display", "");
		 		$("#edit_appr_req_comment").attr("disabled", true); // 요청 메시지 비활성화
		 		$("#edit_comment_approver2").css("display", "");
		 		$("#edit_appr_rep_comment").attr("disabled", true); // 응답 메시지 비활성화
		 		
		 		// 승인 요청
				let getAppr = apprLoadData[apprLoadData.length-2];
		 		
				$("#edit_appr_requester_id").val( getAppr.requester_id );
				$("#edit_appr_requester_nm").val( getAppr.requester_nm );
				
				$("#edit_appr_req_comment").val( getAppr.comment );
				$("#edit_appr_req_date").val( (getAppr.date_created).substring(0, 16) );
				
				// 승인자
				let getAppr2 = apprLoadData[apprLoadData.length-1];
				$("#edit_appr_approver_id").val( getAppr2.approver_id );
				$("#edit_appr_approver_nm").val( getAppr2.approver_nm );
				
				$("#edit_appr_rep_comment").val( getAppr2.comment );
				$("#edit_appr_rep_date").val( (getAppr2.date_created).substring(0, 16) );
	 		}
	 		
	 	}
		if(lstPrtData.length > 0 ) {
// 			$("#edit_apprI_btn").css("display", "none");
			if(lstPrtData.filter(item => item.partner_id == member_id ).length == 0 ){
				$("#btn_detail_next_history").attr("disabled", true);
			} else {
				$("#btn_detail_done").attr("disabled", true);
				$("#detail_save_btn").attr("disabled", true);
				$("#detail_sel_process").attr("disabled", true);
				$("#detail_sel_control").attr("disabled", true);
				$("#detail_plan_due_date").attr("disabled", true);
				
				// 대,중,소분류 대상 
				$("#detail_sel_syInfo").attr("disabled", true);
				$("#detail_selR_type").attr("disabled", true);
				$("#detail_selR_category").attr("disabled", true);
				$("#detail_selR_categoryItem").attr("disabled", true);
				
				$("#detail_sel_priority2").attr("disabled", true);
			}
		} else {
			if(partner_yn != "") {
				$("#btn_detail_next_history").attr("disabled", true);
				$("#btn_detail_done").attr("disabled", true);
				$("#detail_save_btn").attr("disabled", true);
				$("#detail_sel_process").attr("disabled", true);
				$("#detail_sel_control").attr("disabled", true);
				$("#detail_plan_due_date").attr("disabled", true);
				
				// 대,중,소분류 대상 
				$("#detail_sel_syInfo").attr("disabled", true);
				$("#detail_selR_type").attr("disabled", true);
				$("#detail_selR_category").attr("disabled", true);
				$("#detail_selR_categoryItem").attr("disabled", true);
				
				$("#detail_sel_priority2").attr("disabled", true);
			}
		}
		
	}
	
	function fnEditDivD() {
		$("#sel_gubun").val("edit");
		
		fnEditData();
		$(".btnEditDown").css("display", "none"); // 삭제 금지
		$("#btn_detail_done").css("display", "");
		
		let gmGetDt = w2ui["grid_master"].get(1); // 헤더
		let allData = w2ui['subGridO'].records;
		let lastData = w2ui['subGridO'].get(allData[allData.length-1].recid); // 라스트
		
		lstPrtData = prtLoadData.filter(item => item.service_process_id == lastData.service_process_id );
		
		$("#detail_status").val(gmGetDt.status);
		
// 		$("#btn_detail_done").text("In Progress");
		if(selectData.status == "MD1258") {
			$("#btn_detail_done").text("In Progress");
		} else if(selectData.status == "MD1256") {
			$("#btn_detail_done").text("Done");
		} else {
			$("#btn_detail_done").text("Done");
		}
		
		if (gmGetDt.status == "MD1258") {
			$("#detail_status_nm").val("Completed");
		} else {
			$("#detail_status_nm").val(gmGetDt.status_nm);
		}
		
		$("#detail_sel_control").val(gmGetDt.control_gubun).prop("selected", true);
		$("#detail_sel_process").val(gmGetDt.processed_type_code).prop("selected", true);
		$("#detail_title").val(gmGetDt.title);
		$("#detail_plan_due_date").val(gmGetDt.plan_due_date);
		$("#detail_request_due_date").val(gmGetDt.request_due_date);
		
		$("#detail_sel_priority").val(gmGetDt.priority_code).prop("selected", true);
		$("#detail_sel_priority2").val(selectData.priority_code).prop("selected", true);
		$("#detail_sel_priority2").attr("disabled", true);
		
		let gmGetDtStatus = gmGetDt.status;
		let selectDataStatus = selectData.status;
		let lastDataStatus = lastData.status;
		
		// 승인 요청은 중간에도 무조건 가능하다. ( 단, 헤더가 Done이거나 Hold, 해당 status값이 승인 요청 상태, Confirm 상태면 불가 )
		if (selectData.admin_level_type_code == "alt_12") { // confirm 이면
			// 승인 요청 불가능.
			// 협업 보여주기.
			// 무조건 값이 보여주기만. << my case 에서 입력함.
			$("#edit_appr_div").css("display", "none");
			$("#edit_request_div").css("display", "");
			$("#edit_request_status_div").css("display", "none"); // 쓸모 XX
			$("#btn_detail_done").attr("disabled", true); // 진행, 완료 버튼 불가
			 
			if(userLoadData.length == 1){
				// apprLoadData 값이 하나임
				// 승인 요청
				let getRequest = userLoadData[userLoadData.length-1];
				
				$("#edit_request_status").val( getRequest.status );
				$("#edit_request_status_nm").val( getRequest.status_nm );
				
				$("#edit_request_requester_id").val( getRequest.requester_id );
				$("#edit_request_requester_nm").val( getRequest.requester_nm );
				
				$("#edit_request_approver_id").val( getRequest.approver_id );
				$("#edit_request_approver_nm").val( getRequest.approver_nm );
				
				$("#edit_request_req_comment").val( getRequest.comment );
				$("#edit_request_req_date").val( (getRequest.date_created).substring(0, 16) );
			} else {
				// 협업 요청
				let getRequest = userLoadData[userLoadData.length-2];
				
				$("#edit_request_requester_id").val( getRequest.requester_id );
				$("#edit_request_requester_nm").val( getRequest.requester_nm );
				
				$("#edit_request_req_comment").val( getRequest.comment );
				$("#edit_request_req_date").val( (getRequest.date_created).substring(0, 16) );
				
				// 승인자
				let getRequest2 = userLoadData[userLoadData.length-1];
				$("#edit_request_status").val( selectData.status );
				$("#edit_request_status_nm").val( selectData.status_nm );
				
				$("#edit_request_approver_id").val( getRequest2.approver_id );
				$("#edit_request_approver_nm").val( getRequest2.approver_nm );
				
				$("#edit_request_rep_comment").val( getRequest2.comment );
				$("#edit_request_rep_date").val( (getRequest2.date_created).substring(0, 16) );
			}
		}  else if( selectDataStatus == "MD1256" ) { // 해당 값이 진행중이면.
			// 승인 요청 가능.
			if ( gmGetDtStatus == "MD1256" || gmGetDtStatus == "MD1267" || gmGetDtStatus == "MD1268"  ) {
				// 진행중일 때는 내 owner_id가 아니면 안됨.
				if (selectData.owner_id == member_id ) {
					$("#edit_apprI_btn").css("display", "");
				}
			}
			$("#edit_appr_status_div").css("display", "none");
			$("#edit_comment_approver2").css("display", "none");
		} else if( selectDataStatus == "MD1258" ) { // 해당 값이 완료면.
			// 승인 요청 가능.
			if ( gmGetDtStatus == "MD1256" || gmGetDtStatus == "MD1267" || gmGetDtStatus == "MD1268"  ) {
				$("#edit_apprI_btn").css("display", "");
			}
			$("#edit_appr_status_div").css("display", "none");
			$("#edit_comment_approver2").css("display", "none");
		} else if ( selectDataStatus == "MD1267" || selectDataStatus == "MD1268" ) { // 해당 값이  승인이거나 승인 반려면.
				$("#edit_appr_status_div").css("display", "none"); // 승인 반려 버튼.
		 		$("#edit_responseCmtDiv").css("display", "");
				$("#edit_comment_approver").css("display", "");
				$("#edit_comment_approver2").css("display", "");

				let getAppr = apprLoadData[apprLoadData.length-2];
				
				$("#edit_appr_requester_id").val( getAppr.requester_id );
				$("#edit_appr_requester_nm").val( getAppr.requester_nm );
				
				$("#edit_appr_req_comment").val( getAppr.comment );
				$("#edit_appr_req_comment").attr("disabled", true);
				$("#edit_appr_req_date").val( (getAppr.date_created).substring(0, 16) );
				
				// 승인자
				let getAppr2 = apprLoadData[apprLoadData.length-1];
				$("#edit_appr_status").val( getAppr2.status );
				$("#edit_appr_status_nm").val( getAppr2.status_nm );
				
				$("#edit_appr_approver_id").val( getAppr2.approver_id );
				$("#edit_appr_approver_nm").val( getAppr2.approver_nm );
				
				$("#edit_appr_rep_comment").val( getAppr2.comment );
				$("#edit_appr_rep_date").val( (getAppr2.date_created).substring(0, 16) );
				$("#edit_appr_rep_comment").attr("disabled", true);
				
				$("#btn_detail_done").attr("disabled", true);
		 	// 헤더가 진행중이거나 승인이거나 승인 반려면.
			// 승인 요청 가능.
			if ( selectDataStatus != "MD1268" && 
					gmGetDtStatus == "MD1256" || gmGetDtStatus == "MD1267" || gmGetDtStatus == "MD1268"  ) {
				$("#edit_apprI_btn").css("display", "");
			}
		} else if ( selectDataStatus == "MD1266" ) { // 승인 요청이면
			// 승인 요청 불가능.
			$("#edit_apprI_btn").css("display", "none");
			
			$("#edit_comment_approver").css("display", "");
			$("#edit_comment_approver2").css("display", "");
			$("#edit_responseCmtDiv").css('display', '');
			let getAppr = apprLoadData[apprLoadData.length-1];
			
			$("#edit_appr_requester_id").val( getAppr.requester_id );
			$("#edit_appr_requester_nm").val( getAppr.requester_nm );
			
			$("#edit_appr_req_comment").val( getAppr.comment );
			$("#edit_appr_req_comment").attr("disabled", true);
			$("#edit_appr_req_date").val( (getAppr.date_created).substring(0, 16) );
			
			$("#edit_appr_approver_id").val( getAppr.approver_id );
			$("#edit_appr_approver_nm").val( getAppr.approver_nm );
			
			$("#edit_appr_rep_comment").attr("disabled", true);
			
			if(member_id == getAppr.approver_id ){
				$("#edit_appr_status_div").css("display", "");
				$("#edit_appr_rep_comment").attr("disabled", false);
				
				$("#detail_save_btn").css("display", "");
				$("#detail_save_btn").attr("disabled", false); // 저장 가능
				
				$("#edit_appr_btn").css("display", "");
				$("#edit_apprX_btn").css("display", "");
				
				if(getAppr.requester_id != member_id ) {
					$("#edit_apprRst_btn").css("display", "none");
				} else {
					$("#edit_apprRst_btn").css("display", "");
				}
			} else {
				if(getAppr.requester_id == member_id ) {
					$("#edit_appr_status_div").css("display", "");
					$("#edit_appr_btn").css("display", "none");
					$("#edit_apprX_btn").css("display", "none");
					$("#edit_apprRst_btn").css("display", "");
				}
			}
		}
		
		$("#detail_title").attr("disabled", true);
 		$("#detail_sel_process").attr("disabled", true);
 		$("#detail_sel_control").attr("disabled", true);
 		$("#detail_plan_due_date").attr("disabled", true);
 		
 		// 대,중,소분류 대상 
		$("#detail_sel_syInfo").attr("disabled", true);
		$("#detail_selR_type").attr("disabled", true);
		$("#detail_selR_category").attr("disabled", true);
		$("#detail_selR_categoryItem").attr("disabled", true);
		
		$("#detail_sel_priority2").attr("disabled", true);
 		
		// 헤더가 아직 빈값이면
	 	if ( gmGetDtStatus == "MD1269" ) { // User Confirm
	 	} else if ( gmGetDtStatus == "MD1256" || gmGetDt.status == "MD1267" || gmGetDt.status == "MD1268" ){ // 헤더가 진행중이거나 승인 결과받았으면
	 		// 여기서 나중에는 우선순위로 중간에도 승인 요청인 게 있으면 수정, 등록 불가함. 현재는 마지막 값만 봄.
	 		// 라스트 값이 완료, 승인, 반려면
	 		if( selectData.allApprCount == 0 ) {
	 			// 라스트 값이 없거나 완료, 승인, 반려면
	 			if ( (lastDataStatus == "MD1258") || (lastDataStatus == "MD1267") || (lastDataStatus == "MD1268") ){ 
	 				$("#btn_detail_next_history").attr("disabled", false); // 등록 가능
	 			}
	 		}
	 		// 참조 id가 일치한데 마지막이면
			if ( lastData.recid == selectData.recid && selectData.partner_id == member_id && selectData.service_process_id == selectData.subCaseLst ) {
				$("#btn_detail_done").attr("disabled", true);
				$("#detail_save_btn").css("display", "");
				$("#detail_save_btn").attr("disabled", false); // 저장 가능
				
				$(".btnEditDown").css("display", "");
				descEditor.edit.on();
				descEditor.toolbar.show();
			} else if( lastData.recid == selectData.recid && selectData.owner_id == member_id ) { // 마지막이고 본인이 작성자면 수정 가능.
				if ( selectData.admin_level_type_code == "alt_12" || selectDataStatus == "MD1266" ) {
			
				} else if( selectDataStatus == "MD1267" || selectDataStatus == "MD1268" ) { 
// 					$("#detail_title").attr("disabled", false);
					$("#detail_sel_process").attr("disabled", false);
					
					// 수정할 때는 마찬가지로 통제 분류 수정 가능..
					$("#detail_sel_control").attr("disabled", false);
					
					$("#detail_plan_due_date").attr("disabled", false);
					$("#detail_sel_priority2").attr("disabled", false);
					
					// 대,중,소분류 대상 
					$("#detail_sel_syInfo").attr("disabled", false);
					$("#detail_selR_type").attr("disabled", false);
					$("#detail_selR_category").attr("disabled", false);
					$("#detail_selR_categoryItem").attr("disabled", false);
					
					$("#detail_sel_priority2").attr("disabled", false);
					
					$("#detail_owner_btn").css("display", "");
					
					$("#btn_detail_done").attr("disabled", true); // 종료 불가능
					$("#detail_save_btn").css("display", "");
					$("#detail_save_btn").attr("disabled", false); // 저장 가능
					$("#detail_delete_btn").css("display", "");
					$(".btnEditDown").css("display", "");
					
					descEditor.edit.on();
					descEditor.toolbar.show();
				} else {
// 					$("#detail_title").attr("disabled", false);
					$("#detail_sel_process").attr("disabled", false);
					
					// 수정할 때는 마찬가지로 통제 분류 수정 가능..
					$("#detail_sel_control").attr("disabled", false);
					
					$("#detail_plan_due_date").attr("disabled", false);
					$("#detail_sel_priority2").attr("disabled", false);
					
					// 대,중,소분류 대상 
					$("#detail_sel_syInfo").attr("disabled", false);
					$("#detail_selR_type").attr("disabled", false);
					$("#detail_selR_category").attr("disabled", false);
					$("#detail_selR_categoryItem").attr("disabled", false);
					
					$("#detail_owner_btn").css("display", "");
					
					$("#btn_detail_done").attr("disabled", false); // 종료 가능
					$("#detail_save_btn").css("display", "");
					$("#detail_save_btn").attr("disabled", false); // 저장 가능
					
					$("#detail_delete_btn").css("display", "");
					$(".btnEditDown").css("display", "");
					descEditor.edit.on();
					descEditor.toolbar.show();
				}
				// Company Type이 본사면 or company_code이 뷰웍스면(MD1244)
				if( usertData.company_gubun_code == "MD1242" ) {
					$("#btn_partner").css("display", "");
					$(".button_prt_user").css("display", "");
					$(".button_prt_user").attr("disabled", false);
					if(selectData.partner_id){ // 등록한거임.
						$(".btnEditDown").css("display", "none");
						
						$("#btn_partner").css("display", "none");
						$("#edit_apprI_btn").css("display", "none");
						$("#btn_detail_done").attr("disabled", true);
		 				
						$("#detail_sel_process").attr("disabled", true);
						// 수정할 때는 마찬가지로 작업 분류와 같이 통제 분류 수정 불가능..
						$("#detail_sel_control").attr("disabled", true);
						$("#detail_plan_due_date").attr("disabled", true);
						$("#detail_sel_priority2").attr("disabled", true);
						
						// 대,중,소분류 대상 
						$("#detail_sel_syInfo").attr("disabled", true);
						$("#detail_selR_type").attr("disabled", true);
						$("#detail_selR_category").attr("disabled", true);
						$("#detail_selR_categoryItem").attr("disabled", true);
						
						$("#detail_sel_priority2").attr("disabled", true);
						
						$("#detail_owner_btn").css("display", "none");
		 				$("#detail_save_btn").css("display", "none");
						
		 				descEditor.edit.off();
						descEditor.toolbar.hide();
					}
				}
// 				} else if( selectDataStatus == "MD1256" || selectDataStatus == "MD1258" ) { // 해당 값이 진행중이거나 완료면.
			} 
	 	}
	 	
		//
// 		if(lstPrtData.length > 0 ) {
// 			if(lstPrtData.filter(item => item.partner_id == member_id ).length == 0 ){
// 				$("#btn_detail_next_history").attr("disabled", true);
// 			} else {
// 				$("#btn_detail_done").attr("disabled", true);
// 				$("#detail_save_btn").attr("disabled", true);
// 				$("#detail_sel_process").attr("disabled", true);
// 				$("#detail_plan_due_date").attr("disabled", true);
// 			}
// 		} else {
// 			if(partner_yn != "") {
// 				$("#btn_detail_next_history").attr("disabled", true);
// 				$("#btn_detail_done").attr("disabled", true);
// 				$("#detail_save_btn").attr("disabled", true);
// 				$("#detail_sel_process").attr("disabled", true);
// 				$("#detail_plan_due_date").attr("disabled", true);
// 			}
// 		}
		//
		
		if(lstPrtData.length > 0 ) {
// 			$("#btn_detail_done").attr("disabled", true);
			$("#edit_apprI_btn").css("display", "none");
			if(lstPrtData.filter(item => item.partner_id == member_id ).length == 0 ){
				$("#btn_detail_next_history").attr("disabled", true);
			} else {
				$("#detail_sel_process").attr("disabled", true);
				$("#detail_sel_control").attr("disabled", true);
				$("#detail_plan_due_date").attr("disabled", true);
				$("#detail_sel_priority2").attr("disabled", true);
				
				// 대,중,소분류 대상 
				$("#detail_sel_syInfo").attr("disabled", true);
				$("#detail_selR_type").attr("disabled", true);
				$("#detail_selR_category").attr("disabled", true);
				$("#detail_selR_categoryItem").attr("disabled", true);
				
				$("#detail_sel_priority2").attr("disabled", true);
			}
		} else { 
			if(partner_yn != "") {
				$("#edit_apprI_btn").css("display", "none");
				
				$("#btn_detail_next_history").attr("disabled", true);
				$("#btn_detail_done").attr("disabled", true);
// 				$("#detail_save_btn").attr("disabled", true);
				$("#detail_sel_process").attr("disabled", true);
				$("#detail_sel_control").attr("disabled", true);
				$("#detail_plan_due_date").attr("disabled", true);
				$("#detail_sel_priority2").attr("disabled", true);
				
				// 대,중,소분류 대상 
				$("#detail_sel_syInfo").attr("disabled", true);
				$("#detail_selR_type").attr("disabled", true);
				$("#detail_selR_category").attr("disabled", true);
				$("#detail_selR_categoryItem").attr("disabled", true);
				
				$("#detail_sel_priority2").attr("disabled", true);
			}
		}
		
		if ( selectDataStatus == "MD1268" || selectData.partner_id || $("input[name=hidden_prt_user]").length > 0 ) {
			$("#edit_apprI_btn").css("display", "none");
		}
		
		if(  selectDataStatus == "MD1267" || selectDataStatus == "MD1268" ) {
			descEditor.edit.off();
			descEditor.toolbar.hide();
			
			$(".detail_case_div div.fr-element.fr-view.fr-disabled").removeClass( 'fr-disabled' );
		}
		
		// 수정 활성화
		// 빈값이거나 진행이거나 승인 확인 받았다면 < 컨펌은 ..... xx gmGetDt.status == "MD1269" XX 
// 		if( !gmGetDtSt || gmGetDt.status == "MD1256" || gmGetDt.status == "MD1267" || gmGetDt.status == "MD1268" ) {
// 			if(lastSvcDt.recid == getSvcDt.recid && getSvcDt.owner_id == member_id ) { // 마지막이고 본인이 작성자면 수정 가능.
// 				$("#detail_title").attr("disabled", false);
// 				$("#detail_sel_process").attr("disabled", false);
// 				$("#detail_plan_due_date").attr("disabled", false);
// 				$("#detail_request_due_date").attr("disabled", false);
// 				$("#detail_sel_priority").attr("disabled", false);
// 				$(".btnEditDown").css("display", ""); // 다운 파일 삭제
				
// 				descEditor.edit.on();
// 				descEditor.toolbar.show();
// 			}
// 		}
	}
	
	// 무조건 등록, 수정 안되게 
	function fnEditData() {
		loadEditDown(selectData.file_group);
		
		$("#btn_partner").css("display", "none");
		$(".button_prt_user").css("display", "none");
		$(".button_prt_user").attr("disabled", true);
		
		$("#new_apprI_btn").text('승인 추가');
		$("#edit_apprI_btn").text('승인 추가');
		
		$("#btn_detail_next_history").css("display", "");
		
		$("#edit_cmt_div").css("display", "");
		$("#new_cmt_div").css("display", "none");
		
		$("#edit_appr_div").css("display", "");
 		$("#edit_appr_status_div").css("display", "none");
 		$("#edit_comment_approver").css("display", "none");
 		$("#edit_comment_approver2").css("display", "none");
 		
		$("#edit_request_div").css("display", "none");
		
		$("#edit_apprI_btn").css("display", "none"); // confirm, 승인 요청 중 아니면 승인 요청 버튼 활성화
		$("#detail_owner_btn").css("display", "none"); // 마지막 수정은 owner update 버튼 활성화
		$("#detail_save_btn").css("display", "none"); // 마지막 수정은 수정 버튼 활성화
		$("#detail_delete_btn").css("display", "none"); // 마지막 수정은 삭제 버튼 활성화
		$("#btn_detail_done").attr("disabled", true); // 마지막 수정은 상태 버튼 활성화
		$("#detail_save_btn").attr("disabled", true); // 마지막 수정은 저장 버튼 활성화
		
		$("#btn_detail_next_history").attr("disabled", true); // 처음, 마지막 수정은 Next Case 버튼 활성화
		
		// Case Info, Request Info, Step Description
		$("#detail_sel_levelType").attr("disabled", true);
		$("#detail_sel_process").attr("disabled", true);
		$("#detail_sel_priority2").attr("disabled", true);
		$("#detail_title").attr("disabled", true);
		$("#detail_plan_due_date").attr("disabled", true);
		$("#detail_request_due_date").attr("disabled", true);
		$("#detail_sel_priority").attr("disabled", true);
		
		// 대,중,소분류 대상 
		$("#detail_sel_syInfo").attr("disabled", true);
		$("#detail_selR_type").attr("disabled", true);
		$("#detail_selR_category").attr("disabled", true);
		$("#detail_selR_categoryItem").attr("disabled", true);
		
		$("#detail_sel_priority2").attr("disabled", true);
		
		$("#detail_done_status").val('');
		$("#detail_done_status_nm").val('');
		
		$("#sel_request_id").val(selectData.request_id);
		
		$("#detail_old_status").val(selectData.status);
		$("#detail_old_status_nm").val(selectData.status_nm);

		$("#detail_done_status").val(selectData.status);
		if ($("#grid_name").val() == "grid_master" && selectData.status == "MD1258") {
			$("#detail_done_status_nm").val("Completed");
		} else {
			$("#detail_done_status_nm").val(selectData.status_nm);
		}
		
		$("#detail_owner_id").val(selectData.owner_id);
		$("#detail_owner_nm").val(selectData.owner_nm);
		
		$("#detail_partner_id").val(selectData.partner_id);
		$("#detail_partner_nm").val(selectData.partner_nm);
		
		if(selectData.partner_id) {
			$(".partner_div").css("display", "");
		} else {
			$(".partner_div").css("display", "none");
		}
		
		$("#detail_sel_syInfo").val(selectData.system_info_code).prop("selected", true);
		
		if( $('#detail_sel_syInfo option:selected').length == 0 ) {
			partner_yn = "O";
			$("#detail_sel_syInfo option[value='partner_yn']").remove();
			$("#detail_sel_syInfo").append("<option value=" + "partner_yn" + ">" 
															+ selectData.system_info_nm + "</option>");
			
			$("#detail_sel_syInfo").val("partner_yn").prop("selected", true);
		}
		
		$("#detail_sel_control").val(selectData.control_gubun).prop("selected", true);
		$("#detail_sel_process").val(selectData.processed_type_code).prop("selected", true);
		$("#detail_sel_levelType").val(selectData.admin_level_type_code).prop("selected", true); 
		$("#detail_sel_priority").val(selectData.priority_code).prop("selected", true); 
		// .val(selectData[myGubun+'_level_type_nm']);
		
// 		$("#detail_selR_type").val(selectData.request_type).prop("selected", true); 
// 		$("#detail_selR_category").val(selectData.request_category).prop("selected", true); 
// 		$("#detail_selR_categoryItem").val(selectData.request_category_item).prop("selected", true); 
		// ★
		$("#detail_selR_type").val(selectData.request_type).prop("selected", true); 
		fnSelRequest("category", selectData.request_type);
		$("#detail_selR_category").val(selectData.request_category).prop("selected", true); 
        fnSelRequest("categoryItem", selectData.request_category);
		$("#detail_selR_categoryItem").val(selectData.request_category_item).prop("selected", true); 
		
		// Approval Info, Request for collaboration confirmation
		$("#edit_cmt_div input").val('');
		$("#edit_cmt_div textarea").val('');
		
		descEditor.html.set('');
		descEditor.html.set(selectData.context);
		descEditor.edit.off();
		descEditor.toolbar.hide();
		
		$(".detail_case_div div.fr-element.fr-view.fr-disabled").removeClass( 'fr-disabled' );
	}
	
	function loadPartner(){
		$("#append_user").empty();
		
		let prtDt = prtLoadData.filter(item => item.service_process_id == selectData.service_process_id );
		
		for(var i=0; i<prtDt.length; i++){
			let recid = (i+1);
			
			let div = $("<div>");
			div.attr("id", "div_prt_user_"+recid );
			div.addClass("col-sm-6 text-center form-group");
			div.attr("style", "padding-right: 0px;");
			
			let input = $("<input>");
			input.attr("type", "hidden");
			input.attr("id", "hidden_prt_user_no_"+recid);
			input.attr("name", "hidden_prt_user");
			input.attr("value", prtDt[i].user_no);
			
			let input2 = $("<input>");
			input2.attr("type", "hidden");
			input2.attr("id", "hidden_prt_user_id_"+recid);
			input2.attr("value", prtDt[i].partner_id);
			
			let label = $("<label>");
			label.addClass("col-sm-12 no-padding");
			label.attr("id", "label_prt_user_"+recid);
			
			
			let span = $("<span>");
			span.text(prtDt[i].partner_nm);
			span.attr("style", "background-color: #EDEDED; line-height: 30px; padding: 5px;");
			
			
			let button = $("<button>");
			button.addClass("button_prt_user"); 
			button.attr("onclick", "fnDeletePartner('"+recid+"')"); 
			button.attr("id", "button_prt_user_"+recid);
			button.text("x");
			button.attr("style", "margin-left: 5px; line-height: 15px; border:none; color: red;");
			
			$("#append_user").append( div.append(input).append(input2).append(label.append(span.append(button))) );
		}
	}
	
	function loadEditDown(file_group) {
		$("#append_down").empty();
		
		var page_url = "/file/selectFileList";
		var postData = { file_group : file_group };
			
		$.ajax({
			url:page_url, 
			type:'POST', 
			data : postData, 
			dataType: 'json', 
			async : false,
			success: function( data ) {
				if(data.status == "200" && (data.rows).length>0 ) {
					rowArr = data.rows;
					$.each(rowArr,function(idx, row){
						let recid = idx + 1;
						if(row.file_group){
							row.down_link = '<a href="/file/attach_download2?file_group=' 
									+ row.file_group +'&file_name=' 
									+ encodeURIComponent(row.file_name) 
									+ '" target="_blanck"><i class="fa fa-file"> '
									+ row.file_name+ '</i>';
							
							let div = $("<div>");
							div.attr("id", "div_ap_down_"+recid );
							div.addClass("col-sm-12 form-group");
							div.attr("style", "margin-bottom: 5px;");
							
							let span1 = $("<span>");
							span1.attr("id", "span_ap_down_"+recid);
							span1.attr("style", "padding-right: 5px;");
							span1.text(recid+".");
							
							let down_link = '<a style="padding-right: 5px;" href="/file/attach_download2?file_group=' 
												+ row.file_group +'&file_name=' 
												+ encodeURIComponent(row.file_name) 
												+ '" target="_blanck"><i class="fa fa-file"> '
												+ row.file_name+ '</i>';
							
							let btn = '<button type="button" id="btn_del_down_'+ recid +'" '
										+' style="line-height: 10px;" '
										+' class="btn btn-danger btn-sm btnEditDown" onclick="delDown('+recid+');">Del</button>';
									
							$("#append_down").append( div.append(span1).append(down_link).append(btn) );
						}
					});
					
				}
			},
			complete: function() {
				
			}
		});
	}
	
	function fnCaseAdd() {
		page_move("/frontend/location/menus/case_mng", null, "I");
	}
	
	function loadList(workStatus) {
		let postData = [];
		let rowArr = [];
		
		dateData = [];
		// h(High), m(Medium), l(Low) 
		priorityData = [];
// 		[
// 					{ "priorityId" : "h", "priorityText" : "High", "priorityValue": 0}, 
// 					{ "priorityId" : "m", "priorityText" : "Medium", "priorityValue": 0}, 
// 					{ "priorityId" : "l", "priorityText" : "Low", "priorityValue": 0}
//         ];
		sysInfoData = [];
		ownerData = [];
		chartData = [];
		ownerchartData = [];
		
			circleLoadData = {
				"alt_06" : 0, 
				"alt_09" : 0, 
				"alt_02" : 0, 
				"Hold" : 0, 
				"alt_11" : 0, 
				"alt_05" : 0,
				"alt_10" : 0, 
				"alt_03" : 0, 
				"alt_12" : 0,
				"alt_14" : 0,
				"alt_15" : 0,
				"alt_16" : 0
			};
		let workStatus_s = $("#c_clickCircle_div #clickCircle").val();
		if(!workStatus) {
			if(!workStatus_s){
			$(".border-circle").css("background-color", "white");
			$("#clickCircle").val('');
			
			}
		}
		let hap_search = $("#hap_search").val();
		let process_date = $("#process_date").val();
		let date_updated = $("#date_updated").val();
		let n_owner_id = $("#sel_owner option:selected").val();
		
		let system_info_codes = member_id;
		let sysInfo = $("#sysInfo").val();
		let priorityCode = $("#priorityCode").val();
		let getDateCode = $("#getDateCode").val();
		
		let approver_id = "";
		let rdo_approver_yn = $(":radio[name='rdo_approver_yn']:checked").val(); 
		
		let all_data = $(":radio[name='rdo_all_data_yn']:checked").val();
		let control_gubun = $("#sel_ct_gubun option:selected").val();
		let status_nm_info = $("#status_nm_info option:selected").val();
		let header = '';
		
		if(control_gubun == 'all'){
			control_gubun = '';
		}
		if(status_nm_info == 'all'){
			status_nm_info = '';
		}
		if(all_data == 'Y'){
			all_data = '';
		}
		if (rdo_approver_yn == "Y") {
			approver_id = member_id;
		}
		var admin_level_type_code = workStatus;
		if(admin_level_type_code != 'Hold'){
			admin_level_type_code = workStatus_s
		}
		if(admin_level_type_code == 'alt_02' || admin_level_type_code == 'alt_05' || admin_level_type_code == 'Hold'){
			header = 'header';
		}
		
		if(excel_request_id){
			postData = {
				hap_search				: hap_search, 
				process_date			: process_date, 
				date_updated			: date_updated, 
				n_owner_id				: n_owner_id, 
				member_id				: member_id, 
				approver_id				: approver_id, 
				system_info_codes		: system_info_codes, 
				control_gubun			: control_gubun, 
				status					: status_nm_info,
				value2					: all_data,
				value3					: header,
				apprStatus				: excel_request_id, // 엑셀로 다운 받을 때 자식들도 가져오기 위해 담아주는 변수
				
				system_info_code		: sysInfo, 
				priority_code			: priorityCode, 
				dateCode				: getDateCode, 
				
				// 동그라미
	// 			admin_level_type_code	: admin_level_type_code, 
				
				use_yn					: "Y"
			};
		}
		
		if(!excel_request_id){
			if(page_request_seq == null || page_request_seq == 'null'){
	// 		if(page_request_id == null || page_request_id == 'null'){
				console.log('page_request_seq가 빈 값일 때');
				postData = {
					hap_search				: hap_search, 
					process_date			: process_date, 
					date_updated			: date_updated, 
					n_owner_id				: n_owner_id, 
					member_id				: member_id, 
					approver_id				: approver_id, 
					system_info_codes		: system_info_codes, 
					control_gubun			: control_gubun, 
					status					: status_nm_info,
					value2					: all_data,
					value3					: header,
					
					system_info_code		: sysInfo, 
					priority_code			: priorityCode, 
					dateCode				: getDateCode, 
					
					// 동그라미
		// 			admin_level_type_code	: admin_level_type_code, 
					
					use_yn					: "Y"
				};
			}if(page_request_seq != null && page_request_seq != 'null'){
	// 		}if(page_request_id != null && page_request_id != 'null'){
				console.log('page_request_seq가 빈 값이 아닐 때');
				postData = {
						request_seq				: page_request_seq, 
	// 					request_id				: page_request_id, 
						member_id				: member_id, 
						use_yn					: "Y"
				};
			}
		}
		var page_url = "/case/admin/selectHeader";
		
		if(!excel_request_id){
			w2ui['grid_main'].clear();
			w2ui['grid_main'].lock('loading...', true);
		}
			
		$.ajax({
			url:page_url, 
			type:'POST', 
			data : postData, 
			dataType: 'json', 
			async : false,
			success: function( data ) {
				rowArr = data.rows;
// 				var prms_group_arr = data.rows22; // 권한
				
				
// 				var prms_check = 0;
// 				for(var i = 0; i < prms_group_arr.length; i++){
// 					prms_group_arr[i].user_pwd = "";
// 					if(prms_group_arr[i].prms_group_code == 'PG00000004' || // 개발 서버
// 							prms_group_arr[i].prms_group_code == 'PG00000012' ||
// 							prms_group_arr[i].prms_group_code == 'PG00000013' ||
// 							prms_group_arr[i].prms_group_code == 'PG00000016'){
// 						prms_check++;
// 					}
// // 					if(prms_group_arr[i].prms_group_code == 'PG00000004' || //운영 서버
// // 							prms_group_arr[i].prms_group_code == 'PG00000012' ||
// // 							prms_group_arr[i].prms_group_code == 'PG00000018'){
// // 						prms_check++;
// // 					}
// 				}
// 				if(page_request_seq != null && page_request_seq != 'null'){
// 					if(prms_check == 0){
// 						fnMessageModalAlert("Notification", "입력한 URL이 올바르지 않습니다.");
// 						setTimeout(function () {
// 							page_move("/frontend/location/menus/new_1");
// 				         }, 800);
// 						return;
// 					}
// 					$("#mainDiv").show();
// 					$("#section_header").show();
// 				}
// 			if(document.getElementsByClassName("active").length != 0){
			if(document.getElementsByClassName("active").length == 2){
				$("#mainDiv").css("display", "");
				$("#section_header").css("display", "");
			}
				
				if(data.status == "200" && (data.rows).length>0 ) {
					
					let idxA = 0; 
					let idxB = 0; 
					let idxC = 0; 
					
					let dtRq = 0;
					let dtPl = 0;
					var rstArr = [];
					
					$.each(rowArr,function(idx, row){
						row.recid = idx + 1;
						
						row.request_seq = Number(row.request_seq);
						
						row.work_status = row[myGubun+'_level_type_nm'];
						if(row.file_group){
							row.down_link = '<a href="/file/attach_download2?file_group=' + row.file_group +'&file_name=' + encodeURIComponent(row.file_name) + '" target="_blanck"><i class="fa fa-file"> '+ row.file_name+ '</i>'
						}
						
						// selectBox Owner 내 Queue로 보이기.
// 						let gridOwner = "O";
// 						for(var i=0; i<gridStatus.length; i++ ) {
// 							if( !row.n_owner_id || row.n_owner_id == gridStatus[i].n_owner_id ){
// 								gridOwner = "";
// 							}
// 						}
// 						if(gridOwner){
// 							gridStatus.push({"n_owner_id": row.n_owner_id, "n_owner_nm" : row.n_owner_nm });
// 							$("#sel_owner").append("<option value=" + row.n_owner_id + ">" + row.n_owner_nm + "</option>");
// 						}
						
// 						if(!workStatus) {
							if(row.service_process_id == "SER_00") row.value3 = 'header';
							if(row.service_process_id != "SER_00") row.value3 = 'child';
							if(row.process_date) row.process_date = row.process_date.substring(0, 16);
							if(row.value1) row.value1 = row.value1.substring(0, 16);
							if(row.request_date) row.request_date = row.request_date.substring(0, 16);
							if(row.date_updated) row.date_updated = row.date_updated.substring(0, 16);
						if(excel_request_id){
							if(row.service_process_id != "SER_00"){
								row.owner_nm = '';
								row.process_date = '';
							}
						}
						if(!excel_request_id){
							let cnt = 0;
							if(row.admin_level_type_code && row.admin_level_type_code != "null"){
// 								if( (row.work_status).indexOf('closed') > -1 ) {
								if( (row.work_status).search(/closed/i) > -1 ) {
									cnt = Number(circleLoadData['alt_02'])+1;
									circleLoadData['alt_02'] = cnt;
// 									cnt = Number(circleLoadData["Hold"])+1;
									if(workStatus_s == 'alt_02' && row.admin_level_type_code == 'alt_02' || workStatus_s == 'alt_02' && row.admin_level_type_code == "alt_07"){
										rstArr.push(row);
									}
// 									circleLoadData["Hold"] = cnt;
								}  else {
									cnt = Number(circleLoadData[row.admin_level_type_code])+1;
									circleLoadData[row.admin_level_type_code] = cnt;
								}
								if(workStatus_s == 'alt_03' && row.admin_level_type_code == 'alt_16'){
									rstArr.push(row);
								}
								if(workStatus_s == 'alt_15' && row.admin_level_type_code == 'alt_14'){
									rstArr.push(row);
								}
								if(row.admin_level_type_code == workStatus_s && row.admin_level_type_code != 'alt_02' && row.admin_level_type_code != "alt_07"){
									rstArr.push(row);
								}
							}
						} // if(!excel_request_id){
							// Hold는 Status가 "Hold"인것.
							if(row.status == "MD1257") {
								cnt = Number(circleLoadData["Hold"])+1;
								circleLoadData["Hold"] = cnt;
							}
// 						}
						if( row.priority_code ) {
							if( row.priority_code == "h" ) {
								idxA = idxA+1;
							} else if( row.priority_code == "m" ) {
								idxB = idxB+1;
							} else if( row.priority_code == "l" ) {
								idxC = idxC+1;
							}
						}
						// Status가 "Done"이 아닌것.
						if(row.status != "MD1258") {
// 						if(row.status != "MD1258" && row.admin_level_type_code != "alt_05" ) { // Open인 Case 제외.
							var gDate = getFormatDate(new Date());
							if( gDate > row.plan_due_date ) {
								dtPl++;
							}
							if( gDate > row.request_due_date ) {
								dtRq++;
							}
						}
					}); // forEach
					circleLoadData['alt_03'] = circleLoadData['alt_03'] + circleLoadData['alt_16']; 	
					circleLoadData['alt_15'] = circleLoadData['alt_15'] + circleLoadData['alt_14']; 
					for(var i = 0; i < rowArr.length; i++){
						if(workStatus_s == 'Hold' && rowArr[i].status == "MD1257"){
							rstArr.push(rowArr[i]);
						}
					}
					
					if(!excel_request_id){
						if(workStatus_s){
							w2ui['grid_main'].records = rstArr;
							rowArr = rstArr;
						}
						if(!workStatus_s){
							w2ui['grid_main'].records = rowArr;
						}
					}
					if(excel_request_id){
						w2ui['grid_main'].records = rowArr;
						console.log(w2ui['grid_main'].records);
					}
					priorityData = [
			 					{ "priorityId" : "h", "priorityText" : "상", "priorityValue": idxA }, 
			 					{ "priorityId" : "m", "priorityText" : "중", "priorityValue": idxB }, 
			 					{ "priorityId" : "l", "priorityText" : "하", "priorityValue": idxC }
			         ];
					data2Value = [
						[ {v: 'h', f:'상'}, idxA ], 
						[ {v: 'm', f:'중'}, idxB ], 
						[ {v: 'l', f:'하'}, idxC ],
						[ {v: 'd', f:'D'}, (idxA+idxB+idxC) ]
					];
					
					data1Value = [
						[ {v: 'rq', f:'Out of Request'}, dtRq ], 
						[ {v: 'pl', f:'Out of Plan'}, dtPl ],
						[ {v: 'd', f:'D'}, (dtRq+dtPl) ]
					];
				} else {
					// 값이 없으면 안보이게 설정.
					data2Value = [
						[ {v: 'h', f:'상'}, 0 ], 
						[ {v: 'm', f:'중'}, 0 ], 
						[ {v: 'l', f:'하'}, 0 ],
						[ {v: 'd', f:'D'}, (0) ]
					];
					
					data1Value = [
						[ {v: 'rq', f:'Out of Request'}, 0 ], 
						[ {v: 'pl', f:'Out of Plan'}, 0 ],
						[ {v: 'd', f:'D'}, (0) ]
					];
				}
				chartData = JSON.parse(JSON.stringify( rowArr ));
				
// 				if( _.uniqBy(chartData, "priority_code")[0].priority_code == "null" || 
// 					_.uniqBy(chartData, "priority_code")[0].priority_code == null ){
// 					priorityData = [];
// 				}
				
// 				let priorityObjNm = _.uniqBy(prData, "priority_code");
// 				priorityObjNm.forEach(row => priorityData.push(  { "priorityId" : row.priority_code, "priorityText" : row.priority_nm, "priorityValue" : isEmptyArr( prData.filter(it => it.priority_code.includes( row.priority_code )) ) } ) );
				
				data3Value = [];
				
				// 
				let sysInfoObjNm = _.uniqBy(chartData, "system_info_code");
				// rmateChat
// 				sysInfoObjNm.forEach(row => sysInfoData.push(  { "infoId" : row.system_info_code, "infoText" : row.system_info_nm, "infoValue" : isEmptyArr( chartData.filter(it => it.system_info_code.includes( row.system_info_code )) ) } ) );
				sysInfoObjNm.forEach(row => data3Value.push(
						[{ "v" : row.system_info_code, 
						  "f" : row.system_info_nm }, 
						  isEmptyArr( chartData.filter(it => it.system_info_code.includes( row.system_info_code )) )
						]
				));
				
				data4Value = [];
				
				for(var i=0;i<rowArr.length; i++) {
// 					if( (typeof ownerchartData[i].n_owner_id) == "object" || ownerchartData[i].n_owner_id == null || ownerchartData[i].n_owner_id ==""){
					if( !isEmpty(rowArr[i].n_owner_id) ){
// 						ownerchartData.splice(i, 1);
						ownerchartData.push(rowArr[i]);
					}
				}
				let ownerObjNm = _.uniqBy(ownerchartData, "n_owner_id");
				// rmateChat
// 				ownerObjNm.forEach(row => ownerData.push(  { "ownerId" : row.n_owner_id, "ownerText" : row.n_owner_nm, "ownerValue" : isEmptyArr( ownerchartData.filter(it => it.n_owner_id.includes( row.n_owner_id )) ) } ) );
				ownerObjNm.forEach(row => data4Value.push(
						[{ "v" : row.n_owner_id, 
						  "f" : row.n_owner_nm }, 
						  isEmptyArr( ownerchartData.filter(it => it.n_owner_id.includes( row.n_owner_id )) )
						]
				));
			},
			complete: function() {
				if(!excel_request_id){
					w2ui['grid_main'].refresh();
					w2ui['grid_main'].unlock();
					
					var row_arr = w2ui['grid_main'].records; 
					
					initOptions($("#status_nm_info"));
					$("#status_nm_info").append("<option value="+'all'+">ALL</option>");
					
					if(workStatus_s == 'alt_02' || workStatus_s == 'alt_05' || workStatus_s == 'Hold'){
						_.uniqBy(row_arr, "status").forEach(row => $("#status_nm_info").append("<option value=" + row.status + ">" + row.status_nm + "</option>") );
						if(status_nm_info != ''){
							$("#status_nm_info").val(status_nm_info).prop("selected", true);
						}
						if(status_nm_info == '' || status_nm_info == undefined || status_nm_info == 'undefined'){
							$("#status_nm_info option:eq(0)").prop("selected", true); // 셀렉트 박스 첫 번째 선택
						}
					}else{
						_.uniqBy(row_arr, "queue_nm").forEach(row => $("#status_nm_info").append("<option value=" + row.queue_nm + ">" + row.queue_code + "</option>") );
						if(status_nm_info != ''){
							$("#status_nm_info").val(status_nm_info).prop("selected", true);
						}
						if(status_nm_info == '' || status_nm_info == undefined || status_nm_info == 'undefined'){
							$("#status_nm_info option:eq(0)").prop("selected", true); // 셀렉트 박스 첫 번째 선택
						}
					}
					
					
					initOptions($("#sel_ct_gubun"));
					$("#sel_ct_gubun").append("<option value="+'all'+">ALL</option>");
	// 				_.uniqBy(row_arr, "control_gubun").forEach(row =>  $("#sel_ct_gubun").append("<option value=" + row.control_gubun + ">" + row.control_gubun_nm + "</option>") );
					for(var i = 0; i < _.uniqBy(row_arr, "control_gubun").length; i++){
						if(_.uniqBy(row_arr, "control_gubun")[i].control_gubun){
							$("#sel_ct_gubun").append("<option value=" + _.uniqBy(row_arr, "control_gubun")[i].control_gubun + ">" + _.uniqBy(row_arr, "control_gubun")[i].control_gubun_nm + "</option>")
						}
					}
					if(control_gubun != ''){
						$("#sel_ct_gubun").val(control_gubun).prop("selected", true);
					}
					if(control_gubun == '' || control_gubun == undefined || control_gubun == 'undefined'){
						$("#sel_ct_gubun option:eq(0)").prop("selected", true); // 셀렉트 박스 첫 번째 선택
					}
					
	// 				if(!workStatus) {
						fnCircle();
	// 				}
					fnCharts();
					let seq_num;
					$.each(rowArr,function(idx, row){
						if(page_request_seq == row.request_seq){
	// 					if(page_request_id == row.request_id){
							seq_num = row.recid;
						}
						if(row.cmd > 0) {
							w2ui["grid_main"].expand(row.recid);
						}
					});
	// 				console.log("loadList length = ", w2ui['grid_main'].records.length );
					if(page_request_seq != null && page_request_seq != 'null'){
	// 				if(page_request_id != null && page_request_id != 'null'){
	// 					if(document.getElementsByClassName("active").length != 0){
						if(document.getElementsByClassName("active").length == 2){
							w2ui['grid_main'].select(seq_num);
						}
					}
				}
			} // complete
		}); // ajax
	}
		
	function testx(pm, vle) {
		console.log("pm = ", pm, ", vle = ", vle );
		let rowArr = [];
		
		let postData = {};
		
		if (pm == "request_id") {
			postData = {
				request_id	: vle,
				use_yn	: "Y"
			};
		} else if (pm == "request_seq") {
			postData = {
				request_seq : vle,
				use_yn	: "Y"
			};
		}
		 
		var page_url = "/case/admin/selectHeader";
			
		$.ajax({
			url:page_url, 
			type:'POST', 
			data : postData, 
			dataType: 'json', 
			async : false,
			success: function( data ) {
				rowArr = data.rows;
				console.log("data = ", data);
				console.log("rowArr = ", rowArr);
			}
		});
	}
		
	function fnChart1() {
		var total = 0;
		
	    for (var i = 0; i < data1Value.length; i++) {
	      if (data1Value[i][0] !== null) {
	    	 total += data1Value[i][1];
	      }
	    }
		
        var numberFormat = new google.visualization.NumberFormat({
	      pattern: '#,##0.0',
	      suffix: '%'
	    });
		
	    for (var i = 0; i < data1Value.length; i++) {
	      if (data1Value[i][0]['v'] !== null) {
	    	  data1Value[i][2] = numberFormat.formatValue((( data1Value[i][1] / total) * 200));
	      }
	    }
		
		data1 = new google.visualization.DataTable();
	      data1.addColumn('string', 'Topping');
	      data1.addColumn('number', 'Slices');
	      data1.addColumn('string', 'Percent');
	      data1.addRows(
		      data1Value
	      );
	   	 
	      var options = {
                  'width': Number($("#chartHolder1").width()), // 300, 
                  'height':250, 
                  'pieHole': 0.4,
                  'legend': 'none', 
                  'pieStartAngle': 270,
			      'pieSliceText': 'value', 
			      'pieSliceTextStyle' : { fontSize: 12}, 
                  'colors': ['#074D81', '#FABB05' ], 
                  'chartArea': {
                 	 'left' : 10
                 	, 'width':'95%', 'height':'95%'
  			      }, 
                  'slices': {
        		     2: {
        		         color: 'transparent'
        		     }
        		  }
        		  , 'theme': 'maximized'
   				};
	     
	      if (data1Value.length == 0) {
	    	  var chartDiv = document.getElementById('chartHolder1');
			  chartDiv.innerHTML = '<br>&nbsp;'+'Sorry, not info available';
		  } else if(data1Value[2][1] <= 0 || data1Value[2][1] == "0") {
		      var chartDiv = document.getElementById('chartHolder1');
			  chartDiv.innerHTML = '<br>&nbsp;'+'Sorry, not info available';
		  } else {
		      chart1 = new google.visualization.PieChart(document.getElementById('chartHolder1'));
			  google.visualization.events.addListener(chart1, 'select', selectHandler1);    
			  chart1.draw(data1, options); 
			  
			  google.visualization.events.addListener(chart1, 'onmouseover', function(e) {
				  setTooltipContent1(data1, e.row);
			  });
		  }
	}
	
	function selectHandler1() {
        var selectedItem = chart1.getSelection()[0];
		
        if(!selectedItem) {
        	return;
        }
        if (selectedItem) {
          var topping = data1.Wf[selectedItem.row].c[0].f;
			$("#getDateCode").val(data1.Wf[selectedItem.row].c[0].v);
			loadList();
        }
     }
	
	function setTooltipContent1(data1, row) {
	    if (row != null) {
	        var tooltip = $("#chartHolder1 .google-visualization-tooltip")[0]; 
	        
	        var sss = tooltip.innerHTML;
	        sss = sss.substring(0, sss.indexOf(' (')+2) + data1Value[row][2] + sss.substring(sss.indexOf('%)')+1) ;
	        
	        tooltip.innerHTML = sss;
	    }
	}
	
	function fnChart2() {
		var total = 0;
	    for (var i = 0; i < data2Value.length; i++) {
	      if (data2Value[i][0] !== null) {
	    	 total += data2Value[i][1];
	      }
	    }
	    
        var numberFormat = new google.visualization.NumberFormat({
	      pattern: '#,##0.0',
	      suffix: '%'
	    });
        
	    for (var i = 0; i < data2Value.length; i++) {
	      if (data2Value[i][0]['v'] !== null) {
	    	  data2Value[i][2] = numberFormat.formatValue((( data2Value[i][1] / total) * 200));
	      }
	    }
		
		data2 = new google.visualization.DataTable();
	      data2.addColumn('string', 'Topping');
	      data2.addColumn('number', 'Slices');
	      data2.addColumn('string', 'Percent');
	      data2.addRows(
		      data2Value
	      );
	     console.log("widht = ", $("#chartHolder2").width());
	      var options = {
                  'width':  Number($("#chartHolder2").width()), // 300, 
                  'height':250, 
                  'pieHole': 0.4,
                  'pieStartAngle': 270,
			      'pieSliceText': 'value', 
			      'pieSliceTextStyle' : { fontSize: 12}, 
                  'colors': ['#074D81', '#FABB05', '#F97B17'], 
                  'chartArea': {
                 	 'left' : 10
                 	, 'width':'95%', 'height':'95%'
  			      }, 
                  'slices': {
        		     3: {
        		         color: 'transparent'
        		     }
        		  }
  			      , 'legend': 'none'
  			      , 'theme': 'maximized'
   				};
	     
		  if(data2Value[3][1] <= 0 || data2Value[3][1] == "0") { // dataTable.getNumberOfRows()
			  var chartDiv = document.getElementById('chartHolder2');
			  chartDiv.innerHTML = '<br>&nbsp;'+'Sorry, not info available';
		  } else {
			  chart2 = new google.visualization.PieChart(document.getElementById('chartHolder2'));
			  google.visualization.events.addListener(chart2, 'select', selectHandler2);    
			  chart2.draw(data2, options); 
			  
			  google.visualization.events.addListener(chart2, 'onmouseover', function(e) {
				  setTooltipContent2(data2, e.row);
			  });
		  }
	    //
	}
	
	function selectHandler2() {
        var selectedItem = chart2.getSelection()[0];
		
        if(!selectedItem) {
        	return;
        }
        if (selectedItem) {
          var topping = data2.Wf[selectedItem.row].c[0].f; 
			$("#priorityCode").val(data2.Wf[selectedItem.row].c[0].v);
			loadList();
        }
     }
	
	function setTooltipContent2(data2, row) {
	    if (row != null) {
	        var tooltip = $("#chartHolder2 .google-visualization-tooltip")[0]; 
	        
	        var sss = tooltip.innerHTML;
	        sss = sss.substring(0, sss.indexOf(' (')+2) + data2Value[row][2] + sss.substring(sss.indexOf('%)')+1) ;
	        
	        tooltip.innerHTML = sss;
	        // document.getElementsByClassName("google-visualization-tooltip")[0];
	    }
	}
	
	function fnChart3() {
		data3 = new google.visualization.DataTable();
	      data3.addColumn('string', 'Topping');
	      data3.addColumn('number', 'Slices');
	      data3.addRows(
		      data3Value
	      );
	      
	      var options = {
//	    		  'legend': { position: 'bottom' }, 
                  'pieHole': 0.4,
			      'pieSliceText': 'value', // label
			      'pieSliceTextStyle' : { fontSize: 12},  
                  'chartArea': {
                 	 'left' : 10
                 	, 'width':'100%', 'height':'100%'
//                 	, 'width':'100%', 'height':'80%'
  			      }
 			};
	     
	      
		  if(data3Value.length <= 0) { // dataTable.getNumberOfRows()
			  var chartDiv = document.getElementById('chartHolder3');
			  chartDiv.innerHTML = '<br>&nbsp;'+'Sorry, not info available';
		  } else {
			  chart3 = new google.visualization.PieChart(document.getElementById('chartHolder3'));
			  google.visualization.events.addListener(chart3, 'select', selectHandler3);    
			  chart3.draw(data3, options);
		  }
	    //
	}
	
	function selectHandler3() {
        var selectedItem = chart3.getSelection()[0];
		
        if(!selectedItem) {
        	return;
        }
        if (selectedItem) {
          var topping = data3.Wf[selectedItem.row].c[0].f;
			$("#sysInfo").val(data3.Wf[selectedItem.row].c[0].v);
			
			loadList();
        }
     }
	
	function fnChart4() {
		data4 = new google.visualization.DataTable();
	      data4.addColumn('string', 'Topping');
	      data4.addColumn('number', 'Slices');
	      data4.addRows(
		      data4Value
	      );
	      
	      var options = {
//	    		  'legend': { position: 'bottom' }, 
                  'pieHole': 0.4,
			      'pieSliceText': 'value', // label
			      'pieSliceTextStyle' : { fontSize: 12},  
                  'chartArea': {
                 	 'left' : 10
                 	, 'width':'100%', 'height':'100%'
//                 	, 'width':'100%', 'height':'80%'
  			      }
 			};
	     
	      
		  if(data4Value.length <= 0) { // dataTable.getNumberOfRows()
			  var chartDiv = document.getElementById('chartHolder4');
			  chartDiv.innerHTML = '<br>&nbsp;'+'Sorry, not info available';
		  } else {
			  chart4 = new google.visualization.PieChart(document.getElementById('chartHolder4'));
			  google.visualization.events.addListener(chart4, 'select', selectHandler4);    
			  chart4.draw(data4, options);
		  }
	    //
	}
	
	function selectHandler4() {
        var selectedItem = chart4.getSelection()[0];
		
        if(!selectedItem) {
        	return;
        }
        if (selectedItem) {
       	  console.log("data4.Wf[selectedItem.row].c[0].v = ", data4.Wf[selectedItem.row].c[0].v);
          var topping = data4.Wf[selectedItem.row].c[0].f;
          $("#sel_owner").val( data4.Wf[selectedItem.row].c[0].v ).prop("selected", true);
//           $("#sel_owner").val(data4.Wf[selectedItem.row].c[0].v);
			
			loadList();
        }
     }
		
	var isEmpty = function(val) {
		if ( val === "" || val === null || val === undefined
			|| (val !== null && typeof val === "object" && !Object.keys(val).length) ) {
			return true
		} else {
			return false
		}
	};
	
	function loadList2() {
		var postData;
		var hiddenRow = $("#hiddenRow").val();
		
		if(hiddenRow){
			postData = {
				use_yn		: "Y", 
				member_id	: member_id, 
				request_id  : hiddenRow
			}
		}
		var page_url = "/case/admin/selectHeader";
		
		w2ui["grid_master"].clear();
		w2ui["grid_master"].lock('loading...', true);
		
		$.ajax({
			url:page_url, 
			type:'POST', 
			data : postData, 
			dataType: 'json', 
			async : false,
			success: function( data ) {
				if(data.status == "200" && (data.rows).length>0 ) {
					rowArr = data.rows;
					$.each(rowArr,function(idx, row){
						row.recid = idx + 1;
						row.work_status = row[myGubun+'_level_type_nm'];
// 						if ( row.service_process_seq == $("#sel_service_process_seq").val() ) {
// 							selectData = row;
// 						}
					});
					w2ui["grid_master"].records = rowArr;
				}
			},
			complete: function() {
				w2ui["grid_master"].refresh();
				w2ui["grid_master"].unlock();
			}
		});
		$("#new_apprI_btn").text('승인 추가');
		$("#edit_apprI_btn").text('승인 추가');
	}
		
	function isEmptyArr(arr)  {
	  if(Array.isArray(arr) && arr.length === 0)  {
	    return 0;
	  }
	  return arr.length;
	}
	
	function fnCircle() {
		for(var i in circleLoadData) {
// 			console.log('키 값 : ' +i + ', 속성 값 : '+circleLoadData[i]);
			$("#"+i).text(circleLoadData[i]);
			// 키 값 : Open, 속성 값 : 13
		}
	}
	
	function fnCharts() {
		// Load the Visualization API and the piechart package.
	    google.load('visualization', '1.0', {'packages':['corechart']});
	
	    // Set a callback to run when the Google Visualization API is loaded.
	    google.setOnLoadCallback(fnChart1);
	    google.setOnLoadCallback(fnChart2);
	    google.setOnLoadCallback(fnChart3);
	    google.setOnLoadCallback(fnChart4);
	    
// 		makeLayout_1();
		
// 		setTimeout(function () {
// 	 		fnLoadChart_1();
			
// 	 		checkData_1();
//         }, 300);
	}
	
	function loadList_sub(eventData) {
		var mainData = w2ui['grid_main'].get(eventData.recid);
		let hap_search = $("#hap_search").val();
		let system_info_codes = member_id;
		
		loadData = [];
		
		var page_url = "/case/admin/selectSub";
// 		var page_url = "/incident/menus/data_svcPrcs";
		var postData = {
// 				cmd			: "BB", 
				request_id			: mainData.request_id,
				hap_search			: hap_search, 
				
				system_info_codes	: system_info_codes, 
				member_id			: member_id, 
				use_yn				: "Y"
		};
		
		$.ajax({
			url:page_url, 
			type:'POST', 
			data : postData, 
			dataType: 'json', 
			async : false,
			success: function( data ) {
				if(data.status == "200" && (data.rows).length>0 ) {
					loadData = data.rows;
					$.each(loadData, function(idx, row){
						row.recid = idx + 1;
						row.work_status = row[myGubun+'_level_type_nm'];
					});
				} else {
					loadData = [{recid:1, owner_nm:'', title:'No Data', status:''}]
				}
			}, complete: function() {
// 	            setTimeout(function () {
					console.log('mSubGrid-' + eventData.recid)
	                $('#' + eventData.box_id).w2grid({
	                    name: 'mSubGrid-' + eventData.recid,
	                    recordHeight : 30,
	                    show: { columnHeaders: false },
	                    fixedBody: false,
	                    multiSelect : false, 
	                    columns: [
	                        //  background-color: #F9FBFF;
							{ field: 'request_seq', caption : 'Number', size : '10%', 
								style : 'text-align:right;', sortable : true }, 
	
							{ field: 'approver_id', caption : 'Approver Id', size : '40%', 
								style : 'text-align:center;', sortable : true, hidden: true}, 
							{ field: 'approver_nm', caption : 'Approver Nm', size : '12%', 
								style : 'text-align:center;', sortable : true, hidden: true}, 	
							
							{ field: 'request_id', caption : 'Request Id', size : '40%', 
								hidden: true, style : 'text-align:center;', sortable : true}, 
								
							{ field: 'process_date', caption : 'Request date', size : '12%', 
				            	style : 'text-align:center;', sortable : true}, 
				            	
				            { field: 'owner_nm', caption : 'Owner', size : '14%', 
				            	style : 'text-align:center;', sortable : true }, 
					            
				            { field: 'system_info_nm', caption : 'Sys Info', size : '14%', 
				            	style : 'text-align:center;', sortable : true }, 
				            	
					        { field: 'request_type_nm', caption : 'Request Type Level 1', size : '14%',
				            	style : 'text-align:center;', sortable : true}, 
						    	
							{ field: 'title', caption : 'Title', size : '30%', 
						    	style : 'text-align:center;', sortable : true}, 
							
						    // 처리자
							{ field: '', caption : '', size : '14%', 
								style : 'text-align:center;', sortable : true}, 
				            
							{ field: 'context', caption : 'Context', size : '40%', 
								hidden: true, style : 'text-align:center;', sortable : true}, 
							
							{ field:'file_group', caption:'File No', size:'10%', 
								style:'text-align:center', hidden: true }, 	
							
				            { field: 'work_status', caption : 'Step', size : '10%', 
								style : 'text-align:center;'}, 
				            { field: 'status_nm', caption : 'Status', size : '10%', 
								style : 'text-align:center;'}
	                    ],
	                    records: loadData,
	        	        onSelect: function (event) {
	        	            let grid = this;
	        	            // mSubGrid-n
	        	            event.onComplete = function () {
	        	                let sel = grid.getSelection();
	        	                if (sel.length) {
	        	                	let getData = grid.get(sel[0]);
									
	        	                	if( getData.title == "No Data" && getData.status == "" ) {
										w2ui["grid_main"].select((grid.name).substring(9));
// 	        	                		var gmData = w2ui["grid_main"].get((grid.name).substring(9));
//        	        						$("#hiddenRow").val(gmData.request_id);
        			    			} else {
        			    				fnSelRequest("category", getData.request_type);
    	         			            fnSelRequest("categoryItem", getData.request_category);
    	         			            
    	         			            $("#hiddenRow").val(getData.request_id);
    	       			            
    	       			            
   	        			            $("#input_text").val(window.location.origin+"/frontend/location/menus/test_case?request_seq=" + encodeURIComponent(mainData.request_seq));
        			    				
        			    				loadList2();
        			    				loadList2_sub();
    	        	                	
//     	        	                	w2ui['grid_master'].fixedBody = false;
//     	        	               		$("#grid_master").height("");
    	        	               		$("#selDiv").css("display", "");
    	        	               		
    	        	                	setTimeout(function () {
//     	        	                		w2ui['grid_master'].refresh();
//     		        	                	w2ui["grid_master"].expand(1);
    	        	                		setTimeout(function () {
    	        			               		$("#mainDiv").css("display", "none");
    	        			               		
//     	        	                			w2ui['subGridO'].select(getData.recid);
//     	        	                			w2ui['subGridO'].scrollIntoView(getData.recid);
    	        	                			let subGOsubGridO = w2ui['subGridO'].records;
    	        	                			for(var i=0; i<subGOsubGridO.length; i++) {
    	        	                				if(getData.request_seq == subGOsubGridO[i].request_seq) {
    	        	                					w2ui['subGridO'].select(subGOsubGridO[i].recid);
   	     	        	                				w2ui['subGridO'].scrollIntoView(subGOsubGridO[i].recid);
    	        	                					return;
    	        	                				}
    	        	                			}
//     	        	                			w2ui.subGridO.scrollIntoView(getData.recid);
    	        		                	}, 300);
    	        	                	}, 200);
        			    			}
	        	               	} else {
	        	                    select_customer = undefined;
	        	                }
	        	            }
	        			}
	                });
	                $.each(w2ui, function (index, value) {
	                    if (index.indexOf("_toolbar") === -1 && index !== "grid") {
	                    	value.resize();
	                    }
	                });
	                let rowId = eventData.recid;
	                let elmt =  $("#grid_grid_main_frec_"+rowId+"_expanded_row.w2ui-expanded-row");
	                elmt.attr("onclick", "wGExpandedCollapse('"+rowId+"');");

			        $(".subGridStyle.w2ui-grid .w2ui-grid-body .w2ui-grid-records table tr.w2ui-odd, "
	        		  +"#grid_main.w2ui-grid .w2ui-grid-body .w2ui-grid-frecords table tr.w2ui-odd").css("background-color", "#F9FBFF");
					
	        		$(".subGridStyle.w2ui-grid .w2ui-grid-body .w2ui-grid-records table tr.w2ui-even,  "
	           		  +"#grid_main.w2ui-grid .w2ui-grid-body .w2ui-grid-frecords table tr.w2ui-even").css("background-color", "#F9F9F9");
			        
	                setTimeout(function () {
		                elmt.height($("#grid_mSubGrid-"+rowId+"_records").height());   
		             	$('#grid_main').resize();
		                $("#grid_grid_main_rec_"+rowId+"_expanded").height(elmt.height());
		                
		            }, 300);
// 	            }, 300);
			}
		});
	}
	
	function loadList2_sub(eventData) {
// 		var mainData = w2ui['grid_master'].get(eventData.recid);
		var hiddenRow = $("#hiddenRow").val();
		let system_info_codes = member_id;
		
		loadData = [];
		
		var page_url = "/case/admin/selectSub";
		var postData = {
// 			request_id			: mainData.request_id,
			request_id 			: hiddenRow, 
			
			system_info_codes	: system_info_codes, 
			member_id			: member_id, 
			use_yn				: "Y"
		};
		
		w2ui["subGridO"].clear();
		w2ui["subGridO"].lock('loading...', true);
		
		$.ajax({
			url:page_url, 
			type:'POST', 
			data : postData, 
			dataType: 'json', 
// 			async : false,
			success: function( data ) {
				if(data.status == "200" && (data.rows).length>0 ) {
					let dataRows = data.rows;
					$.each(dataRows, function(idx, row){
						row.recid = idx + 1;
						row.work_status = row[myGubun+'_level_type_nm'];
						if(row.file_group){
							row.down_link = '<a href="/file/attach_download?file_group=' + row.file_group +'&file_name=' + encodeURIComponent(row.file_name) + '" target="_blanck"><i class="fa fa-file"> '+ row.file_name+ '</i>'
						}
					});
					loadData = dataRows;
					w2ui["subGridO"].records = loadData;
				} else {
					loadData = [{recid:1, owner_nm: 'No Data', title:'No Data', status:''}];
					w2ui["subGridO"].records = loadData;
				}
			}, complete: function() {
				w2ui["subGridO"].refresh();
				w2ui["subGridO"].unlock();
			}
		});
	}
	
	
	function fnSelUser(selBoxId) {
		let selBox = $(selBoxId);
		initOptions(selBox);
		
		var page_url = "/case/selectQueueMember";
		var postData = {
			member_id	: member_id, 
			use_yn		: "Y"
		};
		
		$.ajax({
			url:page_url, 
			type:'POST', 
			data : postData, 
			dataType: 'json', 
			async : false,
			success:function(data, textStatus, jqXHR){
				if(data.status == "200") {
					let rowArr = data.rows;
					$.each(rowArr, function(idx, row){
						if(idx==1)
							selBox.append("<option value="+''+">ALL</option>");
						
						let gridOwner = "O";
						for(var i=0; i<gridStatus.length; i++ ) {
							if( !row.member_id || row.member_id == gridStatus[i].n_owner_id ){
								gridOwner = "";
							}
						}
						if(gridOwner){
							gridStatus.push({"n_owner_id": row.member_id, "n_owner_nm" : row.member_nm });
							selBox.append("<option value=" + row.member_id + ">" + row.member_nm + "</option>");
						}
						
// 						selBox.append("<option value=" + row.member_id + ">" + row.member_nm + "</option>");
					});
				} 
			},
			error: function(jqXHR, textStatus, errorThrown){
				fnMessageModalAlert("Notification", "User를 불러오는데 에러가 발생하였습니다.");	
			}
		});
	}
	
	function fnUser(id) {
		var page_url = "/users/users/dataUserList";
		var postData = {
			user_id	: id, 
			use_yn	: "Y"
		};
		
		$.ajax({
			url:page_url, 
			type:'POST', 
			data : postData, 
			dataType: 'json', 
			async : false,
			success:function(data, textStatus, jqXHR){
				if(data.status == "200") {
					let rowArr = data.rows;
					$.each(rowArr, function(idx, row){
						usertData = row;
					});
				} 
			},
			error: function(jqXHR, textStatus, errorThrown){
				fnMessageModalAlert("Notification", "User를 불러오는데 에러가 발생하였습니다.");	
			}
		});
	}
	
	function fnSelSyInfo(selBoxId) {
		// sel_syInfo
		let selBox = $(selBoxId);
		
		initOptions(selBox);
// 		selBox.append("<option value="+''+"></option>");
		
		var formURL = "/incident/user/data_userSyInfo_grid";  // << 컨트롤러 만들기 
		var postData = { 
			user_id : member_id,
			use_yn  : "Y" 
		};
		
		$.ajax({
			url : formURL,
			type: "POST",
			data : postData,
			success:function(data, textStatus, jqXHR){
				if(data.status == "200") {
					let rowArr = data.rows;
					$.each(rowArr, function(idx, row){
						selBox.append("<option value=" + row.system_info_code + ">" + row.system_info_nm + "</option>");
					});
				} 
			},
			error: function(jqXHR, textStatus, errorThrown){
				fnMessageModalAlert("Notification", "대상 정보를 불러오는데 에러가 발생하였습니다.");	
			}
		});
	}
	
	// fnSelRequest("category", mstDt.request_type);
	function fnChangeType() {
		var value = $("#detail_selR_type option:selected").val();
		initOptions("#detail_selR_category");
		initOptions("#detail_selR_categoryItem");
		
		if(value){
			fnSelRequest("category", value, "O");
		}
	}
	
	// fnSelRequest("categoryItem", mstDt.request_category);
	function fnChangeCategory() {
		var value = $("#detail_selR_category option:selected").val();
		initOptions("#detail_selR_categoryItem");
		
		if(value){
			fnSelRequest("categoryItem", value);
		}
	}
	
	function fnChangeCategoryItem() {
		let value = $("#detail_selR_categoryItem option:selected").val();
		
// 		if(value){
// 			loadForm();
// 		}
	}
	
	function fnSelRequest(gubun, data, comV) {
		var formURL = "";  
		var postData;
		let selBox;
		
		if(gubun == "type") {
			selBox = $("select[name=selR_type]");
			initOptions(selBox);
			
			formURL = "/backend/code/selectRequestTypeList";
			postData = {
				ordY : "Y",
				use_yn : "Y"
			};
			
		} else if(gubun == "category") {
			selBox = $("select[name=selR_category]");
			initOptions(selBox);
			
			formURL = "/backend/code/selectRequestCategoryList";
			postData = {
				request_type_code : data, 
				ordY : "Y",
				use_yn : "Y"
			};
		} else if (gubun == "categoryItem") {
			selBox = $("select[name=selR_categoryItem]");
			initOptions(selBox);
			
			formURL = "/backend/code/selectRequestCategoryItemList";
			postData = {
				request_category_code : data, 
				ordY : "Y",
				use_yn : "Y"
			};
		}
		
		$.ajax({
			url : formURL,
			type: "POST",
			data : postData,
			dataType : 'json', 
			async : false, 
			success:function(data, textStatus, jqXHR){
				if(data.status == "200") {
					let rowArr = data.rows;
					$.each(rowArr, function(idx, row){
						if(gubun == "type") {
							selBox.append("<option value=" 
								+ row.request_type_code + ">" 
								+ row.request_type_nm + "</option>");
						} else if(gubun == "category") {
							selBox.append("<option value=" 
								+ row.request_category_code + ">" 
								+ row.request_category_nm + "</option>");
						} else if (gubun == "categoryItem") {
							selBox.append("<option value=" 
								+ row.request_item_code + ">" 
								+ row.request_category_item_nm + "</option>");
						}
					});
// 					$("#"+stV+"selR_"+gubun+" option:eq(0)").prop("selected", true);
				} 
			},
			error: function(jqXHR, textStatus, errorThrown){
				fnMessageModalAlert("Notification", "분류 정보를 불러오는데 에러가 발생하였습니다.");	
			},
			complete: function() {
		 		if(comV){
		 			var value = $("#detail_selR_category").val();
		 			if(value){
		 				fnSelRequest("categoryItem", value);
		 			}
		 		}
			}
		});
	}
	
	function fnSelLevel(selBoxId, gubun) { 
		let selBox = $(selBoxId);
		
		initOptions(selBox);
		selBox.append("<option value="+''+"></option>");
		
		var formURL = "/incident/level/data_adminLevelTypeAssign_grid";
		formURL += "?use_yn=" + encodeURIComponent("Y");
		formURL += "&cmd=" + encodeURIComponent("level");
		
		$.ajax({
			url : formURL,
			type: "POST", 
			async : false,
			success:function(data, textStatus, jqXHR){
				if(data.status == "200") {
					let rowArr = data.rows;
					levelData = rowArr;
					$.each(rowArr, function(idx, row){
						selBox.append("<option value=" 
							+ row.admin_level_type_code + ">" 
							+ row[gubun+'_level_type_nm'] + "</option>");
					});
					$(selBoxId+" option:eq(0)").prop("selected", true);
				} 
			},
			error: function(jqXHR, textStatus, errorThrown){
				fnMessageModalAlert("Notification", "단계 정보를 불러오는데 에러가 발생하였습니다.");	
			}
		});
	}
	
	function fnSelProcess(selBoxId) {
		let selBox = $(selBoxId);
		
		initOptions(selBox);
		selBox.append("<option value="+''+"></option>");
		var formURL = "/incident/process/data_prcsType_grid";
		formURL += "?use_yn=" + encodeURIComponent("Y");
		
		$.ajax({
			url : formURL,
			type: "POST",
			success:function(data, textStatus, jqXHR){
				if(data.status == "200") {
					let rowArr = data.rows;
					$.each(rowArr, function(idx, row){
						selBox.append("<option value=" + row.processed_type_code + ">" + row.processed_type_nm + "</option>");
					});
				} 
			},
			error: function(jqXHR, textStatus, errorThrown){
				fnMessageModalAlert("Notification", "대상 정보를 불러오는데 에러가 발생하였습니다.");	
			}
		});
	}
	
	function fnStatus(selBoxId) {
		let selBox = $(selBoxId);
		
		initOptions(selBox);
		selBox.append("<option value="+'all'+">ALL</option>");
		var formURL = "/backend/code/data_codegrid"
		formURL += "?code_use_yn=" + encodeURIComponent("Y");
		formURL += "&master_code=" + encodeURIComponent("MC1015");
		
		$.ajax({
			url : formURL,
			type: "POST",
			success:function(data, textStatus, jqXHR){
				if(data.status == "200") {
					let rowArr = data.rows;
					$.each(rowArr, function(idx, row){
						if(row.code_nm == 'Done') row.code_nm = 'Completed(Done)';
						selBox.append("<option value=" + row.detail_code + ">" + row.code_nm + "</option>");
					});
				} 
			},
			error: function(jqXHR, textStatus, errorThrown){
				fnMessageModalAlert("Notification", "대상 정보를 불러오는데 에러가 발생하였습니다.");	
			}
		});
	}
	
	function fnSelControl(selBoxId) {
		let selBox = $(selBoxId);
		
		initOptions(selBox);
// 		initOptions($("#sel_ct_gubun"));
		
		selBox.append("<option value="+''+"></option>");
// 		$("#sel_ct_gubun").append("<option value='all'>ALL</option>");
		
		var formURL = "/backend/code/selectControlType";
		formURL += "?use_yn=" + encodeURIComponent("Y");
		formURL += "&ordY=" + encodeURIComponent("Y");
		
		$.ajax({
			url : formURL,
			type: "POST",
			success:function(data, textStatus, jqXHR){
				if(data.status == "200") {
					let rowArr = data.rows;
					console.log(rowArr);
					$.each(rowArr, function(idx, row){
						selBox.append("<option value=" + row.control_type_code + ">" + row.control_type_nm + "</option>");
// 						$("#sel_ct_gubun").append("<option value=" + row.control_type_code + ">" + row.control_type_nm + "</option>");
					});
					
// 					$("#sel_ct_gubun option:eq(0)").prop("selected", true);
				} 
			},
			error: function(jqXHR, textStatus, errorThrown){
				fnMessageModalAlert("Notification", "통제 분류 정보를 불러오는데 에러가 발생하였습니다.");	
			}
		});
	}
	
	function apprLoadList( request_id, service_process_id ) {
		apprLoadData = [];
		var page_url = "/incident/menus/selectApprover_history";
		var postData = {
				request_id			: request_id, 
				service_process_id	: service_process_id
		};
		$.ajax({
			url:page_url, 
			type:'POST', 
			data : postData, 
			dataType: 'json', 
			async : false,
			success: function( data ) {
				if(data.status == "200" && (data.rows).length>0 ) {
					apprLoadData = data.rows;
				}
			}
		});
	}
	
	function userLoadList( request_id, service_process_id ) {
		userLoadData = [];
		var page_url = "/incident/menus/selectCollaboration_history";
		var postData = {
				request_id			: request_id, 
				service_process_id	: service_process_id
		};
		$.ajax({
			url:page_url, 
			type:'POST', 
			data : postData, 
			dataType: 'json', 
			async : false,
			success: function( data ) {
				if(data.status == "200" && (data.rows).length>0 ) {
					userLoadData = data.rows;
				}
			}
		});
	}
	
	function prtLoadList( request_id, service_process_id ) {
		prtLoadData = [];
		var page_url = "/case/admin/selectPartner_user";
		var postData = {
				request_id			: request_id
// 				, service_process_id	: service_process_id
		};
		$.ajax({
			url:page_url, 
			type:'POST', 
			data : postData, 
			dataType: 'json', 
			async : false,
			success: function( data ) {
				if(data.status == "200" && (data.rows).length>0 ) {
					prtLoadData = data.rows;
				}
			}
		});
	}
	
	function getFormatDate(d) {
        let month = d.getMonth() + 1;
        let date = d.getDate();
        month = (month < 10) ? "0" + month : month;
        date = (date < 10) ? "0" + date : date;
        return d.getFullYear() + '-' + month + '-' + date;
    }
	
	function initOptions(obj) {
	    $(obj)
	    .find('option')
	    .remove()
	    .end()
	    .val();
	}
	

	function apprCheck(gubun) {
		if(gubun == "new"){
			let btn = $("#new_apprI_btn").text();
			
			if (btn == "승인 추가") {
				fnLoadUserGrid();
				$('#btn_partner').css('display', 'none');
				$("#append_user").empty();
				openUser('new');
			} else if (btn == "승인 제거") {
				$("#new_apprI_btn").text('승인 추가');
				resetUser(gubun);
				$('#btn_partner').css('display', '');
			}
		} else if(gubun == "edit"){
			let btn = $("#edit_apprI_btn").text();
			
			if (btn == "승인 추가") {
				fnLoadUserGrid();
				openUser('edit');
			} else if (btn == "승인 제거") {
				$("#edit_apprI_btn").text('승인 추가');
				resetUser(gubun);
			}
		}
	}
	// ★★★
	function resetUser(gubun) {
		if(gubun == "new"){
			$("#new_comment_approver").css("display", "none");
			$('#new_appr_approver_id').val('');
			$('#new_appr_approver_nm').val('');
			$('#new_appr_req_date').val('');
			$('#new_appr_req_comment').val('');
			$('#new_appr_rep_date').val('');
			$('#new_appr_rep_comment').val('');
			
			$("#detail_done_status").val("MD1256");
			$('#detail_done_status_nm').val("In Progress");
		} else if(gubun == "edit"){
			if(selectData.status=="MD1267") { // 반려는 재승인 불가하기에 if문에 들 필요 X
				$("#detail_done_status").val("MD1267");
				$('#detail_done_status_nm').val("Approved");
				
				let getAppr = apprLoadData[apprLoadData.length-2];
				
				$("#edit_appr_requester_id").val( getAppr.requester_id );
				$("#edit_appr_requester_nm").val( getAppr.requester_nm );
				
				$("#edit_appr_req_comment").val( getAppr.comment );
				$("#edit_appr_req_comment").attr("disabled", true);
				$("#edit_appr_req_date").val( (getAppr.date_created).substring(0, 16) );
				
				// 승인자
				let getAppr2 = apprLoadData[apprLoadData.length-1];
				$("#edit_appr_status").val( getAppr2.status );
				$("#edit_appr_status_nm").val( getAppr2.status_nm );
				
				$("#edit_appr_approver_id").val( getAppr2.approver_id );
				$("#edit_appr_approver_nm").val( getAppr2.approver_nm );
				
				$("#edit_appr_rep_comment").val( getAppr2.comment );
				$("#edit_appr_rep_date").val( (getAppr2.date_created).substring(0, 16) );
				$("#edit_appr_rep_comment").attr("disabled", true);
				
			} else {
				$("#detail_done_status").val("MD1256");
				$('#detail_done_status_nm').val("In Progress");
				
				$("#new_comment_approver").css("display", "none");
				$("#edit_comment_approver").css("display", "none");
				$("#edit_comment_approver2").css("display", "none");
				
				$('#edit_appr_approver_id').val('');
				$('#edit_appr_approver_nm').val('');
				
				$("#edit_appr_req_date").val('');
				$("#edit_appr_req_comment").val('');
				
				$("#edit_appr_rep_date").val('');
				$("#edit_appr_rep_comment").val('');
				
				$("#appr_status").val("");
				$('#appr_status_nm').val("");
				
				$("#request_div").css("display", "none");
				$("#approver_div").css("display", "");
				$("#appr_comment_approver").css("display", "none");
			}
		}
	}
	
	function openUser(gubun) {
		var page_url = "/users/dept_user/selectDeptApporverUser";
		var postData = {
				dept_cd : dept_cd
		};
		$.ajax({
			url:page_url, 
			type:'POST', 
			data : postData, 
			dataType: 'json', 
			async : false,
			success: function( data ) {
				if(data.status == "200" && (data.rows).length>0 ) {
					var userData = (data.rows)[0];
					if(gubun == "new") {
						$("#new_apprI_btn").text('승인 제거');
						$('#new_responseCmtDiv').css('display', '');
						
						$("#detail_save_btn").css('display', '');
						$("#detail_save_btn").attr("disabled", false);
						$("#edit_appr_status_div").css('display', 'none');
						$("#detail_done_status").val("MD1266");
						$('#detail_done_status_nm').val("Approval Submitted");
						
						$('#new_appr_approver_id').val(userData.user_id);
						$('#new_appr_approver_nm').val(userData.user_nm);
						$('#new_appr_requester_nm').val(member_nm);
						
						$('#new_appr_req_comment').val('');
						
						$('#new_appr_div').css('display', '');
						$('#new_comment_approver').css('display', '');
// 						$('#new_comment_approver2').css('display', '');
						
						$("#new_request_div").css("display", "none");
						
						let workValue = $("#detail_sel_levelType option:selected").val();
						if( workValue == "alt_12" ){
							$("#detail_sel_levelType option:eq(0)").prop("selected", true);
						}
						setTimeout(function () {
							$('#grid_user').jqGrid("clearGridData");
		            	}, 200);
						
					} else if(gubun == "edit") {
						$("#edit_apprI_btn").text('승인 제거');
						$("#edit_responseCmtDiv").css('display', '');
						
						$("#edit_appr_rep_comment").attr("disabled", true);
						$('#edit_appr_rep_comment').val('');
						$('#edit_appr_rep_date').val('');
						
						$("#detail_save_btn").css('display', '');
						$("#detail_save_btn").attr("disabled", false);
						$("#edit_appr_status_div").css('display', 'none');
						$("#detail_done_status").val("MD1266");
						$('#detail_done_status_nm').val("Approval Submitted");
						
						
						$("#edit_appr_req_comment").attr("disabled", false);				
						$('#edit_appr_req_comment').val('');
						$('#edit_appr_req_date').val('');
						
						$('#edit_appr_requester_id').val(member_id);
						$('#edit_appr_requester_nm').val(member_nm);
						
						$('#edit_appr_approver_id').val(userData.user_id);
						$('#edit_appr_approver_nm').val(userData.user_nm);
						
						$("#edit_appr_div").css('display', '');
						$("#edit_comment_approver").css('display', '');
						$("#edit_comment_approver2").css('display', '');
						
						$("#edit_request_div").css("display", "none");
						setTimeout(function () {
							$('#grid_user').jqGrid("clearGridData");
		            	}, 200);
						
					} else if(gubun == "owner") {
						modalOpenUser(gubun);
					}
				} else {
					modalOpenUser(gubun);
				}
			},
			complete: function() {
		 		
			}
		});

	}
	
	function modalOpenUser(gubun) {
		$('#user_nm_search').val('');
		$('#user_gubun').val(gubun);
		
		$("#gbox_grid_user, #gview_grid_user"
		 +", #gview_grid_user div:nth-child(2)"
		 +", #gview_grid_user div:nth-child(3)"
		).css("width", "830px");
		
		$("#grid_user").trigger("reloadGrid");
		fnSearchUserGrid();
		
		$("#modal_user").modal('show');
	}
	
	function fnUserInsert() {
		var rowId = $("#grid_user").jqGrid('getGridParam',"selrow");
		
		if(rowId != null){
			var userData = $("#grid_user").jqGrid('getRowData', rowId);
			
			let user_gubun = $('#user_gubun').val();
			
			if(user_gubun == "new") {
				$("#new_apprI_btn").text('승인 제거');
				
				$('#new_appr_approver_id').val(userData.user_id);
				$('#new_appr_approver_nm').val(userData.user_nm);
				$('#new_appr_requester_nm').val(member_nm);
				$('#new_appr_req_comment').val('');
				
				$("#detail_done_status").val("MD1266");
				$('#detail_done_status_nm').val("Approval Submitted");
				
				$('#new_appr_div').css('display', '');
				$("#edit_appr_status_div").css('display', 'none');
				$('#new_comment_approver').css('display', '');
// 				$('#new_comment_approver2').css('display', '');
				
				$("#new_request_div").css("display", "none");
				
				let workValue = $("#detail_sel_levelType option:selected").val();
				if( workValue == "alt_12" ){
					$("#detail_sel_levelType option:eq(0)").prop("selected", true);
				}
				$("#btn_detail_done").text("In Progress");
			} else if(user_gubun == "edit") {
				$("#edit_apprI_btn").text('승인 제거');
				
				$("#detail_save_btn").css('display', '');
				$("#detail_save_btn").attr("disabled", false);				
				
				$("#edit_appr_req_comment").attr("disabled", false);				
				$('#edit_appr_req_date').val('');
				$('#edit_appr_req_comment').val('');
				
				$("#edit_appr_rep_comment").attr("disabled", true);				
				$('#edit_appr_rep_date').val('');
				$('#edit_appr_rep_comment').val('');
				
				$('#edit_appr_requester_id').val(member_id);
				$('#edit_appr_requester_nm').val(member_nm);
				
				$('#edit_appr_approver_id').val(userData.user_id);
				$('#edit_appr_approver_nm').val(userData.user_nm);
								
// 				$("#edit_appr_status").val("MD1266");
// 				$('#edit_appr_status_nm').val("Approval Submitted");
				
				$("#detail_done_status").val("MD1266");
				$('#detail_done_status_nm').val("Approval Submitted");
				
				$("#edit_appr_div").css('display', '');
				$("#edit_appr_status_div").css('display', 'none');
				$("#edit_comment_approver").css('display', '');
				
				$("#edit_comment_approver2").css("display", '');
				$("#edit_responseCmtDiv").css('display', '');
				
				$("#edit_request_div").css("display", "none");
				
				$("#btn_detail_done").text("In Progress");
			} else if(user_gubun == "owner") {
				$('#detail_owner_id').val(userData.user_id);
				$('#detail_owner_nm').val(userData.user_nm);
			}
			$("#modal_user").modal('hide');			
		} else {
			fnMessageModalAlert("Notification", "승인 정보 내에서 항목 한 개 이상 선택해 주세요.");
		}
	}
	
	function fnSearchUserGrid(){
		// rowNum 500 으로 설정.
		var grid = $('#grid_user');
		grid.setGridParam({rowNum:2000});
		// selectBox 5번째 선택 ( 1000 )
		$(".ui-pg-selbox option:eq(6)").prop("selected", true);
		
		var page_url = "/users/users/data_user_grid";
// 		page_url += "?dept_cd=" + encodeURIComponent((dept_cd ? "" : dept_cd));
		let dpC = "";
		if(dept_cd && dept_cd != "null"){
			dpC = dept_cd;
		}
		
		page_url += "?use_yn=" + encodeURIComponent("Y");
		page_url += "&user_nm=" + encodeURIComponent($('#user_nm_search').val());
		
		let user_gubun = $('#user_gubun').val(); 
		
		if(user_gubun != "owner") {
			page_url += "&dept_cd=" + encodeURIComponent( dpC );
		}
		
// 		page_url += "&dept_gubun=" + encodeURIComponent("Y");
		
		if(user_gubun == "owner") {
			page_url = "/case/selectQueueMember2";
			page_url += "?use_yn=" + encodeURIComponent("Y");
			page_url += "&member_id=" + encodeURIComponent(member_id);
			page_url += "&user_nm=" + encodeURIComponent($('#user_nm_search').val());
		}
		
		$("#grid_user").jqGrid('setGridParam',{url: page_url,datatype: 'json'});
		$("#grid_user").setGridParam({ page: 1 }).trigger("reloadGrid");
//	 	$("#grid_user").jqGrid('setGridParam',{url: page_url,datatype: 'json'});
//	 	$("#grid_user").trigger("reloadGrid");

		if(user_gubun == "owner") {
			setTimeout(function () {
				let queueMData = $("#grid_user").getRowData();
				if (queueMData.length == 0) {
					fnOwnerData();
				}
			}, 300);
		}
	}
	
	function fnOwnerData() {
		var page_url = "/users/users/data_user_grid";

		page_url += "?use_yn=" + encodeURIComponent("Y");
		page_url += "&user_nm=" + encodeURIComponent($('#user_nm_search').val());

		$("#grid_user").jqGrid('setGridParam',{url: page_url,datatype: 'json'});
		$("#grid_user").setGridParam({ page: 1 }).trigger("reloadGrid");
	}
	
	function fnLoadUserGrid(){
		var page_url = "/users/users/data_user_grid";
		let dpC = "";
		if(dept_cd && dept_cd != "null"){
			dpC = dept_cd;
		}
		page_url += "?dept_cd=" + encodeURIComponent( dpC );
		page_url += "&user_nm=" + encodeURIComponent($('#user_nm_search').val());
		page_url += "&use_yn=" + encodeURIComponent("Y");
		page_url += "&dept_gubun=" + encodeURIComponent("Y");
		
		$("#grid_user").jqGrid({
			url:page_url,
			datatype: "json",
			colNames:[
						'구분 Code','구분', '사원No',
						
						'Name', 'User_Name(En)','ID',
						
						'Position Code','Position','Email',' Phone', 
						
						'Mobile','회사 Code','Company',
						
						'CRN','Active'
				        ],
			colModel:[
						{name:'company_gubun_code',index:'company_gubun_code', width:120, sorttype:"text", sortable:true, hidden:true},
						{name:'company_gubun_nm',index:'company_gubun_nm', width:120, sorttype:"text", sortable:true, hidden:true},
						{name:'user_no',index:'user_no', width:70, sorttype:"text", sortable:true, hidden:true, key: true},  
						
						{name:'user_nm',index:'user_nm', width:125, sorttype:"text", sortable:true},
						{name:'user_nm_en',index:'user_nm_en', width:90, sorttype:"text", sortable:true, hidden: true},
						{name:'user_id',index:'user_id', width:125, sorttype:"text", sortable:true},
						
						{name:'class_code',index:'class_code', width:120, sorttype:"text", sortable:true, hidden: true},
						{name:'class_nm',index:'class_nm', width:120, sorttype:"text", sortable:true, hidden: true},
																// 140 Active hidden 으로 인한 공백
						{name:'user_email',index:'user_email', width:195, sorttype:"text", sortable:true},
						{name:'phone_no',index:'phone_no', width:90, sorttype:"text", sortable:true},
						
						{name:'mobile',index:'mobile', width:90, sorttype:"text", sortable:true},
						{name:'company_code',index:'company_code', width:120, sorttype:"text", sortable:true, hidden:true},
						{name:'company_nm',index:'company_nm', width:90, sorttype:"text", sortable:true, hidden:false},
						
						{name:'business_reg_num',index:'business_reg_num', width:90, sorttype:"text", sortable:true},
						{name:'use_yn',index:'use_yn', width:55, sorttype:"text", sortable:true, hidden:true}
					],
//			rowTotal:-1,
//			scroll: 1, 
			rowNum:2000, 
			rowList : [ 20, 50, 100, 500, 1000, 1500, 2000 ],
		    pager : "#grid_user_pager",
			viewrecords : true,
		    autowidth : true,
		    shrinkToFit: true, 
		    multiselect : false,
		    height: 300,
			altRows: true,
			rownumbers: true, 
		    rownumWidth: 25,
		    autoencode: true,
		    loadonce: true,
		    sortable: true,
		    
		    sortname: "user_nm", 
	        sortorder : 'asc', 
	        ignoreCase: true, 
	        jsonReader : {
    	      root : "list_data",
    	      records : "records",
    	      repeatitems : false,
    	      id : "user_no"
    	    }
		});
	}
	
	$("#file_group").change(function(){
// 		FunLoadingBarStart();
		$('#progress').show();
		$('#progress .progress-bar').css('width', '10%');
	});
	
	function fnLoadFileHandler() {
		$('.fileupload').fileupload({
			dataType : 'json',
// 			async:false,
			autoUpload : true,
			enctype : "multipart/form-data",
			maxFileSize : 1280000000, 
			add: function(e, data){
				if(data.files[0].size > 1280000000)
				{
					fnMessageModalAlert("Notification", "파일 용량이 너무 큽니다.");
					return;
				}
				data.url = "/file/file_upload?target=" + e.target.id+"&file_cate=incident";
				data.submit();
			},
		}).on('fileuploadadd', function(e, data) {
		}).on('fileuploadprocessalways', function(e, data) {
			var index = data.index;
			var file = data.files[index];
			if (file.error) {
				fnMessageModalAlert("Error", file.error);
			}
		}).on('fileuploadprogressall', function(e, data) {
			$('#progress').show();
			var progress = parseInt(data.loaded / data.total * 100, 10);
			$('#progress .progress-bar').css('width', progress + '%');
		}).on('fileuploaddone', function(e, data) {
			setTimeout(function () {
// 				FunLoadingBarEnd();
				$('#progress').hide();
		    	$('#progress .progress-bar').css('width', '0%');
			}, 700);
	    	let file_name = data.files[0].name;
	    	let file_group = data.result.file_group;
	    	let file_path = data.result.file_group;
	    	//
	    	let recid = Number($("#append_down")[0].childElementCount)+1;
	    	
			let div = $("<div>");
			div.attr("id", "div_ap_down_"+recid );
			div.addClass("col-sm-12 form-group");
			div.attr("style", "margin-bottom: 5px;");
			
			let span1 = $("<span>");
			span1.attr("id", "span_ap_down_"+recid);
			span1.attr("style", "padding-right: 5px;");
			span1.text(recid+".");
			
			let down_link = '<a style="padding-right: 5px;" href="/file/attach_download2?file_group=' 
							+ file_path +'&file_name=' 
							+ encodeURIComponent(file_name) 
							+ '" target="_blanck"><i class="fa fa-file"> '
							+ file_name+ '</i>';
			
			let btn = '<button type="button" id="btn_del_down_'+ recid +'" '
						+' style="line-height: 10px;" '
						+' class="btn btn-danger btn-sm btnEditDown" onclick="delDown('+recid+');">Del</button>';
			
			$("#append_down").append( div.append(span1).append(down_link).append(btn) );
	    	//
		}).on('fileuploadfail', function(e, data) {
			setTimeout(function () {
				$('#progress').hide();
		    	$('#progress .progress-bar').css('width', '0%');
			}, 700);
			fnMessageModalAlert("Notification", "파일 용량이 너무 커, 파일 업로드를 실패했습니다.");
		}).prop('disabled', !$.support.fileInput).parent().addClass($.support.fileInput ? undefined : 'disabled');
	}
	
	function delDown(idx) {
		$("#div_ap_down_"+idx).remove();
		
		let allCount = Number($("#append_down")[0].childElementCount);
		
		let fileData = [];
		for(var i=0; i<allCount; i++ ) {
			let href = $("#append_down")[0].childNodes[i].childNodes[1].href;
			let file_name = $("#append_down")[0].childNodes[i].childNodes[1].childNodes[0].innerText;
			let file_path = href.substring( href.indexOf('file_group=')+11, href.indexOf('&file_name=') );
			
			fileData.push({ href : href, file_name : file_name, file_path : file_path });
		}
		$("#append_down").empty();
		for( var i=0; i<allCount; i++ ) {
			let href = fileData[i].href;
			let file_name = fileData[i].file_name;
			let file_path = fileData[i].file_path;
			
			let recid = (i+1);
			let div = $("<div>");
			div.attr("id", "div_ap_down_"+recid );
			div.addClass("col-sm-12 form-group");
			div.attr("style", "margin-bottom: 5px;");
			
			let span1 = $("<span>");
			span1.attr("id", "span_ap_down_"+recid);
			span1.attr("style", "padding-right: 5px;");
			span1.text(recid+".");
			
			let down_link = '<a style="padding-right: 5px;" href="/file/attach_download2?file_group=' 
							+ file_path +'&file_name=' 
							+ encodeURIComponent(file_name) 
							+ '" target="_blanck"><i class="fa fa-file"> '
							+ file_name+ '</i>';
			
			let btn = '<button type="button" id="btn_del_down_'+ recid +'" '
						+' style="line-height: 10px;" '
						+' class="btn btn-danger btn-sm btnEditDown" onclick="delDown('+recid+');">Del</button>';
			
			$("#append_down").append( div.append(span1).append(down_link).append(btn) );
		}
	}
	
	function fnMailSend(page_url, request_seq, status, rep_comment, req_comment, getRequesterId, page_link) {
		// "mailSending_7", request_seq, status
		// "mailSending_3"
		let sendData = { };
		
		if ( page_url == "/mail/mailSending_3" ) {
			sendData = { 
				request_seq : request_seq, 
				status		: status, 
				rep_comment : rep_comment, 
				req_comment : req_comment, 
				getRequesterId : getRequesterId,
				page_link	: page_link
			};
		} else if ( page_url == "/mail/mailSending_2" ) {
			sendData = { 
				request_seq : request_seq, 
				status		: status, 
				rep_comment : rep_comment, 
				req_comment : req_comment, 
				getRequesterNm : getRequesterId,
				page_link : page_link
			};
		} else if ( page_url == "/mail/mailSending_4" || page_url == "/mail/mailSending_7" ) {
			sendData = { 
				request_seq  	: request_seq, 
				status		 	: status, 
				getRequesterNm : rep_comment,
				page_link 		: req_comment
			};
		} else {
			sendData = { 
				request_seq : request_seq, 
				status		: status,
				page_link	: rep_comment
			};
		}
		console.log('mailSend page_url :', page_url);
		console.log('mailSend request_seq :',request_seq);
		console.log('mailSend status :', status);
		console.log('mailSend rep_comment :',rep_comment);
		console.log('mailSend req_comment :',req_comment);
		console.log('mailSend getRequesterId :', getRequesterId);
		console.log('mailSend page_link :', page_link);
		$.ajax({
			url : page_url,
			type : 'POST',
			data : sendData, 
			dataType : 'json',
// 			async : false,
			success : function( data ) {
				
			},
			complete: function () { 
				
			}
		});
	}
	
	// 참조자
	function openPartner() {
		$('#user_nm_search_p').val('');
		$('#grid_user_p').jqGrid('clearGridData');
		$('#grid_partner').jqGrid('clearGridData');
		
		fnSearchUserGrid_p();
		fnPartnerUserGrid();
		fnLoadUserGrid_p();
		
		$("#gbox_grid_partner, #gview_grid_partner"
		 +", #gbox_grid_user2, #gview_grid_user_p"
		 +", #gview_grid_partner div:nth-child(2)"
		 +", #gview_grid_partner div:nth-child(3)"
		 +", #gview_grid_user_p d_pv:nth-child(2)"
		 +", #gview_grid_user_p div:nth-child(3)"
		).css("width", "830px");
		
		$("#modal_partner").modal('show');
	}
	
	function fnLoadUserGrid_p(){
		var page_url = "/users/users/data_user_grid";
		page_url += "?user_nm=" + encodeURIComponent($('#user_nm_search_p').val());
		page_url += "&not_company_gubun_code=" + encodeURIComponent("MD1242");
		page_url += "&use_yn=" + encodeURIComponent("Y");
		
		$("#grid_user_p").jqGrid({
			url:page_url,
			datatype: "json",
			colNames:[
						'구분 Code','구분', '사원No',
						
						'Name', 'User_Name(En)','ID',
						
						'Position Code','Position','Email',' Phone', 
						
						'Mobile','회사 Code','Company',
						
						'CRN','Active'
				        ],
			colModel:[
						{name:'company_gubun_code',index:'company_gubun_code', width:120, sorttype:"text", sortable:true, hidden:true},
						{name:'company_gubun_nm',index:'company_gubun_nm', width:120, sorttype:"text", sortable:true, hidden:true},
						{name:'user_no',index:'user_no', width:70, sorttype:"text", sortable:true, hidden:true, key: true},  
						
						{name:'user_nm',index:'user_nm', width:125, sorttype:"text", sortable:true},
						{name:'user_nm_en',index:'user_nm_en', width:90, sorttype:"text", sortable:true, hidden: true},
						{name:'user_id',index:'user_id', width:125, sorttype:"text", sortable:true},
						
						{name:'class_code',index:'class_code', width:120, sorttype:"text", sortable:true, hidden: true},
						{name:'class_nm',index:'class_nm', width:120, sorttype:"text", sortable:true, hidden: true},
						{name:'user_email',index:'user_email', width:125, sorttype:"text", sortable:true},
						{name:'phone_no',index:'phone_no', width:85, sorttype:"text", sortable:true},
						
						{name:'mobile',index:'mobile', width:85, sorttype:"text", sortable:true},
						{name:'company_code',index:'company_code', width:120, sorttype:"text", sortable:true, hidden:true},
						{name:'company_nm',index:'company_nm', width:90, sorttype:"text", sortable:true, hidden:false},
						
						{name:'business_reg_num',index:'business_reg_num', width:90, sorttype:"text", sortable:true},
						{name:'use_yn',index:'use_yn', width:55, sorttype:"text", sortable:true}
					],
//	 		rowTotal:-1,
//	 		scroll: 1, 
			rowNum:2000, 
			rowList : [ 20, 50, 100, 500, 1000, 1500, 2000 ],
		    pager : "#grid_user_pager2",
			viewrecords : true,
		    autowidth : true,
		    shrinkToFit: true, 
		    multiselect : true,
		    height: 180,
			altRows: true,
			rownumbers: true, 
		    rownumWidth: 25,
		    autoencode: true,
		    loadonce: true,
		    sortable: true,
		    
		    sortname: "user_nm", 
	        sortorder : 'asc', 
	        ignoreCase: true,
		    jsonReader : {
		      root : "list_data",
		      records : "records",
		      repeatitems : false,
		      id : "user_no"
		    }
		});
		
		$("#grid_partner").jqGrid({
			colNames:[
						'구분 Code','구분', '사원No',
						
						'Name', 'User_Name(En)','ID',
						
						'Position Code','Position','Email',' Phone', 
						
						'Mobile','회사 Code','Company',
						
						'CRN','Active'
				        ],
			colModel:[
						{name:'company_gubun_code',index:'company_gubun_code', width:120, sorttype:"text", sortable:true, hidden:true},
						{name:'company_gubun_nm',index:'company_gubun_nm', width:120, sorttype:"text", sortable:true, hidden:true},
						{name:'user_no',index:'user_no', width:70, sorttype:"text", sortable:true, hidden:true, key: true},  
						
						{name:'user_nm',index:'user_nm', width:125, sorttype:"text", sortable:true},
						{name:'user_nm_en',index:'user_nm_en', width:90, sorttype:"text", sortable:true, hidden: true},
						{name:'user_id',index:'user_id', width:125, sorttype:"text", sortable:true},
						
						{name:'class_code',index:'class_code', width:120, sorttype:"text", sortable:true, hidden: true},
						{name:'class_nm',index:'class_nm', width:120, sorttype:"text", sortable:true, hidden: true},
						{name:'user_email',index:'user_email', width:125, sorttype:"text", sortable:true},
						{name:'phone_no',index:'phone_no', width:85, sorttype:"text", sortable:true},
						
						{name:'mobile',index:'mobile', width:85, sorttype:"text", sortable:true},
						{name:'company_code',index:'company_code', width:120, sorttype:"text", sortable:true, hidden:true},
						{name:'company_nm',index:'company_nm', width:90, sorttype:"text", sortable:true, hidden:false},
						
						{name:'business_reg_num',index:'business_reg_num', width:90, sorttype:"text", sortable:true},
						{name:'use_yn',index:'use_yn', width:55, sorttype:"text", sortable:true}
					],
			rowTotal:-1,
			scroll: 1, 
			viewrecords : true,
		    autowidth : true,
		    shrinkToFit: true, 
		    multiselect : true,
		    height: 180,
			altRows: true,
			rownumbers: true, 
		    rownumWidth: 25,
		    autoencode: true,
		    loadonce: true,
		    sortable: true,
		    
		    sortname: "user_nm", 
	        sortorder : 'asc', 
	        ignoreCase: true
		});
	}
	
	// 아래 들어간 유저 찾기
	function fnPartnerUserGrid() {
		let rdsUser = "";
		let rpUser = $("input[name=hidden_prt_user]");
		for(var i=0; i<rpUser.length; i++){
			let idIdx = $("input[name=hidden_prt_user]")[i].id;
			idIdx = idIdx.substring(("hidden_prt_user_no_").length);
			
			if (i==0) {
				rdsUser = $("#hidden_prt_user_no_"+idIdx).val();
			} else {
				rdsUser = rdsUser+","+$("#hidden_prt_user_no_"+idIdx).val();
			}
		}
		var page_url = "/users/users/selectReferenceUser";
		page_url += "?rdsUser=" + encodeURIComponent( rdsUser );
		page_url += "&use_yn=" + encodeURIComponent("Y");
		
		$("#grid_partner").jqGrid('setGridParam',{url: page_url,datatype: 'json'});
		$("#grid_partner").trigger("reloadGrid");
	}

	function fnSearchUserGrid_p(){
		// rowNum 500 으로 설정.
		var grid = $('#grid_user2');
		grid.setGridParam({rowNum:2000});
		// selectBox 5번째 선택 ( 1000 )
		$(".ui-pg-selbox option:eq(6)").prop("selected", true);
		
		var page_url = "/users/users/data_user_grid";
		page_url += "?user_nm=" + encodeURIComponent($('#user_nm_search_p').val());
		page_url += "&not_company_gubun_code=" + encodeURIComponent("MD1242");
		page_url += "&use_yn=" + encodeURIComponent("Y");
		
		$("#grid_user_p").jqGrid('setGridParam',{url: page_url,datatype: 'json'});
		$("#grid_user_p").setGridParam({ page: 1 }).trigger("reloadGrid");
	}

	function plus() {
		var rowId = $("#grid_user_p").jqGrid('getGridParam',"selarrrow");
		var userRds = $("#grid_partner").getRowData(); // 들어가 있는 값.
		
		if(rowId != null){
			var gridDatas = [];
			//
// 			const arrDup = [{name:'라이언',company:'kakao'}, {name:'브라운',company:'naver'}, {name:'프로도',company:'kakao'}, 
// 			                {name:'라이언',company:'kakao'}, {name:'펭수',company:'ebs'}
// 			               ];
// 			const arrUnique = arrDup.filter((character, idx, arr)=>{
// 			    return arr.findIndex((item) => item.name === character.name && item.company === character.company) === idx
// 			});
			//
			
			for(var i=0 ; i<rowId.length; i++) {
				var gb = "o";
				for(var j=0 ; j<userRds.length; j++) {
					if(userRds[j].user_no == rowId[i]) {
						gb = "";
					}
				}
				if(gb){ // 값 있으면 넣기
		 			var selData = $("#grid_user_p").jqGrid('getRowData', rowId[i]); // 선택한 값
		 			$("#grid_partner").jqGrid("addRowData", rowId[i], selData, 'last'); 
				}
			}
			
		} else {
			fnMessageModalAlert("Notification", "협력사에 추가할 사용자를 한 개 이상 선택해 주세요.");
			return;
		}
	}

	function minus() {
		var rowId = JSON.parse(JSON.stringify( $("#grid_partner").jqGrid('getGridParam', 'selarrrow') ));
		
		if(rowId != null){
			for(var i=0; i<rowId.length; i++) {
//	 		 	파라메터로 rowid를 넘긴다
			 	$("#grid_partner").delRowData(rowId[i]);
			}
		} else {
			fnMessageModalAlert("Notification", "협력사에 제거할 사용자를한 개 이상 선택해 주세요.");
			return;
		}
	}
	
	function fnDeletePartner(gubun){
		$("#div_prt_user_"+gubun).remove();
		
		let prtUser = $("input[name=hidden_prt_user]");
		if(prtUser.length == 0){
			$("#new_apprI_btn").css("display", "");
		}
	}
	
	function fnAddPartner() {
		let rds = $("#grid_partner").getRowData();
		$("#append_user").empty();
		
		for(var i=0; i<rds.length; i++){
			let recid = (i+1);
			
			let div = $("<div>");
			div.attr("id", "div_prt_user_"+recid );
			div.addClass("col-sm-6 text-center form-group");
			div.attr("style", "padding-right: 0px;");
			
			let input = $("<input>");
			input.attr("type", "hidden");
			input.attr("id", "hidden_prt_user_no_"+recid);
			input.attr("name", "hidden_prt_user");
			input.attr("value", rds[i].user_no);
			
			let input2 = $("<input>");
			input2.attr("type", "hidden");
			input2.attr("id", "hidden_prt_user_id_"+recid);
			input2.attr("value", rds[i].user_id);
			
			let label = $("<label>");
			label.addClass("col-sm-12 no-padding");
			label.attr("id", "label_prt_user_"+recid);
			
			
			let span = $("<span>");
			span.text(rds[i].user_nm);
			span.attr("style", "background-color: #EDEDED; line-height: 30px; padding: 5px;");
			
			
			let button = $("<button>");
			button.addClass("button_prt_user"); 
			button.attr("onclick", "fnDeletePartner('"+recid+"')"); 
			button.attr("id", "button_prt_user_"+recid);
			button.text("x");
			button.attr("style", "margin-left: 5px; line-height: 15px; border:none; color: red;");
			
			$("#append_user").append( div.append(input).append(input2).append(label.append(span.append(button))) );
		}
		
		if(rds.length > 0) {
			$("#new_apprI_btn").css("display", "none");
			$('#detail_done_status').val("MD1258");
			$('#detail_done_status_nm').val("Done");
			$("#btn_detail_done").text("In Progress");
		} else {
			$("#new_apprI_btn").css("display", "");
		}
		
		$("#modal_partner").modal('hide');
	}
	
	
	function page_move(url, selectData, cmd) {
		var form = document.createElement("form");
        var parm = new Array();
        var input = new Array();
		
        form.action = url;
        form.method = "post";
		
        if(selectData) {
        	parm.push( ['request_id', selectData.request_id] );
        }		 
        parm.push( ['cmd', cmd] );  // I, U
        		
        for (var i = 0; i < parm.length; i++) {
            input[i] = document.createElement("input");
            input[i].setAttribute("type", "hidden");
            input[i].setAttribute('name', parm[i][0]);
            input[i].setAttribute("value", parm[i][1]);
            form.appendChild(input[i]);
        }
        document.body.appendChild(form);
        form.submit();
	}
	
	function cloneObject(obj) { 
		var clone = []; 
		for(var i in obj) { 
		     if(typeof(obj[i])=="object" && obj[i] != null) { 
		     clone.push( obj[i] ); 
		     cloneObject(obj[i]); 
		     } else { 
		     } 
		 } 
		 return clone; 
	} 
	
	function copyLink(){
		console.log('copyLink btn');
// 		w2ui['grid_main'].onSelect(3);
		
		if(w2ui['grid_master'].get(w2ui['grid_master'].getSelection()).length == 1){
	 		$("#input_text").css("display", "");
			const textArea = document.getElementById("input_text");
	        textArea.select();
	        document.execCommand('copy');
	        $('#input_text').css('display', 'none');
		}else{
			$("#input_text_dtl").css("display", "");
			const textArea = document.getElementById("input_text_dtl");
	        textArea.select();
	        document.execCommand('copy');
			$('#input_text_dtl').css('display', 'none');
		}
        
        fnMessageModalAlert('알림','링크가 복사되었습니다.');
		setTimeout(function(){ 
			$('#modal_message button.close').click();
		}, 1000);
        
//         const textArea = document.getElementById("textArea");
//         textArea.select();
//         document.execCommand('copy');
        
// 		window.location.href = "/frontend/location/menus/new_1";
// 		window.location.href = "/frontend/location/menus/test_case?project_no=" + encodeURIComponent(키값);
// 		page_move("/frontend/location/menus/new_1", 'I'); 
	}
	function page_move(url, selectData, cmd) {
		var form = document.createElement("form");
        var parm = new Array();
        var input = new Array();
		console.log('page_move');
        form.action = url;
        form.method = "post";
		
        if(selectData) {
        	parm.push( ['request_id', selectData.request_id] );
        }		 
        parm.push( ['cmd', cmd] );  // I, U
        		
        for (var i = 0; i < parm.length; i++) {
            input[i] = document.createElement("input");
            input[i].setAttribute("type", "hidden");
            input[i].setAttribute('name', parm[i][0]);
            input[i].setAttribute("value", parm[i][1]);
            form.appendChild(input[i]);
        }
        document.body.appendChild(form);
        form.submit();
	}
	
	function excelFileDownload()
	{
		
		var fileName = 'CaseExport.xlsx';
		var checked = $('#chk_top').is(':checked'); // 상세 체크박스
		if(checked){ // 체크박스가 선택이 됐을 때
			var grid_main = w2ui['grid_main'].records;
			for(var i = 0; i < grid_main.length; i++){
				excel_request_id = excel_request_id+",'"+grid_main[i].request_id+"'";
			}
			excel_request_id = excel_request_id.replace(',','');
			loadList();
			fileName = 'CaseExport_detail.xlsx';
		}
			console.log('excel_request_id : ',excel_request_id);
		
		var gridCols = w2ui['grid_main'].columns;
		var gridData = JSON.parse(JSON.stringify( w2ui['grid_main'].records ));
		
		$.each(gridData, function(idx, row){
			if(row.file_loc_link) {
				row.file_loc_link = row.file_loc;
			}
			
			if(row.asset_owner_nm_open) {
				row.asset_owner_nm_open = row.asset_owner_nm;
			}
			
			if(row.license_key_link) {
				row.license_key_link = row.license_key;
			}
			if(!row.approver_nm){
				row.date_updated = '';
			}
		});
		
// 		var fileName = 'CaseAdminList.xlsx';
		var sheetTitle = 'Case처리';
		var sheetName = 'Case처리';
		
		var param_col_name = "", param_col_id="", param_col_align="", param_col_width="";
		var is_rownum = true;
		
		if(gridCols != null && gridCols.length > 0){
			for(var i=0; i<gridCols.length; i++){
// 	 			if(!gridCols[i].hidden){
	 			if(gridCols[i].name){
					param_col_name += gridCols[i].caption + ",";
					param_col_id += gridCols[i].field + ",";
					param_col_align += "center" + ",";
					param_col_width += (gridCols[i].width==undefined?"10":(gridCols[i].width).replace('px','')) + ",";
	 			}
			}
			param_col_name = param_col_name.substr(0, param_col_name.length -1);
			param_col_id = param_col_id.substr(0, param_col_id.length -1);
			param_col_align = param_col_align.substr(0, param_col_align.length -1);
			param_col_width = param_col_width.substr(0, param_col_width.length -1);
		}
		
		var export_url = "/export/export_client_Case_jqgrid";
		var export_data = "file_name="+encodeURIComponent(fileName);
			export_data += "&sheet_title="+encodeURIComponent(sheetTitle);
			export_data += "&sheet_name="+encodeURIComponent(sheetName);
			export_data += "&header_col_names="+encodeURIComponent(param_col_name);
			export_data += "&header_col_ids="+encodeURIComponent(param_col_id);
			export_data += "&header_col_aligns="+encodeURIComponent(param_col_align);
			export_data += "&header_col_widths="+encodeURIComponent(param_col_width);
			export_data += "&cmd="+encodeURIComponent("grid_goods_detail");
			export_data += "&body_data="+encodeURIComponent(JSON.stringify(gridData));
		
		$.ajax({
		  url:export_url,
		  data:export_data,
		  type:'POST',
		  dataType: 'json',
		  success: function( data ) {
			  console.log('엑셀 데이터 : ',data);
		  	if(data.status == 200) {
		  		var file_path = data.file_path;
		  		var file_name = data.file_name;
		  		var protocol = jQuery(location).attr('protocol');
	  			var host = jQuery(location).attr('host');
	  			var link_url = "/file/editor_attach_download";
	  			link_url += "?file_path="+encodeURIComponent(file_path);
	  			link_url += "&file_name="+encodeURIComponent(file_name);
	  			
	  			$(location).attr('href', link_url);
		  	}
		  },
			complete: function () {
				if(checked){
					excel_request_id = '';
					loadList();
				}
			}
		});
	}
	
	function ApprovalCheck(){
		////////0602 필요 단계 및 승인 함수
		
		setTimeout(function () {
			let control_gubun = $("#detail_sel_control option:selected").val();
			fnControlStep(control_gubun);
			fnControlAppr(control_gubun);
			
			let save_checkT = "";
			console.log('ApprovalCheck (controlLevelData): ', controlLevelData);
			console.log('ApprovalCheck (controlApprData): ', controlApprData);
			$("#save_check").css('display', 'none');
			if( controlLevelData.length > 0 ) {
				// 무조건 level 순서대로 가게 되어 있음.
				var foLoadData = [];
				// sub-case에서 특정 Step값을 가진 배열만 뽑아서 그걸로 for문해서
				for(var i=0; i<loadData.length; i++) {
					for(var j=0; j<controlLevelData.length; j++) {
						if( loadData[i].admin_level_type_code == controlLevelData[j].admin_level_type_code ) {
							foLoadData.push( loadData[i] );
						}
					}
				}
				
				
				var grid_name = 'grid_master';
				
				var key = w2ui['grid_master'].getSelection();
				var key2 = w2ui['subGridO'].getSelection();
				var get_grid = w2ui['grid_master'].get(key[0]);
				
				if(key.length == 0){
					grid_name = 'subGridO';
				}
				
				// 0516
				// ★★★★★★★★★★★★★★★★★★★★★★★ 필요 단계 및 승인 함수
				// 이제 여기 step 통제 순서 부분이 순서가 1 2 3 2 4 1 5 라 해도 > 12345 OK 가 되도록.
				// 전체 for문을 돌려서 해당 인덱스가 맞으면..??
				// 다음 step 이 맞으면 ++ 아니면 idx 냅두기.
				// open에서도 appr 확인해야하니
				// json.parse() < 로 현재 sub 가져오고 거기에 메인 case get한 값 alt_05로 하고 0인덱스에 합쳐서 for문하기 ㅇㅇ
				
				
				let getGData = JSON.parse(JSON.stringify( w2ui[grid_name].get(w2ui[grid_name].getSelection()[0]) ));
				
				if(key.length == 0 && key2 == 0){
					console.log('새 단계 Case 클릭 시');
					getGData = JSON.parse(JSON.stringify( w2ui["grid_master"].get(1) ));
				}
				getGData.admin_level_type_code = "alt_05";
				getGData.admin_level_type_nm = "Open";
				
				foLoadData.splice(0, 0, getGData);
	// 			console.log("foLoadData = ", foLoadData);
				console.log('grid 확인 : ', grid_name);
				console.log("선택된 그리드foLoadData : ",foLoadData);
				
				save_checkT = fnStepCheck(foLoadData);
				
				if (save_checkT) {
					$("#save_check").css('display', '');
					// ★★
					let tttttt = "필요 단계 및 승인: "+save_checkT.substring(0, save_checkT.length-2);
					$("#save_check").text(tttttt);
				}
			}
			////////0602추가
		}, 200);
	}
	
</script>

</body>
</html>
