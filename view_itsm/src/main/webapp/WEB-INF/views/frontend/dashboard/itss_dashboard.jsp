<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="kr.co.inssuf.itsm.util.*"%>
<%
	String titleValue = SessionUtil.getProperties("mes.thema");
	String member_id = SessionUtil.getMemberId(request);
	String member_nm = SessionUtil.getMemberNm(request);
	String role_cd = SessionUtil.getRoleCd(request);
	String role_nm = SessionUtil.getRoleNm(request);
	String dept_cd = SessionUtil.getDeptCd(request);
	String dept_nm = SessionUtil.getDeptNm(request);
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

<%-- <jsp:include page="/WEB-INF/views/common/froalaJs.jsp" /> --%>
</head>

<style>
.etc {
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

#grid_grid_down_fcolumns .w2ui-col-select {
		height: 30px;
}
/* 2021 12 01 ★새로 추가 */
.detail_case_div .fr-second-toolbar {
	border-radius: 0px;
}

/* 	$(".fr-second-toolbar").css("display","none"); */
.fr-second-toolbar {
	display: none;
}

</style>

<link href="/res/itsm/itsm_commStyle.css" type="text/css" rel="stylesheet">
<link href="/res/itsm/itsm_modalStyle.css" type="text/css" rel="stylesheet">
<link href="/res/itsm/itsm_gridStyle.css" type="text/css" rel="stylesheet">

<link rel="stylesheet" href="/res/plugins/rMateChartH5/Assets/Css/rMateChartH5.css">
<script src="/res/plugins/rMateChartH5/rMateChartH5License.js"></script>
<script src="/res/plugins/rMateChartH5/JS/rMateChartH5.js"></script>

<script src="/res/plugins/rMateChartH5/JS/rMateMatrixChartH5.js"></script>

<script src="https://www.gstatic.com/charts/loader.js"></script>

<body class="hold-transition skin-purple sidebar-mini">
	<div class="wrapper">
		<jsp:include page="/common/top_menu_inc" flush="true">
			<jsp:param name="fb_div" value="F" />
			<jsp:param name="page_title" value="0" />
		</jsp:include>

		<jsp:include page="/common/sidebar_menu_inc" flush="true">
			<jsp:param name="menu_div" value="F" />
			<jsp:param name="selected_menu_p_cd" value="1044" />
			<jsp:param name="selected_menu_cd" value="1046" />
		</jsp:include>

<!-- 		<div class="content-wrapper"> -->
<!--     <section class="content-header"> -->
<!--       <h1> -->
<!--         자재관리 -->
<!--         <small>자재불출처리(자재외)</small> -->
<!--       </h1> -->
<!--       <ol class="breadcrumb"> -->
<!--         <li><a href="#"><i class="fa fa-dashboard"></i> 자재관리</a></li><li class="active">자재불출처리(자재외)</li> -->
<!--       </ol> -->
<!--     </section> -->
		<div class="content-wrapper">
			<section class="content-header"
				style="padding-bottom: 0px; padding-left: 3%;">
				<h1 class="text-bold form-group" style="font-size: 35px;">Case Dashboard</h1>
			</section>

    <!-- Main content -->
   		<section class="content">
			<div class="row">
				<div class="col-md-12">
					<div class="box" style="border-color: #27144a;">
						<div class="box-header with-border">
							<div class="row">
								<div class="col-md-2">
									<div id="step_cnt_chart" style="width: 100%; height: 270px;"></div>
								</div>
								<div class="col-md-4">
									<div id="week_case_ocre_chart" style="width: 95%; height: 250px;"></div>
								</div>
								<div class="col-md-5">
									<div id="system_week_ocre_chart" style="width: 95%; height: 250px;"></div>
								</div>
								<div class="col-md-1">
									<div style="text-align: center; border:1px solid; width: 130px; margin-top: 37px">
									<p style="font-size: 15px;">오래 걸린 Case 평균 소요 시간</p>
									<p style="font-size: 12px;">(상위 10%~40% 구간)</p>
									<label style="font-size: 30px; color:red" id="d_time">
<!-- 									미션중 -->
									</label>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-3">
									<div id="step_average_chart" style="width: 100%; height: 270px;"></div>
								</div>
								<div class="col-md-4">
									<div id="week_case_cmp_chart" style="width: 100%; height: 250px;"></div>
								</div>
								<div class="col-md-5">
									<div id="system_week_cmp_chart" style="width: 100%; height: 250px;"></div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-6">
									<div id="syste_quarter_chart" style="width: 100%; height: 250px;"></div>
								</div>
								<div class="col-md-6">
									<div id="ctrl_week_chart" style="width: 100%; height: 250px;"></div>
								</div>
							</div>
                           <div id="searchRow" class="row form-group">
<!-- 								<div class="col-sm-3" style="width: 212px;"> -->
<!-- 									<label>| 요청일</label> -->
<!-- 									<div class="input-group"> -->
<!-- 										<input type="text" id="s_request_Date" placeholder="날짜 선택" -->
<!-- 											class="form-control input-sm border-radius-5 range_date search_text"> -->
<!-- 										<div class="input-group-addon"> -->
<!-- 											<i class="fa fa-calendar"></i> -->
<!-- 										</div> -->
<!-- 									</div> -->
<!-- 								</div> -->
<!-- 								<div class="col-sm-3" style="width: 212px;"> -->
<!-- 									<label>| 시스템정보명</label> -->
<!-- 									<div class="input-group"> -->
<!-- 										<input type="text" id="s_system_info_nm" -->
<!-- 											class="form-control input-sm border-radius-5 range_date search_text"> -->
<!-- 									</div> -->
<!-- 								</div> -->
<!-- 								<div class="col-sm-3" style="width: 212px;"> -->
<!-- 									<label>| 제목</label> -->
<!-- 									<div class="input-group"> -->
<!-- 										<input type="text" id="s_title" -->
<!-- 											class="form-control input-sm border-radius-5 range_date search_text"> -->
<!-- 									</div> -->
<!-- 								</div> -->
<!-- 								<div class="col-sm-3" style="width: 212px;"> -->
<!-- 									<label>| 소유자명</label> -->
<!-- 									<div class="input-group"> -->
<!-- 										<input type="text" id="s_owner_nm" -->
<!-- 											class="form-control input-sm border-radius-5 range_date search_text"> -->
<!-- 									</div> -->
<!-- 								</div> -->
<!-- 								<div class="col-sm-3" style="width: 212px;"> -->
<!-- 									<label>| 관리자수준유형명</label> -->
<!-- 									<div class="input-group"> -->
<!-- 										<input type="text" id="s_admin_level_type_nm" -->
<!-- 											class="form-control input-sm border-radius-5 range_date search_text"> -->
<!-- 									</div> -->
<!-- 								</div> -->

<!-- 								<div class="col-sm-3"> -->
<!-- 									<div class="col-sm-12 no-padding"> -->
<!-- 										<label>| 제어유형명</label> -->
<!-- 									</div> -->
<!-- 									<div class="col-sm-8 text-right no-padding" style="width: 180px;"> -->
<!-- 										<input type="text" id="s_control_type_nm" name="" -->
<!-- 											placeholder="" style="height: 30px;"  -->
<!-- 											class="form-control input-sm border-radius-5 w2field_list search_text"> -->
<!-- 									</div> -->
<!-- 									<div class="col-sm-4 text-right" style="width: 150px; left: 247px; padding-left: 0px;"> -->
<!-- 										<button type="button" id="" onclick="loadGridList();" -->
<!-- 											class="btn btn-danger btn-sm">검색</button> -->
<!-- 										<button type="button" id="" onclick="searchReset();" -->
<!-- 											class="btn btn-danger btn-sm">검색 초기화</button> -->
<!-- 									</div> -->
<!-- 								</div> -->
							</div>
<!-- 							<button type="button" id="" onclick="loadGridList();"class="btn btn-danger btn-sm" style="margin-bottom: 7px;">조회</button> -->
							<div id="grid_list" style="width: 100%; height: 350px; margin-bottom: 7px;"></div>
						</div>
					</div>
				</div>
			</div>
		</section>
    <!-- /.content -->
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

var layoutStr1;
var chartData1 = [];
var layoutStr2;
var chartData2 = [];
var layoutStr3;
var chartData3 = [];
var layoutStr4;
var chartData4 = [];
var layoutStr5;
var chartData5 = [];
var layoutStr6;
var chartData6 = [];
var layoutStr7;
var chartData7 = [];
var layoutStr8;
var chartData8 = [];

$(function($) {
	
	fnDate();
	fnGridList();  // 그리드
	loadGridList(); // 조회
	stepcntChart(); // 단계별 건수
	weekCaseOcreChart(); // 주간 Case 발생
	systemweekOcreChart();   // 시스템 별 주간 Case 발생
	stepAverageChart();	// 단계별 평균 공수
	weekCaseCmpChart();	// 주간 Case 완료
	systemWeekCmpChart();	// 시스템 별 주간 Case 완료
	systemQuarterChart();  // 시스템 별 분기 평균 처리 공수
	ctrlWeekChart();  // 통제분류별 주간 평균 처리 공수
})

function searchReset(){
	$(".search_text").val('');
}

