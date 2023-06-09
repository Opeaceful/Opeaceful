package com.company.opeaceful.dept.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.company.opeaceful.dept.model.service.DeptService;
import com.company.opeaceful.dept.model.vo.Department;
import com.company.opeaceful.dept.model.vo.Position;
import com.google.gson.Gson;

@Controller
@RequestMapping("/dept")
public class DeptController {

	@Autowired
	private DeptService deptService;

	// [지영]
	// 부서명 select
	@ResponseBody
	@GetMapping("/selectDept")
	public String selectDept() {

		List<Department> dList = deptService.selectDeptList();

		return new Gson().toJson(dList);
	}

	// [지영]
	// 직급명 select
	@ResponseBody
	@GetMapping("/selectPosition")
	public String selectPosition() {

		List<Position> dList = deptService.selectPosition();

		return new Gson().toJson(dList);
	}

	// [지영]
	// 전체부서+직급 조회
	@ResponseBody
	@GetMapping("/selectAllDept")
	public String selectAllDept() {

		Map<String, Object> map = new HashMap<>();

		List<Department> dList = deptService.selectDeptList();
		List<Position> PList = deptService.selectPosition();

		map.put("dList", dList);
		map.put("PList", PList);

		return new Gson().toJson(map);
	}

}
