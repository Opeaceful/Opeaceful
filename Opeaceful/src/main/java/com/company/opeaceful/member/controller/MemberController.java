package com.company.opeaceful.member.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.company.opeaceful.dept.model.vo.UserDepatment;
import com.company.opeaceful.member.model.service.MemberService;
import com.company.opeaceful.member.model.vo.Member;
import com.google.gson.Gson;

@Controller
@RequestMapping("/member") // localhost:8081/spring/member 이하의 url요청을 처리하는 컨트롤러
@SessionAttributes({"loginUser"})
public class MemberController {
	
	private MemberService memberService;
	private BCryptPasswordEncoder bcryptPasswordEncoder;

	@Autowired
	public MemberController(MemberService memberService,  BCryptPasswordEncoder bcryptPasswordEncoder) {
		this.memberService = memberService;
		this.bcryptPasswordEncoder = bcryptPasswordEncoder;
		
	}
	// spring-quartz.xml 사용시 기본생성자 필요
	public MemberController() {}
	
	// [지의] - 마이페이지
	@RequestMapping("/mypage")
	public String updateMember() {
		
		return "member/mypage";
	}
	
	// [지의] - 마이페이지 > 비밀번호변경
	@ResponseBody
	@PostMapping("/updatePwd")
	public String updatePwd(@ModelAttribute("loginUser") Member loginUser,
							  String originPwd,
							  String updatePwd) {

		int result = 0;
		// 입력한 현재 비밀번호와 로그인유저의 암호화된 비밀번호의 일치여부 판별
		if(bcryptPasswordEncoder.matches(originPwd, loginUser.getUserPwd())) {
			System.out.println("일치함");
			// 변경된 비밀번호 암호화 작업
			String EnUpdatePwd = bcryptPasswordEncoder.encode(updatePwd);
			loginUser.setUserPwd(EnUpdatePwd);
			
			result = memberService.updatePwd(loginUser);

			return new Gson().toJson(result);
		}else {
			System.out.println("다름");
			
			return new Gson().toJson(result);
		}
		
	}
	
	// [지의] - 로그아웃
	@GetMapping("/logout")
	public String logoutMember(HttpSession session, SessionStatus status) {
		status.setComplete();
		return "redirect:/";
	}
	
	//[지영]
	//member-create로 이동
	@RequestMapping("/create")
	public String createMember() {
		
		return "member/member-create";
	}
	
	//[지영]
	//사용자생성 
	@PostMapping("/insert")
	public String insertMember(Member m,
			UserDepatment ud,
			HttpSession session) {
		
		//암호화 작업
		String encPwd = bcryptPasswordEncoder.encode(m.getUserPwd());
		
		//암호화된 pwd를 m의 userPwd 다시 대입
		m.setUserPwd(encPwd);
		
		
		int result = memberService.insertMember(m);
		
		if(result > 0) { //성공적으로 추가시
			//부서추가
			int result2 = memberService.insertUserDept(ud);
			
			if(result2>0) { 
				int userEno = memberService.selectENO();
				session.setAttribute("userEno", userEno);
				
				return "redirect:/member/create";
				
			}else{
				session.setAttribute("alertMsg", "사용자 부서 생성 오류발생. 담당자에게 문의하세요");
			}
		}else {
			session.setAttribute("alertMsg", "사용자 생성 오류발생. 담당자에게 문의하세요");
		}
		
	
		return "member/member-create";
		
	}
	
	//[지영]
	//member-allview로 이동
	@RequestMapping("/allview")
	public String memberAllview() {
		return "member/member-allview";
	}
	
	
	//[지영]
	//select박스를 통한 member조회
	@ResponseBody
	@PostMapping("/selectAll")
	public String selectMember(
			@RequestParam(value="Dselect", required = false) Integer Dselect,
			@RequestParam(value="Pselect", required = false) Integer Pselect,
			@RequestParam("Sselect") String Sselect	,
			Model model,
			@RequestParam(value="cpage", required = false, defaultValue = "1") int currentPage
			) {
		
		
		//ajax로 전송할 데이터 
		Map<String, Object> map = new HashMap<>();	
		
		//검색 select용 map
		Map<String, Object> selectPD = new HashMap<>();	
		selectPD.put("Dselect", Dselect);
		selectPD.put("Pselect", Pselect);
		selectPD.put("Sselect", Sselect);
		
		
		List<Member> m = memberService.selectMember(currentPage,map,selectPD);

		map.put("m", m);
		
		//map 데이터 ajax로 전송
		return new Gson().toJson(map);
		
	}
	
	
	//[지영]
	// member 수정용 개인정보 조회
	@ResponseBody
	@PostMapping("/selectMemberOne")
	public String selectMemberOne(
			@RequestParam("id") int userNo) {
		
		Member m = memberService.selectMemberOne(userNo);
		
		return new Gson().toJson(m);
	}

	
	
	
	
	
	
}
