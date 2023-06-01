<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="list" value="${list }"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardList</title>
	<!--bootstrap css-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <!-- 부트스트랩 아이콘 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
    <!-- fontawesome라이브러리추가 다양한 아이콘을 지원함.(EX) 검색용 돋보기 버튼) -->
    <script src="https://kit.fontawesome.com/a2e8ca0ae3.js" crossorigin="anonymous"></script>
    <!-- JavaScript Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
	<!-- jquery -->
    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
	<!--css -->
	<link rel="stylesheet" href="${path}/resources/css/common/common.css">
	<link rel="stylesheet" href="${path}/resources/css/board/boardlist.css">
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
                	<c:forEach var="boardType" items="${boardTypeList}">
	                    <a href="${path}/board/list/${boardType.boardCd}" class="board-title-btn">${boardType.boardName}</a>
                	</c:forEach>
                </div>
            </div>
            <div class="board-wrap2">
            	
                <button type="button" class="btn btn-primary" onClick="location.href='${path}/board/enrollForm/${boardCode}'" "style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;">글쓰기</button>
            	
            </div>
            <div class="board-wrap3">
                <table class="table table-hover table-common">
                    <thead>
                    <tr class="b-head">
                        <th scope="col" class="th2">제목</th>
                        <th scope="col" class="th3">작성자</th>
                        <th scope="col" class="th4">작성일</th>
                        <th scope="col" class="th5">조회수</th>
                    </tr>
                    </thead>
                    <tbody class="table-group-divider">
                     <c:if test="${empty list }">
						<td colspan="4">게시글이 없습니다</td>
					</c:if>
					
					<c:forEach items="${ list }" var="b">
	                    <tr onClick="movePage(${b.boardNo});">
	                        <td class="list-ctn-title">${b.boardTitle}</td>
	                        <td>${b.userName}</td>
	                        <td>${b.createDate}</td>
	                        <td>${b.count}</td>
	                    </tr>
                    </c:forEach> 
                    </tbody>
              </table>
            </div>
            <div class="board-wrap4">
                <div class="pagingArea">
                    <nav aria-label="Page navigation example">
                        <ul class="pagination">
                       <!--  <c:if test="${currentPage != 1 }"> --> 
	                          <li class="page-item">
	                            <a class="page-link" href="#" aria-label="Previous">
	                              <span aria-hidden="true">&laquo;</span>
	                            </a>
	                          </li>
                        <!-- </c:if> --> 
                          <li class="page-item"><a class="page-link" href="#">1</a></li>
                          <li class="page-item"><a class="page-link" href="#">2</a></li>
                          <li class="page-item"><a class="page-link" href="#">3</a></li>
                          <li class="page-item"><a class="page-link" href="#">4</a></li>
                          <li class="page-item"><a class="page-link" href="#">5</a></li>
                          <li class="page-item"><a class="page-link" href="#">6</a></li>
                          <li class="page-item"><a class="page-link" href="#">7</a></li>
                          <li class="page-item"><a class="page-link" href="#">8</a></li>
                          <li class="page-item"><a class="page-link" href="#">9</a></li>
                          <li class="page-item"><a class="page-link" href="#">10</a></li>
                          <li class="page-item">
                            <a class="page-link" href="#" aria-label="Next">
                              <span aria-hidden="true">&raquo;</span>
                            </a>
                          </li>
                        </ul>
                      </nav>
                </div>
            </div>
            <div class="board-wrap5">
            
                <form>
                    <div>
                        <select class="form-select form-select-sm select-box box-shadow-none" aria-label=".form-select-sm example">
                            <option value="title" selected>제목</option>
                            <option value="content">내용</option>
                            <option value="writer">작성자</option>
                        </select>
                    </div>
                    <div class="search-wrap">
                        <input type="search" name="keyword" class="search-box">
                        <button type="button" class="search-btn"><i class="fa-solid fa-magnifying-glass"></i></button>
                    </div>
                </form>
                
            </div>
        </div>
    </div>




	<script src="${path}/resources/js/board/boardList.js"></script>  


</body>
</html>