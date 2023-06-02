package com.company.opeaceful.board.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

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
import com.company.opeaceful.dept.model.vo.UserDepatment;
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
			
			if(map.get("condition") == null) {
				map.put("userNo", userNo);
				map.put("currentPage", currentPage);
				map.put("boardCode", boardCode);
				
				boardService.selectBoardList(map);				
			}else {
				map.put("userNo", userNo);
				map.put("currentPage", currentPage);
				map.put("boardCode", boardCode);
				boardService.selectSearchBoardList(map);		
			}
			
			model.addAttribute("map", map);
			
			System.out.println("map에 담긴 값 컨트롤러 : " + map);
			
		return "board/boardList";
	}
	
	
	
	
	
	
	
}
