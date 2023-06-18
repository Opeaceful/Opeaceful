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
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;

import com.company.opeaceful.board.controller.BoardController;
import com.company.opeaceful.commom.FileRenamePolicy;
import com.company.opeaceful.dept.model.vo.Department;
import com.company.opeaceful.dept.model.vo.UserDepartment;
import com.company.opeaceful.member.model.service.MemberService;
import com.company.opeaceful.member.model.vo.Member;
import com.company.opeaceful.member.model.vo.ResignedMember;
import com.company.opeaceful.role.model.vo.UserRole;
import com.google.gson.Gson;

@Controller
@RequestMapping("/member") // localhost:8081/spring/member 이하의 url요청을 처리하는 컨트롤러
@SessionAttributes({ "loginUser" })
public class MemberController {

	private MemberService memberService;
	private BCryptPasswordEncoder bcryptPasswordEncoder;

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	@Autowired
	public MemberController(MemberService memberService, BCryptPasswordEncoder bcryptPasswordEncoder) {
		this.memberService = memberService;
		this.bcryptPasswordEncoder = bcryptPasswordEncoder;

	}

	// spring-quartz.xml 사용시 기본생성자 필요
	public MemberController() {
	}

	// [지의] - 마이페이지 > 회원정보 재조회해서 뿌려주기
	@GetMapping("/mypage")
	public String mypageSelectMember(@ModelAttribute("loginUser") Member loginUser, Model model) {
		logger.info("GET 방식");
		loginUser = memberService.loginMember(loginUser);
		Department topDept = memberService.selecTopDept(loginUser);

		model.addAttribute("loginUser", loginUser);
		model.addAttribute("topDept", topDept);

		return "member/mypage";
	}

	// [지의] - 마이페이지 > 정보수정
	@PostMapping("/mypage")
	public String updateMember(@RequestParam(value = "upfile", required = false) MultipartFile upfile, Member m,
			Model model, HttpSession session, @ModelAttribute("loginUser") Member loginUser) {

		// 이미지 저장경로 설정
		String webPath = "/resources/file/mypage/";
		String serverFolderPath = session.getServletContext().getRealPath(webPath);
		int result = 0;

		// 업로드 파일이 있을경우 -> 변환한 파일명으로 넘겨줌
		if (upfile.getSize() > 0) {
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
			if (result > 0) {
				File deleteFile = new File(serverFolderPath + loginUser.getProfileImg());
				if (deleteFile.exists()) { // 파일이 존재하면
					deleteFile.delete(); // 파일 삭제
				}
			}
		} else {
			result = memberService.updateMember(m);
		}

		// 업데이트에 성공했다면
		if (result > 0) {
			session.setAttribute("alertMsg", "회원정보가 변경되었습니다.");
			return "redirect:/member/mypage";
		} else {
			session.setAttribute("alertMsg", "회원정보가 변경실패");
			return "member/mypage";
		}
	}

	// [지의] - 마이페이지 > 비밀번호변경
	@ResponseBody
	@PostMapping("/updatePwd")
	public String updatePwd(@ModelAttribute("loginUser") Member loginUser, String originPwd, String updatePwd) {

		int result = 0;
		// 입력한 현재 비밀번호와 로그인유저의 암호화된 비밀번호의 일치여부 판별
		if (bcryptPasswordEncoder.matches(originPwd, loginUser.getUserPwd())) {
			// 변경된 비밀번호 암호화 작업
			String EnUpdatePwd = bcryptPasswordEncoder.encode(updatePwd);
			loginUser.setUserPwd(EnUpdatePwd);

			result = memberService.updatePwd(loginUser);

			return new Gson().toJson(result);
		} else {
			return new Gson().toJson(result);
		}

	}

	// [지의] - 로그아웃
	@GetMapping("/logout")
	public String logoutMember(HttpSession session, SessionStatus status) {
		status.setComplete();
		return "redirect:/";
	}

