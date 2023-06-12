package com.company.opeaceful.member.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.company.opeaceful.dept.model.vo.Department;
import com.company.opeaceful.commom.model.vo.PageInfo;
import com.company.opeaceful.dept.model.vo.UserDepatment;
import com.company.opeaceful.member.model.vo.Member;
import com.company.opeaceful.member.model.vo.ResignedMember;

@Repository
public class MemberDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession; // root-context.xml에서 생성해둠
	// connection관리를 service에서 할필요 x -> 자동으로 관리해주기 때문

	public int insertMember(Member m) {
		
		return sqlSession.insert("memberMapper.insertMember", m);
	}

	public Member loginMember(Member m) {
		return sqlSession.selectOne("memberMapper.loginMember", m);
	}
	public int insertUserDept(UserDepatment ud) {
		return sqlSession.insert("memberMapper.insertUserDept", ud);
	}

	public int selectENO() {
		return sqlSession.selectOne("memberMapper.selectENO");
	}

	public List<Member> selectMember(PageInfo pi,Map<String, Object> selectPD) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getSettingLimit();
		int limit = pi.getSettingLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);

		return sqlSession.selectList("memberMapper.selectMember",selectPD,rowBounds);
	}

	public UserDepatment selectdpName(int userNo) {
		return sqlSession.selectOne("deptMapper.selectdpName", userNo);
	}

	public int updatePwd(Member loginUser) {
		return sqlSession.update("memberMapper.updatePwd",loginUser);
	}

	public int selectMemberListCount(Map<String, Object> selectPD) {
		return sqlSession.selectOne("memberMapper.selectMemberCount", selectPD);
	}

	public Member selectMemberOne(int userNo) {
		return sqlSession.selectOne("memberMapper.selectMemberOne",userNo);
	}

	public ResignedMember resignedMembeSelect(int userNo) {
		return sqlSession.selectOne("resignedMapper.resignedMembeSelect",userNo);
	}

	public int updateAllmember(Member m) {
		return sqlSession.update("memberMapper.updateAllmember",m);
	}

	public int UpdateUserDept(Member m) {
		return sqlSession.update("memberMapper.updateUserDept",m);
	}

	public Department selecTopDept(Member loginUser) {
		return sqlSession.selectOne("deptMapper.selecTopDept", loginUser);
	}

	public int updateMember(Member m) {
		return sqlSession.update("memberMapper.updateMember",m);
	}
	
	public List<Object> onlineStatusList() {
		return sqlSession.selectList("attendanceMapper.onlineStatusList");
	}

	public int resignedmember(ResignedMember resignedMember) {
		return sqlSession.insert("resignedMapper.resignedmember",resignedMember);
	}

	public int resignedmemberUpdate(ResignedMember resignedMember) {
		return sqlSession.update("resignedMapper.resignedmemberUpdate",resignedMember);
	}

	public int resignedmemberDelete(int userNo) {
		return sqlSession.delete("resignedMapper.resignedmemberDelete",userNo );
	}

	public List<Member> modalAllMemberView(String keyword) {
		return sqlSession.selectList("memberMapper.modalAllMemberView",keyword);
	}

	public List<Member> checkMemberNoSelect(PageInfo pi, int[] intArray) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getSettingLimit();
		int limit = pi.getSettingLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return sqlSession.selectList("memberMapper.checkMemberNoSelect",intArray,rowBounds);
	}

	public int updateStatusType(Map<String, Object> map) {
		return sqlSession.update("memberMapper.updateStatusType",map);
	}

	public String selectLoginStatus(int eno) {
		return sqlSession.selectOne("memberMapper.selectLoginStatus",eno);
	}

	public List<Object> selectAnnualMembers() {
		return sqlSession.selectList("memberMapper.selectAnnualMembers");
	}

	public int updateAnnualMembers(List<Object> list) {
		return sqlSession.update("memberMapper.updateAnnualMembers", list);
	}


}
