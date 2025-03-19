package kr.co.inssuf.itsm.vo;

import java.io.Serializable;

public class SYCaseVo implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String cmd; 
	private String ordY;
	private String hap_search;
	private String system_info_codes; // In 조건
	private String keyData;
	
	private String member_id;
	private String member_nm;
	
	// 최근 등록자
	private String n_owner_id;
	private String n_owner_nm;
	
	// 최근 승인자
	private String n_approver_id;
	private String n_approver_nm;
	
	// 최근 협업 신청자
//	private String n_collabo_id;
//	private String n_collabo_nm;
	
	private String apprStatus;
	private String allApprCount;
	
	// 
	private String request_id;
	private String request_nm;
	
	private String request_date;
	private String requester_id;
	private String requester_nm;
	private String system_info_code;
	private String system_info_nm;
	
	private String request_type_code;
	private String request_type;
	private String request_category;
	private String request_category_item;
	
	private String request_type_nm;
	private String request_category_nm;
	private String request_category_item_nm;
	
	private String title;
	private String context;
	private String status;
	private String status_nm;
	private String req_comment;
	private String rep_comment;
	private String comment;
	private String use_yn;
	private String creator;
	private String updater;
	private String date_created;
	private String date_updated;
	
	// service_processes_tbl
	private String request_seq;
	private String service_process_id;
	private String service_process_seq;
	private String process_date;
	private String owner_id;
	private String owner_nm;
	
	private String admin_level_type_code;
	private String admin_level_type_nm;
	private String user_level_type_code;
	private String user_level_type_nm;
	private String processed_type_code;
	private String processed_type_nm;
	private String approver_id;
	private String approver_nm;
	
	private String file_group;
	private String file_path; 
	private String file_name; 
	private String file_no;
	
	private String collaboration_history_seq;
	
	private String plan_due_date;
	private String request_due_date;
	private String priority_code;
	private String priority_nm;
	
	private String control_gubun;
	private String control_gubun_nm;
	private String dept_owner_id;
	
	private String value1;
	private String value2;
	private String value3;
	
	private String queue_code;
	private String queue_nm;
	
	private String user_no;
	private String user_id;
	private String user_nm;
	
	// user
	private String user_email;
	private String user_pwd;
	private String user_nm_en;
	private String company_gubun_code; 
	private String company_gubun_nm;
	
	private String company_code;
	private String company_nm;
	
	private String phone_no;
	private String class_code;
	private String class_nm;
	
	private String mobile;
	private String business_reg_num;
	private String init_yn;
	private String pwd_chg_date;
	private String user_lang;
	
	// 페이지
	private Integer page;
	private Integer rows;
	private Integer rnum;
	private String sidx;
	private String sord;
	
	private String dept_cd;
	private String dept_nm;
	private String dept_yn;
	private String dept_gubun;
	
	private String partner_id;
	private String partner_nm;
	
	private String subCaseLength;
	private String subCaseLst;
	
	private String dateCode;
	
	public String getControl_gubun_nm() {
		return control_gubun_nm;
	}
	public void setControl_gubun_nm(String control_gubun_nm) {
		this.control_gubun_nm = control_gubun_nm;
	}
	public String getCmd() {
		return cmd;
	}
	public String getOrdY() {
		return ordY;
	}
	public String getHap_search() {
		return hap_search;
	}
	public String getSystem_info_codes() {
		return system_info_codes;
	}
	public String getKeyData() {
		return keyData;
	}
	public String getMember_id() {
		return member_id;
	}
	public String getMember_nm() {
		return member_nm;
	}
	public String getN_owner_id() {
		return n_owner_id;
	}
	public String getN_owner_nm() {
		return n_owner_nm;
	}
	public String getN_approver_id() {
		return n_approver_id;
	}
	public String getN_approver_nm() {
		return n_approver_nm;
	}
	public String getApprStatus() {
		return apprStatus;
	}
	public String getAllApprCount() {
		return allApprCount;
	}
	public String getRequest_id() {
		return request_id;
	}
	public String getRequest_nm() {
		return request_nm;
	}
	public String getRequest_date() {
		return request_date;
	}
	public String getRequester_id() {
		return requester_id;
	}
	public String getRequester_nm() {
		return requester_nm;
	}
	public String getSystem_info_code() {
		return system_info_code;
	}
	public String getSystem_info_nm() {
		return system_info_nm;
	}
	public String getRequest_type_code() {
		return request_type_code;
	}
	public String getRequest_type() {
		return request_type;
	}
	public String getRequest_category() {
		return request_category;
	}
	public String getRequest_category_item() {
		return request_category_item;
	}
	public String getRequest_type_nm() {
		return request_type_nm;
	}
	public String getRequest_category_nm() {
		return request_category_nm;
	}
	public String getRequest_category_item_nm() {
		return request_category_item_nm;
	}
	public String getTitle() {
		return title;
	}
	public String getContext() {
		return context;
	}
	public String getStatus() {
		return status;
	}
	public String getStatus_nm() {
		return status_nm;
	}
	public String getReq_comment() {
		return req_comment;
	}
	public String getRep_comment() {
		return rep_comment;
	}
	public String getComment() {
		return comment;
	}
	public String getUse_yn() {
		return use_yn;
	}
	public String getCreator() {
		return creator;
	}
	public String getUpdater() {
		return updater;
	}
	public String getDate_created() {
		return date_created;
	}
	public String getDate_updated() {
		return date_updated;
	}
	public String getRequest_seq() {
		return request_seq;
	}
	public String getService_process_id() {
		return service_process_id;
	}
	public String getService_process_seq() {
		return service_process_seq;
	}
	public String getProcess_date() {
		return process_date;
	}
	public String getOwner_id() {
		return owner_id;
	}
	public String getOwner_nm() {
		return owner_nm;
	}
	public String getAdmin_level_type_code() {
		return admin_level_type_code;
	}
	public String getAdmin_level_type_nm() {
		return admin_level_type_nm;
	}
	public String getUser_level_type_code() {
		return user_level_type_code;
	}
	public String getUser_level_type_nm() {
		return user_level_type_nm;
	}
	public String getProcessed_type_code() {
		return processed_type_code;
	}
	public String getProcessed_type_nm() {
		return processed_type_nm;
	}
	public String getApprover_id() {
		return approver_id;
	}
	public String getApprover_nm() {
		return approver_nm;
	}
	public String getFile_group() {
		return file_group;
	}
	public String getFile_path() {
		return file_path;
	}
	public String getFile_name() {
		return file_name;
	}
	public String getFile_no() {
		return file_no;
	}
	public String getCollaboration_history_seq() {
		return collaboration_history_seq;
	}
	public String getPlan_due_date() {
		return plan_due_date;
	}
	public String getRequest_due_date() {
		return request_due_date;
	}
	public String getPriority_code() {
		return priority_code;
	}
	public String getPriority_nm() {
		return priority_nm;
	}
	public String getControl_gubun() {
		return control_gubun;
	}
	public String getDept_owner_id() {
		return dept_owner_id;
	}
	public String getValue1() {
		return value1;
	}
	public String getValue2() {
		return value2;
	}
	public String getValue3() {
		return value3;
	}
	public String getQueue_code() {
		return queue_code;
	}
	public String getQueue_nm() {
		return queue_nm;
	}
	public String getUser_no() {
		return user_no;
	}
	public String getUser_id() {
		return user_id;
	}
	public String getUser_nm() {
		return user_nm;
	}
	public String getUser_email() {
		return user_email;
	}
	public String getUser_pwd() {
		return user_pwd;
	}
	public String getUser_nm_en() {
		return user_nm_en;
	}
	public String getCompany_gubun_code() {
		return company_gubun_code;
	}
	public String getCompany_gubun_nm() {
		return company_gubun_nm;
	}
	public String getCompany_code() {
		return company_code;
	}
	public String getCompany_nm() {
		return company_nm;
	}
	public String getPhone_no() {
		return phone_no;
	}
	public String getClass_code() {
		return class_code;
	}
	public String getClass_nm() {
		return class_nm;
	}
	public String getMobile() {
		return mobile;
	}
	public String getBusiness_reg_num() {
		return business_reg_num;
	}
	public String getInit_yn() {
		return init_yn;
	}
	public String getPwd_chg_date() {
		return pwd_chg_date;
	}
	public String getUser_lang() {
		return user_lang;
	}
	public Integer getPage() {
		return page;
	}
	public Integer getRows() {
		return rows;
	}
	public Integer getRnum() {
		return rnum;
	}
	public String getSidx() {
		return sidx;
	}
	public String getSord() {
		return sord;
	}
	public String getDept_cd() {
		return dept_cd;
	}
	public String getDept_nm() {
		return dept_nm;
	}
	public String getDept_yn() {
		return dept_yn;
	}
	public String getDept_gubun() {
		return dept_gubun;
	}
	public String getPartner_id() {
		return partner_id;
	}
	public String getPartner_nm() {
		return partner_nm;
	}
	public String getSubCaseLength() {
		return subCaseLength;
	}
	public String getSubCaseLst() {
		return subCaseLst;
	}
	public String getDateCode() {
		return dateCode;
	}
	public void setCmd(String cmd) {
		this.cmd = cmd;
	}
	public void setOrdY(String ordY) {
		this.ordY = ordY;
	}
	public void setHap_search(String hap_search) {
		this.hap_search = hap_search;
	}
	public void setSystem_info_codes(String system_info_codes) {
		this.system_info_codes = system_info_codes;
	}
	public void setKeyData(String keyData) {
		this.keyData = keyData;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public void setMember_nm(String member_nm) {
		this.member_nm = member_nm;
	}
	public void setN_owner_id(String n_owner_id) {
		this.n_owner_id = n_owner_id;
	}
	public void setN_owner_nm(String n_owner_nm) {
		this.n_owner_nm = n_owner_nm;
	}
	public void setN_approver_id(String n_approver_id) {
		this.n_approver_id = n_approver_id;
	}
	public void setN_approver_nm(String n_approver_nm) {
		this.n_approver_nm = n_approver_nm;
	}
	public void setApprStatus(String apprStatus) {
		this.apprStatus = apprStatus;
	}
	public void setAllApprCount(String allApprCount) {
		this.allApprCount = allApprCount;
	}
	public void setRequest_id(String request_id) {
		this.request_id = request_id;
	}
	public void setRequest_nm(String request_nm) {
		this.request_nm = request_nm;
	}
	public void setRequest_date(String request_date) {
		this.request_date = request_date;
	}
	public void setRequester_id(String requester_id) {
		this.requester_id = requester_id;
	}
	public void setRequester_nm(String requester_nm) {
		this.requester_nm = requester_nm;
	}
	public void setSystem_info_code(String system_info_code) {
		this.system_info_code = system_info_code;
	}
	public void setSystem_info_nm(String system_info_nm) {
		this.system_info_nm = system_info_nm;
	}
	public void setRequest_type_code(String request_type_code) {
		this.request_type_code = request_type_code;
	}
	public void setRequest_type(String request_type) {
		this.request_type = request_type;
	}
	public void setRequest_category(String request_category) {
		this.request_category = request_category;
	}
	public void setRequest_category_item(String request_category_item) {
		this.request_category_item = request_category_item;
	}
	public void setRequest_type_nm(String request_type_nm) {
		this.request_type_nm = request_type_nm;
	}
	public void setRequest_category_nm(String request_category_nm) {
		this.request_category_nm = request_category_nm;
	}
	public void setRequest_category_item_nm(String request_category_item_nm) {
		this.request_category_item_nm = request_category_item_nm;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public void setContext(String context) {
		this.context = context;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public void setStatus_nm(String status_nm) {
		this.status_nm = status_nm;
	}
	public void setReq_comment(String req_comment) {
		this.req_comment = req_comment;
	}
	public void setRep_comment(String rep_comment) {
		this.rep_comment = rep_comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	public void setCreator(String creator) {
		this.creator = creator;
	}
	public void setUpdater(String updater) {
		this.updater = updater;
	}
	public void setDate_created(String date_created) {
		this.date_created = date_created;
	}
	public void setDate_updated(String date_updated) {
		this.date_updated = date_updated;
	}
	public void setRequest_seq(String request_seq) {
		this.request_seq = request_seq;
	}
	public void setService_process_id(String service_process_id) {
		this.service_process_id = service_process_id;
	}
	public void setService_process_seq(String service_process_seq) {
		this.service_process_seq = service_process_seq;
	}
	public void setProcess_date(String process_date) {
		this.process_date = process_date;
	}
	public void setOwner_id(String owner_id) {
		this.owner_id = owner_id;
	}
	public void setOwner_nm(String owner_nm) {
		this.owner_nm = owner_nm;
	}
	public void setAdmin_level_type_code(String admin_level_type_code) {
		this.admin_level_type_code = admin_level_type_code;
	}
	public void setAdmin_level_type_nm(String admin_level_type_nm) {
		this.admin_level_type_nm = admin_level_type_nm;
	}
	public void setUser_level_type_code(String user_level_type_code) {
		this.user_level_type_code = user_level_type_code;
	}
	public void setUser_level_type_nm(String user_level_type_nm) {
		this.user_level_type_nm = user_level_type_nm;
	}
	public void setProcessed_type_code(String processed_type_code) {
		this.processed_type_code = processed_type_code;
	}
	public void setProcessed_type_nm(String processed_type_nm) {
		this.processed_type_nm = processed_type_nm;
	}
	public void setApprover_id(String approver_id) {
		this.approver_id = approver_id;
	}
	public void setApprover_nm(String approver_nm) {
		this.approver_nm = approver_nm;
	}
	public void setFile_group(String file_group) {
		this.file_group = file_group;
	}
	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}
	public void setFile_no(String file_no) {
		this.file_no = file_no;
	}
	public void setCollaboration_history_seq(String collaboration_history_seq) {
		this.collaboration_history_seq = collaboration_history_seq;
	}
	public void setPlan_due_date(String plan_due_date) {
		this.plan_due_date = plan_due_date;
	}
	public void setRequest_due_date(String request_due_date) {
		this.request_due_date = request_due_date;
	}
	public void setPriority_code(String priority_code) {
		this.priority_code = priority_code;
	}
	public void setPriority_nm(String priority_nm) {
		this.priority_nm = priority_nm;
	}
	public void setControl_gubun(String control_gubun) {
		this.control_gubun = control_gubun;
	}
	public void setDept_owner_id(String dept_owner_id) {
		this.dept_owner_id = dept_owner_id;
	}
	public void setValue1(String value1) {
		this.value1 = value1;
	}
	public void setValue2(String value2) {
		this.value2 = value2;
	}
	public void setValue3(String value3) {
		this.value3 = value3;
	}
	public void setQueue_code(String queue_code) {
		this.queue_code = queue_code;
	}
	public void setQueue_nm(String queue_nm) {
		this.queue_nm = queue_nm;
	}
	public void setUser_no(String user_no) {
		this.user_no = user_no;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public void setUser_nm(String user_nm) {
		this.user_nm = user_nm;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public void setUser_pwd(String user_pwd) {
		this.user_pwd = user_pwd;
	}
	public void setUser_nm_en(String user_nm_en) {
		this.user_nm_en = user_nm_en;
	}
	public void setCompany_gubun_code(String company_gubun_code) {
		this.company_gubun_code = company_gubun_code;
	}
	public void setCompany_gubun_nm(String company_gubun_nm) {
		this.company_gubun_nm = company_gubun_nm;
	}
	public void setCompany_code(String company_code) {
		this.company_code = company_code;
	}
	public void setCompany_nm(String company_nm) {
		this.company_nm = company_nm;
	}
	public void setPhone_no(String phone_no) {
		this.phone_no = phone_no;
	}
	public void setClass_code(String class_code) {
		this.class_code = class_code;
	}
	public void setClass_nm(String class_nm) {
		this.class_nm = class_nm;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public void setBusiness_reg_num(String business_reg_num) {
		this.business_reg_num = business_reg_num;
	}
	public void setInit_yn(String init_yn) {
		this.init_yn = init_yn;
	}
	public void setPwd_chg_date(String pwd_chg_date) {
		this.pwd_chg_date = pwd_chg_date;
	}
	public void setUser_lang(String user_lang) {
		this.user_lang = user_lang;
	}
	public void setPage(Integer page) {
		this.page = page;
	}
	public void setRows(Integer rows) {
		this.rows = rows;
	}
	public void setRnum(Integer rnum) {
		this.rnum = rnum;
	}
	public void setSidx(String sidx) {
		this.sidx = sidx;
	}
	public void setSord(String sord) {
		this.sord = sord;
	}
	public void setDept_cd(String dept_cd) {
		this.dept_cd = dept_cd;
	}
	public void setDept_nm(String dept_nm) {
		this.dept_nm = dept_nm;
	}
	public void setDept_yn(String dept_yn) {
		this.dept_yn = dept_yn;
	}
	public void setDept_gubun(String dept_gubun) {
		this.dept_gubun = dept_gubun;
	}
	public void setPartner_id(String partner_id) {
		this.partner_id = partner_id;
	}
	public void setPartner_nm(String partner_nm) {
		this.partner_nm = partner_nm;
	}
	public void setSubCaseLength(String subCaseLength) {
		this.subCaseLength = subCaseLength;
	}
	public void setSubCaseLst(String subCaseLst) {
		this.subCaseLst = subCaseLst;
	}
	public void setDateCode(String dateCode) {
		this.dateCode = dateCode;
	}
}
