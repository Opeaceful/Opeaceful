package com.company.opeaceful.member.model.service;

import java.util.List;
import java.util.Map;

import com.company.opeaceful.dept.model.vo.UserDepatment;
import com.company.opeaceful.member.model.vo.Member;

public interface MemberService {

	int insertMember(Member m);

	Member loginMember(Member m);
	
	int insertUserDept(UserDepatment ud);

	int selectENO();

	List<Member> selectMember(Map<String, Object> selectPD);
	
	UserDepatment selectdpName(int userNo);

	

	

}
