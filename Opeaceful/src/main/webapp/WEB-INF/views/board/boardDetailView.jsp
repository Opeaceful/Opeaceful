<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="cp" value="${map.currentPage}"/>
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
	<link rel="stylesheet" href="${path}/resources/css/board/boardDetail.css">
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
            <!-- 상단카테고리 버튼 영역 -->
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
            <!-- 수정/삭제 버튼 영역 -->
            <div class="board-wrap2">
            <c:choose>
				<c:when test="${ boardCode eq 'F'}"> <!-- 자유게시판 -->
				<c:if test='${(b.boardWriter == loginUser.userNo+"")}'> 
				<div><button type="button" id="udtBtn" class="btn btn-success" style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;">수정</button></div>
                <div class="dlt-btn"><button type="button" id="dltBtn" class="btn btn-danger" style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;">삭제</button></div>
				</c:if>
				<c:if test='${(b.boardWriter != loginUser.userNo+"") && freeRoll eq "B02" }'> 
				<div class="dlt-btn"><button type="button" id="dltBtn" class="btn btn-danger" style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;">삭제</button></div>
				</c:if>
				</c:when>
				
				<c:when test="${ boardCode eq 'N'}"> <!-- 공지사항 -->
				<c:if test="${notiRoll eq 'B01'}">
                <div><button type="button" id="udtBtn" class="btn btn-success" style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;">수정</button></div>
                <div class="dlt-btn"><button type="button" id="dltBtn" class="btn btn-danger" style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;">삭제</button></div>
            	</c:if>
				</c:when>
				
				<c:otherwise>  <!-- 팀게시판 -->
				<c:if test='${(b.boardWriter == loginUser.userNo+"")}'> 
				<div><button type="button" id="udtBtn" class="btn btn-success" style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;">수정</button></div>
                <div class="dlt-btn"><button type="button" id="dltBtn" class="btn btn-danger" style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;">삭제</button></div>
				</c:if>
				</c:otherwise>
			</c:choose>
            </div>
            <!-- 글제목 영역 -->
            <div class="board-wrap3">
                <div class="ctn-title">${b.boardTitle}</div>
                <c:choose>
                <c:when test="${boardCode == 'N'}">
                <div class="ctn-writer">${b.boardWriter}</div>
                </c:when>
                <c:otherwise>
                
                <c:choose>
                     <c:when test="${b.secret eq 'Y'}">
                     <div class="ctn-writer">익명</div>
                     </c:when>
                     <c:otherwise>
                     <div class="ctn-writer">${b.PName} ${b.userName}</div>
                     </c:otherwise>
	            </c:choose>
                
                </c:otherwise>
                </c:choose>
                <div class="ctn-date">${b.createDate }</div>
            </div>
            <!-- 첨부파일영역 -->
            <c:if test="${not empty file}">
            <div class="board-wrap4">
                <div class="atc-icon">
                    <i class="fa-solid fa-paperclip"></i>
                </div>
                <div class="atc-box">
                <c:forEach items="${file}" var="f">
                	<div class="atc-txt"><a download href="${path}/resources/file/board/${f.changeFile}">${f.originFile}</a></div>
                </c:forEach>
                </div>
            </div>
            </c:if>
            <!-- 글 내용 영역 -->
            <div class="board-wrap5">
                <div class="detail-ctn">
                    <span>${b.boardContent }</span>
                </div>
            </div>
            <!-- 댓글 전체 영역 -->
            <c:if test="${boardCode == 'T' or boardCode == 'F' }">
            <div class="board-wrap6">
                <div class="reply-title"><span>댓글</span></div>
                <div class="reply-space">
                
                <!-- 실제 댓글은  스크립트로 추가 -->
                
                	<!-- 댓글 예시 
                    <div class="reply-one">
                        <div class="jcode-name"><span>사원 김혜린</span></div>
                        <div class="reply-ctn"><span>확인했습니다.</span></div>
                        <div class="reply-footer">
                            <span class="reply-date">2023-05-19 10:15:39</span>
                            <button class="reply-dlt-btn"><span>삭제</span></button>
                            <button class="re-reply-btn"><span class="re-btn-text">답글달기</span></button>            
                        </div>
                    </div>
                    
                     답댓글등록란 
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
                     답댓글 예시 -
                    <div class="reply-two">
                        <div class="jcode-name">사원 김혜린</div>
                        <div class="reply-ctn">확인했습니다.</div>
                        <div class="reply-footer">
                            <span class="reply-date">2023-05-19 10:15:39</span>
                            <button class="reply-dlt-btn"><span>삭제</span></button>
                        </div>
                    </div>        
                               -->
                </div>
                
                
                <!-- 댓글등록란 -->
                <div class="reply-input-area">
                    <div class="lock-space">
                        <div><button class="unlock-btn"><i class="fa-solid fa-lock-open"></i></button></div>
                        <div><button class="lock-btn"><i class="fa-solid fa-lock"></i></button></div>
                    </div>
                    <div class="reply-input-box">
                        <div class="reply-text"><textarea class="reply-content box-shadow-none reply-input form-control container" id="exampleFormControlTextarea1" rows="3" required></textarea></div>
                        <div><button type="button" id="reply-insert-btn" class="reply-button btn btn-primary" onclick="insertReply();">등록</button></div>
                    </div>
                </div>
            </div>
            </c:if>
            
          
            <div class="board-wrap7">
                <div></div>
            </div>
              <!-- 
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
              -->
            <div class="board-wrap10">
           
           <!-- 
            <c:choose>
            	<c:when test="${!empty map.condition }">
				<div><button type="button" onclick="moveSp(${map.condition },${map.keyword })" class="go-list-btn"><i class="bi bi-list"></i><span> 목록</span></button></div>				
            	</c:when>
            	<c:otherwise> -->
                <div class="list-icon-btn"><button type="button" onclick="moveCp(${cp})" class="go-list-btn"><i class="bi bi-list" style="font-weight: 600 !important"></i><span> 목록</span></button></div>
            	<!--</c:otherwise>
            </c:choose>-->
            
                
                
            </div>
        </div>
    </div>
    
    
    <script>
    
    // 상세조회 페이지가 열릴 때 윈도우실행되자마자 파일이름 갈아끼워주는 함수 실행하기!!!!!!!!!!!!!!!!!   
    //changeImgPath
    /*
    
    let changeImgPath = function () {
    	
    	
    let imgArr = (이위치에 보드 컨텐츠 싸여있는 태그 같다붙이기.).getElementsByTagName('img');
  
    if (imgArr) {
      for (let img of imgArr) {
        let imgSrc = img.src;
        // 신규로 추가된 이미지들의 src는 blob로 시작되도록 해두었음
        // 그외 / 로 시작하지 않는 기존 이미지들 src 갈아끼기
        if (!imgSrc.startsWith('blob')) {
          // 이미지 실제 이름만 가져옴
          imgSrc = imgSrc.substring(imgSrc.lastIndexOf('/') + 1);
  
          // 이미지 경로 재설정
          img.src = path + '/resources/file/board/' + imgSrc;
        }
      }
    }
  };
  
  */
    
    let lockCheckObj = {
    	    secretReply : 'N'
    	 }
    
    $(function(){
     	selectReplyList();
     
        // ==== 댓글 자물쇠 버튼 ====
        let lock = $(".lock-btn");
        let unlock = $(".unlock-btn");
        let lockSm = $(".sm-lock-btn");
        let unlockSm = $(".sm-unlock-btn");

        unlock.on('click', function(){
             console.log("Locking...");
            unlock.css('display', 'none');
            lock.css('display', 'block');
            lockCheckObj.secretReply = 'Y';
            console.log("secret유무 (Y/N)" + lockCheckObj.secretReply);
        })

        lock.on('click', function(){
             console.log("Unlocking...");
            unlock.css('display', 'block');
            lock.css('display', 'none');
            lockCheckObj.secretReply = 'N';
            console.log("secret유무 (Y/N)" + lockCheckObj.secretReply);
        })

        unlockSm.on('click', function(){
            unlockSm.css('display', 'none');
            lockSm.css('display', 'block');
        })

        lockSm.on('click', function(){
            unlockSm.css('display', 'block');
            lockSm.css('display', 'none');
        })
        
    });
    
    
	function moveCp(cp){
    	location.href = '${path}/board/list/${boardCode}?cpage='+cp;
    }
    
    function addReReply(){
        if($('#repTxt').text() == "답글달기"){
            console.log("댓글창 열림")
            $('#repTxt').text("답글취소");
            $('#rep-insert').css('display', 'flex');
        }else{
            console.log("댓글창 닫힘")
            $('#repTxt').text("답글달기");
            $('#rep-insert').css('display', 'none');
        }
     };
    
     function deleteReply(replyNo){
			$.ajax({
				url : "${path}/reply/delete",
				data : {replyNo},
				success : function(result){
					if(result == 1){
						console.log("댓글삭제.");
					}else{
						console.log("댓글삭제실패");									
					}
					selectReplyList();
				}
			})
		}
     
     
    function selectReplyList(){
		$.ajax({
			url : '${path}/reply/selectReplyList',
			data : {bno : '${b.boardNo}'},
			dataType : 'json',
			success: function(result){
				console.log(result);
				
				let html ="";
				for(let r of result){
					
					if(r.pName == null){
						r.pName = "";
					}else{
						r.pName += " ";
					}
					html += "<div class='reply-one'>";
					if(r.secret == 'Y'){
					html += "<div class='jcode-name'><span>익명</span></div>";
					}else{
						html += "<div class='jcode-name'><span>"+r.pName + r.userName +"</span></div>";	
					}
					
					html += "<div class='reply-ctn'><span>"+r.content+"</span></div>";
					html += "<div class='reply-footer'>";
					html += "<span class='reply-date'>"+r.createDate+"</span>";
					//html += "<button class='re-reply-btn' id='repBtn"+r.replyNo+"' onclick='addReReply()'><span id='repTxt"+r.replyNo+"' class='re-btn-text'>답글달기</span></button>";
						
					if((r.userNo == '${loginUser.userNo}') || ('${freeRoll}' == "B02")){
						html += "<button class='reply-dlt-btn' onclick='deleteReply("+r.replyNo+")'><span>삭제</span></button>";
					}									   
					/* --답글
					
					html += "</div></div>";
					html += "<div class='reply-input-area re-reply-input-area' id='rep-insert"+r.replyNo+"'>";
					html += "<div class='lock-space'>";
					html += "<div><button class='sm-unlock-btn'><i class='fa-solid fa-lock-open'></i></button></div>";
					html += "<div><button class='sm-lock-btn'><i class='fa-solid fa-lock'></i></button></div>";
					html += "</div>"
					html += "<div class='reply-input-box'>";
					html += "<div class='reply-text'><textarea class='box-shadow-none reply-input form-control container' id='exampleFormControlTextarea1' rows='3'></textarea></div>";
					html += "<div><button type='button' class='reply-button btn btn-primary'>등록</button></div>";
					html += "</div></div>"; */
				
					//$('#repTxt'+r.+  ').text("답글달기");
			         //  $('#rep-insert').css('display', 'none');
				}
				
				$(".reply-space").html(html);
				
			},error : function(req,sts,err){
				console.log(req);
				console.log(sts);
				console.log(err);
			} 
		})
	}
    
    function insertReply(){
        
        $.ajax({
            url: "${path}/reply/insert",
            data : {
                boardNo : '${b.boardNo}',
                userNo: '${loginUser.userNo}',
                content : $(".reply-content").val(),
                secret : lockCheckObj.secretReply							
            },
            type : 'POST',
            success : function (result){
                if(result == "1"){
                    console.log("댓글 등록 성공");
                }else{
                    console.log("댓글 등록 실패");
                }
                selectReplyList();
            },
            complete : function(){
                $(".reply-content").val("");
            }
            
        })
      
    };
    
    /* 게시글 삭제 전 confirm */
    $("#dltBtn").click(function(){
        swal("정말 삭제 하시겠습니까?",{
            buttons: {confirm: "확인", cancel: "취소"}
        })
        .then(function(isConfirm){
            if(isConfirm){
                $.ajax({
                    url : "${path}/board/delete",
                    data : {
                        boardNo : '${b.boardNo}'							
                    },
                    type : 'POST',
                    success : function(result) {
                    	
                    	console.log("result : "+result);
                    	console.log("boardCode : "+'${boardCode}');
                    	console.log("cp : "+'${cp}');
                    	
                        if(result > 0){
                            location.href= "${path}/board/list/${boardCode}?cpage=${cp}";
                        }
                    },
                    error : function(e) {
                        swal("error");
                    }
                })
            }
        })
    });
    
    /* 수정버튼 클릭이벤트 */
    $("#udtBtn").click(function(){
    	location.href="${path}/board/enrollForm/${boardCode}?mode=update&bno=${b.boardNo}";
    });
    
    </script>
    
    
    
    
</body>
</html>