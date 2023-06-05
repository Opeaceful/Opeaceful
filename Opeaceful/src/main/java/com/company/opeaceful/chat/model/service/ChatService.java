package com.company.opeaceful.chat.model.service;

import java.util.ArrayList;

import com.company.opeaceful.chat.model.vo.OnlineStatus;
import com.company.opeaceful.member.model.vo.Member;

public interface ChatService {
	
	public abstract ArrayList<Member> adminAll();
	
	public abstract ArrayList<OnlineStatus> chatStatus();

}
