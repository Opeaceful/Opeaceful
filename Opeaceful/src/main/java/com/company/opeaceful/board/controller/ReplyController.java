package com.company.opeaceful.board.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.company.opeaceful.board.model.service.ReplyService;
import com.company.opeaceful.board.model.vo.BoardReply;
import com.google.gson.Gson;

@RestController
@RequestMapping("/reply")
@SessionAttributes({"loginUser"}) 
public class ReplyController {

	@Autowired
	private ReplyService replyService;
	
	// 댓글 등록
	@PostMapping("/insert")
	public int insertReply(BoardReply reply) {
		return replyService.insertReply(reply);
	}
	
	// 댓글 조회
	@GetMapping("/selectReplyList")
	public String selectReplyList(int bno) {
		List<BoardReply> rList = replyService.selectReplyList(bno);
		return new Gson().toJson(rList);
	}
	
	// 댓글 삭제
	@GetMapping("/delete")
	public int deleteReply(int replyNo) {
		return replyService.deleteReply(replyNo);
	}
	
	//댓글 수 조회
	@PostMapping("/replyCount")
	public String replyCount(int bno) {
		 int result = replyService.replyCount(bno);
		return new Gson().toJson(result);
	}
}
