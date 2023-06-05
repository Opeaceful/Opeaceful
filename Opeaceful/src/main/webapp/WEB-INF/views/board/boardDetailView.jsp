<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
	<link rel="stylesheet" href="${path}/resources/css/board/boardDetail.css">
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
                <div><button type="button" class="btn btn-success" style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;">수정</button></div>
                <div class="dlt-btn"><button type="button" class="btn btn-danger" style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;">삭제</button></div>
            </div>
            <div class="board-wrap3">
                <div class="ctn-title">${b.boardTitle}</div>
                <div class="ctn-writer">${b.PName} ${b.userName}</div>
                <div class="ctn-date">${b.createDate }</div>
            </div>
            <div class="board-wrap4">
                <div class="atc-icon">
                    <i class="fa-solid fa-paperclip"></i>
                </div>
                <div class="atc-box">
                    <div class="atc-txt"><a href="">main.css</a></div>


                </div>
            </div>
            <div class="board-wrap5">
                <div class="detail-ctn">
                    <span>${b.boardContent }</span>
                </div>
            </div>
            <div class="board-wrap6">
                <div class="reply-title"><span>댓글</span></div>
                <div class="reply-space">
                    <div class="reply-one">
                        <div class="jcode-name"><span>사원 김혜린</span></div>
                        <div class="reply-ctn"><span>확인했습니다.</span></div>
                        <div class="reply-footer">
                            <span class="reply-date">2023-05-19 10:15:39</span>
                            <button class="reply-dlt-btn"><span>삭제</span></button>
                            <button class="re-reply-btn"><span class="re-btn-text">답글달기</span></button>            
                        </div>
                    </div>
                    <div class="reply-input-area re-reply-input-area">
                        <div class="lock-space">
                            <div><button class="sm-unlock-btn"><i class="fa-solid fa-lock-open"></i></button></div>
                            <div><button class="sm-lock-btn"><i class="fa-solid fa-lock"></i></button></div>
                        </div>
                        <div class="reply-input-box">
                            <div class="reply-text"><textarea class="box-shadow-none reply-input form-control container" id="exampleFormControlTextarea1" rows="3"></textarea></div>
                            <div><button type="button" class="reply-button btn btn-primary">등록</button></div>
                        </div>
                    </div>
                    <div class="reply-two">
                        <div class="jcode-name">사원 김혜린</div>
                        <div class="reply-ctn">확인했습니다.</div>
                        <div class="reply-footer">
                            <span class="reply-date">2023-05-19 10:15:39</span>
                            <button class="reply-dlt-btn"><span>삭제</span></button>
                        </div>
                    </div>                   
                </div>
                <div class="reply-input-area">
                    <div class="lock-space">
                        <div><button class="unlock-btn"><i class="fa-solid fa-lock-open"></i></button></div>
                        <div><button class="lock-btn"><i class="fa-solid fa-lock"></i></button></div>
                    </div>
                    <div class="reply-input-box">
                        <div class="reply-text"><textarea class="box-shadow-none reply-input form-control container" id="exampleFormControlTextarea1" rows="3"></textarea></div>
                        <div><button type="button" class="reply-button btn btn-primary">등록</button></div>
                    </div>
                </div>
            </div>
            <div class="board-wrap7">
                <div></div>
            </div>
            <div class="board-wrap8">
                <div><i class="bf-icon fa-solid fa-angle-up"></i></div>
                <div class="bf-title">이전글</div>
                <div class="bf-txt"><Span>1차 훈련장려금 신청 공지입니다.</Span></div>
            </div>
           
            <div class="board-wrap9">
                <div><i class="af-icon fa-solid fa-angle-down"></i></div>
                <div class="af-title">다음글</div>
                <div class="af-txt"><Span>3차 훈련장려금 신청 공지입니다.</Span></div>
            </div>
            <div class="board-wrap10">
                <div><button type="button" class="go-list-btn"><i class="bi bi-list"></i><span> 목록</span></button></div>
            </div>
        </div>
    </div>
    
    
    
    
    <script src="${path}/resources/js/board/boardDetail.js"></script>
    
</body>
</html>