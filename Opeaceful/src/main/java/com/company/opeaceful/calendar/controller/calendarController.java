package com.company.opeaceful.calendar.controller;

import java.net.http.HttpRequest;
import java.util.ArrayList;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.company.opeaceful.calendar.model.service.CalendarService;
import com.company.opeaceful.calendar.model.vo.Calendar;
import com.company.opeaceful.member.model.vo.Member;
import com.google.gson.Gson;

@Controller
@RequestMapping("/calendar")
@SessionAttributes({"loginUser"})
public class calendarController {
	
	@Autowired
	private CalendarService calendarService;
	private static final Logger logger = LoggerFactory.getLogger(calendarController.class);
	
	@GetMapping("/calendarForm/{category}")
	public String calendarList(@ModelAttribute ("loginUser") Member loginUser,
							   @PathVariable("category") String category,
							   Model model, @ModelAttribute Calendar calendar,
							   @RequestParam Map<String, Object> map) {	
		
		System.out.println("category 담긴 값 : " + category);
		
		map.put("category", category);
		
		int userNo = loginUser.getUserNo();
		map.put("userNo", userNo);
		
		
			ArrayList<Calendar> listM = calendarService.selectMyCalendarList(userNo);
			ArrayList<Calendar> listT = calendarService.selectTeamCalendarList(userNo);
			model.addAttribute("category", category);
			model.addAttribute("listM", listM);
			model.addAttribute("listT", listT);
			System.out.println("listT담긴 값 : "+listT);
			System.out.println("listM담긴 값 : "+listM);
			//return new Gson().toJson(list);
		
		
		return "calendar/calendarPage";
	}
	
	@ResponseBody
	@PostMapping("/calendarForm/M")
	public String myCalendar(@ModelAttribute ("loginUser") Member loginUser,
			 				 Model model, @ModelAttribute Calendar calendar,
			 				@RequestParam Map<String, Object> map) {
		int userNo = loginUser.getUserNo();
		map.put("userNo", userNo);
		
		ArrayList<Calendar> list = calendarService.selectMyCalendarList(userNo);
		model.addAttribute("list", list);
		
		System.out.println("list담긴 값 : "+list);
		
		return new Gson().toJson(list);
	}
	
	@ResponseBody
	@PostMapping("/calendarForm/T")
	public String teamCalendar(@ModelAttribute ("loginUser") Member loginUser,
			 				 Model model, @ModelAttribute Calendar calendar,
			 				@RequestParam Map<String, Object> map) {
		int userNo = loginUser.getUserNo();
		map.put("userNo", userNo);
		
		ArrayList<Calendar> tlist = calendarService.selectTeamCalendarList(userNo);
		model.addAttribute("list", tlist);
		
		System.out.println("list담긴 값 : "+tlist);
		
		return new Gson().toJson(tlist);
	}
	
	@ResponseBody
	@PostMapping("/calendarForm/F")
	public String fullCalendar(@ModelAttribute ("loginUser") Member loginUser,
			 				 Model model, @ModelAttribute Calendar calendar,
			 				@RequestParam Map<String, Object> map) {
		int userNo = loginUser.getUserNo();
		map.put("userNo", userNo);
		
		ArrayList<Calendar> list = calendarService.selectFullCalendarList(userNo);
		model.addAttribute("list", list);
		
		System.out.println("list담긴 값 : "+list);
		
		return new Gson().toJson(list);
	}
	
	
	
	
	
	
	
	
	
	
	
	
}
