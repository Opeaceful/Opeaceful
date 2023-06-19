package com.company.opeaceful.orgChart.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.company.opeaceful.board.model.service.BoardService;
import com.company.opeaceful.dept.model.service.DeptService;
import com.company.opeaceful.dept.model.vo.Department;
import com.company.opeaceful.dept.model.vo.Position;
import com.company.opeaceful.dept.model.vo.UserDepartment;
import com.company.opeaceful.member.model.vo.Member;
import com.company.opeaceful.orgChart.model.service.OrgChartService;
import com.company.opeaceful.orgChart.model.vo.OrgChart;
import com.google.gson.Gson;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/orgChart")
@SessionAttributes({"loginUser"})
public class OrgChartController {

	private OrgChartService orgchartService;
	private DeptService deptService;
	private BoardService boardService;
	
	@Autowired
	public OrgChartController(OrgChartService orgchartService, 
								DeptService deptService,
								BoardService boardService) {
		this.orgchartService = orgchartService;
		this.deptService = deptService;
		this.boardService = boardService;
	}
	
//	quartz 사용할 때를 위해 작성만 함
//	public OrgChartController() {
//		
//	}
	
	@GetMapping("/")
	public String orgChart() {	
		return "orgChart/orgChartEnroll";
	}
	
	// 부서조회
	@PostMapping("/selectDept")
	@ResponseBody
	public String selectDept() {
		List<Department> dList = orgchartService.selectAllDeptList();
		return new Gson().toJson(dList);
	}
	
	// 상위부서 추가
	@PostMapping("/insertDeptCode")
	@ResponseBody
	public int insertTopDp(OrgChart orgChart) {
		
		int result = orgchartService.insertTopDp(orgChart);

		return result;
	}
	
	// 부서명 변경
	@PostMapping("/updateDeptName")
	@ResponseBody
	public int updateTopDp(OrgChart orgChart) {
		
		int result = orgchartService.updateTopDp(orgChart);

		return result;
	}
	
	// 상위부서 삭제
	@PostMapping("/deleteTopDeptCode")
	@ResponseBody
	public int deleteDeptCode(OrgChart orgChart, int deptCode, int topDeptCode) {
		
		System.out.println("==============================================="+deptCode + "" + topDeptCode);
		
		Map<String, Object> map = new HashMap<>();	
		
		map.put("deptCode", deptCode);
		map.put("topDeptCode", topDeptCode);
		
		
		int result = orgchartService.selectDept(orgChart);
		
//		List<UserDepatment> udList = orgchartService.selectMember(deptCode);
//		
//		if (udList == null && udList.size() > 0) {
//			result = orgchartService.deleteDeptCode(map);			
//		}
		
		if (result <= 0) {
			orgchartService.deleteDeptCode(map);
		}
		
		return result;
	}
	
	// 하위부서 추가
	@PostMapping("/insertTopDeptCode")
	@ResponseBody
	public int insertDp(OrgChart orgChart) {
		
		int result = orgchartService.insertDp(orgChart);

		return result;
	}
	
	// 하위부서 사원 조회
	@PostMapping("/selectAll")
	@ResponseBody
	public String selectMember(int deptCode) {
		
		List<UserDepartment> udList = orgchartService.selectMember(deptCode);
		
		return new Gson().toJson(udList);		
	}
	
	// 직급 조회
	@ResponseBody
	@PostMapping("/selectPosition")
	public String selectPosition() {
			
		List<Position> dList = deptService.selectPosition();
			
		return new Gson().toJson(dList);
	}
	
	// 직급 추가
	@PostMapping("/insertPosition")
	@ResponseBody
	public int insertPname(OrgChart orgChart) {
			
		int result = orgchartService.insertPname(orgChart);

		return result;
	}
	
	// 직급명 변경
	@PostMapping("/updatePname")
	@ResponseBody
	public String updatePname(OrgChart orgChart) {
				
		int result = orgchartService.updatePname(orgChart);

		return new Gson().toJson(result);
	}
	
	// 직급 삭제
	@PostMapping("/deletePosition")
	@ResponseBody
	public int deletePosition(OrgChart orgChart, int pCode) {
		
		int result = orgchartService.selectPosition(orgChart);
		
		if (result <= 0) {
			orgchartService.deletePosition(pCode);
		}
		
		return result;
	}
	
	// 조직도 조회
	@GetMapping("/selectOrgChart")
	public String selectOrgChart(Model model) {
		
		Map<String, Object> map = new HashMap<>();
		
		// 상위부서 리스트 map
		List<Department> topDeptList = boardService.selectDeptList();
		map.put("topDeptList", topDeptList);
		
		for (Department topDepartment : topDeptList) {
			// 하위부서 리스트 map
			List<OrgChart> deptList = orgchartService.selectTopDeptList(topDepartment.getDeptCode());
			map.put(topDepartment.getDeptCode()+"Dept", deptList);
			
			for (OrgChart department : deptList) {
				// 하위부서에 속한 사원들 map
				List<OrgChart> topDeptUser = orgchartService.selectTopDeptUser(department.getDeptCode());
				map.put(department.getDeptCode()+"topDept", topDeptUser);
			}
		}
		
		model.addAttribute("map", map);
			
		return "orgChart/orgChartView";
			
	}
	
	// 조직도 명함
	@PostMapping("/businessCard")
	@ResponseBody
	public String businessCard(int userNo) {
		
		List<Member> list = orgchartService.businessCard(userNo);
		
		return new Gson().toJson(list);
	}
	
	// 인사발령용 사원 조회
	@PostMapping("/personnel")
	@ResponseBody
	public String selectPersonnel(int deptCode,int topDeptCode) {
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("deptCode", deptCode);
		map.put("topDeptCode", topDeptCode);
		
		List<OrgChart> personnelList = orgchartService.selectPersonnel(map);
		
		return new Gson().toJson(personnelList);
				
	}
	
	// 인사발령 
	@PostMapping("updatePersonnel")
	@ResponseBody
	public int updatePersonnel(@RequestParam String jsonData) {
	 
	    Map<String, Object> paramMap = new HashMap<String, Object>();
	    
	    JSONArray array = JSONArray.fromObject(jsonData);
        
	    List<Map<String, Object>> resendList = new ArrayList<Map<String, Object>>();
		
	    for(int i=0; i<array.size(); i++){
	        
	        //JSONArray 형태의 값을 가져와 JSONObject 로 풀어준다.    
	        JSONObject obj = (JSONObject)array.get(i);
	                
	        Map<String, Object> resendMap = new HashMap<String, Object>();
	            
	        resendMap.put("userNo", obj.get("userNo"));
	        resendMap.put("deptCode", obj.get("deptCode"));
	        resendMap.put("pCode", obj.get("pCode"));
	            
	        resendList.add(resendMap);
	    }
	 
	    paramMap.put("resendList", resendList);
	 
	    int cnt = orgchartService.updatePersonnel(paramMap);
	        
	    return cnt;
		
	}
}
