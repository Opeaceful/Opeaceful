package com.company.opeaceful.member.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.company.opeaceful.commom.model.vo.PageInfo;
import com.company.opeaceful.commom.template.Pagination;
import com.company.opeaceful.dept.model.vo.UserDepatment;
import com.company.opeaceful.member.model.dao.MemberDao;
import com.company.opeaceful.member.model.vo.Member;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private Pagination pagination;
	
	
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
	public List<Member> selectMember(int currentPage, Map<String, Object> map, Map<String, Object> selectPD){
		
		
		//페이지네이션 처리
		int listCount = memberDao.selectMemberListCount(selectPD);
		int pageLimit = 5;
		int memberLimit = 2; //테스트용으로 2해둠 나중에 10으로바꾸기
		PageInfo pi = pagination.getPageInfo(listCount, currentPage, pageLimit, memberLimit);
		
		//ajax로 돌려보내줄 map에 pi정보 담아주기
		map.put("pi", pi);
		
		return memberDao.selectMember(pi,selectPD);
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
