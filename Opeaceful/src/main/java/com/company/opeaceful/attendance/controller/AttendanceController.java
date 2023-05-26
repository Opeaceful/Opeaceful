package com.company.opeaceful.attendance.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.company.opeaceful.attendance.model.service.AttendanceService;

@Controller
@RequestMapping("/attendance")
@SessionAttributes({"loginUser"})
public class AttendanceController {

	private AttendanceService attendanceService;
	
	@Autowired
	public AttendanceController(AttendanceService attendanceService) {
		this.attendanceService = attendanceService;
	}
	
//	quartz 사용할 때를 위해 작성만 함
//	public AttendanceController() {
//		
//	}
	
	@RequestMapping("/attendanceInquiry")
	public String selectAttendance() {
		return "attendance";
	}
}
