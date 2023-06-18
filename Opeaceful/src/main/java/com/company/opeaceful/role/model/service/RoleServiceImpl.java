package com.company.opeaceful.role.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.company.opeaceful.member.model.vo.Member;
import com.company.opeaceful.role.model.dao.RoleDao;
import com.company.opeaceful.role.model.vo.DepartmentRole;
import com.company.opeaceful.role.model.vo.RoleList;
import com.company.opeaceful.role.model.vo.UserRole;

@Service
public class RoleServiceImpl implements RoleService {

	@Autowired
	private RoleDao roleDao;

	@Override
	public List<DepartmentRole> roleSelect(DepartmentRole departmentRole) {
		return roleDao.roleSelect(departmentRole);
	}

	@Override
	public List<RoleList> roleListSelct() {
		return roleDao.roleListSelct();
	}

	@Override
	public int roleGrantinginesrt(DepartmentRole departmentRole) {
		return roleDao.roleGrantinginesrt(departmentRole);
	}

	@Override
	public int roleGrantingdelete(DepartmentRole departmentRole) {
		return roleDao.roleGrantingdelete(departmentRole);
	}

	@Override
	public Member userMemberSelect(int userNo) {
		return roleDao.userMemberSelect(userNo);
	}

	@Override
	public List<UserRole> userRoleSelect(int userNo) {
		return roleDao.userRoleSelect(userNo);
	}

	@Override
	public int userRoleGrantinginesrt(UserRole userRole) {
		return roleDao.userRoleGrantinginesrt(userRole);
	}

	@Override
	public int userRoleGrantingdelete(UserRole userRole) {
		return roleDao.userRoleGrantingdelete(userRole);
	}

	@Override
	public List<UserRole> loginUserRoleSelect(int userNo) {
		return roleDao.loginUserRoleSelect(userNo);
	}

}