function fnDate() {
		let start = new Date();
   	
   		$('#s_request_Date').daterangepicker({
           opens: 'right',
           singleDatePicker: true, 
//            timePicker : true, // 분 ,시간
		   timePicker24Hour : true, 
           locale: {
               format: 'YYYY-MM-DD', 
//                format: 'YYYY-MM-DD HH:mm', 
               monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
               daysOfWeek: ["일", "월", "화", "수", "목", "금", "토"],
               showMonthAfterYear: true,
               yearSuffix: '년',
               orientation: "top left"
           },
           startDate: start
       });
   		
   		$("#s_request_Date").val('');
}
////////////////// 단계별 건수 차트
function stepcntChart() {
	
	FunLoadingBarStart();
	
	var page_url = "/case/dashboardChart/stepCntSelect";
	
   	$.ajax({
	    url: page_url,  
	    type: "POST",
	    async:false,
	    success: function(data) {
	    	if(data.status == "200"){
	    		var stepArr = data.rows;
	    		var Accept_cnt = 0;
	    		var Proceeding_cnt = 0;
	    		var Test_cnt = 0;
	    		var User_cnt = 0;
	    		
	    		for(var i = 0; i < stepArr.length; i++){
	    			if(stepArr[i].admin_level_type_nm == "Accept"){
	    				Accept_cnt = stepArr[i].count*1; 
	    			}
	    			if(stepArr[i].admin_level_type_nm == "Proceeding"){
	    				Proceeding_cnt = stepArr[i].count*1; 
	    			}
	    			if(stepArr[i].admin_level_type_nm == "Test"){
	    				Test_cnt = stepArr[i].count*1; 
	    			}
	    			if(stepArr[i].admin_level_type_nm == "User Confirm"){
	    				User_cnt = stepArr[i].count*1; 
	    			}
	    		}
	    		
	    		var max_cnt = Math.max(...[Accept_cnt,Proceeding_cnt,Test_cnt,User_cnt]);
	    		var max_ct = max_cnt / 10;
	    		var rst_max_cnt = Math.ceil(max_ct) + Math.ceil(max_ct) + max_cnt; // 동적으로 maximum 주기 미션중
	    		
	    		chartData1 = [{"Country":"Accept", "label":"건수", "GDP":Accept_cnt},
	    			              {"Country":"Proceeding", "label":"건수", "GDP":Proceeding_cnt},
	    			             {"Country":"Test", "label":"건수", "GDP":Test_cnt},
	    			               {"Country":"User Confirm", "label":"건수", "GDP":User_cnt}];
	    		var chCnt = [];
	    		for(var i = 0; i < chartData1.length; i++){
	    			chCnt.push(i); // 차트에 개수 뜨게하기
	    		}
	    		
	    		layoutStr1 =
	    	        '<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
	    	              +'<Options>'
	    	                 +'<Caption text="단계별 건수" />'
	    	                +'<SubCaption text="(진행 Case)" textAlign="center" />'
	    	                +'<Legend defaultMouseOverAction="false" position="right" direction="vertical" borderStyle="none"/>'
	    	            +'</Options>'
	    	            +'<SeriesInterpolate id="ss"/>'
	    	              +'<Column2DChart showDataTips="true" selectionMode="multiple" columnWidthRatio="0.48" itemClickJsFunction="stepChartClick">'
	    	                  +'<horizontalAxis>'
	    	                      +'<CategoryAxis categoryField="Country" id="hAxis"/>' // yField에다가 스타일 주기 id 설정
	    	                   +'</horizontalAxis>'
	    	                 +'<verticalAxis>'
	    	                    +'<LinearAxis maximum="'
	    	                    +rst_max_cnt
	    	                    +'" interval="10"/>'
	    	                 +'</verticalAxis>'
	    	                   +'<series>'
	    	                      +'<Column2DSeries labelPosition="outside" yField="GDP" displayName="요약" showDataEffect="{ss}" showValueLabels="['
	    	                      +chCnt
	    						  +']" strokeJsFunction="strokeFunction"/>'
	    	                  +'</series>'
	    	                  +'<horizontalAxisRenderers>'  // yField에다가 스타일 주기 글씨 휘청 (축 레이블 회전)
	    	                  +'<Axis2DRenderer axis="{hAxis}" styleName="xAxisStyle" showLine="true"/>'
	    	                 +'</horizontalAxisRenderers>'
	    	             +'</Column2DChart>'
	    	                +'<Style>'
	    	                 +'.xAxisStyle {fontFamily:"Malgun Gothic";fontSize:11;labelRotation:45;}'
	    	                +'</Style>' // yField에다가 스타일 주기
	    	          +'</rMateChart>';
	    	          
	 	 	}
	    },
	    error : function(jqXHR, textStatus, errorThrown) {
		    fnMessageModalAlert("알림",   "요청처리를 실패했습니다.");
		 },
	   	complete: function () {
		
		   	var chartVars = "rMateOnLoadCallFunction=chartReadyHandler1";
		   	
			rMateChartH5.create("chart1", "step_cnt_chart", chartVars, "100%", "90%"); 
	
		    FunLoadingBarEnd();
	   	}
	});// ajax
}
function chartReadyHandler1(id){
	document.getElementById(id).setLayout(layoutStr1);
	document.getElementById(id).setData(chartData1);
}

//////////////////////////// 주간 Case 발생 차트
function weekCaseOcreChart(){
	
	var page_url = "/case/dashboardChart/weekOccurSelect";
	
	FunLoadingBarStart();
	
	$.ajax({
		 url:page_url,
		 type:'POST',
		 async:false,
		//     data:postData,
		 success : function(data, textStatus, jqXHR) {
		    if(data.status == 200) {
		    	var rowArr = data.rows;
		    	var rowArr_count = _.map(rowArr, "count");
		    	rowArr = rowArr.reverse();
		    	
		    	for(var i = 0; i < rowArr.length; i++){
		    		var obj = {};
		    		obj["Country"] = rowArr[i].start+" -\n"+ rowArr[i].end;
		    		obj["rdate"] = rowArr[i].count;
		    		obj["label"] = "발생";
		    		
		    		chartData2.push(obj);
		    		
		    	}
		    	
		    	var chCnt = [];
		    	for(var i = 0; i < chartData2.length; i++){
		    		chCnt.push(i);
		    	}
		    	
		    	var max_cnt = Math.max(...rowArr_count);
		    	var max_ct = max_cnt / 10;
		    	var rst_max_cnt = Math.ceil(max_ct) + Math.ceil(max_ct) + max_cnt; // 동적으로 maximum 주기 미션중
		    	
		    	layoutStr2 =
		            '<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
		                  +'<Options>'
		                     +'<Caption text="주간 Case 발생" />'
//		                     +'<SubCaption text="GDP Growth (In %)" textAlign="center" />' 부제목
		                +'</Options>'
		                +'<SeriesInterpolate id="ss"/>'
		                  +'<Column2DChart showDataTips="true" selectionMode="multiple" columnWidthRatio="0.48" itemClickJsFunction="weekChartClick">'
		                      +'<horizontalAxis>'
		                          +'<CategoryAxis categoryField="Country"/>'
		                       +'</horizontalAxis>'
		                     +'<verticalAxis>'
		                        +'<LinearAxis maximum="'
		                        +rst_max_cnt
		                        +'" interval="10"/>'
		                     +'</verticalAxis>'
		                       +'<series>'
		                          +'<Column2DSeries labelPosition="outside" yField="rdate" displayName="rdate" showDataEffect="{ss}" showValueLabels="['
		    						+chCnt
		    					  +']" strokeJsFunction="strokeFunction"/>'
		                      +'</series>'
		                 +'</Column2DChart>'
		              +'</rMateChart>';
		    }
		 },
		 error : function(jqXHR, textStatus, errorThrown) {
		    fnMessageModalAlert("알림",   "요청처리를 실패했습니다.");
		 },
		 complete: function () {
			var chartVars = "rMateOnLoadCallFunction=chartReadyHandler2";
			
			rMateChartH5.create("chart2", "week_case_ocre_chart", chartVars, "100%", "90%");
				
		    FunLoadingBarEnd();
		 }
	});
}

function chartReadyHandler2(id){
	document.getElementById(id).setLayout(layoutStr2);
	document.getElementById(id).setData(chartData2);
}

