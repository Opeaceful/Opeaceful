package com.company.opeaceful.board.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.company.opeaceful.board.model.service.BoardService;
import com.company.opeaceful.board.model.vo.Board;

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
	
//	@GetMapping("/list/{boardCode}")
//	public String boardList(@PathVariable("boardCode") String boardCode,
//							@RequestParam(value = "cpage", defaultValue = "1") int currentPage,
//							Model model,
//							@RequestParam Map<String, Object> paramMap) {
//		
//		Map<String, Object> map = new HashMap();
//		
//		ArrayList<Board> list = boardService.selectBoardList(currentPage, boardCode);
//	
//		model.addAttribute("list", list);
//		
//		return "board/boardList";
//	}
	
	@GetMapping("/list/{boardCode}")

		public String boardList(@PathVariable("boardCode") String boardCode,
		Model model) {

			ArrayList<Board> list = boardService.selectBoardList(boardCode);
			
			model.addAttribute("list", list);
			
//			System.out.println("loginUser" + loginUser);

		
		
		return "board/boardList";
	}
	
	
	
	
	
	
	
}
