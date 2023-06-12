package com.company.opeaceful.role.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.company.opeaceful.member.model.vo.Member;
import com.company.opeaceful.role.model.service.RoleService;
import com.company.opeaceful.role.model.vo.DepartmentRole;
import com.company.opeaceful.role.model.vo.RoleList;
import com.company.opeaceful.role.model.vo.UserRole;
import com.google.gson.Gson;


@Controller
@RequestMapping("/role")
public class RoleController {
	
	@Autowired
	private RoleService roleService;
	
	
	//[지영]
	//granting-role로 이동
	@RequestMapping("/granting")
	public String granting(@SessionAttribute("loginUserRole") List<UserRole> loginUserRole) {
		
		boolean RoleCheck = false;
		
		for(UserRole role :loginUserRole) {
			if (role.getRoleCode().equals("M01")) {
				RoleCheck = true;
	            break;
	        }	
		}
		
		if (RoleCheck) {
			return "role/granting-role";
	    } else {
	    	//일단은 로그인으로 보냄 : 에러페이지?
	    	return "login";
	    }
		
	}
	
	//[지영]
	//부서-직급별 권한조회
	@ResponseBody
	@PostMapping("/roleSelect")
	public String roleSelect(
			DepartmentRole departmentRole
			){
		
		Map<String, Object> map = new HashMap<>();
		
		List<DepartmentRole> dr = roleService.roleSelect(departmentRole);
		List<RoleList> rl = roleService.roleListSelct();
		map.put("dr", dr);
		map.put("rl", rl);
		
		return new Gson().toJson(map);
			
	}
	
	//[지영]
	//권한 부여 또는 삭제
	@ResponseBody
	@PostMapping("/roleGranting")
	public String roleGranting(
			DepartmentRole departmentRole,
			Boolean checked
			){
		
		int result = 0;
		
		//권한 부여라면
		if(checked) {
			result = roleService.roleGrantinginesrt(departmentRole);
		
		}else { //권한 삭제라면
			result = roleService.roleGrantingdelete(departmentRole);
		}
		
		return new Gson().toJson(result);
			
	}
	
	//[지영]
	//user-role로 이동
	@RequestMapping("/userRole")
	public String memberRole(@SessionAttribute("loginUserRole") List<UserRole> loginUserRole) {
		
		boolean RoleCheck = false;
		
		for(UserRole role :loginUserRole) {
			if (role.getRoleCode().equals("M01")) {
				RoleCheck = true;
	            break;
	        }	
		}
		
		if (RoleCheck) {
			return "role/user-role";
	    } else {
	    	//일단은 로그인으로 보냄 : 에러페이지?
	    	return "login";
	    }
		
	}
	
	//[지영]
	//유저 role정보 조회 + 데이터 세팅
	@GetMapping("/selectMRole/{userNo}")
	public String selectMRole(
			@PathVariable("userNo") int userNo,
			HttpSession session,
			Model model) {
		
		//유저 데이터 가져오기
		Member m = roleService.userMemberSelect(userNo);
			
		if(m != null) { //멤버 조회시
			
			//role list도 가져오기
			List<RoleList> rl = roleService.roleListSelct();
			
			//권한도 가져오기
			List<UserRole> ur = roleService.userRoleSelect(userNo);
			
			
			DepartmentRole departmentRole = new DepartmentRole();
			departmentRole.setDeptCode(m.getDeptCode());
			departmentRole.setPCode(m.getPCode());
			
			//부서별 권한도 가져오기 
			List<DepartmentRole> dr = roleService.roleSelect(departmentRole);
			
			if(rl != null && !rl.isEmpty()) {
				//데이터 넣어주기
				model.addAttribute("m", m);
				model.addAttribute("rl", rl);
				model.addAttribute("ur", ur);
				model.addAttribute("dr", dr);
				
				
				return "role/user-role";
				
			}else {
				session.setAttribute("alertMsg", "회사 권한 설정 오류. 담당자에게 문의하세요");
			}
			
		}else{
			session.setAttribute("alertMsg", "유저 권한 설정 오류. 담당자에게 문의하세요");
		}

		return "redirect:/role/userRole";
		
		
	}
		
	
	//[지영]
	//user 권한 부여 또는 삭제
	@ResponseBody
	@PostMapping("/userRoleGranting")
	public String userRoleGranting(
			UserRole userRole,
			Boolean checked
			){
		
		int result = 0;
		
		//권한 부여라면
		if(checked) {
			result = roleService.userRoleGrantinginesrt(userRole);
		
		}else { //권한 삭제라면
			result = roleService.userRoleGrantingdelete(userRole);
		}
		
		return new Gson().toJson(result);
			
	}
	
	

}
