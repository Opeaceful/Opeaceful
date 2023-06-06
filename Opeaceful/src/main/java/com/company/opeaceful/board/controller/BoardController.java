package com.company.opeaceful.board.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.company.opeaceful.board.model.service.BoardService;
import com.company.opeaceful.board.model.vo.Board;
import com.company.opeaceful.member.model.vo.Member;

@Controller
@RequestMapping("/board")
@SessionAttributes({"loginUser", "map"}) 
public class BoardController {

	@Autowired
	private BoardService boardService;
	
	@GetMapping("/list")
	public String settingAnnaul(){
		return "board/boardList";
	}
	
	
	@GetMapping("/list/{boardCode}")
	public String boardList(@ModelAttribute ("loginUser") Member loginUser,
							@RequestParam(value = "cpage", defaultValue = "1") int currentPage,
							@PathVariable("boardCode") String boardCode,
							Model model,
							@RequestParam Map<String, Object> map) {
		
		String userNo = Integer.toString(loginUser.getUserNo());
		
		map.put("userNo", userNo);
		map.put("currentPage", currentPage);
		map.put("boardCode", boardCode);
		
		int rollCount = 0;
		if(map.get("condition") == null) {
			rollCount = boardService.selectNoticeRoll(userNo);	
			boardService.selectBoardList(map);				
		}else {
			rollCount = boardService.selectNoticeRoll(userNo);	
			boardService.selectSearchBoardList(map);
		}
		
		model.addAttribute("map", map);
		model.addAttribute("notiRoll", rollCount);
		
		
		System.out.println("map에 담긴 값 컨트롤러 : " + map);
		System.out.println(" 공지사항 권한관리 유무값(1/0) : " + rollCount);
		return "board/boardList";
	}
	
	
	@GetMapping("/detail/{boardCode}/{boardNo}")
	public String boardDetail(@PathVariable("boardCode") String boardCode,
							  @PathVariable("boardNo") int boardNo,
							  @RequestParam(value = "cpage", required = false, defaultValue = "1") int currentPage,
							  Model model,
							  @ModelAttribute ("map") Map<String, Object> map,
							  HttpSession session, HttpServletRequest req, HttpServletResponse resp) {
		System.out.println("가져온 맵에 리스트" + map);
		
		ArrayList<Board> boardList = (ArrayList<Board>) map.get("list");
		
		System.out.println("객체배열 보드리스트 0번째 보드넘버 :" + boardList.get(3).getBoardNo());
		
		System.out.println("boardNo 값 : "+ boardNo);
		
		Board detail = boardService.selectBoardDetail(boardNo);
		
		System.out.println("detail담긴ㄱ값 : " + detail);
		
		System.out.println("노티롤 담긴 값 : "+map.get("notiRoll"));
		
		String userNo = (String) map.get("userNo");
		
		int rollCount = boardService.selectFreeRoll(userNo);
		
		model.addAttribute("freeRoll", rollCount);
		
		// 조회수 중복 증가 방지 (타인이 작성한 글만 조회수 카운트)
		if (detail != null) { // 상세조회 성공

			Member loginUser = (Member) session.getAttribute("loginUser");

			int memberNo = 0;

			System.out.println("현재 loginUser : " + loginUser);
			memberNo = loginUser.getUserNo();

			// 글쓴이와 현재 상세보기요청을한 클라이언트가 같지 않을 경우에만 조회수 증가서비스 호출.
			if (Integer.parseInt(detail.getBoardWriter()) != memberNo) {
				Cookie cookie = null;

				Cookie[] cArr = req.getCookies(); // 쿠키얻어보기

				if (cArr != null && cArr.length > 0) { // 얻어온 쿠키가 있을경우

					for (Cookie c : cArr) {

						if (c.getName().equals("readBoardNo")) {
							cookie = c;
							System.out.println("c담긴 값 : " + c);
							System.out.println("보드넘버로 된 쿠키 있을때 쿠키 담긴 값 : "+cookie);
						}
					}

				}
				int result = 0;
				if (cookie == null) { // 기존에 readBoardNo라는 이름의 쿠키가 없던 경우
					cookie = new Cookie("readBoardNo", boardNo + "");
					result = boardService.updateAddCount(boardNo); /// 조회수 증가서비스 호출
				} else {
					// readBoardNo가 이미 존재할경우 -> 쿠키에 저장된값 뒤쪽에 현재 조회된 게시글 번호를 추가
					// 단, 기존 쿠키값중에 중복되는 번호가 없어야한다.
					String temp[] = cookie.getValue().split("/");// 기존 value
					// "readBoardNo" / "1/2/3/4/5/6/7/8/9/100"
					System.out.println("temp : "+temp);
					List<String> list = Arrays.asList(temp); // 배열 --> List로 변환시켜주는 함수
					
					// List.indexOf(Object) :
					// - List에서 Object와 일치하는 부분의 인덱스를 반환
					// - 일치하는부분이 없으면 -1을 반환
					if (list.indexOf(boardNo + "") == -1) {// 즉 , 기존값에 같은 글번호가 없다면
						cookie.setValue(cookie.getValue() + "/" + boardNo);
						
						System.out.println("보드넘버 추가 후 쿠키 담긴 값 : "+cookie);
						
						result = boardService.updateAddCount(boardNo); // 조회수 증가서비스 호출
					}

				}
				
				if (result > 0) {

					cookie.setPath(req.getContextPath());
					cookie.setMaxAge(60 * 60 * 1); // 1시간
					resp.addCookie(cookie);
				}

			}

		}
		
		
		
		
		
		
		
		
		model.addAttribute("b", detail);
		
		return "board/boardDetailView";
	}


	
	
	
	
	
	
	@GetMapping("/enrollForm/{boardCode}")
	public String boardEnroll() {
		
		return "board/boardEnrollForm";
	}
	
	
	
	
}
