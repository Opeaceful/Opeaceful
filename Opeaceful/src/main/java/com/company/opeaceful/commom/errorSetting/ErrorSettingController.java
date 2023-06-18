package com.company.opeaceful.commom.errorSetting;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ErrorSettingController {

	// [지영]
	// 에러페이지 연동
	@GetMapping("/error")
	public String Error404(Model model, HttpServletResponse res,
			@RequestParam(value = "code", required = false) String code

	) {

		model.addAttribute("errorMsg", "ERROR : 올바르지 않은 요청입니다.");

		if (code.equals("404")) {
			model.addAttribute("errorMsg", "ERROR_404 : 올바르지 않은 페이지입니다.");
		}

		if (code.equals("405")) {
			model.addAttribute("errorMsg", "ERROR_405 : HTTP통신이 올바르지 않습니다.");
		}

		if (code.equals("500")) {
			model.addAttribute("errorMsg", "ERROR_500 : 페이지를 표시 할 수 없습니다.");
		}

		return "errorPage";
	}

}
