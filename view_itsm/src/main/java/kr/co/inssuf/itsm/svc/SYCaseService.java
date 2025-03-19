package kr.co.inssuf.itsm.svc;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.annotation.Resource;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.inssuf.itsm.dao.SYCaseDAO;
import kr.co.inssuf.itsm.dao.SYIncidentDAO;
import kr.co.inssuf.itsm.util.SessionUtil;
import kr.co.inssuf.itsm.vo.SYCaseDashBoardVo;
import kr.co.inssuf.itsm.vo.SYCaseVo;
import kr.co.inssuf.itsm.vo.SYRqstMngVo;
import kr.co.inssuf.itsm.vo.SYTaskScheduleDetailVo;
import kr.co.inssuf.itsm.vo.SYUserVo;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpStatus;

@Service(value = "caseService")
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
public class SYCaseService {

	private static final Logger logger = LoggerFactory.getLogger(SYOrganService.class);
	
	@Resource
	private Environment environment;
	
	@Resource(name = "usersService")
	SYUsersService syUsersService;
	
	@Resource(name = "caseDAO")
	private SYCaseDAO caseDAO;
	
	@Resource(name = "incidentDAO")
	private SYIncidentDAO incidentDAO;
	
	public List<SYCaseVo> selectQueueMember(SYCaseVo vo) {
		return caseDAO.selectQueueMember(vo);
	}

	public int selectQueueMember2Count(SYCaseVo vo) {
		return caseDAO.selectQueueMember2Count(vo);
	}
	public List<SYCaseVo> selectQueueMember2(SYCaseVo vo) {
		return caseDAO.selectQueueMember2(vo);
	}
	
	public List<SYCaseVo> selectCaseMng(SYCaseVo vo) {
		return caseDAO.selectCaseMng(vo);
	}
	
	public List<SYCaseVo> selectCaseMngSub(SYCaseVo vo) {
		return caseDAO.selectCaseMngSub(vo);
	}

	public String insertCaseMng(SYCaseVo vo, List<SYCaseVo> rpuserDatas) {
		int result = 0;
		
		result = caseDAO.insertCaseMng(vo);	
		// service_processes_tbl
		// 새로 등록 OPEN
		vo.setAdmin_level_type_code("alt_05");
		vo.setRequest_id(vo.getKeyData());
		result = caseDAO.insertCaseMng_new(vo);
		
		String keydata = vo.getKeyData();
		
		//
		if(rpuserDatas.size() > 0) {
			for(int i=0; i<rpuserDatas.size(); i++) {
				rpuserDatas.get(i).setRequest_id(vo.getKeyData());
			}
			insertReference_user(rpuserDatas);
		} else {
			caseDAO.deleteReference_user_all(vo);
		}
		//
		
		// approver_id
		if( "MD1266".equals(vo.getStatus()) ){
			vo.setRequester_id(vo.getOwner_id());
			vo.setRequester_nm(vo.getOwner_nm());
			result = caseDAO.insertApprover_history(vo);
		}
		return keydata;
	}
	
	public List<SYCaseVo> selectReference_user(SYCaseVo vo) {
		return caseDAO.selectReference_user(vo);
	}
	public List<SYCaseVo> selectPartner_user(SYCaseVo vo) {
		return caseDAO.selectPartner_user(vo);
	}
	
	public int insertReference_user(List<SYCaseVo> rpuserDatas) {
		caseDAO.deleteReference_user_all(rpuserDatas.get(0));
		return caseDAO.insertReference_user(rpuserDatas);
	}
	
	public int insertPartner_user(List<SYCaseVo> prtuserDatas) {
		caseDAO.deletePartner_user_all(prtuserDatas.get(0));
		return caseDAO.insertPartner_user(prtuserDatas);
	}
	
	public int deleteReference_user_all(SYCaseVo vo) {
		return caseDAO.deleteReference_user_all(vo);
	}
	
	public int updateCaseMng(SYCaseVo vo) {
		int result = 0;
		result = caseDAO.updateCaseMng(vo);

		// service_processes_tbl
		result = caseDAO.updateCaseMng_new(vo);
		return result;
	}
	
	public int deleteCaseMng(SYCaseVo vo) {
		int result = 0;
		result = caseDAO.deleteCaseMng(vo);

		// service_processes_tbl
		result = caseDAO.deleteCase(vo);
		return result;
	}
	
