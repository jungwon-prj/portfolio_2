package kr.co.inssuf.itsm.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
 

@Controller
@RequestMapping("/frontend")
public class FrontendController {
	private static final Logger logger = LoggerFactory
			.getLogger(FrontendController.class);

	 

	@RequestMapping(value = "/location/{menu_div}/{menu_page}", method = {
			RequestMethod.GET, RequestMethod.POST })
	public ModelAndView frontendMenuNavigation(@PathVariable String menu_div,
			@PathVariable String menu_page, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		logger.debug("FrontendController.frontendMenuNavigation() is called.");
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("frontend/" + menu_div + "/" + menu_page);

		System.out.println("menu_page : " +menu_page);
		if ("new_1".equals(menu_page) || "test_case".equals(menu_page)) {
			modelAndView.addObject("request_seq", request.getParameter("request_seq"));
			modelAndView.addObject("request_seq_dtl", request.getParameter("request_seq_dtl"));
//			modelAndView.addObject("request_id", request.getParameter("request_id"));
		} else if ("notice2".equals(menu_page) || "archive".equals(menu_page) || "faq2".equals(menu_page)) {
			modelAndView.addObject("notice_board_seq", request.getParameter("notice_board_seq"));
		}
		return modelAndView;
	}

	 
}