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
    <!-- 알랏 커스텀 링크 -->
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <!-- jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
    
    <!-- css-->
    <link rel="stylesheet" href="${path}/resources/css/common/common.css">
	<link rel="stylesheet" href="${path}/resources/css/board/boardEnroll.css">
</head>
<body>
	<!-- alert -->
	<c:if test="${ not empty alertMsg }">
		<script>swal('${alertMsg}');</script>
		<c:remove var="alertMsg"/>
	</c:if>
	
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
	                    <a href="#" class="board-title-btn c-page">팀게시판</a>
	                 	</c:when>
	                 	<c:when test="${ boardCode eq 'N'}">
	                    <a href="#" class="board-title-btn c-page">공지사항</a>
	                 	</c:when>
						<c:otherwise>
	                    <a href="#" class="board-title-btn c-page">자유게시판</a>
						</c:otherwise>
					</c:choose>
                
               
                </div>
            </div>
            <form id="enrollForm" action="${path}/board/insert/${boardCode}" enctype="multipart/form-data" method="post">
            <div class="board-wrap2">
                <table>
                    <tr>
                        <th>제목</th>
                        <td colspan="2">
                            <input name="boardTitle" value="${b.boardTitle }" class="box-shadow-none form-control" type="text" required placeholder="" aria-label="default input example">
                        </td>
                    </tr>
                    <c:if test="${ boardCode eq 'N'}">
                    <tr>
                        <th>작성자</th>
                        <td colspan="2">
                            <div class="enroll-select">
                                <select name="boardWriter" class="box-shadow-none form-select form-select-sm" aria-label=".form-select-sm example" required>
                                    <!-- 게시글 등록용 -->
                                    <c:if test="${b.boardWriter eq null}">
                                    <option disabled selected>부서명</option>
                                    <c:forEach items="${dlist }" var="d">
                                    	<option value="${d.deptName }">${d.deptName }</option>
                                    </c:forEach>
                                    </c:if>
                                    <!-- 게시글 수정용 -->
                                    <c:if test="${b.boardWriter != null}">
                                    <option disabled>부서명</option>
                                    <c:forEach items="${dlist }" var="d">
                                    
                                    	<c:choose>
                                    	<c:when test="${d.deptName eq b.boardWriter}">
                                    	<option value="${d.deptName }" selected>${d.deptName }</option>
                                    	</c:when>
                                    	
                                    	<c:otherwise>
                                    	<option value="${d.deptName }">${d.deptName }</option>
                                    	</c:otherwise>
                                    	</c:choose>
                                    	
                                    </c:forEach>
                                    </c:if>
                                </select>
                            </div>
                        </td>
                    </tr>
                    </c:if>
                    
                    <tr>
                        <th>내용</th>
                        <td colspan="2" class="enroll-cnt">
                            <div><textarea style="resize:none;" rows ="10" class="form-control" name="boardContent" required="required">${b.boardContent }</textarea></div>
                        </td>
                    </tr>
                    <!-- 첨부파일 영역 -->
                    <tr>
                        <th><i class="fa-solid fa-paperclip"></i></th>
                        <td colspan="2" class="atc-box">
                            <div class="mb-0">
                                <input name="atcFile" class="box-shadow-none form-control" type="file" id="formFileMultiple" multiple>
                            </div>
                        </td>
                    </tr>
                    <!-- 익명체크 영역은 자유게시판만 -->
                    <c:if test="${ boardCode eq 'F'}">
                    <tr>
                        <th>익명 여부</th>
                        <td colspan="2">
                            <div class="form-check form-switch">
                            	<c:choose>
                            	<c:when test="${b.secret eq 'Y'}">
                                <input name="secret" class="box-shadow-none form-check-input" type="checkbox" role="switch" id="flexSwitchCheckChecked" value="Y" checked>
                            	</c:when>
                            	<c:otherwise>
                                <input name="secret" class="box-shadow-none form-check-input" type="checkbox" role="switch" id="flexSwitchCheckChecked" value="Y">
                            	</c:otherwise>
                            	</c:choose>
                                <label class="form-check-label" for="flexSwitchCheckChecked">* 체크 시 익명으로 등록됩니다.</label>
                              </div>
                        </td>
                    </tr>
                    </c:if>
                    <!-- 상단고정 영역은 공지사항만 -->
                     <c:if test="${ boardCode eq 'N'}">
                    <tr>
                        <th>상단고정 여부</th>
                        <td colspan="2">
                            <div class="form-check form-switch">
                            	<c:choose>
                            	<c:when test="${b.fixed eq 'Y'}">
                            	<input name="fixed" class="box-shadow-none form-check-input" type="checkbox" role="switch" id="flexSwitchCheckDefault" value="Y" checked>
                            	</c:when>
                            	<c:otherwise>
                                <input name="fixed" class="box-shadow-none form-check-input" type="checkbox" role="switch" id="flexSwitchCheckDefault" value="Y">
                            	</c:otherwise>
                            	</c:choose>
                                <label class="form-check-label" for="flexSwitchCheckDefault">* 체크 시 공지사항 목록 상단에 고정됩니다.</label>
                            </div>
                        </td>
                    </tr>
                    </c:if>
                </table>
                
                
            </div>
            
            <input type="hidden" name="mode" value="${param.mode}"/>
			<input type="hidden" name="boardNo" value="${empty b.boardNo ? 0 : b.boardNo}" />
            
            <!-- submit 버튼 영역 -->
            <div class="board-wrap3">
            	<c:if test="${b.boardNo eq null }">
                <div><button type="submit" class="btn btn-primary" style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: 1rem;">등록</button></div>
                </c:if>
                <c:if test="${b.boardNo != null }">
                <div><button type="submit" class="btn btn-primary" style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: 1rem;">수정</button></div>
                </c:if>
                <div class="cnl-btn"><button id="cancelBtn" type="button" class="btn btn-outline-primary" style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: 1rem;">취소</button></div>
            </div>
            
            </form>
        </div>
    </div>

	<script>
	/* 취소버튼 클릭이벤트 */
    $("#cancelBtn").click(function(){
    	location.href="${path}/board/list/${boardCode}";
    });
    
	
	
	
	</script>


</body>
</html>