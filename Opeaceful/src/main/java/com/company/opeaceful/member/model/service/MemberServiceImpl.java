package com.company.opeaceful.member.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.company.opeaceful.dept.model.vo.UserDepatment;
import com.company.opeaceful.member.model.dao.MemberDao;
import com.company.opeaceful.member.model.vo.Member;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao memberDao;
	
	
	@Override
	public int insertMember(Member m) {
		
		return memberDao.insertMember(m);
	}
	
	@Override
	public int insertUserDept(UserDepatment ud) {
		return memberDao.insertUserDept(ud);
	}
	
	@Override
	public int selectENO() {
		return memberDao.selectENO();
	}
	
	public List<Member> selectMember(){
		return memberDao.selectMember();
	}
}