	// [지의] 유저 접속상태 변경
	@ResponseBody
	@PostMapping("/updateStatusType")
	public String updateStatusType(@RequestParam("statusType") int statusType,
			@ModelAttribute("loginUser") Member loginUser, HttpSession session) {

		int userNo = loginUser.getUserNo();
		Map<String, Object> map = new HashMap<>();
		map.put("userNo", userNo);
		map.put("statusType", statusType);
		int result = memberService.updateStatusType(map);
		if (result > 0) {
			loginUser.setStatusType(statusType);
			session.setAttribute("loginUser", loginUser);
		}
		return new Gson().toJson(statusType);
	}

	// [지영]
	// member-create로 이동
	@RequestMapping("/create")
	public String createMember(@SessionAttribute("loginUserRole") List<UserRole> loginUserRole, Model model) {

		boolean RoleCheck = false;

		for (UserRole role : loginUserRole) {

			if (role.getRoleCode().equals("M01")) {
				RoleCheck = true;
				break;
			}
		}

		if (RoleCheck) {
			return "member/member-create";
		} else {
			model.addAttribute("errorMsg", "권한이 없습니다");
			return "errorPage";
		}
	}

	// [지영]
	// 사용자생성
	@PostMapping("/insert")
	public String insertMember(Member m, UserDepartment ud, HttpSession session) {

		// 암호화 작업
		String encPwd = bcryptPasswordEncoder.encode(m.getUserPwd());

		// 암호화된 pwd를 m의 userPwd 다시 대입
		m.setUserPwd(encPwd);

		int result = memberService.insertMember(m);

		if (result > 0) { // 성공적으로 추가시
			// 부서추가
			int result2 = memberService.insertUserDept(ud);

			if (result2 > 0) {
				int userEno = memberService.selectENO();
				session.setAttribute("userEno", userEno);

				return "redirect:/member/create";

			} else {
				session.setAttribute("alertMsg", "사용자 부서 생성 오류발생. 담당자에게 문의하세요");
			}
		} else {
			session.setAttribute("alertMsg", "사용자 생성 오류발생. 담당자에게 문의하세요");
		}

		return "redirect:/member/create";

	}

	// [지영]
	// member-allview로 이동
	@RequestMapping("/allview")
	public String memberAllview(@SessionAttribute("loginUserRole") List<UserRole> loginUserRole, Model model) {

		boolean RoleCheck = false;

		for (UserRole role : loginUserRole) {
			if (role.getRoleCode().equals("M01")) {
				RoleCheck = true;
				break;
			}
		}

		if (RoleCheck) {
			return "member/member-allview";
		} else {
			model.addAttribute("errorMsg", "권한이 없습니다");
			return "errorPage";
		}

	}

	// [지영]
	// select박스를 통한 member조회
	@ResponseBody
	@PostMapping("/selectAll")
	public String selectMember(@RequestParam(value = "Dselect", required = false) Integer Dselect,
			@RequestParam(value = "Pselect", required = false) Integer Pselect,
			@RequestParam(value = "Sselect", defaultValue = "Y") String Sselect, Model model,
			@RequestParam(value = "cpage", required = false, defaultValue = "1") int currentPage,
			@RequestParam(value = "checkMemberNo", required = false) String checkMemberNo) {

		// json 다시 int배열로 변경
		int[] intArray = new Gson().fromJson(checkMemberNo, int[].class);

		// ajax로 전송할 데이터
		Map<String, Object> map = new HashMap<>();

		// checkMemberNo에 값이 있다면
		if (intArray != null && intArray.length > 0) {

			List<Member> m = memberService.checkMemberNoSelect(currentPage, map, intArray);
			map.put("m", m);

		} else {
			// 검색 select용 map
			Map<String, Object> selectPD = new HashMap<>();
			selectPD.put("Dselect", Dselect);
			selectPD.put("Pselect", Pselect);
			selectPD.put("Sselect", Sselect);

			List<Member> m = memberService.selectMember(currentPage, map, selectPD);

			map.put("m", m);

		}

		// map 데이터 ajax로 전송
		return new Gson().toJson(map);

	}