////////////////////// 시스템 별 주간 Case 발생 차트
function systemweekOcreChart(){
	
	var page_url = "/case/dashboardChart/systemWeekOccurSelect";
	var rowArr;
	var row_order_arr;
	var rstArr = [];
	var rowArr_start;
	
	FunLoadingBarStart();
	
	$.ajax({
     url:page_url,
     async:false,
     type:'POST',
// 미션중
     success : function(data, textStatus, jqXHR) {
        if(data.status == 200) {  
        	rowArr = data.rows;
        	row_order_arr = rowArr.reverse(); // 바로 주간 데이터를 뽑으면 1월,2월 데이터가 나오기 때문에 최근 주간 데이터를 뽑기 위해 배열 거꾸로 시작
        	rowArr_start = _.uniqBy(rowArr, "start"); // 중복 없애주기
        	
        	if(rowArr_start.length > 6){
        		rowArr_start.length = 6;
        	}
        	
        	for(var j = 0; j < rowArr_start.length; j++){ // start 날짜 6개에 해당하는 데이터들 뽑아주기
	        	for(var i = 0; i < row_order_arr.length; i++){
	        		if(row_order_arr[i].start == rowArr_start[j].start){
	        			rstArr.push(row_order_arr[i]);
	        		}
	        	}
        	}
        	var flagArr1 = [0,0,0,0,0,0];
        	var flagArr2 = [0,0,0,0,0,0];
        	var flagArr3 = [0,0,0,0,0,0];
        	var flagArr4 = [0,0,0,0,0,0];
        	var flagArr5 = [0,0,0,0,0,0];
        	var flagArr6 = [0,0,0,0,0,0];
        	var flagArr7 = [0,0,0,0,0,0]; // 미션중
        	
        	var rowArr_str = _.uniqBy(rstArr, "start") // 중복 없애주기
        	var rowArr_end = _.uniqBy(rstArr, "end");
        	
        	rowArr_str = _.map(rowArr_str, "start") // 날짜만 넣어주기
        	rowArr_end = _.map(rowArr_end, "end");
        	
        	rstArr = rstArr.reverse(); //  배열 거꾸로 시작
        	
        	for(var i = 0; i < rstArr.length; i++){
        		for(var j = 0; j < rowArr_start.length; j++){
        			if(rstArr[i].start == rowArr_start[j].start && rstArr[i].system_info_nm == 'IT 기술지원'){
        				flagArr1[j] = rstArr[i].count*1;
        			}
        			if(rstArr[i].start == rowArr_start[j].start && rstArr[i].system_info_nm == 'MES'){
        				flagArr2[j] = rstArr[i].count*1;
        			}
        			if(rstArr[i].start == rowArr_start[j].start && rstArr[i].system_info_nm == 'Office365'){
        				flagArr3[j] = rstArr[i].count*1;
        			}
        			if(rstArr[i].start == rowArr_start[j].start && rstArr[i].system_info_nm == 'Salesforce'){
        				flagArr4[j] = rstArr[i].count*1;
        			}
        			if(rstArr[i].start == rowArr_start[j].start && rstArr[i].system_info_nm == 'SAP'){
        				flagArr5[j] = rstArr[i].count*1;
        			}
        			if(rstArr[i].start == rowArr_start[j].start && rstArr[i].system_info_nm == 'VIP (사내 Groupware)'){
        				flagArr6[j] = rstArr[i].count*1;
        			}
        			if(rstArr[i].start == rowArr_start[j].start && rstArr[i].system_info_nm == '유지보수'){
        				flagArr7[j] = rstArr[i].count*1;
        			}
        		}
        	}
        	
        	var flagCnt1 = Math.max(...flagArr1);
        	var flagCnt2 = Math.max(...flagArr2);
        	var flagCnt3 = Math.max(...flagArr3);
        	var flagCnt4 = Math.max(...flagArr4);
        	var flagCnt5 = Math.max(...flagArr5);
        	var flagCnt6 = Math.max(...flagArr6);
        	var flagCnt7 = Math.max(...flagArr7);
        	
        	var sum_max_cnt = Math.max(...[flagCnt1,flagCnt2,flagCnt3,flagCnt4,flagCnt5,flagCnt6,flagCnt7]);
        	var max_ct = sum_max_cnt / 10;
        	var rst_max_cnt = Math.ceil(max_ct) + Math.ceil(max_ct) + sum_max_cnt;
        	rst_max_cnt = Math.ceil(rst_max_cnt / 10) * 10;
        	
        	for(var i = rowArr_str.length-1; i >= 0; i--){ // 데이터가 거꾸로 나와서 for문을 거꾸로 돌림
        		var obj = {};
        		obj["Month"] = rowArr_str[i]+"-\n"+rowArr_end[i];
        		obj["label"] = "발생";
        		obj["IT 기술지원"] = flagArr1[i];
        		obj["MES"] = flagArr2[i];
        		obj["Office365"] = flagArr3[i];
        		obj["Salesforce"] = flagArr4[i];
        		obj["SAP"] = flagArr5[i];
        		obj["VIP (사내 Groupware)"] = flagArr6[i];
        		obj['유지보수'] = flagArr7[i];

        		chartData3.push(obj);
        	}
        	var chCnt = [];
        	for(var i = 0; i < chartData3.length; i++){
        		chCnt.push(i);
        	}
        	
        	layoutStr3 =
                '<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
                   +'<Options>'
                      +'<Caption text="시스템 별 주간 Case 발생"/>'
//                         +'<SubCaption text="시스템 별 주간 Case 발생" textAlign="center" />'
                      +'<Legend defaultMouseOverAction="false" position="right" direction="vertical"  borderStyle="none"/>' // 범례 오른쪽 일자로 정렬
                  +'</Options>'
                 +'<Column2DChart showDataTips="true" columnWidthRatio="0.55" selectionMode="single" itemClickJsFunction="systemChartClick">'
                     +'<horizontalAxis>'
                           +'<CategoryAxis categoryField="Month"/>'
                      +'</horizontalAxis>'
                      +'<verticalAxis>'
                         +'<LinearAxis maximum="'
                         +rst_max_cnt
                         +'" interval="10"/>'
                     +'</verticalAxis>'
                        +'<series>'
                           +'<Column2DSeries labelPosition="outside" yField="IT 기술지원" displayName="IT 기술지원" showValueLabels="['
                              +chCnt                                                                                                
        					+']">'
                                +'<showDataEffect>'
                                   +'<SeriesInterpolate/>'
                               +'</showDataEffect>'
                          +'</Column2DSeries>'
                          +'<Column2DSeries labelPosition="outside" yField="MES" displayName="MES" showValueLabels="['
                          		+chCnt                                                                                                
        					+']">'
                                +'<showDataEffect>'
                                   +'<SeriesInterpolate/>'
                               +'</showDataEffect>'
                          +'</Column2DSeries>'
                          +'<Column2DSeries labelPosition="outside" yField="Office365" displayName="Office365" showValueLabels="['
                          	+chCnt                                                                                                
        					+']">'
                                +'<showDataEffect>'
                                   +'<SeriesInterpolate/>'
                               +'</showDataEffect>'
                          +'</Column2DSeries>'
                          +'<Column2DSeries labelPosition="outside" yField="Salesforce" displayName="Salesforce" showValueLabels="['
                          	+chCnt                                                                                                
        					+']">'
        	                  +'<showDataEffect>'
        	                     +'<SeriesInterpolate/>'
        	                 +'</showDataEffect>'
                   		 +'</Column2DSeries>'
                   		+'<Column2DSeries labelPosition="outside" yField="SAP" displayName="SAP" showValueLabels="['
                        	+chCnt                                                                                                
        				+']">'
        	                +'<showDataEffect>'
        	                   +'<SeriesInterpolate/>'
        	               +'</showDataEffect>'
                  		+'</Column2DSeries>'
                  		+'<Column2DSeries labelPosition="outside" yField="VIP (사내 Groupware)" displayName="VIP (사내 Groupware)" showValueLabels="['
                        	+chCnt                                                                                                
        				+']">'
        	                +'<showDataEffect>'
        	                   +'<SeriesInterpolate/>'
        	               +'</showDataEffect>'
              			+'</Column2DSeries>'
              			+'<Column2DSeries labelPosition="outside" yField="유지보수" displayName="유지보수" showValueLabels="['
                        	+chCnt                                                                                                
        				+']">'
        	                +'<showDataEffect>'
        	                   +'<SeriesInterpolate/>'
        	               +'</showDataEffect>'
          				+'</Column2DSeries>'
                      +'</series>'
//                       +'<annotationElements>'
//                       +'<CrossRangeZoomer enableZooming="false"/>' // 마우스 이동에 따른 십자가 표시
//                       +'</annotationElements>'
                  +'</Column2DChart>'
               +'</rMateChart>';
        	
        }
     },
     error : function(jqXHR, textStatus, errorThrown) {
        fnMessageModalAlert("알림",   "요청처리를 실패했습니다.");
     },
     complete: function () {
    	 var chartVars = "rMateOnLoadCallFunction=chartReadyHandler3";
    	 
		rMateChartH5.create("chart3", "system_week_ocre_chart", chartVars, "100%", "90%");
        FunLoadingBarEnd();
     }
   });
}

function chartReadyHandler3(id){
	document.getElementById(id).setLayout(layoutStr3);
	document.getElementById(id).setData(chartData3);
}

///////////////// 단계별 평균 공수 차트
function stepAverageChart(){
	
	var page_url = "/case/dashboardChart/stepAverageSelect";
	
	FunLoadingBarStart();
	
	$.ajax({
     url:page_url,
     type:'POST',
     async:false,
     success : function(data, textStatus, jqXHR) {
        if(data.status == 200) {  
			var stepArr = data.rows;
			var Accept_cnt = 0;
			var Proceeding_cnt = 0;
			var Test_cnt = 0;
			var User_cnt = 0;
			
			for(var i = 0; i < stepArr.length; i++){
				if(stepArr[i].admin_level_type_nm == "Accept"){
					Accept_cnt = stepArr[i].avgtime*1; 
				}
				if(stepArr[i].admin_level_type_nm == "Proceeding"){
					Proceeding_cnt = stepArr[i].avgtime*1; 
				}
				if(stepArr[i].admin_level_type_nm == "Test"){
					Test_cnt = stepArr[i].avgtime*1; 
				}
				if(stepArr[i].admin_level_type_nm == "User Confirm"){
					User_cnt = stepArr[i].avgtime*1; 
				}
			}
			
			
			var max_cnt = Math.max(...[Accept_cnt,Proceeding_cnt,Test_cnt,User_cnt]);
			var max_ct = max_cnt / 10;
			var rst_max_cnt = Math.ceil(max_ct) + Math.ceil(max_ct) + max_cnt; // 동적으로 maximum 주기 미션중
			
			chartData4 = [{"Country":"Accept", "label":"평균", "GDP":Accept_cnt},
				              {"Country":"Proceeding", "label":"평균", "GDP":Proceeding_cnt},
				             {"Country":"Test", "label":"평균", "GDP":Test_cnt},
				               {"Country":"User Confirm", "label":"평균", "GDP":User_cnt}];
			
			var chCnt = [];
			for(var i = 0; i < chartData4.length; i++){
				chCnt.push(i);
			}
			
			layoutStr4 =
		        '<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
		              +'<Options>'
		                 +'<Caption text="단계별 평균 공수" />'
		                +'<SubCaption text="(진행 Case)" textAlign="center" />'
		                +'<Legend defaultMouseOverAction="false" position="right" direction="vertical" borderStyle="none"/>'
		            +'</Options>'
		            +'<SeriesInterpolate id="ss"/>'
		              +'<Column2DChart showDataTips="true" selectionMode="multiple" columnWidthRatio="0.48" itemClickJsFunction="stepChartClick">'
		                  +'<horizontalAxis>'
		                      +'<CategoryAxis categoryField="Country" id="hAxis"/>'
		                   +'</horizontalAxis>'
		                 +'<verticalAxis>'
		                    +'<LinearAxis maximum="'
		                    +rst_max_cnt
		                    +'" interval="0.1"/>'
		                 +'</verticalAxis>'
		                   +'<series>'
		                      +'<Column2DSeries labelPosition="outside" yField="GDP" displayName="요약" showDataEffect="{ss}" showValueLabels="['
								+chCnt
							  +']" strokeJsFunction="strokeFunction"/>'
		                  +'</series>'
		                  +'<horizontalAxisRenderers>'
		                  +'<Axis2DRenderer axis="{hAxis}" styleName="xAxisStyle" showLine="true"/>'
		                  +'</horizontalAxisRenderers>'
		              +'</Column2DChart>'
		                 +'<Style>'
		                  +'.xAxisStyle {fontFamily:"Malgun Gothic";fontSize:11;labelRotation:45;}'
		                 +'</Style>'
		          +'</rMateChart>';
        }
     },
     error : function(jqXHR, textStatus, errorThrown) {
        fnMessageModalAlert("알림",   "요청처리를 실패했습니다.");
     },
     complete: function () {
    	 var chartVars = "rMateOnLoadCallFunction=chartReadyHandler4";
    	 
		rMateChartH5.create("chart4", "step_average_chart", chartVars, "100%", "90%");
		
        FunLoadingBarEnd();
     }
   });
}
function chartReadyHandler4(id){
	document.getElementById(id).setLayout(layoutStr4);
	document.getElementById(id).setData(chartData4);
}

