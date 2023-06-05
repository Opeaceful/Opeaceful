package com.company.opeaceful.board.controller;

import java.util.Map;

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
@SessionAttributes({"loginUser"}) 
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
							  HttpSession session, HttpServletRequest req, HttpServletResponse resp) {
		
		System.out.println("boardNo 값 : "+ boardNo);
		
		Board detail = boardService.selectBoardDetail(boardNo);
		
		System.out.println("detail담긴ㄱ값 : " + detail);
		
		model.addAttribute("b", detail);
		
		return "board/boardDetailView";
	}


	
	
	
	
	
	
	@GetMapping("/enrollForm/{boardCode}")
	public String boardEnroll() {
		
		return "board/boardEnrollForm";
	}
	
	
	
	
}
