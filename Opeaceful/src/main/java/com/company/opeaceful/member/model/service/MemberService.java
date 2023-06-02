package com.company.opeaceful.member.model.service;

import java.util.List;
import java.util.Map;

import com.company.opeaceful.dept.model.vo.Department;
import com.company.opeaceful.dept.model.vo.UserDepatment;
import com.company.opeaceful.member.model.vo.Member;

public interface MemberService {

	int insertMember(Member m);

	Member loginMember(Member m);
	
	int insertUserDept(UserDepatment ud);

	int selectENO();
	
	List<Member> selectMember(Map<String, Object> selectPD);
	
	int updatePwd(Member loginUser);

	// [지의] - 상위부서 조회
	Department selecTopDept(Member loginUser);

	int updateMember(Member m);

}
