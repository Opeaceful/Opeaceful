<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
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
					<li>
						<div class="dp-name" id="dp-name"></div>
						<ul >
							<li >
								<table>
									<thead>
										<tr>
										  <td scope="col" colspan="2">회계팀</td>
										  <td scope="col"></td>
										</tr>
									  </thead>
									  <tbody>
										<tr>
										  <td scope="row">장팀장</td>
										  <td>부장</td>
										</tr>
										<tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
									  </tbody>
								</table>
							</li>
							<li>
								<table>
									<thead>
										<tr>
										  <td scope="col" colspan="2">회계팀</td>
										  <td scope="col"></td>
										</tr>
									  </thead>
									  <tbody>
										<tr>
										  <td scope="row">장팀장</td>
										  <td>부장</td>
										</tr>
										<tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
									  </tbody>
								</table>
							</li>
							<li>
								<a href="#">Great Grand Child</a>
							</li>
						</ul>
					</li>
					<li>
						<div class="dp-name">경영지원본부</div>
						<ul >
							<li >
								<table>
									<thead>
										<tr>
										  <td scope="col" colspan="2">회계팀</td>
										  <td scope="col"></td>
										</tr>
									  </thead>
									  <tbody>
										<tr>
										  <td scope="row">장팀장</td>
										  <td>부장</td>
										</tr>
										<tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
									  </tbody>
								</table>
							</li>
							<li>
								<table>
									<thead>
										<tr>
										  <td scope="col" colspan="2">회계팀</td>
										  <td scope="col"></td>
										</tr>
									  </thead>
									  <tbody>
										<tr>
										  <td scope="row">장팀장</td>
										  <td>부장</td>
										</tr>
										<tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
									  </tbody>
								</table>
							</li>
							<li>
								<a href="#">Great Grand Child</a>
							</li>
						</ul>
					</li>
					<li>
						<div class="dp-name">경영지원본부</div>
						<ul >
							<li >
								<table>
									<thead>
										<tr>
										  <td scope="col" colspan="2">회계팀</td>
										  <td scope="col"></td>
										</tr>
									  </thead>
									  <tbody>
										<tr>
										  <td scope="row">장팀장</td>
										  <td>부장</td>
										</tr>
										<tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
									  </tbody>
								</table>
							</li>
							<li>
								<table>
									<thead>
										<tr>
										  <td scope="col" colspan="2">회계팀</td>
										  <td scope="col"></td>
										</tr>
									  </thead>
									  <tbody>
										<tr>
										  <td scope="row">장팀장</td>
										  <td>부장</td>
										</tr>
										<tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
									  </tbody>
								</table>
							</li>
							<li>
								<a href="#">Great Grand Child</a>
							</li>
						</ul>
					</li>
					<li>
						<div class="dp-name">경영지원본부</div>
						<ul >
							<li >
								<table>
									<thead>
										<tr>
										  <td scope="col" colspan="2">회계팀</td>
										  <td scope="col"></td>
										</tr>
									  </thead>
									  <tbody>
										<tr>
										  <td scope="row">장팀장</td>
										  <td>부장</td>
										</tr>
										<tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
									  </tbody>
								</table>
							</li>
							<li >
								<table>
									<thead>
										<tr>
										  <td scope="col" colspan="2">회계팀</td>
										  <td scope="col"></td>
										</tr>
									  </thead>
									  <tbody>
										<tr>
										  <td scope="row">장팀장</td>
										  <td>부장</td>
										</tr>
										<tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
									  </tbody>
								</table>
							</li>
							<li >
								<table>
									<thead>
										<tr>
										  <td scope="col" colspan="2">회계팀</td>
										  <td scope="col"></td>
										</tr>
									  </thead>
									  <tbody>
										<tr>
										  <td scope="row">장팀장</td>
										  <td>부장</td>
										</tr>
										<tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
									  </tbody>
								</table>
							</li>
							<li >
								<table>
									<thead>
										<tr>
										  <td scope="col" colspan="2">회계팀</td>
										  <td scope="col"></td>
										</tr>
									  </thead>
									  <tbody>
										<tr>
										  <td scope="row">장팀장</td>
										  <td>부장</td>
										</tr>
										<tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
									  </tbody>
								</table>
							</li>
							<li >
								<table>
									<thead>
										<tr>
										  <td scope="col" colspan="2">회계팀</td>
										  <td scope="col"></td>
										</tr>
									  </thead>
									  <tbody>
										<tr>
										  <td scope="row">장팀장</td>
										  <td>부장</td>
										</tr>
										<tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
									  </tbody>
								</table>
							</li>
							<li>
								<table>
									<thead>
										<tr>
										  <td scope="col" colspan="2">회계팀</td>
										  <td scope="col"></td>
										</tr>
									  </thead>
									  <tbody>
										<tr>
										  <td scope="row">장팀장</td>
										  <td>부장</td>
										</tr>
										<tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
										  <tr>
											<td scope="row">장팀장</td>
											<td>부장</td>
										  </tr>
									  </tbody>
								</table>
							</li>
							<li>
								<a href="#">Great Grand Child</a>
							</li>
						</ul>
					</li>
				</ul>
			</div>
		</div>
	</div>
	<script type="module" src="${path}/resources/js/orgChart.js"></script>
</body>
</html>