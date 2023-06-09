package com.company.opeaceful.member.model.service;

import java.util.List;
import java.util.Map;

import com.company.opeaceful.dept.model.vo.Department;
import com.company.opeaceful.dept.model.vo.UserDepatment;
import com.company.opeaceful.member.model.vo.Member;
import com.company.opeaceful.member.model.vo.ResignedMember;

public interface MemberService {

	int insertMember(Member m);

	Member loginMember(Member m);
	
	int insertUserDept(UserDepatment ud);

	int selectENO();
	
	List<Member> selectMember(int currentPage, Map<String, Object> map, Map<String, Object> selectPD);
	
	//UserDepatment selectdpName(int userNo);

	int updatePwd(Member loginUser);

	Member selectMemberOne(int userNo);

	ResignedMember resignedMembeSelect(int userNo);

	int updateAllmember(Member m);

	int UpdateUserDept(Member m);
	// [지의] - 상위부서 조회
	Department selecTopDept(Member loginUser);

	int updateMember(Member m);

	List<Object> onlineStatusList();
	
	int resignedmember(ResignedMember resignedMember);

	int resignedmemberUpdate(ResignedMember resignedMember);

	int resignedmemberDelete(int userNo);

	List<Member> modalAllMemberView(String keyword);

	List<Member> checkMemberNoSelect(int currentPage, Map<String, Object> map, int[] intArray);

	int updateStatusType(Map<String, Object> map);

	String selectLoginStatus(int eno);

}
