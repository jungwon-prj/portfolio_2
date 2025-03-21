package kr.co.inssuf.itsm.controller;

import kr.co.inssuf.itsm.util.ResponseUtils;
import kr.co.inssuf.itsm.util.SessionUtil;
import kr.co.inssuf.itsm.util.StringUtil;
import kr.co.inssuf.itsm.vo.SYCaseDashBoardVo;
import kr.co.inssuf.itsm.vo.SYCaseVo;
import kr.co.inssuf.itsm.vo.SYFileVo;
import kr.co.inssuf.itsm.vo.SYInfoVo;
import kr.co.inssuf.itsm.vo.SYQueueUserVo;
import kr.co.inssuf.itsm.svc.SYCaseService;
import kr.co.inssuf.itsm.svc.SYFileService;





//import java.util.Base64; // 자바 8 버전만 가능함.
import javax.xml.bind.DatatypeConverter;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/case")
public class CaseController {
	private static final Logger logger = LoggerFactory.getLogger(CaseController.class);

	@Inject
	private FileSystemResource fsResource;
	
	@Resource(name = "itsmFileService")
	SYFileService syFileService;
	
	@Resource(name = "caseService")
	SYCaseService syCaseService;
	
	/*@RequestMapping(value = "", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView backendMain(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("UsersController.backendMain() is called.");
		ModelAndView mo
AndView = new ModelAndView();
		modelAndView.setViewName("itsm/itsm_main");
		return modelAndView;
	}*/

	/** #00. System Management : Menu Navigation Management : START =================================================================== */

