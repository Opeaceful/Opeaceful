package com.company.opeaceful.member.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.company.opeaceful.commom.model.vo.PageInfo;
import com.company.opeaceful.commom.template.Pagination;
import com.company.opeaceful.dept.model.vo.Department;
import com.company.opeaceful.dept.model.vo.UserDepartment;
import com.company.opeaceful.member.model.dao.MemberDao;
import com.company.opeaceful.member.model.vo.Member;
import com.company.opeaceful.member.model.vo.ResignedMember;

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
	
	public Member loginMember(Member m) {
		return memberDao.loginMember(m);
	}
	
	@Override
	public int insertUserDept(UserDepartment ud) {
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
		int settingLimit = 10;
		PageInfo pi = pagination.getPageInfo(listCount, currentPage, pageLimit, settingLimit);
		
		//ajax로 돌려보내줄 map에 pi정보 담아주기
		map.put("pi", pi);
		
		return memberDao.selectMember(pi,selectPD);
	}
	
	
	@Override
	public int updatePwd(Member loginUser) {
		return memberDao.updatePwd(loginUser);
	}
	
	@Override
	public Member selectMemberOne(int userNo) {
		return memberDao.selectMemberOne(userNo);
	}
	
	@Override
	public ResignedMember resignedMembeSelect(int userNo) {
		return memberDao.resignedMembeSelect(userNo);
	}
	
	@Override
	public int updateAllmember(Member m) {
		return memberDao.updateAllmember(m);
	}
	
	@Override
	public int UpdateUserDept(Member m) {
		return memberDao.UpdateUserDept(m);
	}
	
	@Override
	public Department selecTopDept(Member loginUser) {
		return memberDao.selecTopDept(loginUser);
	}
	
	@Override
	public int updateMember(Member m) {
		return memberDao.updateMember(m);
	}
	
	@Override
	public List<Object> onlineStatusList() {
		return memberDao.onlineStatusList();
	}
	
	@Override
	public int resignedmember(ResignedMember resignedMember) {
		return memberDao.resignedmember(resignedMember);
	}
	
	@Override
	public int resignedmemberUpdate(ResignedMember resignedMember) {
		return memberDao.resignedmemberUpdate(resignedMember);
	}
	
	@Override
	public int resignedmemberDelete(int userNo) {
		return memberDao.resignedmemberDelete(userNo);
	}
	
	@Override
	public List<Member> modalAllMemberView(String keyword) {
		return memberDao.modalAllMemberView(keyword);
	}
	
	@Override
	public List<Member> checkMemberNoSelect(int currentPage, Map<String, Object> map,int[] intArray){
		
		//페이지네이션 처리
		int listCount = intArray.length;
		int pageLimit = 5;
		int settingLimit = 10;
		PageInfo pi = pagination.getPageInfo(listCount, currentPage, pageLimit, settingLimit);
		
		//ajax로 돌려보내줄 map에 pi정보 담아주기
		map.put("pi", pi);
		
		return memberDao.checkMemberNoSelect(pi,intArray);
	}
	
	@Override
	public int updateStatusType(Map<String, Object> map) {
		return memberDao.updateStatusType(map);
	}
	
	@Override
	public String selectLoginStatus(int eno) {
		return memberDao.selectLoginStatus(eno);
	}
	
	@Override
	public List<Object> selectAnnualMembers(){
		return memberDao.selectAnnualMembers();
	}
	
	@Override
	public int updateAnnualMembers(List<Object> list) {
		return memberDao.updateAnnualMembers(list);
	}
	
	@Override
	public List<Integer> resignedmemberList() {
		return memberDao.resignedmemberList();
	}
	
	@Override
	public int deleteMembers(List<Integer> delist) {
		return memberDao.deleteMembers(delist);
	}
	
	@Override
	public List<Integer> resignedmemberApprovalList(Integer uesrNo){
		return memberDao.resignedmemberApprovalList(uesrNo);
	}
	

}