//////////////////////////// 주간 Case 완료 차트
function weekCaseCmpChart(){
	
	var page_url = "/case/dashboardChart/weekCmpSelect";
		FunLoadingBarStart();
		
		$.ajax({
		 url:page_url,
		 type:'POST',
		 async:false,
		 success : function(data, textStatus, jqXHR) {
		    if(data.status == 200) {  
			var rowArr = data.rows;
			// 바로 주간 데이터를 뽑으면 1월,2월 데이터가 나오기 때문에 최근 주간 데이터를 뽑기 위해 배열 거꾸로 시작
			rowArr = rowArr.reverse();
			for(var i = 0; i < rowArr.length; i++){
				var obj = {};
				obj["Country"] = rowArr[i].start+" -\n"+ rowArr[i].end;
				obj["sdate"] = rowArr[i].count;
				obj["label"] = "완료";
				
				chartData5.push(obj);
				
			}
			var chCnt = [];
			for(var i = 0; i < chartData5.length; i++){
				chCnt.push(i);
			}

			var rowArr_count = _.map(rowArr, "count");
			
			var max_cnt = Math.max(...rowArr_count);
			var max_ct = max_cnt / 10;
			var rst_max_cnt = Math.ceil(max_ct) + Math.ceil(max_ct) + max_cnt; // 동적으로 maximum 주기 미션중
			
			layoutStr5 =
		        '<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
		              +'<Options>'
		                 +'<Caption text="주간 Case 완료" />'
//		                 +'<SubCaption text="GDP Growth (In %)" textAlign="center" />'
		            +'</Options>'
		            +'<SeriesInterpolate id="ss"/>'
		              +'<Column2DChart showDataTips="true" selectionMode="multiple" columnWidthRatio="0.48" itemClickJsFunction="weekChartClick">'
		                  +'<horizontalAxis>'
		                      +'<CategoryAxis categoryField="Country"/>'
		                   +'</horizontalAxis>'
		                 +'<verticalAxis>'
		                    +'<LinearAxis maximum="'
		                    +rst_max_cnt
		                    +'" interval="10"/>'
		                 +'</verticalAxis>'
		                   +'<series>'
		                      +'<Column2DSeries labelPosition="outside" yField="sdate" displayName="sdate" showDataEffect="{ss}" showValueLabels="['
		                        +chCnt                                                                                                                             
							  +']" strokeJsFunction="strokeFunction"/>'
		                  +'</series>'
		             +'</Column2DChart>'
		          +'</rMateChart>';
		    }
		 },
		 error : function(jqXHR, textStatus, errorThrown) {
		    fnMessageModalAlert("알림",   "요청처리를 실패했습니다.");
		 },
		 complete: function () {
			 var chartVars = "rMateOnLoadCallFunction=chartReadyHandler5";
			 
			rMateChartH5.create("chart5", "week_case_cmp_chart", chartVars, "100%", "90%");
		    FunLoadingBarEnd();
		 }
	});
}

function chartReadyHandler5(id){
	document.getElementById(id).setLayout(layoutStr5);
	document.getElementById(id).setData(chartData5);
}

// fnMessageModalAlert("",   "."); 메시지
////////////////////// 시스템 별 주간 Case 완료 차트
function systemWeekCmpChart(){
	
	var page_url = "/case/dashboardChart/systemWeekCmpSelect";
	var rowArr;
	var row_order_arr;
	var rstArr = [];
	var rowArr_start;
	FunLoadingBarStart();
	
	$.ajax({
     url:page_url,
     type:'POST',
     async:false,
     success : function(data, textStatus, jqXHR) {
        if(data.status == 200) { 
        	rowArr = data.rows;
        	row_order_arr = rowArr.reverse(); // 배열 거꾸로 시작
        	rowArr_start = _.uniqBy(rowArr, "start"); // 중복 없애주기
        	
        	if(rowArr_start.length > 6){
        		rowArr_start.length = 6;
        	}
        	for(var j = 0; j < rowArr_start.length; j++){ // start 날짜 4개에 해당하는 데이터들 뽑아주기
	        	for(var i = 0; i < row_order_arr.length; i++){
	        		if(row_order_arr[i].start == rowArr_start[j].start){
	        			rstArr.push(row_order_arr[i]);
	        		}
	        	}
        	}
        	var flagArr1 = [0,0,0,0,0,0];
        	var flagArr2 = [0,0,0,0,0,0];
        	var flagArr3 = [0,0,0,0,0,0];
        	var flagArr4 = [0,0,0,0,0,0];
        	var flagArr5 = [0,0,0,0,0,0];
        	var flagArr6 = [0,0,0,0,0,0];
        	var flagArr7 = [0,0,0,0,0,0];
        	var flagArr8 = [0,0,0,0,0,0];
        	
        	var rowArr_str = _.uniqBy(rstArr, "start") // 중복 없애주기
        	var rowArr_end = _.uniqBy(rstArr, "end");
        	
        	rowArr_str = _.map(rowArr_str, "start") // 날짜만 넣어주기
        	rowArr_end = _.map(rowArr_end, "end");
        	
        	for(var i = 0; i < rstArr.length; i++){
        		for(var j = 0; j < rowArr_start.length; j++){
        			if(rstArr[i].start == rowArr_start[j].start && rstArr[i].system_info_nm == 'IT 기술지원'){
        				flagArr1[j] = rstArr[i].count*1;
        			}
        			if(rstArr[i].start == rowArr_start[j].start && rstArr[i].system_info_nm == 'IT 지원 시스템'){
        				flagArr2[j] = rstArr[i].count*1;
        			}
        			if(rstArr[i].start == rowArr_start[j].start && rstArr[i].system_info_nm == 'MES'){
        				flagArr3[j] = rstArr[i].count*1;
        			}
        			if(rstArr[i].start == rowArr_start[j].start && rstArr[i].system_info_nm == 'Office365'){
        				flagArr4[j] = rstArr[i].count*1;
        			}
        			if(rstArr[i].start == rowArr_start[j].start && rstArr[i].system_info_nm == 'Salesforce'){
        				flagArr5[j] = rstArr[i].count*1;
        			}
        			if(rstArr[i].start == rowArr_start[j].start && rstArr[i].system_info_nm == 'SAP'){
        				flagArr6[j] = rstArr[i].count*1;
        			}
        			if(rstArr[i].start == rowArr_start[j].start && rstArr[i].system_info_nm == 'VIP (사내 Groupware)'){
        				flagArr7[j] = rstArr[i].count*1;
        			}
        			if(rstArr[i].start == rowArr_start[j].start && rstArr[i].system_info_nm == '유지보수'){
        				flagArr8[j] = rstArr[i].count*1;
        			}
        		}
        	}

        	for(var i = 0; i < rowArr_str.length; i++){
        		var obj = {};
        		obj["Month"] = rowArr_str[i]+"-\n"+rowArr_end[i];
        		obj["label"] = "완료";
        		obj["IT 기술지원"] = flagArr1[i];
        		obj["IT 지원 시스템"] = flagArr2[i];
        		obj["MES"] = flagArr3[i];
        		obj["Office365"] = flagArr4[i];
        		obj['Salesforce'] = flagArr5[i];
        		obj["SAP"] = flagArr6[i];
        		obj["VIP (사내 Groupware)"] = flagArr7[i];
        		obj["유지보수"] = flagArr8[i];

        		chartData6.push(obj);
        	}
        	
        	var flagCnt1 = Math.max(...flagArr1);
        	var flagCnt2 = Math.max(...flagArr2);
        	var flagCnt3 = Math.max(...flagArr3);
        	var flagCnt4 = Math.max(...flagArr4);
        	var flagCnt5 = Math.max(...flagArr5);
        	var flagCnt6 = Math.max(...flagArr6);
        	var flagCnt7 = Math.max(...flagArr7);
        	var flagCnt8 = Math.max(...flagArr8);
        	
        	var sum_max_cnt = Math.max(...[flagCnt1,flagCnt2,flagCnt3,flagCnt4,flagCnt5,flagCnt6,flagCnt7,flagCnt8]);
        	var max_ct = sum_max_cnt / 10;
        	var rst_max_cnt = Math.ceil(max_ct) + Math.ceil(max_ct) + sum_max_cnt;
        	rst_max_cnt = Math.ceil(rst_max_cnt / 10) * 10;
        	
        	var chCnt = [];
        	for(var i = 0; i < chartData6.length; i++){
        		chCnt.push(i);
        	}
        	
        	layoutStr6 =
                '<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
                   +'<Options>'
                      +'<Caption text="시스템 별 주간 Case 완료"/>'
//                         +'<SubCaption text="From IT 기술지원 To Office365 (Annual %)" textAlign="center" />'
                      +'<Legend defaultMouseOverAction="false" position="right" direction="vertical" borderStyle="none"/>' // 차트기준 범례 오른쪽 표시
                  +'</Options>'
                 +'<Column2DChart showDataTips="true" columnWidthRatio="0.55" selectionMode="single" itemClickJsFunction="systemChartClick">'
                     +'<horizontalAxis>'
                           +'<CategoryAxis categoryField="Month"/>'
                      +'</horizontalAxis>'
                      +'<verticalAxis>'
                         +'<LinearAxis maximum="'
                         +rst_max_cnt
                         +'" interval="10"/>'
                     +'</verticalAxis>'
                        +'<series>'
                           +'<Column2DSeries labelPosition="outside" yField="IT 기술지원" displayName="IT 기술지원" showValueLabels="['
                              +chCnt                                                                                                
        					+']">'
                                +'<showDataEffect>'
                                   +'<SeriesInterpolate/>'
                               +'</showDataEffect>'
                          +'</Column2DSeries>'
                          +'<Column2DSeries labelPosition="outside" yField="IT 지원 시스템" displayName="IT 지원 시스템" showValueLabels="['
                          	+chCnt                                                                                                
        					+']">'
                                +'<showDataEffect>'
                                   +'<SeriesInterpolate/>'
                               +'</showDataEffect>'
                          +'</Column2DSeries>'
                          +'<Column2DSeries labelPosition="outside" yField="MES" displayName="MES" showValueLabels="['
                         	 +chCnt                                                                                                
        					+']">'
                                +'<showDataEffect>'
                                   +'<SeriesInterpolate/>'
                               +'</showDataEffect>'
                          +'</Column2DSeries>'
                          +'<Column2DSeries labelPosition="outside" yField="Office365" displayName="Office365" showValueLabels="['
                          	+chCnt                                                                                                
        					+']">'
        	                  +'<showDataEffect>'
        	                     +'<SeriesInterpolate/>'
        	                 +'</showDataEffect>'
                   		 +'</Column2DSeries>'
                   		+'<Column2DSeries labelPosition="outside" yField="Salesforce" displayName="Salesforce" showValueLabels="['
                       	 +chCnt                                                                                                
        				+']">'
        	                +'<showDataEffect>'
        	                   +'<SeriesInterpolate/>'
        	               +'</showDataEffect>'
                  		+'</Column2DSeries>'
                  		+'<Column2DSeries labelPosition="outside" yField="SAP" displayName="SAP" showValueLabels="['
                        	+chCnt                                                                                                
        				+']">'
        	                +'<showDataEffect>'
        	                   +'<SeriesInterpolate/>'
        	               +'</showDataEffect>'
        	               +'</Column2DSeries>'
        	               +'<Column2DSeries labelPosition="outside" yField="VIP (사내 Groupware)" displayName="VIP (사내 Groupware)" showValueLabels="['
                           +chCnt                                                                                                
        					+']">'
                             +'<showDataEffect>'
                                +'<SeriesInterpolate/>'
                            +'</showDataEffect>'
                       +'</Column2DSeries>'
                       +'<Column2DSeries labelPosition="outside" yField="유지보수" displayName="유지보수" showValueLabels="['
                       +chCnt                                                                                                
        				+']">'
                         +'<showDataEffect>'
                            +'<SeriesInterpolate/>'
                        +'</showDataEffect>'
                   +'</Column2DSeries>'
                      +'</series>'
                  +'</Column2DChart>'
               +'</rMateChart>';
        	
        }
     },
     error : function(jqXHR, textStatus, errorThrown) {
        fnMessageModalAlert("알림",   "요청처리를 실패했습니다.");
     },
     complete: function () {
    	 
    	 var chartVars = "rMateOnLoadCallFunction=chartReadyHandler6";
    	 
		rMateChartH5.create("chart6", "system_week_cmp_chart", chartVars, "100%", "90%");
			
        FunLoadingBarEnd();
     }
   });
}

