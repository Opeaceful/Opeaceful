package com.company.opeaceful.role.model.service;

import java.util.List;

import com.company.opeaceful.member.model.vo.Member;
import com.company.opeaceful.role.model.vo.DepartmentRole;
import com.company.opeaceful.role.model.vo.RoleList;
import com.company.opeaceful.role.model.vo.UserRole;

public interface RoleService {

	List<DepartmentRole> roleSelect(DepartmentRole departmentRole);

	List<RoleList> roleListSelct();

	int roleGrantinginesrt(DepartmentRole departmentRole);

	int roleGrantingdelete(DepartmentRole departmentRole);

	Member userMemberSelect(int userNo);

	List<UserRole> userRoleSelect(int userNo);

	int userRoleGrantinginesrt(UserRole userRole);

	int userRoleGrantingdelete(UserRole userRole);

}
