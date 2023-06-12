package com.company.opeaceful.attendance.controller;

import java.util.HashMap;
import java.util.List;
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

import com.company.opeaceful.attendance.model.service.AttendanceService;
import com.company.opeaceful.attendance.model.vo.Attendance;
import com.company.opeaceful.board.controller.BoardController;
import com.company.opeaceful.member.model.vo.Member;
import com.google.gson.Gson;

@Controller
@RequestMapping("/attendance")
@SessionAttributes({"loginUser"})
public class AttendanceController {

	private AttendanceService attendanceService;

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	@Autowired
	public AttendanceController(AttendanceService attendanceService) {
		this.attendanceService = attendanceService;
	}
	
//	quartz 사용할 때를 위해 작성만 함
//	public AttendanceController() {
//		
//	}
	
	@RequestMapping("/")
	public String selectAttendance() {
		return "attendance";
	}
	
	// [지의] - 출근시간 등록
	@ResponseBody
	@PostMapping("/workOn")
	public String insertWorkOn(@ModelAttribute("loginUser") Member loginUser, Model model) {
		
		int userNo = loginUser.getUserNo();
		int result = attendanceService.insertWorkOn(userNo);
		int update = 0;
		// 출근 등록 성공시 member statusType 온라인으로 변경
		if(result > 0 ) {
			update = attendanceService.updateOnlineStatus(userNo);
			
			if(update > 0) {
				loginUser.setStatusType(1);
				model.addAttribute("loginUser", loginUser);
			}
			
		}
		
		return new Gson().toJson(result*update);
	}
	
	// [지의] - 퇴근시간 등록
	@ResponseBody
	@PostMapping("/workOff")
	public String updateWorkOff(@ModelAttribute("loginUser") Member loginUser,Model model) {
		
		int userNo = loginUser.getUserNo();
		int result = attendanceService.updateWorkOff(userNo);
		int update = 0;
		// 퇴근 등록 성공시 member statusType 오프라인으로 변경
		if(result > 0 ) {
			update = attendanceService.updateOfflineStatus(userNo);
			if(update > 0) {
				loginUser.setStatusType(0);
				model.addAttribute("loginUser", loginUser);
			}
		}
		return new Gson().toJson(result*update);
	}
	
	// [가영] - 로그인한 유저의 출퇴근 조회

	@GetMapping("/{userNo}")
	public String selectUserAttendance(@ModelAttribute("loginUser") Member loginUser,
										@PathVariable("userNo") int userNo,
										Model model,
										@RequestParam(value= "year",required = false) Integer year,
										@RequestParam(value= "month", required = false) Integer month,
										@RequestParam(value= "day", required = false) Integer day) {
			System.out.println("들어옴?");
			System.out.println(userNo);
		 
		Map<String, Object> selectUser = new HashMap<>();	
				
		selectUser.put("year", year);
		selectUser.put("month", month);
		selectUser.put("day", day);
		selectUser.put("userNo", loginUser.getUserNo());
				
		List<Attendance> userAd = attendanceService.selectUserAttendance(selectUser);
				
		model.addAttribute("loginUser", loginUser);
		model.addAttribute("userAd", userAd);
		
		System.out.println(selectUser);
		System.out.println(userAd);
				
		return "attendance";
	}
}
