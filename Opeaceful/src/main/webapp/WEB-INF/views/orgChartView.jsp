<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<c:set var="topDept" value="${map['topDeptList']}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<link rel="stylesheet" href="${path}/resources/css/common/common.css">
<link rel="stylesheet" href="${path}/resources/css/orgChart.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/sidebar.jsp" />

	<div id="content-wrap">
		<div class="container">
			<div class="title-box">
				<h2 class="title-common">조직도</h2>
			</div>
			<div class="tree" id="tree">
				<ul>	
					<c:forEach items="${topDept}" var="td">
					<c:set var="deptKey" value="${td.deptCode}Dept"/>
					<c:set var="deptList" value="${map[deptKey]}"/>
						<li>
							<div class="dp-name" id="dp-name">${td.deptName}</div>
								<ul>
									<c:forEach items="${deptList}" var="team">
										<li>
											<table>
												<thead>
													<tr>
														<td scope="col" colspan="2">${team.deptName}</td>
														<td scope="col"></td>
													</tr>
												</thead>
												<c:set var="memberKey" value="${team.deptCode}topDept"/>
												<c:set var="memberList" value="${map[memberKey]}"/>
												<c:forEach items="${memberList}" var="member">
													<tbody>
														<tr>
															<td scope="row">${member.userName}</td>
														  	<td>${member.PName}</td>
														</tr>
													 </tbody>
												</c:forEach>
											</table>
										</li>
									</c:forEach>
								</ul>
							</li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>
	<script type="module" src="${path}/resources/js/orgChart.js"></script>
</body>
</html>