	// appr = 현재는 서브만
	public int apprCancelCase(SYCaseVo vo) {
		int result = 0;
		result = caseDAO.deleteApprover_history(vo); // history 삭제
		
		SYRqstMngVo apVo = new SYRqstMngVo();
		apVo.setRequest_id(vo.getRequest_id());
		apVo.setService_process_id(vo.getService_process_id());
		
		List<SYRqstMngVo> apList = incidentDAO.selectApprover_history(apVo);
		
		vo.setComment("");
		vo.setApprover_id("");
		vo.setApprover_nm("");
		vo.setStatus("MD1256");
		vo.setKeyData("cancelAppr");
		
		// 그 전이 승인완료 된 값이면 (MD1267) > 반려(MD1268) X
		if(apList.size() > 0) {
			vo.setComment(apList.get( apList.size()-2 ).getComment());
			vo.setApprover_id(apList.get( apList.size()-2 ).getApprover_id());
			vo.setApprover_nm(apList.get( apList.size()-2 ).getApprover_nm());
			vo.setStatus( apList.get( apList.size()-1 ).getStatus() );
		}
		// service_processes_tbl
		result = caseDAO.apprCancelCase(vo); // 해당 case 이전 값으로 변경 + appr 삭제. 
		
		return result;
	}
	
	// 메인
	public int apprCancelCase_header(SYCaseVo vo) throws Exception {
		int result = 0;
		result = caseDAO.deleteApprover_history(vo); // history 삭제
		
		SYRqstMngVo apVo = new SYRqstMngVo();
		apVo.setRequest_id(vo.getRequest_id());
		apVo.setService_process_id(vo.getService_process_id());
		
		List<SYRqstMngVo> apList = incidentDAO.selectApprover_history(apVo);
		
		String newCase_created = vo.getDate_created();
		String apprHis_created = "";
		
		vo.setComment("");
		vo.setApprover_id("");
		vo.setApprover_nm("");
		vo.setStatus("MD1256");
		vo.setKeyData("cancelAppr");
		
		// ★
		// 22 03 03
		// 7번기능.
		// 요청 회수를 하면 무조건 진행중 MD1256이 아님.
		// 반려 후에도 다시 요청이 가능하기에.
		// new case로 만들어진 마지막 case의 생성일자
		// 마지막 appr his 값이 반려이고 저장된 날짜 
		// 를 대조해서 appr his 반려일이 더 최신이면 반려 상태로 변경, new case가 최신이면 MD1256 ㄱ
		
		// new_1 > svcData 모든 case
		// appr 반려.
		// 걍 여기서 다 조회하자 ㅇㅇ
		
		// 그 전이 승인완료 된 값이면 (MD1267) > 반려(MD1268) X
		if(apList.size() > 0) {
			apprHis_created = apList.get( apList.size()-1 ).getDate_created();
			String gtStatus = apList.get( apList.size()-1 ).getStatus();
			
//			System.out.println("gtStatus = " + gtStatus);
			
			Date currentTime = new Date ();
		    SimpleDateFormat SimpleDateFormat  = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss");            
		    SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");            
		    Date d1 = f.parse( apprHis_created.substring(0, 19) ); // "2019-12-06 15:00:00");
		    Date d2 = f.parse( newCase_created.substring(0, 19) );
			
			// 반려인데 apprHis마지막 값이 new case 생성일자보다 최신이거나 같으면
			if( "MD1268".equals(gtStatus) &&  d1.compareTo(d2) >= 0 ) { 
//		        System.out.println("d1값이 d2보다 크거나 같음.");
		        vo.setComment(apList.get( apList.size()-2 ).getComment());
				vo.setApprover_id(apList.get( apList.size()-2 ).getApprover_id());
				vo.setApprover_nm(apList.get( apList.size()-2 ).getApprover_nm());
				vo.setStatus( gtStatus );
			}
		}
//		System.out.println("apprHis_created = " + apprHis_created);
//		System.out.println("newCase_created = " + newCase_created);
		
		// service_processes_tbl
		result = caseDAO.apprCancelCase(vo); // 해당 case 이전 값으로 변경 + appr 삭제. 
		
		vo.setKeyData("comment");
		caseDAO.updateRequestMng_status(vo);
		
		//
		// > 메인이면
		/*
		// + 위랑 같은 코드 쓴 다음 if문
		if("SER_00".equals( vo.getService_process_id() )) {
			vo.setKeyData("comment");
			caseDAO.updateRequestMng_status(vo);
		}
		 */
		//
		
		return result;
	}
	
