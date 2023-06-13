package com.company.opeaceful.calendar.controller;

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
import com.company.opeaceful.calendar.model.vo.CalendarMemo;
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
	
	// 카테고리 별 일정 조회용
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
	
	// 일정 추가
	@ResponseBody
	@PostMapping("/insertEvent")
	public int insertEvent(@ModelAttribute ("loginUser") Member loginUser,
							  Model model, Calendar calendar, String category,
							  @RequestParam(defaultValue = "") String colorT,
							  @RequestParam(defaultValue = "") String colorM,
							  String startDate, String endDate) {
		
		// 일정에 시간 없을 경우 00시00분으로 계산되어 하루 표시가 빠짐.
		//날짜 값에 뒤에 문자열 붙여주기 	+= T00:00:01
		startDate = startDate + "T00:00:01"; 
		System.out.println("시작날짜 : "+startDate);
		endDate = endDate + "T00:00:01";
		System.out.println("끝날짜 : "+endDate);
		
		int userNo = loginUser.getUserNo();
		calendar.setUserNo(userNo);
		System.out.println("colorM"+colorM + "colorT: " +colorT);
		System.out.println("ajax 넘어온 캘린더: " + calendar);
		
		//dept_code //넘겨받은 카테고리가 T일때만 넣어주기**
		if(category.equals("T")) {
			int deptCode = calendarService.selectDeptCode(userNo);
			calendar.setDeptCode(deptCode);
		}
		System.out.println("부서코드 넣은 캘린더: " + calendar);
		//넘겨받은 m컬러 t컬러 null 유무에 따라 color 세팅해주기 
		if(colorT.equals("") && !colorM.equals("")) {
			calendar.setColor(colorM);
		}
		if(colorM.equals("") && !colorT.equals("")) {
			calendar.setColor(colorT);
		}
		/*     ""이면 기본값 디폴트 넣어주기     */
		// 카테고리가 팀 일정일 때
		if(category.equals("T") && colorT.equals("") && colorM.equals("")) {
			calendar.setColor("var(--col11)");
		}
		// 카테고리가 내 일정일 때
		if(category.equals("M") && colorT.equals("") && colorM.equals("")) {
			calendar.setColor("var(--col1)");
		}
		
		System.out.println("insert 전 세팅 캘린더: " + calendar);
		
		int result = calendarService.insertEvent(calendar);
		
		return result;
	}
	
	// 메모 추가 및 변경
	@ResponseBody
	@PostMapping("/addMemo")
	public String addMemo(@ModelAttribute ("loginUser") Member loginUser,
				          String memo, CalendarMemo calendarMemo) {
		
		// 기존에 메모가 없으면 insert, 있음 update
		
		int userNo = loginUser.getUserNo();
		
		calendarMemo.setUserNo(userNo);
		
		CalendarMemo result = calendarService.selectMemo(userNo);
		
		if(result != null) {
			calendarService.updateMemo(calendarMemo);
		}else {
			calendarService.insertMemo(calendarMemo);
		}
		
		CalendarMemo newMemo = calendarService.selectMemo(userNo);
		
		String reset = newMemo.getMemo();
		
		return reset;
	}
	
	
	
	
	
	
	
}
