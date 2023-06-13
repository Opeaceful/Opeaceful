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
	@GetMapping("/check")
	public String selectUserAttendance(@ModelAttribute("loginUser") Member loginUser,
										@RequestParam(value= "userNo",required = false) Integer userNo,
										Model model,
										@RequestParam(value= "year1",required = false) Integer year1,
										@RequestParam(value= "month1", required = false) Integer month1,
										@RequestParam(value= "day1", required = false) Integer day1,
										@RequestParam(value= "year2",required = false) Integer year2,
										@RequestParam(value= "month2", required = false) Integer month2,
										@RequestParam(value= "day2", required = false) Integer day2,
										@RequestParam(value = "cpage", defaultValue = "1") int currentPage) {
		 
		Map<String, Object> selectUser = new HashMap<>();	
		
		String startDate = year1 + "-" + month1 + "-" + day1;
		String endDate = year2 + "-" + month2 + "-" + day2;
			
		selectUser.put("startDate", startDate);
		selectUser.put("endDate", endDate);
		selectUser.put("userNo", loginUser.getUserNo());
		selectUser.put("currentPage", currentPage);
		
		selectUser.put("year1", year1);
		selectUser.put("month1", month1);
		selectUser.put("day1", day1);
		selectUser.put("year2", year2);
		selectUser.put("month2", month2);
		selectUser.put("day2", day2);
				
		List<Attendance> adList = attendanceService.selectUserAttendance(selectUser, currentPage);
				
		model.addAttribute("loginUser", loginUser);
		model.addAttribute("adList", adList);
		model.addAttribute("map", selectUser);
		
		System.out.println("selectUser에 담긴 값 : "+selectUser);
		System.out.println("adList에 담긴 값 : "+adList);
				
		return "attendance";
	}
	
	// [가영] - 로그인한 유저의 출퇴근 조회
	@GetMapping("/allCheck")
	public String selectAllUserAttendance(@RequestParam(value= "userNo",required = false) Integer userNo,
											Model model,
											@RequestParam(value= "year1",required = false) Integer year1,
											@RequestParam(value= "month1", required = false) Integer month1,
											@RequestParam(value= "day1", required = false) Integer day1,
											@RequestParam(value= "year2",required = false) Integer year2,
											@RequestParam(value= "month2", required = false) Integer month2,
											@RequestParam(value= "day2", required = false) Integer day2,
											@RequestParam(value = "cpage", defaultValue = "1") int currentPage,
											@RequestParam(value="no", required = false) int[] no) {
			 
		Map<String, Object> selectAllUser = new HashMap<>();	
			
		String startDate = year1 + "-" + month1 + "-" + day1;
		String endDate = year2 + "-" + month2 + "-" + day2;
				
		selectAllUser.put("startDate", startDate);
		selectAllUser.put("endDate", endDate);
		selectAllUser.put("currentPage", currentPage);
		selectAllUser.put("no", no);
		
		selectAllUser.put("year1", year1);
		selectAllUser.put("month1", month1);
		selectAllUser.put("day1", day1);
		selectAllUser.put("year2", year2);
		selectAllUser.put("month2", month2);
		selectAllUser.put("day2", day2);
					
		List<Attendance> adList = attendanceService.selectAllUserAttendance(selectAllUser, currentPage);
		
		model.addAttribute("adList", adList);
		model.addAttribute("map", selectAllUser);
			
		System.out.println("selectAllUser에 담긴 값 : "+selectAllUser);
		System.out.println("adList에 담긴 값 : "+adList);
					
		return "attendance";
	}
	
}