	public int updateCaseMngConfirm_status(SYCaseVo vo) {
		int result = 0;
		System.out.println("vo.getStatus() = " + vo.getStatus());
		if( "MD1269".equals(vo.getStatus()) || "MD1270".equals(vo.getStatus()) ){
			vo.setComment(vo.getRep_comment());
			// rq_service_process_id > Confirm 보낸 id
			result = caseDAO.insertCollaboration_history(vo); // 협업 답 등록
			
			vo.setStatus("MD1256");
			// SER_00
			vo.setService_process_id("SER_00");
			result = caseDAO.updateRequestMng_status(vo);	// mng  상태 변경
			result = caseDAO.updateCase_status(vo); 		// sub-0 상태 변경
		}
		return result;
	}
	
	public int updateCaseMngAppr_status(SYCaseVo vo) {
		int result = 0;
		vo.setComment(vo.getReq_comment());
			result = caseDAO.updateCaseMng(vo); // updateSvcPrcs_appr(vo);
			result = caseDAO.updateRequestMng_status(vo);	// mng  상태 변경
			result = caseDAO.updateCase_status(vo); 		// sub-0 상태 변경
			// approver_id, comment, status
			result = caseDAO.insertApprover_history(vo);
		return result;
	}
	
	public List<SYCaseVo> selectHeader(SYCaseVo vo) {
		return caseDAO.selectHeader(vo);
	}
	
	public List<SYCaseVo> selectSub(SYCaseVo vo) {
		return caseDAO.selectSub(vo);
	}
	
	public List<SYCaseVo> selectDetail(SYCaseVo vo) {
		return caseDAO.selectDetail(vo);
	}
	

	public List<SYCaseVo> selectApprHeader(SYCaseVo vo) {
		return caseDAO.selectApprHeader(vo);
	}
	public List<SYCaseVo> selectApprSub(SYCaseVo vo) {
		return caseDAO.selectApprSub(vo);
	}
	
	public int insertCase(SYCaseVo vo, List<SYCaseVo> prtuserDatas) { // rpuserDatas Case
		int result = 0;
		
		if ( "alt_12".equals(vo.getAdmin_level_type_code()) ) {
			vo.setN_owner_id(vo.getApprover_id());
			vo.setN_owner_nm(vo.getApprover_nm());
			vo.setApprover_id("");
			vo.setApprover_nm("");
		}
		result = caseDAO.insertCase(vo);
		
		if(prtuserDatas.size() > 0) {
			for(int i=0; i<prtuserDatas.size(); i++) {
				String service_process_id = "SER_"+ String.format("%02d", Integer.valueOf(vo.getKeyData()) ); 
				prtuserDatas.get(i).setService_process_id(service_process_id);
				prtuserDatas.get(i).setService_process_seq(vo.getKeyData());
			}
			insertPartner_user(prtuserDatas);
		} else {
			caseDAO.deletePartner_user_all(vo);
		}
		
		SYCaseVo vo0 = new SYCaseVo();
		vo0.setStatus("MD1256"); // 진행중
		vo0.setAdmin_level_type_code(vo.getAdmin_level_type_code());
		vo0.setRequest_id(vo.getRequest_id());
		vo0.setUpdater(vo.getUpdater());
		vo0.setService_process_id("SER_00");
		
		// 승인 요청이면 
		if( "MD1266".equals(vo.getStatus()) ){
			// CONCAT( 'SER_', LPAD( #{keyData}, 2, '0' ) )
			String service_process_id = "SER_"+ String.format("%02d", Integer.valueOf(vo.getKeyData()) ); 
			vo.setService_process_id(service_process_id);
			vo.setRequester_id(vo.getOwner_id());
			vo.setRequester_nm(vo.getOwner_nm());
			result = caseDAO.insertApprover_history(vo);
			
			vo0.setApprover_id(vo.getApprover_id());
			vo0.setApprover_nm(vo.getApprover_nm());
			vo0.setComment(vo.getComment());
		} else if ( "alt_12".equals(vo.getAdmin_level_type_code()) ) {
			vo0.setStatus("MD1269"); // 협업 요청
			
			String service_process_id = "SER_"+ String.format("%02d", Integer.valueOf(vo.getKeyData()) ); 
			vo.setService_process_id(service_process_id);
			vo.setRequester_id(vo.getOwner_id());
			vo.setRequester_nm(vo.getOwner_nm());
			// 맨 처음 헤더 만든 사람.
			// approver_id, approver_nm
			vo.setApprover_id(vo.getN_owner_id());
			vo.setApprover_nm(vo.getN_owner_nm());
			
			result = caseDAO.insertCollaboration_history(vo);
			vo0.setApprover_id(vo.getOwner_id());
			vo0.setApprover_nm(vo.getOwner_nm());
			vo0.setComment(vo.getComment());
		}
		
		// 0번째랑 request_management_tbl update
		caseDAO.updateCase_status(vo0); // admin_level_type_code
		caseDAO.updateRequestMng_status(vo0);
		// 전체 변경
		result = caseDAO.updateCase_case(vo);
		result = caseDAO.updateRequestMng_case(vo);
		result = caseDAO.maxRequestSeq(vo); // 미션중 추가
		
		return result;
	}
	
