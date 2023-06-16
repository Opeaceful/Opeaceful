package com.company.opeaceful.calendar.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

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
							   CalendarMemo calendarMemo,
							    @ModelAttribute("memo") String memo) {	
		
		//logger.info("캘린더페이지 로거");
		
		int userNo = loginUser.getUserNo();
		
		calendarMemo = calendarService.selectMemo(userNo);
		
		if(calendarMemo == null) {
			memo = "";
		}else {
			memo = calendarMemo.getMemo();
		}
		
		ArrayList<Calendar> listM = calendarService.selectMyCalendarList(userNo);
		ArrayList<Calendar> listT = calendarService.selectTeamCalendarList(userNo);
		model.addAttribute("category", category);
		model.addAttribute("memo", memo);
		
		/* 우측 디데이 리스트 조회 */
		ArrayList<Calendar> listD = calendarService.dDayList(userNo);
		model.addAttribute("listD", listD);	
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
							HttpSession session,
							  Model model, Calendar calendar, String category,
							  @RequestParam(defaultValue = "") String colorT,
							  @RequestParam(defaultValue = "") String colorM,
							  @RequestParam String startDate, @RequestParam String endDate) {
		
		//logger.info("일정추가 로거");
		
		int userNo = loginUser.getUserNo();
		calendar.setUserNo(userNo);
		
		//dept_code : 넘겨받은 카테고리가 T일때만 넣어주기
		if(calendar.getCategory().equals("T")) {
			int deptCode = calendarService.selectDeptCode(userNo);
			calendar.setDeptCode(deptCode);
		}
		
		//넘겨받은 m컬러 t컬러 null 유무에 따라 color 세팅해주기 
		if(colorT.equals("") && !colorM.equals("")) {
			calendar.setColor(colorM);
		}
		if(colorM.equals("") && !colorT.equals("")) {
			calendar.setColor(colorT);
		}
		
		/*     "" 빈 문자열이면 기본값 디폴트 넣어주기     */
		
		// 1) 카테고리가 팀 일정일 때
		if(calendar.getCategory().equals("T") && colorT.equals("") && colorM.equals("")) {
			calendar.setColor("var(--col11)");
		}
		// 2) 카테고리가 내 일정일 때
		if(calendar.getCategory().equals("M") && colorT.equals("") && colorM.equals("")) {
			calendar.setColor("var(--col1)");
		}
		
		int result = calendarService.insertEvent(calendar);
		
		if(result > 0) {
			session.setAttribute("alertMsg", "일정이 등록되었습니다.");
		}
		
		return result;
	}
	
	// 일정번호로 조회
	@ResponseBody
	@PostMapping("/selectEvent")
	public String selectEvent(Calendar calendar) {
		//logger.info("일정번호로 조회 로거");
		
		int cno = calendar.getId();
		
		Calendar cal = calendarService.selectEvent(cno);
		
		return new Gson().toJson(cal);
	}
	
	// 일정수정(업데이트)
	@ResponseBody
	@PostMapping("/updateEvent")
	public String updateEvent(Calendar calendar,
						   @RequestParam int cno,
						   @RequestParam(defaultValue = "") String colorT,
						   @RequestParam(defaultValue = "") String colorM,
						   HttpSession session) {
		
		//logger.info("일정 update 로거");
		
		//넘겨받은 m컬러 t컬러 null 유무에 따라 color 세팅해주기 
		if(colorT.equals("") && !colorM.equals("")) {
			calendar.setColor(colorM);
		}
		if(colorM.equals("") && !colorT.equals("")) {
			calendar.setColor(colorT);
		}
		/*     ""이면 기본값 디폴트 넣어주기     */
		// 1) 카테고리가 팀 일정일 때
		if(calendar.getCategory().equals("T") && colorT.equals("") && colorM.equals("")) {
			calendar.setColor("var(--col11)");
		}
		// 2) 카테고리가 내 일정일 때
		if(calendar.getCategory().equals("M") && colorT.equals("") && colorM.equals("")) {
			calendar.setColor("var(--col1)");
		}
		
		calendar.setCalendarNo(cno);
		
		int result = calendarService.updateEvent(calendar);
		
		if(result > 0) {
			session.setAttribute("alertMsg", "일정이 수정되었습니다.");
		}
		
		return new Gson().toJson(result);
	}
	
	// 일정삭제
		@ResponseBody
		@PostMapping("/deleteEvent")
		public String deleteEvent(@RequestParam int cno,
								HttpSession session) {
			
			//logger.info("일정삭제 로거");
			
			int result = calendarService.deleteEvent(cno);
			
			if(result > 0) {
				session.setAttribute("alertMsg", "일정이 삭제되었습니다.");
			}
			
			return new Gson().toJson(result);
			
		}
	
		
	// 메모 추가 및 변경
	@ResponseBody
	@PostMapping("/addMemo")
	public int addMemo(@ModelAttribute ("loginUser") Member loginUser,
			@ModelAttribute("memo") String memo, CalendarMemo calendarMemo, Model model) {
		//logger.info("메모추가 로거");
		
		// 기존에 메모가 없으면 insert, 있음 update
		
		int userNo = loginUser.getUserNo();
		
		calendarMemo.setUserNo(userNo);
		
		CalendarMemo result = calendarService.selectMemo(userNo);
		
		if(result != null) {
			int memoResult = calendarService.updateMemo(calendarMemo);
			return memoResult;
		}else {
			int memoResult = calendarService.insertMemo(calendarMemo);
			return memoResult;
		}
		
	
	}
	
	
}
