package com.company.opeaceful.annual.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/annual")
public class AnnualController {

	@GetMapping("/setting")
	public String settingAnnaul(){
		return "annual/annual";
	}
	
	
	@GetMapping("/list")
	public String listAnnaul(){
		return "annual/annual-user";
	}
	
	
}