	public int insertPartnerCase(SYCaseVo vo) {
		int result = 0;
		
		result = caseDAO.insertPartnerCase(vo);
		
		SYCaseVo vo0 = new SYCaseVo();
		vo0.setStatus("MD1256"); // 진행중
		vo0.setAdmin_level_type_code(vo.getAdmin_level_type_code());
		vo0.setRequest_id(vo.getRequest_id());
		vo0.setUpdater(vo.getUpdater());
		vo0.setService_process_id("SER_00");
		
		// 0번째랑 request_management_tbl update
		caseDAO.updateCase_status(vo0); // admin_level_type_code
		caseDAO.updateRequestMng_status(vo0);
		// 전체 변경 > 하는거 없음.
//		result = caseDAO.updateCase_case(vo);
//		result = caseDAO.updateRequestMng_case(vo);
		
		return result;
	}
	
	public int updatePartnerCase(SYCaseVo vo) {
		int result = caseDAO.updatePartnerCase(vo);
		return result;
	}
	
	public int updateCase_header(SYCaseVo vo) {
		// 0번째랑 request_management_tbl update
		int result = caseDAO.updateCase_status(vo);
		result = caseDAO.updateRequestMng_status(vo);
			
		// 승인 요청이면 
		if( "MD1267".equals(vo.getStatus()) || "MD1268".equals(vo.getStatus()) ){ // 승인, 반려
			vo.setComment(vo.getRep_comment());
			result = caseDAO.insertApprover_history(vo);
		}
		return result;
	}
	
	public int updateCase_header_all(SYCaseVo vo) {
		// all과 request_management_tbl update
		int result = caseDAO.updateCase_status(vo);
		result = caseDAO.updateRequestMng_status(vo);
		
		result = caseDAO.updateCase_case(vo);
		result = caseDAO.updateRequestMng_case(vo);
		
		// 승인 요청이면 
		if( "MD1267".equals(vo.getStatus()) || "MD1268".equals(vo.getStatus()) ){ // 승인, 반려
			vo.setComment(vo.getRep_comment());
			result = caseDAO.insertApprover_history(vo);
		}
		return result;
	}
	
	public int updateCase(SYCaseVo vo, List<SYCaseVo> prtuserDatas) {
		int result = caseDAO.updateCase(vo);
		
		if(prtuserDatas.size() > 0) {
			insertPartner_user(prtuserDatas);
		} else {
			caseDAO.deletePartner_user_all(vo);
		}
		
		result = caseDAO.updateCase_case(vo);
		result = caseDAO.updateRequestMng_case(vo);
		
		// 승인 요청이면 
		if( "MD1266".equals(vo.getStatus()) ){
			result = caseDAO.insertApprover_history(vo);
		} else if( "MD1267".equals(vo.getStatus()) || "MD1268".equals(vo.getStatus()) ){ // 승인, 반려
			vo.setComment(vo.getRep_comment());
			result = caseDAO.insertApprover_history(vo);
		}
		return result;
	}
	
