package com.company.opeaceful.role.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.company.opeaceful.member.model.vo.Member;
import com.company.opeaceful.role.model.vo.DepartmentRole;
import com.company.opeaceful.role.model.vo.RoleList;
import com.company.opeaceful.role.model.vo.UserRole;

@Repository
public class RoleDao {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public List<DepartmentRole> roleSelect(DepartmentRole departmentRole) {
		return sqlSession.selectList("roleMapper.roleSelect",departmentRole);
	}

	public List<RoleList> roleListSelct() {
		return sqlSession.selectList("roleMapper.roleListSelct");
	}

	public int roleGrantinginesrt(DepartmentRole departmentRole) {
		return sqlSession.insert("roleMapper.roleGrantinginesrt",departmentRole);
	}

	public int roleGrantingdelete(DepartmentRole departmentRole) {
		return sqlSession.delete("roleMapper.roleGrantingdelete",departmentRole);
	}

	public Member userMemberSelect(int userNo) {
		return sqlSession.selectOne("memberMapper.selectMemberOne",userNo);
	}

	public List<UserRole> userRoleSelect(int userNo) {
		return sqlSession.selectList("roleMapper.userRoleSelect",userNo);
	}

	public int userRoleGrantinginesrt(UserRole userRole) {
		return sqlSession.insert("roleMapper.userRoleGrantinginesrt",userRole);
	}

	public int userRoleGrantingdelete(UserRole userRole) {
		return sqlSession.delete("roleMapper.userRoleGrantingdelete",userRole);
	}

	public List<UserRole> loginUserRoleSelect(int userNo) {
		return sqlSession.selectList("roleMapper.loginUserRoleSelect",userNo);
	}

}
