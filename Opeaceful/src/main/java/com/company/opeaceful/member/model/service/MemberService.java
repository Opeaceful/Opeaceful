package com.company.opeaceful.member.model.service;

import java.util.List;
import java.util.Map;

import com.company.opeaceful.dept.model.vo.UserDepatment;
import com.company.opeaceful.member.model.vo.Member;
import com.company.opeaceful.member.model.vo.ResignedMember;

public interface MemberService {

	int insertMember(Member m);

	Member loginMember(Member m);
	
	int insertUserDept(UserDepatment ud);

	int selectENO();
	
	List<Member> selectMember(int currentPage, Map<String, Object> map, Map<String, Object> selectPD);
	
	UserDepatment selectdpName(int userNo);

	int updatePwd(Member loginUser);

	Member selectMemberOne(int userNo);

	ResignedMember resignedMembeSelect(int userNo);

	int updateAllmember(Member m);

	int UpdateUserDept(Member m);

}