	public int updateApprCase(SYCaseVo vo) {
		int result = caseDAO.updateApprCase(vo);
		vo.setComment(vo.getRep_comment());
		result = caseDAO.insertApprover_history(vo);
		
		return result;
	}
	
	public int updateCase_status(SYCaseVo vo) {
		// 0번째랑 request_management_tbl update
		int result = caseDAO.updateCase_status(vo);
		result = caseDAO.updateRequestMng_status(vo);
		return result;
	}

	public int deleteCase(SYCaseVo vo) {
		// 해당 sub case
		int result = 0;
		result = caseDAO.deleteCase(vo);
		caseDAO.deletePartner_user_all(vo); // 해당 case에 있을 수 있음.
		
		// 삭제시 
//		마지막 가져오기
		SYCaseVo vo2 = new SYCaseVo();
		vo2.setRequest_id(vo.getRequest_id());
		List<SYCaseVo> listSvcPrss = caseDAO.selectDetail(vo);
		
		String levelCode = listSvcPrss.get( listSvcPrss.size()-1 ).getAdmin_level_type_code();
		
		if(listSvcPrss.size() == 1) {
			levelCode = "alt_05";
		}
		
		String status = listSvcPrss.get( 0 ).getStatus();
		
		
		SYCaseVo vo3 = new SYCaseVo();
		vo3.setStatus(status);
		vo3.setAdmin_level_type_code(levelCode);
		vo3.setUpdater(vo.getUpdater());
		vo3.setRequest_id(vo.getRequest_id());
		vo3.setService_process_id("SER_00");
		
		caseDAO.updateCase_status(vo3); // admin_level_type_code
		
		// 메인
//		incidentDAO.updateRequestMng_status(vo);
		// 첫번째 변경
//		vo.setService_process_id("SER_00");
//		incidentDAO.updateSvcPrcs_status_comment_no(vo);
		
		return result;
	}

	public List<SYCaseVo> loadWait(SYCaseVo vo) {
		return caseDAO.loadWait(vo);
	}
	public List<SYCaseVo> loadCaseCount_q(SYCaseVo vo) {
		return caseDAO.loadCaseCount_q(vo);
	}
	
	public List<SYCaseVo> loadChart1(SYCaseVo vo) {
		return caseDAO.loadChart1(vo);
	}
	public List<SYCaseVo> loadChart2(SYCaseVo vo) {
		return caseDAO.loadChart2(vo);
	}
	public List<SYCaseVo> loadChart3(SYCaseVo vo) {
		return caseDAO.loadChart3(vo);
	}
	public List<SYCaseVo> loadChart4(SYCaseVo vo) {
		return caseDAO.loadChart4(vo);
	}
	public List<SYCaseVo> loadChart6(SYCaseVo vo) {
		return caseDAO.loadChart6(vo);
	}
	
	public List<SYCaseVo> selectMailSendQueueUserList(SYCaseVo caseVo) {
		return caseDAO.selectMailSendQueueUserList(caseVo);
	}
	
	public List<SYCaseVo> selectSysInfoCountList(SYCaseVo syVo) {
		return caseDAO.selectSysInfoCountList(syVo);
	}
	
	public String mailSending_1() {
	    JSONObject resultData = new JSONObject();
	    
	    try {
	    	Properties props = new Properties();
	    	props.put("mail.smtp.host", "vieworks-com.mail.protection.outlook.com");
	    	props.put("mail.smtp.port", "25");
	    	props.put("mail.smtp.auth", "true");
	    	props.put("mail.smtp.starttls.enable", "true");
	    	props.put("mail.smtp.ssl.trust", "vieworks-com.mail.protection.outlook.com");
	    	props.put("mail.smtp.socketFactory.port", "25");
	    	props.put("mail.debug", "true");
	    	props.put("mail.smtp.ssl.protocols", "TLSv1.2");
	    	props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory"); 
	
		    // 사용자 인증
		    Session send_session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			   	protected javax.mail.PasswordAuthentication getPasswordAuthentication(){
			    	return new javax.mail.PasswordAuthentication("smtp@vieworks.com", "vieworksservice");
			   	}
		    });
		    System.out.println("인증??");
		    send_session.setDebug(true);
	    	
		    
		    SYCaseVo caseVo = new SYCaseVo();
	    	caseVo.setCompany_gubun_code("MD1242");
	    	List<SYCaseVo> userList = selectMailSendQueueUserList(caseVo);
	    	
