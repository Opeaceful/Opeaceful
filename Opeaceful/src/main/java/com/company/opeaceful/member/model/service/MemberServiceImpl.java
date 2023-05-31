package com.company.opeaceful.member.model.service;

import java.util.List;
import java.util.Map;

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
	public Member loginMember(Member m) {
		return memberDao.loginMember(m);
	}
	
	@Override
	public int insertUserDept(UserDepatment ud) {
		return memberDao.insertUserDept(ud);
	}
	
	@Override
	public int selectENO() {
		return memberDao.selectENO();
	}
	
	@Override
	public List<Member> selectMember(Map<String, Object> selectPD){
		
		System.out.println("service까지옴");
		return memberDao.selectMember(selectPD);
	}
	
	
	@Override
	public UserDepatment selectdpName(int userNo) {
		return memberDao.selectdpName(userNo);
	}
	
	@Override
	public int updatePwd(Member loginUser) {
		return memberDao.updatePwd(loginUser);
	}
}
