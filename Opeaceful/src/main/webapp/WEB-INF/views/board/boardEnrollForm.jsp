<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dlist" value="${map.dlist}"/>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Opeaceful</title>
	<!--bootstrap css-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <!-- 부트스트랩 아이콘 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
    <!-- fontawesome라이브러리추가 다양한 아이콘을 지원함.(EX) 검색용 돋보기 버튼) -->
    <script src="https://kit.fontawesome.com/a2e8ca0ae3.js" crossorigin="anonymous"></script>
    <!-- jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
    
    <!-- css-->
    <link rel="stylesheet" href="${path}/resources/css/common/common.css">
	<link rel="stylesheet" href="${path}/resources/css/board/boardEnroll.css">
</head>
<body>

	<jsp:include page="/WEB-INF/views/sidebar.jsp" />

	<div id="content-wrap">
        <div class="container board-wrap">
            <div class="title-box">
                <h2 class="title-common">게시판</h2>
            </div>
            <div class="board-wrap1">
                <div class="board-title-btn-wrap">
                
                	<c:choose>
						<c:when test="${ boardCode eq 'T'}">
	                    <a href="${path}/board/list/T" class="board-title-btn c-page">팀게시판</a>
	                 	</c:when>
	                 	<c:when test="${ boardCode eq 'N'}">
	                    <a href="${path}/board/list/N" class="board-title-btn c-page">공지사항</a>
	                 	</c:when>
						<c:otherwise>
	                    <a href="${path}/board/list/F" class="board-title-btn c-page">자유게시판</a>
						</c:otherwise>
					</c:choose>
                
               
                </div>
            </div>
            <div class="board-wrap2">
                <table>
                    <tr>
                        <th>제목</th>
                        <td colspan="2">
                            <input class="box-shadow-none form-control" type="text" placeholder="" aria-label="default input example">
                        </td>
                    </tr>
                    <c:if test="${ boardCode eq 'N'}">
                    <tr>
                        <th>작성자</th>
                        <td colspan="2">
                            <div class="enroll-select">
                                <select class="box-shadow-none form-select form-select-sm" aria-label=".form-select-sm example" required>
                                    <option disabled selected>부서명</option>
                                    <c:forEach items="${dlist }" var="d">
                                    	<option value="${d.deptCode }">${d.deptName }</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </td>
                    </tr>
                    </c:if>
                    
                    <tr>
                        <th>내용</th>
                        <td colspan="2" class="enroll-cnt">
                            <div><textarea required></textarea></div>
                        </td>
                    </tr>
                    <tr>
                        <th><i class="fa-solid fa-paperclip"></i></th>
                        <td colspan="2" class="atc-box">
                            <div class="mb-0">
                                <input class="box-shadow-none form-control" type="file" id="formFileMultiple" multiple>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th>익명 여부</th>
                        <td colspan="2">
                            <div class="form-check form-switch">
                                <input class="box-shadow-none form-check-input" type="checkbox" role="switch" id="flexSwitchCheckChecked" checked>
                                <label class="form-check-label" for="flexSwitchCheckChecked">* 체크 시 익명으로 등록됩니다.</label>
                              </div>
                        </td>
                    </tr>
                    <tr>
                        <th>상단고정 여부</th>
                        <td colspan="2">
                            <div class="form-check form-switch">
                                <input class="box-shadow-none form-check-input" type="checkbox" role="switch" id="flexSwitchCheckDefault">
                                <label class="form-check-label" for="flexSwitchCheckDefault">* 체크 시 공지사항 목록 상단에 고정됩니다.</label>
                            </div>
                        </td>
                    </tr>
                </table>
                
                
            </div>
            <div class="board-wrap3">
            	<!-- if boardNo == null -->
                <div><button type="button" class="btn btn-primary" style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: 1rem;">등록</button></div>
                <!-- if boardNo != null 
                <div><button type="button" class="btn btn-primary" style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: 1rem;">수정</button></div>
                -->
                <div class="cnl-btn"><button type="button" class="btn btn-outline-primary" style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: 1rem;">취소</button></div>
            </div>
        </div>
    </div>




</body>
</html>