	@RequestMapping(value = "/location/{menu_div}/{menu_page}", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView caseMenuNavigation(@PathVariable String menu_div, @PathVariable String menu_page, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("CaseController.usersMenuNavigation() is called.");
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("case/"+menu_div+"/"+menu_page);
		return modelAndView;
	}
	
	public static byte[] decodeBase64ToBytes(String imageString, String base_64_prefix) {
		if (imageString.contains(base_64_prefix)) {
			return DatatypeConverter.parseBase64Binary( imageString.substring(imageString.indexOf(base_64_prefix)+8) );
		} else {
			throw new IllegalStateException("it is not base 64 string");
		}
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/admin/selectCaseMng", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectCaseMng(@ModelAttribute SYCaseVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("CaseController.selectCaseMng() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();

			List<SYCaseVo> listCaseMng = syCaseService.selectCaseMng(vo);
			String listDataJsonString = ResponseUtils.getJsonResponse(response, listCaseMng);
			
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
	    resultData.put("rows", listDataJArray);
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
	    resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	

	@ResponseBody
	@RequestMapping(value = "/admin/selectCaseMngSub", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectCaseMngSub(@ModelAttribute SYCaseVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("CaseController.selectCaseMngSub() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			
			List<SYCaseVo> listSvcPrss = syCaseService.selectCaseMngSub(vo);
			
			String listDataJsonString = ResponseUtils.getJsonResponse(response, listSvcPrss);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
	    resultData.put("rows", listDataJArray);
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
	    resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/admin/selectApprHeader", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectApprHeader(@ModelAttribute SYCaseVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("CaseController.selectApprHeader() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			
			List<SYCaseVo> listSvcPrss = syCaseService.selectApprHeader(vo);
			
			String listDataJsonString = ResponseUtils.getJsonResponse(response, listSvcPrss);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
	    resultData.put("rows", listDataJArray);
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
	    resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/admin/selectApprSub", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectApprSub(@ModelAttribute SYCaseVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("CaseController.selectApprSub() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			
			List<SYCaseVo> listSvcPrss = syCaseService.selectApprSub(vo);
			
			String listDataJsonString = ResponseUtils.getJsonResponse(response, listSvcPrss);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
	    resultData.put("rows", listDataJArray);
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
	    resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/selectQueueMember", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectQueueMember(@ModelAttribute SYCaseVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("CaseController.selectQueueMember() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			
			List<SYCaseVo> listSvcPrss = syCaseService.selectQueueMember(vo);
			
			String listDataJsonString = ResponseUtils.getJsonResponse(response, listSvcPrss);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	// /admin/apprCancelCase
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/admin/apprCancelCase", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json; charset=utf-8")
	public String apprCancelCase(@ModelAttribute SYCaseVo vo, HttpServletRequest request) {
		logger.debug("CaseController.apprCancelCase() is called.");
		JSONObject resultData = new JSONObject();
		int result = 0;
		try {
			vo.setUpdater(SessionUtil.getMemberId(request));
			result = syCaseService.apprCancelCase(vo);
			if (result < 0) {
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			} else {
				resultData.put("status", HttpStatus.OK.value());
			}
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	// 맞추자
	// insertCase
	@ResponseBody
	@RequestMapping(value = "/admin/insertCase", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String insertCase(@ModelAttribute SYCaseVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("CaseController.insertCase() is called.");
		vo.setCreator(SessionUtil.getMemberId(request));
		vo.setUpdater(SessionUtil.getMemberId(request));
		JSONObject resultData = new JSONObject();
		
		JSONArray jsonArray = new JSONArray();
		JSONParser parser = new JSONParser();
		try{
			SimpleDateFormat formatter_yyyy = new SimpleDateFormat("yyyy");
			SimpleDateFormat formatter_mm = new SimpleDateFormat("MM");
			SimpleDateFormat formatter_dd = new SimpleDateFormat("dd");
			String yyyy= formatter_yyyy.format(new java.util.Date());
			String mm= formatter_mm.format(new java.util.Date());
			String dd= formatter_dd.format(new java.util.Date());
			String file_cate = "froala";
			String error_msg = "";
			
			String strDir = fsResource.getPath() +"/"+ file_cate +"/"+yyyy+"/"+mm+"/"+dd+"/";
			
			File d = new File(strDir);
			
			if(!d.isDirectory()) {
				d.mkdirs();
			}
			String fileExt = "png";
			String frData = request.getParameter("frData");
			
			String[] imgSplit = frData.split("src=\"");
			
			for(int i=1; i<imgSplit.length; i++) {
				String o_path = imgSplit[i].substring(0, imgSplit[i].indexOf("\""));
				System.out.println("imgSplit["+i+"].substring = " + o_path );
				
				if(o_path.contains("/file/attach_download")){
					System.out.println("이미 등록된 값");
				} else {
					System.out.println("등록안된 값");
					
					UUID uid = UUID.randomUUID();
					String c_path = strDir + "_"+uid+"."+fileExt; 
					String file_path = file_cate +"/" + yyyy+"/"+mm+"/"+dd+"/"+"_"+uid+"."+fileExt;
					
					File localFile = new File(c_path);
					
					String base_64_prefix = "data:image/png;base64,";
					String base_64_prefix2 = ";base64,";
					System.out.println("base_64_prefix2 = " + base_64_prefix2);
					byte[] o_path_byte = decodeBase64ToBytes(o_path, base_64_prefix2);
					
					Files.copy( new ByteArrayInputStream(o_path_byte), localFile.toPath() );
					
					SYFileVo fVo = new SYFileVo();
					String file_group = syFileService.selectFileKey();
					
					fVo.setFile_group(file_group);
					fVo.setFile_repo("1");
					fVo.setFile_cate(file_cate);
					fVo.setFile_path(file_path); 
					fVo.setFile_name("fileName."+fileExt);
					fVo.setFile_ext(fileExt);
					fVo.setFile_del_yn("N");
					fVo.setFile_size((localFile.length() / 1024));
					fVo.setCreator(SessionUtil.getMemberId(request));
					fVo.setUpdater(SessionUtil.getMemberId(request));
					int result = syFileService.insertFile(fVo);
					System.out.println("result = "+result);
					
					int idx = frData.indexOf(o_path);
					System.out.println("idx = " + idx);
					System.out.println("frData = " + frData);
					
					frData = frData.replace(o_path, "/file/attach_download2?file_group="+file_group );
				}
			}
			vo.setContext(frData);
			// service_processes_tbl
			vo.setOwner_id(SessionUtil.getMemberId(request));
			vo.setOwner_nm(SessionUtil.getMemberNm(request));
			
			// ★
			int result = 0;
			
			String prtuserData = request.getParameter("prtuserData");
			jsonArray = (JSONArray) parser.parse(prtuserData); 
			
			List<SYCaseVo> prtuserDatas = new ArrayList<SYCaseVo>();
			if(jsonArray.size() > 0) {
				Object[] keyArr = ((JSONObject)jsonArray.get(0)).keySet().toArray(); 
				for(int i=0; i<jsonArray.size(); i++) {
					JSONObject jObj = (JSONObject)jsonArray.get(i);
					SYCaseVo cVo = new SYCaseVo();
					
					for(Object key : keyArr) { 
						String nKey = key.toString();
						String nValue = "";
						if( jObj.get(nKey)==null || jObj.get(nKey)=="") 
							continue;
						else 
							nValue = jObj.get(nKey).toString();
						// user
//						if( "user_no".equals(nKey) ) 		cVo.setUser_no(nValue);
//						else 
						if( "user_id".equals(nKey) ) 	cVo.setPartner_id(nValue);
						else if( "user_nm".equals(nKey) ) 		cVo.setPartner_nm(nValue);
					}
					cVo.setCreator(SessionUtil.getMemberId(request));
					cVo.setUpdater(SessionUtil.getMemberId(request));
					cVo.setOwner_id(SessionUtil.getMemberId(request));
					cVo.setOwner_nm(SessionUtil.getMemberNm(request));
					cVo.setRequest_id(vo.getRequest_id());
					
					prtuserDatas.add(cVo);
				}
			}
			System.out.println("rpuserDatas = " + prtuserDatas.size());
			
			String cmd = vo.getCmd();
			
			result = syCaseService.insertCase(vo, prtuserDatas);
			
			resultData.put("division", "detail");
			resultData.put("error_msg", error_msg);
			resultData.put("request_seq", result);
			resultData.put("status", HttpStatus.OK.value());
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString(); 
	}
	
	@ResponseBody
	@RequestMapping(value = "/admin/insertPartnerCase", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String insertPartnerCase(@ModelAttribute SYCaseVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("CaseController.insertPartnerCase() is called.");
		vo.setCreator(SessionUtil.getMemberId(request));
		vo.setUpdater(SessionUtil.getMemberId(request));
		JSONObject resultData = new JSONObject();
		
		JSONArray jsonArray = new JSONArray();
		JSONParser parser = new JSONParser();
		try{
			SimpleDateFormat formatter_yyyy = new SimpleDateFormat("yyyy");
			SimpleDateFormat formatter_mm = new SimpleDateFormat("MM");
			SimpleDateFormat formatter_dd = new SimpleDateFormat("dd");
			String yyyy= formatter_yyyy.format(new java.util.Date());
			String mm= formatter_mm.format(new java.util.Date());
			String dd= formatter_dd.format(new java.util.Date());
			String file_cate = "froala";
			String error_msg = "";
			
			String strDir = fsResource.getPath() +"/"+ file_cate +"/"+yyyy+"/"+mm+"/"+dd+"/";
			
			File d = new File(strDir);
			
			if(!d.isDirectory()) {
				d.mkdirs();
			}
			String fileExt = "png";
			String frData = request.getParameter("frData");
			
			String[] imgSplit = frData.split("src=\"");
			
			for(int i=1; i<imgSplit.length; i++) {
				String o_path = imgSplit[i].substring(0, imgSplit[i].indexOf("\""));
				System.out.println("imgSplit["+i+"].substring = " + o_path );
				
				if(o_path.contains("/file/attach_download")){
					System.out.println("이미 등록된 값");
				} else {
					System.out.println("등록안된 값");
					
					UUID uid = UUID.randomUUID();
					String c_path = strDir + "_"+uid+"."+fileExt; 
					String file_path = file_cate +"/" + yyyy+"/"+mm+"/"+dd+"/"+"_"+uid+"."+fileExt;
					
					File localFile = new File(c_path);
					
					String base_64_prefix = "data:image/png;base64,";
					String base_64_prefix2 = ";base64,";
					System.out.println("base_64_prefix2 = " + base_64_prefix2);
					byte[] o_path_byte = decodeBase64ToBytes(o_path, base_64_prefix2);
					
					Files.copy( new ByteArrayInputStream(o_path_byte), localFile.toPath() );
					
					SYFileVo fVo = new SYFileVo();
					String file_group = syFileService.selectFileKey();
					
					fVo.setFile_group(file_group);
					fVo.setFile_repo("1");
					fVo.setFile_cate(file_cate);
					fVo.setFile_path(file_path); 
					fVo.setFile_name("fileName."+fileExt);
					fVo.setFile_ext(fileExt);
					fVo.setFile_del_yn("N");
					fVo.setFile_size((localFile.length() / 1024));
					fVo.setCreator(SessionUtil.getMemberId(request));
					fVo.setUpdater(SessionUtil.getMemberId(request));
					int result = syFileService.insertFile(fVo);
					System.out.println("result = "+result);
					
					int idx = frData.indexOf(o_path);
					System.out.println("idx = " + idx);
					System.out.println("frData = " + frData);
					
					frData = frData.replace(o_path, "/file/attach_download2?file_group="+file_group );
				}
			}
			vo.setContext(frData);
			// service_processes_tbl
//			vo.setOwner_id(SessionUtil.getMemberId(request));
//			vo.setOwner_nm(SessionUtil.getMemberNm(request));
			
			// ★
			int result = 0;
			
			String cmd = vo.getCmd();
			
			result = syCaseService.insertPartnerCase(vo);
			
			resultData.put("division", "detail");
			resultData.put("error_msg", error_msg);
			resultData.put("status", HttpStatus.OK.value());
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString(); 
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/admin/updatePartnerCase", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String updatePartnerCase(@ModelAttribute SYCaseVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("CaseController.updatePartnerCase() is called.");
		vo.setCreator(SessionUtil.getMemberId(request));
		vo.setUpdater(SessionUtil.getMemberId(request));
		JSONObject resultData = new JSONObject();
		try{
			SimpleDateFormat formatter_yyyy = new SimpleDateFormat("yyyy");
			SimpleDateFormat formatter_mm = new SimpleDateFormat("MM");
			SimpleDateFormat formatter_dd = new SimpleDateFormat("dd");
			String yyyy= formatter_yyyy.format(new java.util.Date());
			String mm= formatter_mm.format(new java.util.Date());
			String dd= formatter_dd.format(new java.util.Date());
			String file_cate = "froala";
			String error_msg = "";
			
			String strDir = fsResource.getPath() +"/"+ file_cate +"/"+yyyy+"/"+mm+"/"+dd+"/";
			
			File d = new File(strDir);
			
			if(!d.isDirectory()) {
				d.mkdirs();
			}
			String fileExt = "png";
			String frData = request.getParameter("frData");
			
			String[] imgSplit = frData.split("src=\"");
			
			for(int i=1; i<imgSplit.length; i++) {
				String o_path = imgSplit[i].substring(0, imgSplit[i].indexOf("\""));
				
				if(o_path.contains("/file/attach_download")){
					System.out.println("이미 등록된 값");
				} else {
					System.out.println("등록안된 값");
					
					UUID uid = UUID.randomUUID();
					String c_path = strDir + "_"+uid+"."+fileExt; 
					String file_path = file_cate +"/" + yyyy+"/"+mm+"/"+dd+"/"+"_"+uid+"."+fileExt;
					
					File localFile = new File(c_path);
					
					String base_64_prefix = "data:image/png;base64,";
					String base_64_prefix2 = ";base64,";
					System.out.println("base_64_prefix2 = " + base_64_prefix2);
					byte[] o_path_byte = decodeBase64ToBytes(o_path, base_64_prefix2);
					
					Files.copy( new ByteArrayInputStream(o_path_byte), localFile.toPath() );
					
					SYFileVo fVo = new SYFileVo();
					String file_group = syFileService.selectFileKey();
					
					fVo.setFile_group(file_group);
					fVo.setFile_repo("1");
					fVo.setFile_cate(file_cate);
					fVo.setFile_path(file_path); 
					fVo.setFile_name("fileName."+fileExt);
					fVo.setFile_ext(fileExt);
					fVo.setFile_del_yn("N");
					fVo.setFile_size((localFile.length() / 1024));
					fVo.setCreator(SessionUtil.getMemberId(request));
					fVo.setUpdater(SessionUtil.getMemberId(request));
					int result = syFileService.insertFile(fVo);
					System.out.println("result = "+result);
					
					int idx = frData.indexOf(o_path);
					System.out.println("idx = " + idx);
					System.out.println("frData = " + frData);
					
					frData = frData.replace(o_path, "/file/attach_download2?file_group="+file_group );
				}
			}
			vo.setContext(frData);
			
			int result = 0;
			String cmd = vo.getCmd();
			
			result = syCaseService.updatePartnerCase(vo);
			
			resultData.put("division", "detail");
			resultData.put("error_msg", error_msg);
			resultData.put("status", HttpStatus.OK.value());
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString(); 
	}
	
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/admin/updateCase_header", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json; charset=utf-8")
	public String updateCase_header(@ModelAttribute SYCaseVo vo, HttpServletRequest request) {
		logger.debug("CaseController.updateCase_header() is called.");
		JSONObject resultData = new JSONObject();
		int result = 0;
		try {
			vo.setUpdater(SessionUtil.getMemberId(request));
			vo.setCreator(SessionUtil.getMemberId(request));
			
			result = syCaseService.updateCase_header(vo);
			
			if (result < 0) {
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			} else {
				resultData.put("status", HttpStatus.OK.value());
			}
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/admin/updateCase_header_all", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json; charset=utf-8")
	public String updateCase_header_all(@ModelAttribute SYCaseVo vo, HttpServletRequest request) {
		logger.debug("CaseController.updateCase_header_all() is called.");
		JSONObject resultData = new JSONObject();
		int result = 0;
		try {
			vo.setUpdater(SessionUtil.getMemberId(request));
			vo.setCreator(SessionUtil.getMemberId(request));
			
			result = syCaseService.updateCase_header_all(vo);
			
			if (result < 0) {
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			} else {
				resultData.put("status", HttpStatus.OK.value());
			}
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/admin/updateCase", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String updateCase(@ModelAttribute SYCaseVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("CaseController.updateCase() is called.");
		vo.setCreator(SessionUtil.getMemberId(request));
		vo.setUpdater(SessionUtil.getMemberId(request));
		JSONObject resultData = new JSONObject();
		
		JSONArray jsonArray = new JSONArray();
		JSONParser parser = new JSONParser();
		try{
			SimpleDateFormat formatter_yyyy = new SimpleDateFormat("yyyy");
			SimpleDateFormat formatter_mm = new SimpleDateFormat("MM");
			SimpleDateFormat formatter_dd = new SimpleDateFormat("dd");
			String yyyy= formatter_yyyy.format(new java.util.Date());
			String mm= formatter_mm.format(new java.util.Date());
			String dd= formatter_dd.format(new java.util.Date());
			String file_cate = "froala";
			String error_msg = "";
			
			String strDir = fsResource.getPath() +"/"+ file_cate +"/"+yyyy+"/"+mm+"/"+dd+"/";
			
			File d = new File(strDir);
			
			if(!d.isDirectory()) {
				d.mkdirs();
			}
			String fileExt = "png";
			String frData = request.getParameter("frData");
			
			String[] imgSplit = frData.split("src=\"");
			
			for(int i=1; i<imgSplit.length; i++) {
				String o_path = imgSplit[i].substring(0, imgSplit[i].indexOf("\""));
				System.out.println("imgSplit["+i+"].substring = " + o_path );
				
				if(o_path.contains("/file/attach_download")){
					System.out.println("이미 등록된 값");
				} else {
					System.out.println("등록안된 값");
					
					UUID uid = UUID.randomUUID();
					String c_path = strDir + "_"+uid+"."+fileExt; 
					String file_path = file_cate +"/" + yyyy+"/"+mm+"/"+dd+"/"+"_"+uid+"."+fileExt;
					
					File localFile = new File(c_path);
					
					String base_64_prefix = "data:image/png;base64,";
					String base_64_prefix2 = ";base64,";
					System.out.println("base_64_prefix2 = " + base_64_prefix2);
					byte[] o_path_byte = decodeBase64ToBytes(o_path, base_64_prefix2);
					
					Files.copy( new ByteArrayInputStream(o_path_byte), localFile.toPath() );
					
					SYFileVo fVo = new SYFileVo();
					String file_group = syFileService.selectFileKey();
					
					fVo.setFile_group(file_group);
					fVo.setFile_repo("1");
					fVo.setFile_cate(file_cate);
					fVo.setFile_path(file_path); 
					fVo.setFile_name("fileName."+fileExt);
					fVo.setFile_ext(fileExt);
					fVo.setFile_del_yn("N");
					fVo.setFile_size((localFile.length() / 1024));
					fVo.setCreator(SessionUtil.getMemberId(request));
					fVo.setUpdater(SessionUtil.getMemberId(request));
					int result = syFileService.insertFile(fVo);
					System.out.println("result = "+result);
					
					int idx = frData.indexOf(o_path);
					System.out.println("idx = " + idx);
					System.out.println("frData = " + frData);
					
					frData = frData.replace(o_path, "/file/attach_download2?file_group="+file_group );
				}
			}
			vo.setContext(frData);
			// service_processes_tbl
//			vo.setOwner_id(SessionUtil.getMemberId(request));
//			vo.setOwner_nm(SessionUtil.getMemberNm(request));
			
			int result = 0;
			
			String prtuserData = request.getParameter("prtuserData");
			jsonArray = (JSONArray) parser.parse(prtuserData); 
			
			List<SYCaseVo> prtuserDatas = new ArrayList<SYCaseVo>();
			if(jsonArray.size() > 0) {
				Object[] keyArr = ((JSONObject)jsonArray.get(0)).keySet().toArray(); 
				for(int i=0; i<jsonArray.size(); i++) {
					JSONObject jObj = (JSONObject)jsonArray.get(i);
					SYCaseVo cVo = new SYCaseVo();
					
					for(Object key : keyArr) { 
						String nKey = key.toString();
						String nValue = "";
						if( jObj.get(nKey)==null || jObj.get(nKey)=="") 
							continue;
						else 
							nValue = jObj.get(nKey).toString();
						// user
//						if( "user_no".equals(nKey) ) 		cVo.setUser_no(nValue);
//						else 
						if( "user_id".equals(nKey) ) 	cVo.setPartner_id(nValue);
						else if( "user_nm".equals(nKey) ) 		cVo.setPartner_nm(nValue);
					}
					cVo.setCreator(vo.getOwner_id());
					cVo.setUpdater(vo.getOwner_id());
					cVo.setOwner_id(vo.getOwner_id());
					cVo.setOwner_nm(vo.getOwner_nm());
					cVo.setRequest_id(vo.getRequest_id());
					cVo.setService_process_id(vo.getService_process_id());
					cVo.setService_process_seq(vo.getService_process_seq());
					
					prtuserDatas.add(cVo);
				}
			}
			System.out.println("rpuserDatas = " + prtuserDatas.size());
			
			String cmd = vo.getCmd();
			
			result = syCaseService.updateCase(vo, prtuserDatas);
			
			resultData.put("division", "detail");
			resultData.put("error_msg", error_msg);
			resultData.put("status", HttpStatus.OK.value());
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString(); 
	}
	
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/admin/updateCase_status", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json; charset=utf-8")
	public String updateCase_status(@ModelAttribute SYCaseVo vo, HttpServletRequest request) {
		logger.debug("CaseController.updateCase_status() is called.");
		JSONObject resultData = new JSONObject();
		int result = 0;
		try {
			vo.setUpdater(SessionUtil.getMemberId(request));
			vo.setCreator(SessionUtil.getMemberId(request));
			
			result = syCaseService.updateCase_status(vo);
			
			if (result < 0) {
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			} else {
				resultData.put("status", HttpStatus.OK.value());
			}
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/admin/selectHeader", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectHeader(@ModelAttribute SYCaseVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("CaseController.selectHeader() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			
			List<SYCaseVo> listSvcPrss = syCaseService.selectHeader(vo);
			
			String listDataJsonString = ResponseUtils.getJsonResponse(response, listSvcPrss);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
	    resultData.put("rows", listDataJArray);
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
	    resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/admin/selectSub", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectSub(@ModelAttribute SYCaseVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("CaseController.selectSub() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			
			List<SYCaseVo> listSvcPrss = syCaseService.selectSub(vo);
			
			String listDataJsonString = ResponseUtils.getJsonResponse(response, listSvcPrss);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
	    resultData.put("rows", listDataJArray);
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
	    resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	// deleteCase
//	request_id			: request_id,
//	service_process_id	: service_process_id,
//	status 				: "MD1256",
//	use_yn 				: "N"
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/admin/deleteCase", method = { RequestMethod.GET, RequestMethod.POST }, produces = "application/json; charset=utf-8")
	public String deleteCase(@ModelAttribute SYCaseVo vo, HttpServletRequest request) {
		logger.debug("CaseController.deleteCase() is called.");
		JSONObject resultData = new JSONObject();
		int result = 0;
		try {
			vo.setUpdater(SessionUtil.getMemberId(request));
			result = syCaseService.deleteCase(vo);
			if (result < 0) {
				resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			} else {
				resultData.put("status", HttpStatus.OK.value());
			}
		} catch (Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	@ResponseBody
	@RequestMapping(value = "/admin/selectReference_user", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectReference_user(@ModelAttribute SYCaseVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("CaseController.selectReference_user() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			
			List<SYCaseVo> listSvcPrss = syCaseService.selectReference_user(vo);
			
			String listDataJsonString = ResponseUtils.getJsonResponse(response, listSvcPrss);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
	    resultData.put("rows", listDataJArray);
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
	    resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/admin/selectPartner_user", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String selectPartner_user(@ModelAttribute SYCaseVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("CaseController.selectPartner_user() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			
			List<SYCaseVo> listSvcPrss = syCaseService.selectPartner_user(vo);
			
			String listDataJsonString = ResponseUtils.getJsonResponse(response, listSvcPrss);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
			resultData.put("rows", null);
		}
		return resultData.toJSONString();
	}
	
	///////////////////////// 대시보드 시작
	@ResponseBody // itss dashboard 단계별 건수
	@RequestMapping(value = "/dashboardChart/stepCntSelect", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String stepSelect(@ModelAttribute SYCaseDashBoardVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("CaseController.stepCntSelect() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			
			List<SYCaseDashBoardVo> list = syCaseService.stepCntSelect(vo);
			System.out.println("잘 넘어 오나~  "+list);
			
			String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody // itss dashboard 단계별 평균 공수
	@RequestMapping(value = "/dashboardChart/stepAverageSelect", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String stepAverageSelect(@ModelAttribute SYCaseDashBoardVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("CaseController.stepAverageSelect() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			
			List<SYCaseDashBoardVo> list = syCaseService.stepAverageSelect(vo);
			System.out.println("잘 넘어 오나~  "+list);
			
			String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody // itss dashboard 단계별 선택 시 조회
	@RequestMapping(value = "/dashboardChart/stepDtlSelect", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String stepDtlSelect(@ModelAttribute SYCaseDashBoardVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("CaseController.stepDtlSelect() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			
			List<SYCaseDashBoardVo> list = syCaseService.stepDtlSelect(vo);
			
			String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody // itss dashboard 주간 Case 발생 조회
	@RequestMapping(value = "/dashboardChart/weekOccurSelect", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String weekOccurSelect(@ModelAttribute SYCaseDashBoardVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("CaseController.weekOccurSelect() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			
			List<SYCaseDashBoardVo> list = syCaseService.weekOccurSelect(vo);
			
			String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody // itss dashboard 주간 Case 발생 상세 조회
	@RequestMapping(value = "/dashboardChart/weekOccurDtlSelect", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String weekOccurDtlSelect(@ModelAttribute SYCaseDashBoardVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("CaseController.weekOccurSelect() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			
			List<SYCaseDashBoardVo> list = syCaseService.weekOccurDtlSelect(vo);
			
			String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody // itss dashboard 주간 Case 완료
	@RequestMapping(value = "/dashboardChart/weekCmpSelect", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String weekCmpSelect(@ModelAttribute SYCaseDashBoardVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("CaseController.weekCmpSelect() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			
			List<SYCaseDashBoardVo> list = syCaseService.weekCmpSelect(vo);
			
			String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}

	@ResponseBody // itss dashboard 주간 Case 완료 상세
	@RequestMapping(value = "/dashboardChart/weekCmpDtlSelect", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String weekCmpDtlSelect(@ModelAttribute SYCaseDashBoardVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("CaseController.weekCmpSelect() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			
			List<SYCaseDashBoardVo> list = syCaseService.weekCmpDtlSelect(vo);
			
			String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody // itss dashboard 시스템 별 주간 Case 발생
	@RequestMapping(value = "/dashboardChart/systemWeekOccurSelect", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String systemWeekOccurSelect(@ModelAttribute SYCaseDashBoardVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("CaseController.systemWeekOccurSelect() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			
			List<SYCaseDashBoardVo> list = syCaseService.systemWeekOccurSelect(vo);
			
			String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody // itss dashboard 시스템 별 주간 Case 발생 상세
	@RequestMapping(value = "/dashboardChart/systemWeekOccurDtlSelect", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String systemWeekOccurDtlSelect(@ModelAttribute SYCaseDashBoardVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("CaseController.systemWeekOccurDtlSelect() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			
			List<SYCaseDashBoardVo> list = syCaseService.systemWeekOccurDtlSelect(vo);
			
			String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody // itss dashboard 시스템 별 주간 Case 완료
	@RequestMapping(value = "/dashboardChart/systemWeekCmpSelect", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String systemWeekCmpSelect(@ModelAttribute SYCaseDashBoardVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("CaseController.systemWeekCmpSelect() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			
			List<SYCaseDashBoardVo> list = syCaseService.systemWeekCmpSelect(vo);
			
			String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody // itss dashboard 시스템 별 주간 Case 완료 상세
	@RequestMapping(value = "/dashboardChart/systemWeekCmpDtlSelect", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String systemWeekCmpDtlSelect(@ModelAttribute SYCaseDashBoardVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("CaseController.systemWeekCmpDtlSelect() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			
			List<SYCaseDashBoardVo> list = syCaseService.systemWeekCmpDtlSelect(vo);
			
			String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody // itss dashboard 시스템 별 분기 평균 처리 공수
	@RequestMapping(value = "/dashboardChart/systemQuarterSelect", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String systemQuarterSelect(@ModelAttribute SYCaseDashBoardVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("CaseController.systemQuarterSelect() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			
			List<SYCaseDashBoardVo> list = syCaseService.systemQuarterSelect(vo);
			
			String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody // itss dashboard 시스템 별 분기 평균 처리 공수 상세
	@RequestMapping(value = "/dashboardChart/systemQuarterDtlSelect", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String systemQuarterDtlSelect(@ModelAttribute SYCaseDashBoardVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("CaseController.systemQuarterDtlSelect() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			
			List<SYCaseDashBoardVo> list = syCaseService.systemQuarterDtlSelect(vo);
			
			String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody // itss dashboard 통제분류별 주간 평균 처리 공수
	@RequestMapping(value = "/dashboardChart/ctrlWeekSelect", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String ctrlWeekSelect(@ModelAttribute SYCaseDashBoardVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("CaseController.ctrlWeekSelect() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			
			JSONParser jsonParser = new JSONParser();
			
			List<SYCaseDashBoardVo> list = syCaseService.ctrlWeekSelect(vo);
			String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody // itss dashboard 통제분류별 주간 평균 처리 공수 상세
	@RequestMapping(value = "/dashboardChart/ctrlWeekDtlSelect", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String ctrlWeekDtlSelect(@ModelAttribute SYCaseDashBoardVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("CaseController.ctrlWeekDtlSelect() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			
			List<SYCaseDashBoardVo> list = syCaseService.ctrlWeekDtlSelect(vo);
			
			String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
	@ResponseBody // itss dashboard case 소요시간
	@RequestMapping(value = "/dashboardChart/caseAverageTime", method = {RequestMethod.GET, RequestMethod.POST}, produces="application/json;charset=UTF-8")
	@SuppressWarnings("unchecked")
	public String caseAverageTime(@ModelAttribute SYCaseDashBoardVo vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		logger.debug("CaseController.caseAverageTime() is called.");
		JSONObject resultData = new JSONObject();
		JSONArray listDataJArray = new JSONArray();
		try {
			JSONParser jsonParser = new JSONParser();
			
			List<SYCaseDashBoardVo> list = syCaseService.caseAverageTime(vo);
			
			String listDataJsonString = ResponseUtils.getJsonResponse(response, list);
			listDataJArray = (JSONArray) jsonParser.parse(listDataJsonString);
			resultData.put("status", HttpStatus.OK.value());
			resultData.put("rows", listDataJArray);
		} catch(Exception e) {
			e.printStackTrace();
			resultData.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return resultData.toJSONString();
	}
	
}


