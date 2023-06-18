package com.company.opeaceful.orgChart.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.company.opeaceful.dept.model.vo.UserDepartment;
import com.company.opeaceful.member.model.vo.Member;
import com.company.opeaceful.orgChart.model.vo.OrgChart;

@Repository
public class OrgChartDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	// 상위부서 추가
	public int insertTopDp(OrgChart orgChart) {
		
		int result = sqlSession.insert("orgChartMapper.insertTopDp", orgChart);
		
		// 부서추가 성공 시 selectKey 태그를 이용해서 세팅한 DeptCode값을 orgChart 객체 안에 담아서 반환시켜줌
		if (result > 0) {
			result = orgChart.getDeptCode();
		}
		return result;
	}
	
	// 부서명 변경
	public int updateTopDp(OrgChart orgChart) {
		
		int result =  sqlSession.update("orgChartMapper.updateTopDp", orgChart);
		
		if (result > 0) {
			result = orgChart.getDeptCode();
		}
		
		return result;
	}
	
	// 상위부서 삭제
	public int deleteDeptCode(Map<String, Object> map) {
		
		
		int result = sqlSession.delete("orgChartMapper.deleteDeptCode", map);
		
		return result;
	}
	
	// 하위부서 추가
	public int insertDp(OrgChart orgChart) {
		
		int result = sqlSession.insert("orgChartMapper.insertDp", orgChart);
		
		if (result > 0) {
			result = orgChart.getDeptCode();
		}
		return result;
	}
	
	// 하위부서 사원 조회
	public List<UserDepartment> selectMember(int deptCode) {
		return sqlSession.selectList("deptMapper.selectMember", deptCode);
	}
	
	// 직급추가
	public int insertPname(OrgChart orgChart) {
		
		int result = sqlSession.insert("orgChartMapper.insertPname", orgChart);
		
		if (result > 0) {
			result = orgChart.getPCode();
		}
		
		return result;
	}
	
	// 직급명 변경
	public int updatePname(OrgChart orgChart) {
		
		int result = sqlSession.update("orgChartMapper.updatePname", orgChart);
		
		return result;
	}
	
	// 부서조회
	public int selectDept(OrgChart orgChart) {
		
		int result = sqlSession.selectOne("orgChartMapper.selectDept", orgChart);
		
		return result;
	}
	
	// 직급조회
	public int selectPosition(OrgChart orgChart) {
		int result = sqlSession.selectOne("orgChartMapper.selectPosition", orgChart);
		return result;
	}
	
	// 직급삭제
	public int deletePosition(int pCode) {
		int result = sqlSession.delete("orgChartMapper.deletePosition", pCode);
		return result;
	}
	
	// 조직도 조회
	public List<OrgChart> selectTopDeptList(int deptCode){
		return sqlSession.selectList("orgChartMapper.selectTopDeptList", deptCode);
	}
	
	public List<OrgChart> selectTopDeptUser(int deptCode){
		return sqlSession.selectList("orgChartMapper.selectTopDeptUser", deptCode);
	}
	
	// 조직도 명함
	public List<Member> businessCard(int userNo) {
		return sqlSession.selectList("memberMapper.businessCard", userNo);
	}
	
	// 인사발령 사원 조회
	public List<OrgChart> selectPersonnel(Map<String, Object> map) {
		return sqlSession.selectList("orgChartMapper.selectPersonnel", map);
	}
	
	// 인사발령
	public int updatePersonnel(Map<String, Object> paramMap) {
		return sqlSession.update("orgChartMapper.updatePersonnel", paramMap);
	}
}