function chartReadyHandler6(id){
	document.getElementById(id).setLayout(layoutStr6);
	document.getElementById(id).setData(chartData6);
}


//////////////////////////// 시스템 별 분기 평균 처리 공수 차트
function systemQuarterChart(){
	
	var page_url = "/case/dashboardChart/systemQuarterSelect";
	var rowArr;
	var rowArr_quarter;
	FunLoadingBarStart();
	
	$.ajax({
     url:page_url,
     type:'POST',
     async:false,
     success : function(data, textStatus, jqXHR) {
        if(data.status == 200) { 
        	rowArr = data.rows;
        	rowArr_quarter = _.uniqBy(rowArr, "quarter"); // 중복 없애주기
        	
        	var sytem_cnt_arr1 = [0,0,0,0];
        	var sytem_cnt_arr2 = [0,0,0,0];
        	var sytem_cnt_arr3 = [0,0,0,0];
        	var sytem_cnt_arr4 = [0,0,0,0];
        	var sytem_cnt_arr5 = [0,0,0,0];
        	var sytem_cnt_arr6 = [0,0,0,0];
        	var sytem_cnt_arr7 = [0,0,0,0];
        	var sytem_cnt_arr8 = [0,0,0,0];
        	var sytem_cnt_arr9 = [0,0,0,0];
        	var sytem_cnt_arr10 = [0,0,0,0];
        	var sytem_cnt_arr11 = [0,0,0,0];

        	for(var j = 0; j < rowArr_quarter.length; j++){
        		for(var i = 0; i < rowArr.length; i++){
        			if(rowArr_quarter[j].quarter == rowArr[i].quarter && rowArr[i].system_info_nm == 'IT 기술지원'){
        				sytem_cnt_arr1[j] = rowArr[i].count*1;
        			}
        			if(rowArr_quarter[j].quarter == rowArr[i].quarter && rowArr[i].system_info_nm == 'IT 지원 시스템'){
        				sytem_cnt_arr2[j] = rowArr[i].count*1;
        			}
        			if(rowArr_quarter[j].quarter == rowArr[i].quarter && rowArr[i].system_info_nm == 'LMS (License Management System)'){
        				sytem_cnt_arr3[j] = rowArr[i].count*1;
        			}
        			if(rowArr_quarter[j].quarter == rowArr[i].quarter && rowArr[i].system_info_nm == 'MES'){
        				sytem_cnt_arr4[j] = rowArr[i].count*1;
        			}
        			if(rowArr_quarter[j].quarter == rowArr[i].quarter && rowArr[i].system_info_nm == 'Office365'){
        				sytem_cnt_arr5[j] = rowArr[i].count*1;
        			}
        			if(rowArr_quarter[j].quarter == rowArr[i].quarter && rowArr[i].system_info_nm == 'Salesforce'){
        				sytem_cnt_arr6[j] = rowArr[i].count*1;
        			}
        			if(rowArr_quarter[j].quarter == rowArr[i].quarter && rowArr[i].system_info_nm == 'SAP'){
        				sytem_cnt_arr7[j] = rowArr[i].count*1;
        			}
        			if(rowArr_quarter[j].quarter == rowArr[i].quarter && rowArr[i].system_info_nm == 'SSO (Sing sign-on system)'){
        				sytem_cnt_arr8[j] = rowArr[i].count*1;
        			}
        			if(rowArr_quarter[j].quarter == rowArr[i].quarter && rowArr[i].system_info_nm == 'VIP (사내 Groupware)'){
        				sytem_cnt_arr9[j] = rowArr[i].count*1;
        			}
//         			if(rowArr_quarter[j].quarter == rowArr[i].quarter && rowArr[i].system_info_nm == 'Web 전표 시스템'){
//         				sytem_cnt_arr10[j] = rowArr[i].count*1;
//         			}
//         			if(rowArr_quarter[j].quarter == rowArr[i].quarter && rowArr[i].system_info_nm == '유지보수'){
//         				sytem_cnt_arr11[j] = rowArr[i].count*1;
//         			}
        		}
        	}
        	
        	for(var i = 0; i < rowArr_quarter.length; i++){
        		var obj = {};
        		obj["Month"] = rowArr_quarter[i].quarter+"사분기";
        		obj["IT 기술지원"] = sytem_cnt_arr1[i];
        		obj["IT 지원 시스템"] = sytem_cnt_arr2[i];
        		obj["LMS (License Management System)"] = sytem_cnt_arr3[i];
        		obj["MES"] = sytem_cnt_arr4[i];
        		obj['Office365'] = sytem_cnt_arr5[i];
        		obj["Salesforce"] = sytem_cnt_arr6[i];
        		obj["SAP"] = sytem_cnt_arr7[i];
        		obj["SSO (Sing sign-on system)"] = sytem_cnt_arr8[i];
        		obj["VIP (사내 Groupware)"] = sytem_cnt_arr9[i];
//         		obj["Web 전표 시스템"] = sytem_cnt_arr10[i];
//         		obj["유지보수"] = sytem_cnt_arr11[i];
        		
        		chartData7.push(obj);
        	}
        	var chCnt = [];
        	for(var i = 0; i < chartData7.length; i++){
        		chCnt.push(i);
        	}
        	
        	var sum_max_cnt = sytemCntArr(sytem_cnt_arr1,sytem_cnt_arr2,sytem_cnt_arr3,sytem_cnt_arr4,sytem_cnt_arr5,sytem_cnt_arr6,sytem_cnt_arr7,sytem_cnt_arr8
        			,sytem_cnt_arr9);
        	
        	var max_ct = sum_max_cnt / 10;
        	var rst_max_cnt = Math.ceil(max_ct) + Math.ceil(max_ct) + sum_max_cnt;
        	rst_max_cnt = Math.ceil(rst_max_cnt / 10) * 10;
        	
        	layoutStr7 =
                '<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
                   +'<Options>'
                      +'<Caption text="시스템 별 분기 평균 처리 공수"/>'
//                         +'<SubCaption text="From IT 기술지원 To Office365 (Annual %)" textAlign="center" />'
                      +'<Legend defaultMouseOverAction="false" position="right" direction="vertical" borderStyle="none"/>'
                  +'</Options>'
                 +'<Column2DChart showDataTips="true" columnWidthRatio="0.55" selectionMode="single" itemClickJsFunction="systemQuarterChartClick">'
        	         +'<backgroundElements>'
        		       	+'<GridLines direction="none" verticalShowCenterLine="true">'
        		       	+'</GridLines>'
        	    	+'</backgroundElements>'
                     +'<horizontalAxis>'
                           +'<CategoryAxis categoryField="Month"/>'
                      +'</horizontalAxis>'
                      +'<verticalAxis>'
                         +'<LinearAxis maximum="'
                         +rst_max_cnt
                         +'" interval="10"/>'
                     +'</verticalAxis>'
                        +'<series>'
                           +'<Column2DSeries labelPosition="outside" yField="IT 기술지원" displayName="IT 기술지원" showValueLabels="['
                              +chCnt                                                                                                
        					+']">'
                                +'<showDataEffect>'
                                   +'<SeriesInterpolate/>'
                               +'</showDataEffect>'
                          +'</Column2DSeries>'
                          +'<Column2DSeries labelPosition="outside" yField="IT 지원 시스템" displayName="IT 지원 시스템" showValueLabels="['
                          	+chCnt                                                                                                
        					+']">'
                                +'<showDataEffect>'
                                   +'<SeriesInterpolate/>'
                               +'</showDataEffect>'
                          +'</Column2DSeries>'
                          +'<Column2DSeries labelPosition="outside" yField="LMS (License Management System)" displayName="LMS (License Management System)" showValueLabels="['
                         	 +chCnt                                                                                                
        					+']">'
                                +'<showDataEffect>'
                                   +'<SeriesInterpolate/>'
                               +'</showDataEffect>'
                          +'</Column2DSeries>'
                          +'<Column2DSeries labelPosition="outside" yField="MES" displayName="MES" showValueLabels="['
                          	+chCnt                                                                                                
        					+']">'
        	                  +'<showDataEffect>'
        	                     +'<SeriesInterpolate/>'
        	                 +'</showDataEffect>'
                   		 +'</Column2DSeries>'
                   		+'<Column2DSeries labelPosition="outside" yField="Office365" displayName="Office365" showValueLabels="['
                       	 +chCnt                                                                                                
        				+']">'
        	                +'<showDataEffect>'
        	                   +'<SeriesInterpolate/>'
        	               +'</showDataEffect>'
                  		+'</Column2DSeries>'
                  		+'<Column2DSeries labelPosition="outside" yField="Salesforce" displayName="Salesforce" showValueLabels="['
                        	+chCnt                                                                                                
        				+']">'
        	                +'<showDataEffect>'
        	                   +'<SeriesInterpolate/>'
        	               +'</showDataEffect>'
              			+'</Column2DSeries>'
              			+'<Column2DSeries labelPosition="outside" yField="SAP" displayName="SAP" showValueLabels="['
                        	+chCnt                                                                                                
        				+']">'
        	                +'<showDataEffect>'
        	                   +'<SeriesInterpolate/>'
        	               +'</showDataEffect>'
          				+'</Column2DSeries>'
              			+'<Column2DSeries labelPosition="outside" yField="SSO (Sing sign-on system)" displayName="SSO (Sing sign-on system)" showValueLabels="['
                        	+chCnt                                                                                                
        				+']">'
        	                +'<showDataEffect>'
        	                   +'<SeriesInterpolate/>'
        	               +'</showDataEffect>'
          				+'</Column2DSeries>'
          				+'<Column2DSeries labelPosition="outside" yField="VIP (사내 Groupware)" displayName="VIP (사내 Groupware)" showValueLabels="['
                    	+chCnt                                                                                                
        			+']">'
                        +'<showDataEffect>'
                           +'<SeriesInterpolate/>'
                       +'</showDataEffect>'
        				+'</Column2DSeries>'
                      +'</series>'
                  +'</Column2DChart>'
               +'</rMateChart>';
        }
     },
     error : function(jqXHR, textStatus, errorThrown) {
        fnMessageModalAlert("알림",   "요청처리를 실패했습니다.");
     },
     complete: function () {
    	 
    	 var chartVars = "rMateOnLoadCallFunction=chartReadyHandler7";
    	 
		rMateChartH5.create("chart7", "syste_quarter_chart", chartVars, "100%", "90%");
			
        FunLoadingBarEnd();
     }
   });
}

