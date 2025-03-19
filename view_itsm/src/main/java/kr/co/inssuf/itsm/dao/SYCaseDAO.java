package kr.co.inssuf.itsm.dao;

import java.util.HashMap;
import java.util.List;

import kr.co.inssuf.itsm.vo.SYCaseDashBoardVo;
import kr.co.inssuf.itsm.vo.SYCaseVo;

import org.springframework.stereotype.Repository;

@Repository(value = "caseDAO")
public interface SYCaseDAO {
	
	public List<SYCaseVo> selectQueueMember(SYCaseVo vo);
	
	public int selectQueueMember2Count(SYCaseVo vo);
	public List<SYCaseVo> selectQueueMember2(SYCaseVo vo);
	
	public List<SYCaseVo> selectCaseMng(SYCaseVo vo);
	public List<SYCaseVo> selectCaseMngSub(SYCaseVo vo);
	
	public int insertCaseMng(SYCaseVo vo);
	public int insertCaseMng_new(SYCaseVo vo);

	public int updateCaseMng(SYCaseVo vo);
	public int updateCaseMng_new(SYCaseVo vo);
	
	public List<SYCaseVo> selectHeader(SYCaseVo vo);
	public List<SYCaseVo> selectSub(SYCaseVo vo);
	public List<SYCaseVo> selectDetail(SYCaseVo vo);

	public List<SYCaseVo> selectApprHeader(SYCaseVo vo);
	public List<SYCaseVo> selectApprSub(SYCaseVo vo);

	public int insertCase(SYCaseVo vo);
	
	public int insertPartnerCase(SYCaseVo vo);
	public int updatePartnerCase(SYCaseVo vo);
	// 0
	public int updateCase_status(SYCaseVo vo0);
	public int updateRequestMng_status(SYCaseVo vo0);
	
	// all
	public int updateCase_case(SYCaseVo vo);
	public int updateRequestMng_case(SYCaseVo vo);
	
	public int updateCase(SYCaseVo vo0);
	public int updateApprCase(SYCaseVo vo0);
	
	public int apprCancelCase(SYCaseVo vo);
	
	public int insertApprover_history(SYCaseVo vo);
	public int deleteApprover_history(SYCaseVo vo);
	public int insertCollaboration_history(SYCaseVo vo);

	public int deleteCaseMng(SYCaseVo vo);
	public int deleteCase(SYCaseVo vo);

	public List<SYCaseVo> loadWait(SYCaseVo vo);
	public List<SYCaseVo> loadCaseCount_q(SYCaseVo vo);
	
	public List<SYCaseVo> loadChart1(SYCaseVo vo);
	public List<SYCaseVo> loadChart2(SYCaseVo vo);
	public List<SYCaseVo> loadChart3(SYCaseVo vo);
	public List<SYCaseVo> loadChart4(SYCaseVo vo);
	public List<SYCaseVo> loadChart6(SYCaseVo vo);

	public int deleteReference_user_tbl_all(SYCaseVo vo);
	public int insertReference_user_tbl(List<SYCaseVo> vo);

	public int deleteReference_user_all(SYCaseVo syCaseVo);
	public int insertReference_user(List<SYCaseVo> rpuserDatas);
	
	public int deletePartner_user_all(SYCaseVo syCaseVo);
	public int insertPartner_user(List<SYCaseVo> prtuserDatas);
	
	public List<SYCaseVo> selectReference_user(SYCaseVo vo);
	public List<SYCaseVo> selectPartner_user(SYCaseVo vo);

	public List<SYCaseVo> selectMailSendQueueUserList(SYCaseVo caseVo);
	public List<SYCaseVo> selectSysInfoCountList(SYCaseVo syVo);

	public List<SYCaseDashBoardVo> stepCntSelect(SYCaseDashBoardVo vo); // itts_dashboard 시작

	public List<SYCaseDashBoardVo> stepAverageSelect(SYCaseDashBoardVo vo);

	public List<SYCaseDashBoardVo> stepDtlSelect(SYCaseDashBoardVo vo);

	public List<SYCaseDashBoardVo> weekOccurSelect(SYCaseDashBoardVo vo);
	
	public List<SYCaseDashBoardVo> weekOccurDtlSelect(SYCaseDashBoardVo vo);

	public List<SYCaseDashBoardVo> weekCmpSelect(SYCaseDashBoardVo vo);
	
	public List<SYCaseDashBoardVo> weekCmpDtlSelect(SYCaseDashBoardVo vo);

	public List<SYCaseDashBoardVo> systemWeekOccurSelect(SYCaseDashBoardVo vo);

	public List<SYCaseDashBoardVo> systemWeekCmpSelect(SYCaseDashBoardVo vo);

	public List<SYCaseDashBoardVo> systemWeekOccurDtlSelect(SYCaseDashBoardVo vo);

	public List<SYCaseDashBoardVo> systemWeekCmpDtlSelect(SYCaseDashBoardVo vo);

	public List<SYCaseDashBoardVo> systemQuarterSelect(SYCaseDashBoardVo vo);

	public List<SYCaseDashBoardVo> systemQuarterDtlSelect(SYCaseDashBoardVo vo);

	public List<SYCaseDashBoardVo> ctrlWeekSelect(SYCaseDashBoardVo vo);

	public List<SYCaseDashBoardVo> ctrlWeekDtlSelect(SYCaseDashBoardVo vo);

	public List<SYCaseDashBoardVo> caseAverageTime(SYCaseDashBoardVo vo);

	public int maxRequestSeq(SYCaseVo vo);

}