	// [지영]
	// member 수정용 개인정보 조회
	@ResponseBody
	@PostMapping("/selectMemberOne")
	public String selectMemberOne(@RequestParam("id") int userNo) {

		// ajax로 전송할 데이터
		Map<String, Object> map = new HashMap<>();

		Member m = memberService.selectMemberOne(userNo);
		// 조회된 멤버
		map.put("m", m);

		// 해당 데이터가 퇴사자라면
		if (m.getStatus().equals("N")) {
			ResignedMember rm = memberService.resignedMembeSelect(userNo);

			// 조회된 퇴사자 정보
			map.put("rm", rm);
		}

		return new Gson().toJson(map);

	}

	// [지영]
	// member 데이터 변경
	@RequestMapping("/updateAllmember")
	public String updateAllmember(Member m, ResignedMember resignedMember, HttpSession session) {

		// 퇴사자였는지 아닌지 체크하기!
		ResignedMember rm = memberService.resignedMembeSelect(resignedMember.getUserNo());

		// 내용변경 + 퇴사자 처리
		// 1. 퇴사일이 있을 경우
		if (resignedMember.getResignedDate() != "") {

			// 상위부서 불러와서 세팅
			Department topDept = memberService.selecTopDept(m);
			resignedMember.setDeptName(topDept.getDeptName());
			resignedMember.setTName(m.getDName());

			int resignedresult = 0;

			if (rm != null) { // 1)퇴사자가 퇴사일을 풀고 내용변경을 했을 경우
				resignedresult = memberService.resignedmemberUpdate(resignedMember);
			} else {// 2)재직자가 처음으로 퇴사처리 됐을때
				resignedresult = memberService.resignedmember(resignedMember);
			}

			if (resignedresult > 0) { // 퇴사자 데이터 저장시
				// 퇴사 설정 세팅
				m.setStatus("N");
			} else {
				session.setAttribute("alertMsg", "퇴사자 오류발생. 담당자에게 문의하세요");
				return "redirect:/member/allview";
			}

		} else {
			if (rm != null) { // 3) 퇴사자가 퇴사일을 삭제했을 경우 -> 재직자로 변경

				int resignedmemberDelete = memberService.resignedmemberDelete(rm.getUserNo());

				if (resignedmemberDelete > 0) { // 재직자로 변경시
					// 퇴사 설정 세팅 변경
					m.setStatus("Y");
				} else {
					session.setAttribute("alertMsg", "퇴사자 오류발생. 담당자에게 문의하세요");
					return "redirect:/member/allview";
				}
			}
		}

		int result = memberService.updateAllmember(m);

		if (result > 0) { // 성공적으로 추가시

			// 부서추가변경
			int result2 = memberService.UpdateUserDept(m);

			if (result2 > 0) {

				session.setAttribute("success", "정보가 수정되었습니다");

				return "redirect:/member/allview";

			} else {
				session.setAttribute("alertMsg", "사용자 부서 변경 오류발생. 담당자에게 문의하세요");
				return "redirect:/member/allview";
			}
		} else {
			session.setAttribute("alertMsg", "사용자 변경 오류발생. 담당자에게 문의하세요");
			return "redirect:/member/allview";
		}

	}

	// [지영]
	// member 비번 초기화
	@ResponseBody
	@PostMapping("/passwordReset")
	public String passwordReset(@RequestParam("eno") int eno) {

		String encPwd = bcryptPasswordEncoder.encode("1234");

		Member m = new Member();
		m.setUserPwd(encPwd);
		m.setEno(eno);

		int result = memberService.updatePwd(m);
		return new Gson().toJson(result);

	}

	// [지영]
	// 모달용 멤버 전체조회
	@ResponseBody
	@PostMapping("/modalAllMemberView")
	public String modalAllMemberView(@RequestParam("keyword") String keyword) {

		List<Member> m = memberService.modalAllMemberView(keyword);

		return new Gson().toJson(m);

	}

}
