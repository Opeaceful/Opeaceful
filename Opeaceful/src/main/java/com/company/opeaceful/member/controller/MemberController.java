package com.company.opeaceful.member.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
import org.springframework.web.multipart.MultipartFile;

import com.company.opeaceful.board.controller.BoardController;
import com.company.opeaceful.commom.FileRenamePolicy;
import com.company.opeaceful.dept.model.vo.Department;
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
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	@Autowired
	public MemberController(MemberService memberService,  BCryptPasswordEncoder bcryptPasswordEncoder) {
		this.memberService = memberService;
		this.bcryptPasswordEncoder = bcryptPasswordEncoder;
		
	}
	// spring-quartz.xml 사용시 기본생성자 필요
	public MemberController() {}
	
	// [지의] - 마이페이지 > 회원정보 재조회해서 뿌려주기
	@GetMapping("/mypage")
	public String mypageSelectMember(@ModelAttribute ("loginUser") Member loginUser, Model model) {
		logger.info("GET 방식");
		loginUser = memberService.loginMember(loginUser);
		Department topDept = memberService.selecTopDept(loginUser);
		
		model.addAttribute("loginUser", loginUser);
		model.addAttribute("topDept",topDept);

		return "member/mypage";
	}
	
	// [지의] - 마이페이지 > 정보수정
	@PostMapping("/mypage")
	public String updateMember(@RequestParam(value="upfile", required = false) MultipartFile upfile,
							   Member m,
							   Model model,
							   HttpSession session,
							   @ModelAttribute ("loginUser") Member loginUser) {
		
		// 이미지 저장경로 설정
		String webPath = "/resources/image/mypage/";
		String serverFolderPath = session.getServletContext().getRealPath(webPath);
		int result = 0;
		
		// 업로드 파일이 있을경우 -> 변환한 파일명으로 넘겨줌
		if(upfile.getSize() > 0) {
			try {
				String changeName = FileRenamePolicy.saveFile(upfile, serverFolderPath);
				m.setProfileImg(changeName);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			// 업로드 성공시 저장경로에 있는 이미지 삭제
			result = memberService.updateMember(m);
			if(result > 0) {
				File deleteFile = new File(serverFolderPath+loginUser.getProfileImg());
				if(deleteFile.exists()) {	// 파일이 존재하면
					deleteFile.delete();	// 파일 삭제	
				}
			}
		}else {
			result = memberService.updateMember(m);
		}

		// 업데이트에 성공했다면
		if(result > 0) {
			session.setAttribute("alertMsg", "회원정보가 변경되었습니다.");
			return "redirect:/member/mypage";
		}else {
			session.setAttribute("alertMsg", "회원정보가 변경실패");
			return "member/mypage";
		}
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
			// 변경된 비밀번호 암호화 작업
			String EnUpdatePwd = bcryptPasswordEncoder.encode(updatePwd);
			loginUser.setUserPwd(EnUpdatePwd);
			
			result = memberService.updatePwd(loginUser);

			return new Gson().toJson(result);
		}else {
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
			@RequestParam(value="Pselect", required = false) Integer Pselect
			) {
		
		Map<String, Object> selectPD = new HashMap<>();	
		selectPD.put("Dselect", Dselect);
		selectPD.put("Pselect", Pselect);
		
		List<Member> m = memberService.selectMember(selectPD);
		

		return new Gson().toJson(m);
		
	}

	
	
	
	
	
	
}
