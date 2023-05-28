package com.company.opeaceful.member.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.company.opeaceful.member.model.dao.MemberDao;
import com.company.opeaceful.member.model.vo.Member;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao memberDao;
	
	
	@Override
	public int insertMember(Member m) {
		
		System.out.println("sys"+m);
		
		return memberDao.insertMember(m);
	}
}