function chartReadyHandler7(id){
	document.getElementById(id).setLayout(layoutStr7);
	document.getElementById(id).setData(chartData7);
}

function sytemCntArr(arr1,arr2,arr3,arr4,arr5,arr6,arr7,arr8,arr9){ // 가장 높은 수 구하기

// 	rowArr1 = JSON.stringify(rowArr);
// 	rowArr = JSON.parse(rowArr1).filter(function(element){
// 		return element.quarter == num; // 예) num == 1일 때 rowArr에 quarter == 1인 행만 뽑아주기
// 	});

   arr1 = Math.max(...arr1);
   arr2 = Math.max(...arr2);
   arr3 = Math.max(...arr3);
   arr4 = Math.max(...arr4);
   arr5 = Math.max(...arr5);
   arr6 = Math.max(...arr6);
   arr7 = Math.max(...arr7);
   arr8 = Math.max(...arr8);
   arr9 = Math.max(...arr9);
   
   var rstArr = Math.max(...[arr1, arr2, arr3, arr4, arr5, arr6, arr7, arr8, arr9]);
	
	return rstArr;
}

/////////////// 통제분류별 주간 평균 처리 공수 차트
function ctrlWeekChart(){
	
	var page_url = "/case/dashboardChart/ctrlWeekSelect";
	var rowArr;
	var row_order_arr;
	var rstArr = [];
	var rowArr_start;
	
	FunLoadingBarStart();
	
	$.ajax({
     url:page_url,
     type:'POST',
     async:false,
//         data:postData,
// 미션중
     success : function(data, textStatus, jqXHR) {
        if(data.status == 200) {  
        	
        	rowArr = data.rows;
        	row_order_arr = rowArr.reverse(); // 배열 거꾸로 시작
        	rowArr_start = _.uniqBy(rowArr, "start"); // 중복 없애주기
        	
        	if(rowArr_start.length > 6){
        		rowArr_start.length = 6;
        	}
        	
        	for(var j = 0; j < rowArr_start.length; j++){ // start 날짜 6개에 해당하는 데이터들 뽑아주기
	        	for(var i = 0; i < row_order_arr.length; i++){
	        		if(row_order_arr[i].start == rowArr_start[j].start){
	        			rstArr.push(row_order_arr[i]);
	        		}
	        	}
        	}
        	
        	var sytem_cnt1 = [0,0,0,0,0,0];
        	var sytem_cnt2 = [0,0,0,0,0,0];
        	var sytem_cnt3 = [0,0,0,0,0,0];
        	var sytem_cnt4 = [0,0,0,0,0,0];
        	var sytem_cnt5 = [0,0,0,0,0,0];
        	var sytem_cnt6 = [0,0,0,0,0,0];
        	var sytem_cnt7 = [0,0,0,0,0,0];
        	var sytem_cnt8 = [0,0,0,0,0,0];
        	var sytem_cnt9 = [0,0,0,0,0,0];
        	
        	var rowArr_str = _.uniqBy(rstArr, "start") // 중복 없애주기
        	var rowArr_end = _.uniqBy(rstArr, "end");
        	
        	rowArr_str = _.map(rowArr_str, "start") // 날짜만 넣어주기
        	rowArr_end = _.map(rowArr_end, "end");
//         	console.log(rstArr);
        	for(var i = 0; i < rstArr.length; i++){
        		for(var j = 0; j < rowArr_start.length; j++){
        			if(rstArr[i].start == rowArr_start[j].start && rstArr[i].control_type_nm == 'DB 데이터 변경 (IT)'){
        				sytem_cnt1[j] = rstArr[i].count*1;
        			}
        			if(rstArr[i].start == rowArr_start[j].start && rstArr[i].control_type_nm == 'IT 자원 요청 대응'){
        				sytem_cnt2[j] = rstArr[i].count*1;
        			}
        			if(rstArr[i].start == rowArr_start[j].start && rstArr[i].control_type_nm == '계정 생성 및 권한 변경'){
        				sytem_cnt3[j] = rstArr[i].count*1;
        			}
        			if(rstArr[i].start == rowArr_start[j].start && rstArr[i].control_type_nm == '계정 생성 및 권한 변경 (인사발령)'){
        				sytem_cnt4[j] = rstArr[i].count*1;
        			}
        			if(rstArr[i].start == rowArr_start[j].start && rstArr[i].control_type_nm == '모니터링 및 유지보수'){
        				sytem_cnt5[j] = rstArr[i].count*1;
        			}
        			if(rstArr[i].start == rowArr_start[j].start && rstArr[i].control_type_nm == '시스템 변경(단순)'){
        				sytem_cnt6[j] = rstArr[i].count*1;
        			}
        			if(rstArr[i].start == rowArr_start[j].start && rstArr[i].control_type_nm == '시스템 변경(로직)'){
        				sytem_cnt7[j] = rstArr[i].count*1;
        			}
        			if(rstArr[i].start == rowArr_start[j].start && rstArr[i].control_type_nm == '시스템 장애 처리'){
        				sytem_cnt8[j] = rstArr[i].count*1;
        			}
        			if(rstArr[i].start == rowArr_start[j].start && rstArr[i].control_type_nm == '자산 구매 요청'){
        				sytem_cnt9[j] = rstArr[i].count*1;
        			}
        		}
        	}
        	
//         	var sytem_cnt1 = systemCount('통제분류','DB 데이터 변경 (IT)');

        	for(var i = rowArr_str.length-1; i >= 0; i--){ // 데이터가 거꾸로 나와서 for문을 거꾸로 돌림
        		var obj = {};
        		obj["Month"] = rowArr_str[i]+"-\n"+rowArr_end[i];
        		obj["label"] = "통제분류";
        		obj["DB 데이터 변경 (IT)"] = sytem_cnt1[i];
        		obj["IT 자원 요청 대응"] = sytem_cnt2[i];
        		obj["계정 생성 및 권한 변경"] = sytem_cnt3[i];
        		obj["계정 생성 및 권한 변경(인사발령)"] = sytem_cnt4[i];
        		obj['모니터링 및 유지보수'] = sytem_cnt5[i];
        		obj["시스템 변경(단순)"] = sytem_cnt6[i];
        		obj["시스템 변경(로직)"] = sytem_cnt7[i];
        		obj["시스템 장애 처리"] = sytem_cnt8[i];
        		obj["자산 구매 요청"] = sytem_cnt9[i];

        		chartData8.push(obj);
        	}
        	
        	var sytemCnt1 = Math.max(...sytem_cnt1);
        	var sytemCnt2 = Math.max(...sytem_cnt2);
        	var sytemCnt3 = Math.max(...sytem_cnt3);
        	var sytemCnt4 = Math.max(...sytem_cnt4);
        	var sytemCnt5 = Math.max(...sytem_cnt5);
        	var sytemCnt6 = Math.max(...sytem_cnt6);
        	var sytemCnt7 = Math.max(...sytem_cnt7);
        	var sytemCnt8 = Math.max(...sytem_cnt8);
        	var sytemCnt9 = Math.max(...sytem_cnt9);
        	
        	var sum_max_cnt = Math.max(...[sytemCnt1,sytemCnt2,sytemCnt3,sytemCnt4,sytemCnt5,sytemCnt6,sytemCnt7,sytemCnt8,sytemCnt9]);
        	var max_ct = sum_max_cnt / 10;
        	var rst_max_cnt = Math.ceil(max_ct) + Math.ceil(max_ct) + sum_max_cnt;
        	rst_max_cnt = Math.ceil(rst_max_cnt / 10) * 10;
        	
        	var chCnt = [];
        	for(var i = 0; i < chartData8.length; i++){
        		chCnt.push(i);
        	}
        	layoutStr8 =
                '<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
                   
                   +'<Options>'
                      +'<Caption text="통제분류별 주간 평균 처리 공수"/>'
                      +'<Legend defaultMouseOverAction="false" position="right" direction="vertical" borderStyle="none"/>' // 범례
                  +'</Options>'
                 +'<Column2DChart showDataTips="true" columnWidthRatio="0.55" selectionMode="single" itemClickJsFunction="ctrlChartClick">'
                     +'<horizontalAxis>'
                           +'<CategoryAxis categoryField="Month"/>'
                      +'</horizontalAxis>'
                      +'<verticalAxis>'
                         +'<LinearAxis maximum="'
                         +rst_max_cnt
                         +'"/>'
                     +'</verticalAxis>'
                        +'<series>'
                           +'<Column2DSeries labelPosition="outside" yField="DB 데이터 변경 (IT)" displayName="DB 데이터 변경(IT)" showValueLabels="['
                              +chCnt                                                                                                
        					+']">'
                                +'<showDataEffect>'
                                   +'<SeriesInterpolate/>'
                               +'</showDataEffect>'
                          +'</Column2DSeries>'
                          +'<Column2DSeries labelPosition="outside" yField="IT 자원 요청 대응" displayName="IT 자원 요청 대응" showValueLabels="['
                          	+chCnt                                                                                                
        					+']">'
                                +'<showDataEffect>'
                                   +'<SeriesInterpolate/>'
                               +'</showDataEffect>'
                          +'</Column2DSeries>'
                          +'<Column2DSeries labelPosition="outside" yField="계정 생성 및 권한 변경" displayName="계정 생성 및 권한 변경" showValueLabels="['
                         	 +chCnt                                                                                                
        					+']">'
                                +'<showDataEffect>'
                                   +'<SeriesInterpolate/>'
                               +'</showDataEffect>'
                          +'</Column2DSeries>'
                          +'<Column2DSeries labelPosition="outside" yField="계정 생성 및 권한 변경(인사발령)" displayName="계정 생성 및 권한 변경(인사발령)" showValueLabels="['
                          	+chCnt                                                                                                
        					+']">'
        	                  +'<showDataEffect>'
        	                     +'<SeriesInterpolate/>'
        	                 +'</showDataEffect>'
                   		 +'</Column2DSeries>'
                   		+'<Column2DSeries labelPosition="outside" yField="모니터링 및 유지보수" displayName="모니터링 및 유지보수" showValueLabels="['
                       	 +chCnt                                                                                                
        				+']">'
        	                +'<showDataEffect>'
        	                   +'<SeriesInterpolate/>'
        	               +'</showDataEffect>'
                  		+'</Column2DSeries>'
                  		+'<Column2DSeries labelPosition="outside" yField="시스템 변경(단순)" displayName="시스템 변경(단순)" showValueLabels="['
                        	+chCnt                                                                                                
        				+']">'
        	                +'<showDataEffect>'
        	                   +'<SeriesInterpolate/>'
        	               +'</showDataEffect>'
              			+'</Column2DSeries>'
              			+'<Column2DSeries labelPosition="outside" yField="시스템 변경(로직)" displayName="시스템 변경(로직)" showValueLabels="['
                        	+chCnt                                                                                                
        				+']">'
        	                +'<showDataEffect>'
        	                   +'<SeriesInterpolate/>'
        	               +'</showDataEffect>'
          				+'</Column2DSeries>'
          				+'<Column2DSeries labelPosition="outside" yField="시스템 장애 처리" displayName="시스템 장애 처리" showValueLabels="['
                        +chCnt                                                                                                
        				+']">'
                          +'<showDataEffect>'
                             +'<SeriesInterpolate/>'
                         +'</showDataEffect>'
                    +'</Column2DSeries>'
                    +'<Column2DSeries labelPosition="outside" yField="자산 구매 요청" displayName="자산 구매 요청" showValueLabels="['
                    +chCnt                                                                                                
        			+']">'
                      +'<showDataEffect>'
                         +'<SeriesInterpolate/>'
                     +'</showDataEffect>'
                +'</Column2DSeries>'
                      +'</series>'
                  +'</Column2DChart>'
               +'</rMateChart>';
        	
        }
     },
     error : function(jqXHR, textStatus, errorThrown) {
        fnMessageModalAlert("알림",   "요청처리를 실패했습니다.");
     },
     complete: function () {
    	 
    	 var chartVars = "rMateOnLoadCallFunction=chartReadyHandler8";
    	 
		rMateChartH5.create("chart8", "ctrl_week_chart", chartVars, "100%", "90%");
        FunLoadingBarEnd();
     }
   });
}

