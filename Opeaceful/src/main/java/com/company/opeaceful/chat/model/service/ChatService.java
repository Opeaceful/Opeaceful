package com.company.opeaceful.chat.model.service;

import java.util.ArrayList;

import com.company.opeaceful.board.model.vo.Board;
import com.company.opeaceful.member.model.vo.Member;
import com.company.opeaceful.member.model.vo.OnlineStatus;

public interface ChatService {
	
	public abstract ArrayList<Member> adminAll();
	
	public abstract ArrayList<OnlineStatus> onlineStatusList();
	
	public abstract ArrayList<Board> noticeList();

}