	    	if(userList.size() > 0) {
	    		for(int i=0; i<userList.size(); i++) {
	    			String content = "";    // 내용
	    		
				    SYCaseVo vo = userList.get(i);
				    
				    String user_email = vo.getUser_email();
				    
				    SYCaseVo syVo = new SYCaseVo();
				    syVo.setUser_id( vo.getUser_id() );
				    List<SYCaseVo> syListCase = selectSysInfoCountList(syVo);
					
				    int openValue = 0;
				    if(syListCase.size() > 0) {
					    for(int j=0; j<syListCase.size(); j++) {
							SYCaseVo vo2 = syListCase.get(j);
							openValue += Integer.parseInt(vo2.getValue1());
					    }
				    }
				    
				    if( openValue > 0 ) {
						Message mimeMessage = new MimeMessage(send_session); //MimeMesage 생성
						mimeMessage.setFrom(new InternetAddress("itss@vieworks.com")); // 보내는 EMAIL (정확히 적어야 SMTP 서버에서 인증 실패되지 않음)
						mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(user_email)); // 받는 email
						
						mimeMessage.setSubject("[ITSS] Case 미확인 항목 안내"); // 제목
						
						mimeMessage.setContent(new MimeMultipart());
						
						Multipart mp = (Multipart) mimeMessage.getContent();
						
						content += "<html>"+
					            "<head>"+
					            "<title></title>"+
					            "</head>"+
					            "<style>"+
					            "body {font-size:11pt; font-family:arial}table {font-size:11pt; font-family:Verdana;color:black}A {text-decoration:none;color:#999999;}A:hover {color:red;text-decoration:none;}td.main {text-align:center;font-weight:bold;border-bottom:#dddddd 1px solid;background-color:#F8F8F8}.title {text-decoration:underline;}"+
					            "</style>"+
					            "<body bgcolor='#ffffff'>"+
								"[발신 전용 Email 이므로 회신이 불가능합니다.]<br><br><br>"+
								
								"미확인 Case 건수를 아래와 같이 공유드리오니<br>담당자분들은 해당 Case를 확인하여 주시기 바랍니다.<br><br>"+ 
								
								//
								"<table border='1' cellspacing='0' cellpadding='0' style='border-collapse:collapse;'>"+ 
									"<tr style='height:16.5pt; text-align: center;'>"+ 
										"<td style='min-width:26.0pt; background:#e2efda; padding:0cm 4.95pt 0cm 4.95pt;height:16.5pt'>"+ 
											"No"+ 
										"</td>"+ 
										"<td style='min-width:242.0pt; background:#e2efda; padding:0cm 4.95pt 0cm 4.95pt;height:16.5pt'>"+ 
											"작업 대상"+ 
										"</td>"+ 
										"<td style='min-width:69.0pt; background:#e2efda; padding:0cm 4.95pt 0cm 4.95pt;height:16.5pt'>"+ 
											"Open 건수"+ 
										"</td>"+ 
									"</tr>";
								//
								int caseHapValue = 0;
								// for 문 해서 건수 보여주기.
//					            "System1 : xxx 건<br>"+
//								"System2 : xxx 건<br>"+
								for(int j=0; j<syListCase.size(); j++) {
									SYCaseVo vo2 = syListCase.get(j);
									// INNER JOIN 으로 바꿔서 할 필요 없는 if문.. << 후에 같은 queue 의 sysinfo라 해도 0건이면 안보이게 조건 가능
//									if( !"".equals(vo2.getQueue_code()) ){
//									content += vo2.getSystem_info_nm() +" : " + vo2.getValue1() + " 건<br>";
//									
									caseHapValue += Integer.parseInt(vo2.getValue1());
									content += ""+ 
									"<tr style='height:16.5pt; text-align: center;'>"+ 
										"<td style='padding:0cm 4.95pt 0cm 4.95pt;'>"+ (j+1) +"</td>"+ 
										"<td style='text-align: left; padding: 0cm 4.95pt 0cm 4.95pt;'>"+ vo2.getSystem_info_nm() +"</td>"+ 
										"<td style=' padding:0cm 4.95pt 0cm 4.95pt;'>"+ vo2.getValue1() +"</td>"+ 
									"</tr>";
								}
					            
								content += "<tr style='height:16.5pt; text-align: center;'>"+ 
										"<td colspan='2'>합계</td>"+ 
										"<td>"+ caseHapValue +"</td>"+ 
									"</tr>"+ 
								"</table>"+ 
								
								"<br><br>"+ 
								
								"Case Link : " + 
					            "<a target=\"_blank\" href=\"" + "https://itss.vieworks.com/frontend/location/menus/case_admin_list" + 
					            "\" style='text-decoration:underline;color: #DC143C;'>Case 처리</a>"+
					            "<br>"+
					            "</body>"+
					            "</html>";
						
						mp.addBodyPart(getContents(content));
						
						Transport.send(mimeMessage);
				    }
	    		}
	    	}
			System.out.println("메일완료");
		} catch (MessagingException me) {
			me.printStackTrace();
	    } catch(Exception e){
	    	System.out.println(e);
	    }
		return resultData.toJSONString();
	}

	private static BodyPart getContents(String html) throws MessagingException {
		BodyPart mbp = new MimeBodyPart();
		// setText를 이용할 경우 일반 텍스트 내용으로 설정된다.
		// mbp.setText(html);
		// html 형식으로 설정
		mbp.setContent(html, "text/html; charset=utf-8");
		return mbp;
	}

	public List<SYCaseDashBoardVo> stepCntSelect(SYCaseDashBoardVo vo) { // itts_dashboard 시작
		return caseDAO.stepCntSelect(vo);
	}

	public List<SYCaseDashBoardVo> stepAverageSelect(SYCaseDashBoardVo vo) {
		return caseDAO.stepAverageSelect(vo);
	}

	public List<SYCaseDashBoardVo> stepDtlSelect(SYCaseDashBoardVo vo) {
		return caseDAO.stepDtlSelect(vo);
	}

	public List<SYCaseDashBoardVo> weekOccurSelect(SYCaseDashBoardVo vo) {
		return caseDAO.weekOccurSelect(vo);
	}

	public List<SYCaseDashBoardVo> weekOccurDtlSelect(SYCaseDashBoardVo vo) {
		return caseDAO.weekOccurDtlSelect(vo);
	}

	public List<SYCaseDashBoardVo> weekCmpSelect(SYCaseDashBoardVo vo) {
		return caseDAO.weekCmpSelect(vo);
	}
	
	public List<SYCaseDashBoardVo> weekCmpDtlSelect(SYCaseDashBoardVo vo) {
		return caseDAO.weekCmpDtlSelect(vo);
	}

	public List<SYCaseDashBoardVo> systemWeekOccurSelect(SYCaseDashBoardVo vo) {
		return caseDAO.systemWeekOccurSelect(vo);
	}

	public List<SYCaseDashBoardVo> systemWeekCmpSelect(SYCaseDashBoardVo vo) {
		return caseDAO.systemWeekCmpSelect(vo);
	}

	public List<SYCaseDashBoardVo> systemWeekOccurDtlSelect(SYCaseDashBoardVo vo) {
		return caseDAO.systemWeekOccurDtlSelect(vo);
	}

	public List<SYCaseDashBoardVo> systemWeekCmpDtlSelect(SYCaseDashBoardVo vo) {
		return caseDAO.systemWeekCmpDtlSelect(vo);
	}

	public List<SYCaseDashBoardVo> systemQuarterSelect(SYCaseDashBoardVo vo) {
		return caseDAO.systemQuarterSelect(vo);
	}

	public List<SYCaseDashBoardVo> systemQuarterDtlSelect(SYCaseDashBoardVo vo) {
		return caseDAO.systemQuarterDtlSelect(vo);
	}

	public List<SYCaseDashBoardVo> ctrlWeekSelect(SYCaseDashBoardVo vo) {
		return caseDAO.ctrlWeekSelect(vo);
	}

	public List<SYCaseDashBoardVo> ctrlWeekDtlSelect(SYCaseDashBoardVo vo) {
		return caseDAO.ctrlWeekDtlSelect(vo);
	}

	public List<SYCaseDashBoardVo> caseAverageTime(SYCaseDashBoardVo vo) {
		return caseDAO.caseAverageTime(vo);
	}
	
}