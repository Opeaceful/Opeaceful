<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="list" value="${map.list}"/>
<c:set var="pi" value="${map.pi}"/>
<c:if test="${!empty map.condition }">
	<c:set var="sUrl" value="&condition=${map.condition }&keyword=${map.keyword }"/>
</c:if>
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
            <!-- 게시판 상단 카테고리 버튼 -->
            <div class="board-wrap1">
                <div class="board-title-btn-wrap">
                	<c:choose>
						<c:when test="${ boardCode eq 'T'}">
	                    <a href="${path}/board/list/N" class="board-title-btn">공지사항</a>
	                    <a href="${path}/board/list/F" class="board-title-btn">자유게시판</a>
	                    <a href="${path}/board/list/T" class="board-title-btn c-page">팀게시판</a>
	                 	</c:when>
	                 	<c:when test="${ boardCode eq 'N'}">
	                    <a href="${path}/board/list/N" class="board-title-btn c-page">공지사항</a>
	                    <a href="${path}/board/list/F" class="board-title-btn">자유게시판</a>
	                    <a href="${path}/board/list/T" class="board-title-btn">팀게시판</a>
	                 	</c:when>
						<c:otherwise>
						<a href="${path}/board/list/N" class="board-title-btn">공지사항</a>
	                    <a href="${path}/board/list/F" class="board-title-btn c-page">자유게시판</a>
	                    <a href="${path}/board/list/T" class="board-title-btn">팀게시판</a>
						</c:otherwise>
					</c:choose>
                </div>
            </div>
            <div class="board-wrap2">
            <c:choose>
					<c:when test="${ boardCode eq 'T'}">
						<button type="button" class="btn btn-primary" onClick="location.href='${path}/board/enrollForm/${boardCode}'" "style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;">글쓰기</button>						
					</c:when>
	                 <c:when test="${ boardCode eq 'F'}">
		                <button type="button" class="btn btn-primary" onClick="location.href='${path}/board/enrollForm/${boardCode}'" "style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;">글쓰기</button>
	                 </c:when>
						<c:otherwise>
							<c:if test="${notiRoll > 0}">
            					<button type="button" class="btn btn-primary" onClick="location.href='${path}/board/enrollForm/${boardCode}'" "style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;">글쓰기</button>
            				</c:if>
            				<c:if test="${notiRoll == 0}">
            					<div><pre> </pre></div>
            				</c:if>	
						</c:otherwise>
					</c:choose>
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
	                    <c:choose>
	                    <c:when test='${ b.fixed == "Y"}'>
		                    <tr class="notice-fixed" onClick='location.href = "${path}/board/detail/${boardCode}/${b.boardNo }"'>
		                        <td class="list-ctn-title">${b.boardTitle}</td>
		                        <td>${b.PName} ${b.userName}</td>
		                        <td>${b.createDate}</td>
		                        <td>${b.count}</td>
		                    </tr>
	                    </c:when>
	                    <c:otherwise>
	                    	<tr onClick='location.href = "${path}/board/detail/${boardCode}/${b.boardNo }"'>
	                        <td class="list-ctn-title">${b.boardTitle}</td>
	                        <td>${b.PName} ${b.userName}</td>
	                        <td>${b.createDate}</td>
	                        <td>${b.count}</td>
	                    </tr>
	                    </c:otherwise>
	                    </c:choose>
                    </c:forEach> 
                    </tbody>
              </table>
            </div>
            <!-- 페이징 영역 -->
            <c:set var="url" value="${path}/board/list/${boardCode}?cpage=" />
            
            <div class="board-wrap4">
                <div class="pagingArea">
                    <nav aria-label="Page navigation example">
                        <ul class="pagination">
                        <!-- 이전페이지 버튼 -->
                        <c:choose>
							<c:when test="${ pi.currentPage eq 1 }">
								<li class="page-item disabled">
		                            <a class="page-link" href="#" aria-label="Previous">
		                              <span aria-hidden="true">&laquo;</span>
		                            </a>
		                          </li>
							</c:when>
							<c:otherwise>
								<li class="page-item">
		                            <a class="page-link" href="${url}${pi.currentPage -1 }${sUrl}" aria-label="Previous">
		                              <span aria-hidden="true">&laquo;</span>
		                            </a>
		                          </li>
							</c:otherwise>					
						</c:choose>
                        
                        <!-- 페이지버튼 -->
                        <c:forEach var="item" begin="${pi.startPage }" end="${pi.endPage }">
                        <c:choose>
							<c:when test="${ pi.currentPage eq item }">
                        	<li class="page-item active"><a class="page-link" href="${url}${item }${sUrl}">${item }</a></li>
	                        </c:when>
								<c:otherwise>	
							<li class="page-item"><a class="page-link" href="${url}${item }${sUrl}">${item }</a></li>
							</c:otherwise>					
						</c:choose>
						</c:forEach>
                          
                          <!-- 다음페이지 버튼 -->
                          <c:choose>
							<c:when test="${ (pi.currentPage eq pi.maxPage) or pi.maxPage == 0 }">
								<li class="page-item disabled">
		                            <a class="page-link" href="#" aria-label="Next">
		                              <span aria-hidden="true">&raquo;</span>
		                            </a>
	                            </li>
							</c:when>
							<c:otherwise>
								<li class="page-item">
		                            <a class="page-link" href="${url}${pi.currentPage + 1 }${sUrl}" aria-label="Next">
		                              <span aria-hidden="true">&raquo;</span>
		                            </a>
		                         </li>
							</c:otherwise>					
						</c:choose>
                        </ul>
                      </nav>
                </div>
            </div>
            <!-- 검색창 영역 -->
            <div class="board-wrap5">
                <form action="${ boardCode }" method="get">
                    <div>
                        <select name="condition" class="form-select form-select-sm select-box box-shadow-none" aria-label=".form-select-sm example">
                            <option value="title" ${map.condition == 'title' ? 'selected':''}>제목</option>
                            <option value="content" ${map.condition == 'content' ? 'selected':''}>내용</option>
                            <option value="writer" ${map.condition == 'writer' ? 'selected':''}>작성자</option>
                        </select>
                    </div>
                    <div class="search-wrap">
                        <input type="search" name="keyword" class="search-box" value="${map.keyword }">
                        <button type="submit" class="search-btn"><i class="fa-solid fa-magnifying-glass"></i></button>
                    </div>
                </form>
                
            </div>
        </div>
    </div>


	<script>
	
	
	// function movePage(){
		 
		// 	console.log("클릭됨");
		 
		 //	location.href = path+"/board/detail/${boardCode}";
		 	
		// }
		 
	
	</script>

	<script src="${path}/resources/js/board/boardList.js"></script>  

</body>
</html>