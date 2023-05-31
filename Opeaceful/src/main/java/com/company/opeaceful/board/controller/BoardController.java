package com.company.opeaceful.board.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.company.opeaceful.board.model.service.BoardService;

@Controller
public class BoardController {

	@Autowired
	private BoardService boardService;
}