function chartReadyHandler8(id){
	document.getElementById(id).setLayout(layoutStr8);
	document.getElementById(id).setData(chartData8);
}


function fnGridList(){
	   
	   var grid_nm = 'grid_list';
	   
	   $("#"+grid_nm+"").w2grid({
	      name : grid_nm,
	      show : {
// 	         toolbar: true,
	         lineNumbers : true,
	            footer: true,
	            selectColumn: true,
	            columnHeaders: true
	        },
	        reorderColumns: true,
	        multiSearch: true,
	        multiSelect: false,
	        markSearch : true,
// 	        toolbar: {
// 	            items: [
// 	                { type: 'break' },
// 	                { type: 'menu-radio', id: 'item2',
// 	                    text: function (item) {
// 	                        var text = item.selected;
// 	                        var el   = this.get('item2:' + item.selected);
	                        
// 	                        return 'Sort: ' + el.text;
// 	                    },
// 	                    selected: 'on',
// 	                    items: [
// 	                        { id: 'off', text: 'OFF', icon: 'fa fa-camera' },
// 	                        { id: 'on', text: 'ON', icon: 'fa fa-picture-o' },
// 	                    ]
// 	                },
// 	                {type: 'break' },
// 	                {type: 'button', id: 'excel_down', text: 'Excel Download', img: 'icon-page' },
// 	            ],
// 	            onClick: function (target, data) {
// 	                if(target == 'excel_down'){
// 	                   //excelFileDownload(grid_nm);
// 	                   xlsxDownload(grid_nm);
// 	                }
	                
// 	                if(target.split(':').reverse()[0] == 'on'){
// 	                   for(var i=0; i<w2ui[grid_nm].columns.length; i++){
// 	                      w2ui[grid_nm].columns[i].sortable = true;
// 	                   }
// 	                }else if(target.split(':').reverse()[0] == 'off'){
// 	                   for(var i=0; i<w2ui[grid_nm].columns.length; i++){
// 	                      w2ui[grid_nm].columns[i].sortable = false;
// 	                   }
// 	                }
	                
// 	            }
// 	        },
	        columns : [
						{field: 'request_id', caption: 'Case 번호', size: '50%', style: 'text-align:center;', sortable: true, editable : {type: 'text'}},
						{field: 'request_Date', caption: '요청 일시', size: '50%', style: 'text-align:center;', sortable: true},
						{field: 'owner_nm', caption: '요청자', size: '50%', style: 'text-align:center;', sortable: true},
						{field: 'system_info_nm', caption: '요청 대상', size: '50%', style: 'text-align:center;', sortable: true},
						{field: 'request_type_nm', caption: '요청 분류', size: '50%', style: 'text-align:center;', sortable: true},
						{field: 'service_process_seq', caption: '서비스프로세스시퀀스', size: '50%', style: 'text-align:center;', sortable: true, hidden:true},
						{field: 'title', caption: '제목', size: '50%', style: 'text-align:center;', sortable: true},
						{field: 'n_owner_nm', caption: '처리자', size: '50%', style: 'text-align:center;', sortable: true},
						{field: 'admin_level_type_nm', caption: '단계', size: '50%', style: 'text-align:center;', sortable: true},
						{field: 'step_date', caption: '단계날짜', size: '50%', style: 'text-align:center;', sortable: true, hidden:true},
						{field: 'step_update', caption: '단계 업데이트', size: '50%', style: 'text-align:center;', sortable: true, hidden:true},
						{field: 'leadtime', caption: '제품생산 소요시간', size: '50%', style: 'text-align:center;', sortable: true, hidden:true},
						{field: 'code_nm', caption: '상태', size: '50%', style: 'text-align:center;', sortable: true},
						{field: 'control_type_nm', caption: '제어유형명', size: '50%', style: 'text-align:center;', sortable: true},
	      ],
	      records: [],
	      total : 0,
	      recordHeight : 30,
	      onReload: function(event) {},
	      onClick: function (event) {
		   	  event.onComplete = function (){ 
		   	  }
	      },
	      onDblClick: function (event) {
	      },
	      onChange: function(event){
	         event.onComplete = function () {
	        	 console.log(event);
	        	 w2ui[grid_nm].refresh();
// 	        	 console.log(this.getSelection());
// 	        	 var sel = this.getSelection();
	        	 var key = w2ui[grid_nm].getSelection();
				var get_grid = w2ui[grid_nm].get(key[0]);
				console.log(get_grid);
	         }
	      }, 
	      
	   });
	   
	   w2ui[grid_nm].textSearch = 'contains';
}


