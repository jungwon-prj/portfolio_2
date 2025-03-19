package kr.co.inssuf.itsm.vo;

import java.io.Serializable;

public class SYCaseDashBoardVo implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String request_id;
	private String request_type_nm;
	private String service_process_seq;
	private String system_info_nm;
	private String title;
	private String code_nm;
	private String owner_nm;
	private String n_owner_nm;
	private String admin_level_type_nm;
	private String admin_level_type_code;
	private String control_type_nm;
	private String request_Date;
	private String step_date;
	private String step_update;
	private String leadtime;
	private String date_created;
	private String date_updated;
	private String creator;
	private String updater;
	private String user_level_type_nm;
	private String user_level_type_code;
	private String use_yn;
	private String result;
	private String count;
	private String avgtime;
	private String START;
	private String END;
	private String start_date;
	private String end_date;
	private String date;
	private String quarter;
	
	
	
	
	public String getN_owner_nm() {
		return n_owner_nm;
	}
	public void setN_owner_nm(String n_owner_nm) {
		this.n_owner_nm = n_owner_nm;
	}
	public String getRequest_type_nm() {
		return request_type_nm;
	}
	public void setRequest_type_nm(String request_type_nm) {
		this.request_type_nm = request_type_nm;
	}
	public String getLeadtime() {
		return leadtime;
	}
	public void setLeadtime(String leadtime) {
		this.leadtime = leadtime;
	}
	public String getQuarter() {
		return quarter;
	}
	public void setQuarter(String quarter) {
		this.quarter = quarter;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	public String getSTART() {
		return START;
	}
	public void setSTART(String sTART) {
		START = sTART;
	}
	public String getEND() {
		return END;
	}
	public void setEND(String eND) {
		END = eND;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getAvgtime() {
		return avgtime;
	}
	public void setAvgtime(String avgtime) {
		this.avgtime = avgtime;
	}
	public String getCount() {
		return count;
	}
	public void setCount(String count) {
		this.count = count;
	}
	public String getResult() {
		return result;
	}
	public void setResult(String result) {
		this.result = result;
	}
	public String getUser_level_type_nm() {
		return user_level_type_nm;
	}
	public void setUser_level_type_nm(String user_level_type_nm) {
		this.user_level_type_nm = user_level_type_nm;
	}
	public String getUser_level_type_code() {
		return user_level_type_code;
	}
	public void setUser_level_type_code(String user_level_type_code) {
		this.user_level_type_code = user_level_type_code;
	}
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	public String getAdmin_level_type_code() {
		return admin_level_type_code;
	}
	public void setAdmin_level_type_code(String admin_level_type_code) {
		this.admin_level_type_code = admin_level_type_code;
	}
	public String getRequest_id() {
		return request_id;
	}
	public void setRequest_id(String request_id) {
		this.request_id = request_id;
	}
	public String getService_process_seq() {
		return service_process_seq;
	}
	public void setService_process_seq(String service_process_seq) {
		this.service_process_seq = service_process_seq;
	}
	public String getSystem_info_nm() {
		return system_info_nm;
	}
	public void setSystem_info_nm(String system_info_nm) {
		this.system_info_nm = system_info_nm;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getCode_nm() {
		return code_nm;
	}
	public void setCode_nm(String code_nm) {
		this.code_nm = code_nm;
	}
	public String getOwner_nm() {
		return owner_nm;
	}
	public void setOwner_nm(String owner_nm) {
		this.owner_nm = owner_nm;
	}
	public String getAdmin_level_type_nm() {
		return admin_level_type_nm;
	}
	public void setAdmin_level_type_nm(String admin_level_type_nm) {
		this.admin_level_type_nm = admin_level_type_nm;
	}
	public String getControl_type_nm() {
		return control_type_nm;
	}
	public void setControl_type_nm(String control_type_nm) {
		this.control_type_nm = control_type_nm;
	}
	public String getrequest_Date() {
		return request_Date;
	}
	public void setrequest_Date(String request_Date) {
		this.request_Date = request_Date;
	}
	public String getStep_date() {
		return step_date;
	}
	public void setStep_date(String step_date) {
		this.step_date = step_date;
	}
	public String getStep_update() {
		return step_update;
	}
	public void setStep_update(String step_update) {
		this.step_update = step_update;
	}
	public String getDate_created() {
		return date_created;
	}
	public void setDate_created(String date_created) {
		this.date_created = date_created;
	}
	public String getDate_updated() {
		return date_updated;
	}
	public void setDate_updated(String date_updated) {
		this.date_updated = date_updated;
	}
	public String getCreator() {
		return creator;
	}
	public void setCreator(String creator) {
		this.creator = creator;
	}
	public String getUpdater() {
		return updater;
	}
	public void setUpdater(String updater) {
		this.updater = updater;
	}
	
	
}