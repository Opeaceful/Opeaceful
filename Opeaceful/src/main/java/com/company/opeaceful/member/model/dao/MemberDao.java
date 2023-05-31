package com.company.opeaceful.member.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.company.opeaceful.commom.model.vo.PageInfo;
import com.company.opeaceful.dept.model.vo.UserDepatment;
import com.company.opeaceful.member.model.vo.Member;

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
		
		int offset = (pi.getCurrentPage() - 1) * pi.getMemberLimit();
		int limit = pi.getMemberLimit();
		
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
}