function loadGridList(){
	w2ui['grid_list'].clear();
	
	FunLoadingBarStart();
	
	var page_url = page_url = "/case/dashboardChart/caseAverageTime"; // 오래 걸린 Case 평균 소요 시간
	$.ajax({
     url:page_url,
     type:'POST',
     success : function(data, textStatus, jqXHR) {
        if(data.status == 200) {  
        	document.getElementById('d_time').innerText = data.rows[0].avgtime+' 일';
			
        	
        }
     },
     error : function(jqXHR, textStatus, errorThrown) {
        fnMessageModalAlert("알림",   "요청처리를 실패했습니다.");
     },
     complete: function () {
        FunLoadingBarEnd();
     }
   });
	
//            $.each(TestArr, function(idx, row){
//               row.recid = idx+1;
//               row.request_Date = row.request_Date.substr(0, 10);
//               row.step_date = row.step_date.substr(0, 10);
//               row.step_update = row.step_update.substr(0, 10);
//            });
           
// 			w2ui['grid_list'].records = TestArr;
// 			w2ui['grid_list'].refresh();
}

//단계별 건수 클릭 시, 단계별 평균 공수 차트 클릭 시
function stepChartClick(seriesId, displayText, index, data, values){
	
	FunLoadingBarStart();
	w2ui['grid_list'].clear();
	
	var postData = "admin_level_type_nm=" + encodeURIComponent(values[0]);
// 	postData +=  "&system_info_nm=" + encodeURIComponent($("#s_system_info_nm").val());  // 시스템 정보 명
	var page_url;
	if(data.label == "건수"){
		page_url = "/case/dashboardChart/stepDtlSelect";
	}
	if(data.label == "평균"){
		page_url = "/case/dashboardChart/stepDtlSelect";
	}
	
	FunLoadingBarStart();
	
	$.ajax({
     url:page_url,
     type:'POST',
//      async:false,
        data:postData,
     success : function(data, textStatus, jqXHR) {
        if(data.status == 200) {  
		var stepArr = data.rows;
		console.log(stepArr);
		$.each(stepArr, function(idx, row){
	     	row.recid = idx+1;
	  	});
		w2ui['grid_list'].records = stepArr;
		w2ui['grid_list'].refresh();
		
        }
     },
     error : function(jqXHR, textStatus, errorThrown) {
        fnMessageModalAlert("알림",   "요청처리를 실패했습니다.");
     },
     complete: function () {
        FunLoadingBarEnd();
        
     }
   });
}
// 주간 Case 발생 클릭 시, 주간 Case 완료 차트 클릭 시
function weekChartClick(seriesId, displayText, index, data, values){
	w2ui['grid_list'].clear();
	var rst_date = displayText.substring(0, 10); // 시작 날짜
	var rst_txt = displayText.substring(13,23); // 종료 날짜
	var Date1;
	
	var postData = "start_date=" + encodeURIComponent(rst_date);
	postData +=  "&end_date=" + encodeURIComponent(rst_txt);
	
	var page_url;
	if(data.label == "발생"){
		page_url = "/case/dashboardChart/weekOccurDtlSelect";
	}
	if(data.label == "완료"){
		page_url = "/case/dashboardChart/weekCmpDtlSelect";
	}
	
	FunLoadingBarStart();
	
	$.ajax({
     url:page_url,
     type:'POST',
//      async:false,
     data:postData,
     success : function(data, textStatus, jqXHR) {
        if(data.status == 200) {  
		var rowArr = data.rows;
		console.log(rowArr);
		$.each(rowArr, function(idx, row){
	     	row.recid = idx+1;
	  	});
		
		w2ui['grid_list'].records = rowArr;
		w2ui['grid_list'].refresh();
		
        }
     },
     error : function(jqXHR, textStatus, errorThrown) {
        fnMessageModalAlert("알림",   "요청처리를 실패했습니다.");
     },
     complete: function () {
        FunLoadingBarEnd();
        
     }
   });
}

// function f_SkipTags_html(input, allowed) {
// 	// 허용할 태그는 다음과 같이 소문자로 넘겨받습니다. (<a><b><c>) 미션중
//     allowed = (((allowed || "") + "").toLowerCase().match(/<[a-z][a-z0-9]*>/g) || []).join('');
//     var tags = /<\/?([a-z][a-z0-9]*)\b[^>]*>/gi,
//     commentsAndPhpTags = /<!--[\s\S]*?-->|<\?(?:php)?[\s\S]*?\?>/gi;
//     return input.replace(commentsAndPhpTags, '').replace(tags, function ($0, $1) {
//         return allowed.indexOf('<' + $1.toLowerCase() + '>') > -1 ? $0 : '';
//     });
// }
// 시스템 별 주간 Case 발생 클릭 시, 시스템 별 주간 Case 완료 클릭 시
function systemChartClick(seriesId, displayText, index, data, values){
	w2ui['grid_list'].clear();
	
	var rst_date = displayText.substring(0, 10); // 시작 날짜
	var rst_txt = displayText.substring(12,22); // 종료 날짜
	var str = displayText.substring(27);
	str = str.replace(' : <b>'+values[1]+'</b></b>','');
	console.log(str);
	
	var postData = "start_date=" + encodeURIComponent(rst_date);
	postData +=  "&end_date=" + encodeURIComponent(rst_txt);
	postData +=  "&system_info_nm=" + encodeURIComponent(str);  // 시스템 정보 명
	
	var page_url;
	if(data.label == "발생"){
		page_url = "/case/dashboardChart/systemWeekOccurDtlSelect";
	}
	if(data.label == "완료"){
		page_url = "/case/dashboardChart/systemWeekCmpDtlSelect";
	}
		
	FunLoadingBarStart();
	
	$.ajax({
     url:page_url,
     type:'POST',
//      async:false,
     data:postData,
     success : function(data, textStatus, jqXHR) {
        if(data.status == 200) {  
		var rowArr = data.rows;
		console.log(data);
		$.each(rowArr, function(idx, row){
	     	row.recid = idx+1;
	  	});
		
		w2ui['grid_list'].records = rowArr;
		w2ui['grid_list'].refresh();
		
        }
     },
     error : function(jqXHR, textStatus, errorThrown) {
        fnMessageModalAlert("알림",   "요청처리를 실패했습니다.");
     },
     complete: function () {
        FunLoadingBarEnd();
        
     }
   });
}

//시스템 별 분기 평균 처리 공수 평균 클릭 시.
function systemQuarterChartClick(seriesId, displayText, index, data, values){
	
w2ui['grid_list'].clear();
	
	var string = displayText.substring(9);
	string = string.replace(' : <b>'+values[1]+'</b></b>','');
	var quarter = data.Month.replace('사분기','');
	console.log(quarter);
	console.log(string);
	
	var postData = "quarter=" + encodeURIComponent(quarter);
	postData +=  "&system_info_nm=" + encodeURIComponent(string);  // 시스템 정보 명
	
	var	page_url = "/case/dashboardChart/systemQuarterDtlSelect";
		
	FunLoadingBarStart();
	
	$.ajax({
     url:page_url,
     type:'POST',
//      async:false,
     data:postData,
     success : function(data, textStatus, jqXHR) {
        if(data.status == 200) {  
		var rowArr = data.rows;
		console.log(data);
		$.each(rowArr, function(idx, row){
	     	row.recid = idx+1;
	  	});
		
		w2ui['grid_list'].records = rowArr;
		w2ui['grid_list'].refresh();
		
        }
     },
     error : function(jqXHR, textStatus, errorThrown) {
        fnMessageModalAlert("알림",   "요청처리를 실패했습니다.");
     },
     complete: function () {
        FunLoadingBarEnd();
        
     }
   });
	
}

// 통제분류별 주간 평균 처리 공수 클릭 시
function ctrlChartClick(seriesId, displayText, index, data, values){
	
	w2ui['grid_list'].clear();
	
	var rst_date = displayText.substring(0, 10);
	var rst_txt = displayText.substring(12,22);
	var str = displayText.substring(27);
	str = str.replace(' : <b>'+values[1]+'</b></b>','');
	
	console.log(str);
	
	var postData = "start_date=" + encodeURIComponent(rst_date);
	postData +=  "&end_date=" + encodeURIComponent(rst_txt);
	postData +=  "&control_type_nm=" + encodeURIComponent(str);  // 제어 유형 명
	
	var	page_url = "/case/dashboardChart/ctrlWeekDtlSelect";
	FunLoadingBarStart();
	
	$.ajax({
     url:page_url,
     type:'POST',
//      async:false,
     data:postData,
     success : function(data, textStatus, jqXHR) {
        if(data.status == 200) {  
		var rowArr = data.rows;
		$.each(rowArr, function(idx, row){
	     	row.recid = idx+1;
	  	});
		
		w2ui['grid_list'].records = rowArr;
		w2ui['grid_list'].refresh();
		
        }
     },
     error : function(jqXHR, textStatus, errorThrown) {
        fnMessageModalAlert("알림",   "요청처리를 실패했습니다.");
     },
     complete: function () {
        FunLoadingBarEnd();
        
     }
   });
}
</script>
</body>
</html>
