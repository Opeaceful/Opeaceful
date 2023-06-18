<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	
<%@page import="java.util.List"%>
<%@page import="com.company.opeaceful.calendar.model.vo.Calendar"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Opeaceful</title>
	<link href='${path}/resources/fullcalendar-4.4.0/packages/core/main.css' rel='stylesheet' />
	<link href='${path}/resources/fullcalendar-4.4.0/packages/daygrid/main.css' rel='stylesheet' />
	<script src='${path}/resources/fullcalendar-4.4.0/packages/core/main.js'></script>
	<script src='${path}/resources/fullcalendar-4.4.0/packages/interaction/main.js'></script>
	<script src='${path}/resources/fullcalendar-4.4.0/packages/daygrid/main.js'></script>
	
	<!--bootstrap css-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <!-- 부트스트랩 아이콘 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
    <!-- fontawesome라이브러리추가 다양한 아이콘을 지원함.(EX) 검색용 돋보기 버튼) -->
    <script src="https://kit.fontawesome.com/a2e8ca0ae3.js" crossorigin="anonymous"></script>
    <!-- JavaScript Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
	<!-- 알랏 커스텀 링크 -->
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<!-- jquery -->
    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
    
	<!--css -->
	<link rel="stylesheet" href="${path}/resources/css/common/common.css">
	<link rel="stylesheet" href="${path}/resources/css/calendar/calendar.css">
</head>

<body>
	<!-- alert -->
 	<c:if test="${ not empty alertMsg }">
		<script>swal('${alertMsg}');</script>
		<c:remove var="alertMsg"/>
	</c:if> 
	
	<jsp:include page="/WEB-INF/views/sidebar.jsp" />


	<div id="content-wrap">
    <div class="container">
      <div class="header-btn-area">
        <div class="category-btn-wrap">
	        <c:choose>
	        <c:when test="${ category eq 'M'}">
	        <a href="${path}/calendar/calendarForm/M" class="cal-category-btn my-cal-btn c-page">내 캘린더</a>
          	<a href="${path}/calendar/calendarForm/T" class="cal-category-btn team-cal-btn">팀 캘린더</a>
          	<a href="${path}/calendar/calendarForm/F" class="cal-category-btn all-cal-btn">전체</a>
	        </c:when>
	       	<c:when test="${ category eq 'T'}">
	       	<a href="${path}/calendar/calendarForm/M" class="cal-category-btn my-cal-btn">내 캘린더</a>
          	<a href="${path}/calendar/calendarForm/T" class="cal-category-btn team-cal-btn c-page">팀 캘린더</a>
          	<a href="${path}/calendar/calendarForm/F" class="cal-category-btn all-cal-btn">전체</a>
	       	</c:when>
			<c:otherwise>
			<a href="${path}/calendar/calendarForm/M" class="cal-category-btn my-cal-btn">내 캘린더</a>
          	<a href="${path}/calendar/calendarForm/T" class="cal-category-btn team-cal-btn">팀 캘린더</a>
          	<a href="${path}/calendar/calendarForm/F" class="cal-category-btn all-cal-btn c-page">전체</a>
			</c:otherwise>
	        </c:choose> 
        </div>
        <!-- 일정추가버튼 영역 -->
        <div class="add-event-wrap modify-btn">
          <div><button type="button" id="addEventBtn" class="add-event btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#event-modal"><i class="bi bi-plus-square"></i> 일정추가</button></div>
        </div>
      </div>
	

      <div class="calendar-wrap" id="calendar-wrap" data-category="${ category }">
        <!-- 캘린더 -->
        <div class="cnt-left">
         <div id='calendarM'></div>
         
          
        </div>
        <!-- 캘린더 오른쪽 사이드 영역 -->
        <div class="cnt-right">
          
           
            <!-- 미니캘린더 영역 -->
            <div class="sm-calendar-wrap">
              <div id='mini-calendar'></div>
            </div>
            <!-- 디데이박스 -->
            <div class="d-day-wrap">
              <div class="sm-box-title">D-day</div>
              <div class="d-day-box">
              	<table>
				<c:forEach items="${listD}" var="d">
			 	<tr class="d-event">
			    <td>
			    <div class="d-day-txt"><span style="font-weight:500">D${d.name} </span>&nbsp
			    <span>${ d.title }</span></div>
			    </td>
			    <!-- <td><div class="d-xbtn" data-dayNone="${d.calendarNo}"><i class="fa-solid fa-xmark"></i></div></td>     -->                  
			 	</tr>
			 	</c:forEach>
			 </table>
              </div>
            </div>
            <!-- 메모박스 -->
            <div class="memo-wrap">
                <div class="sm-box-title">MEMO</div>
                <div class="child-memo-wrap"><textarea class="input-memo" maxlength="950">${memo}</textarea></div>
            </div>
        </div>
      </div>
    </div>
      




  <!-- 일정추가 모달 -->
  <div class="modal fade" id="event-modal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content cal-modal-content">
            <div class="table-box annual-modify-modal modal-body">
                <form>
                  <table class="add-event-table">
                      <tr>
                        <th class="apv-hidden" colspan="3">
                          <div class="event-ctg-btn">
                              <input type="radio" class="btn-check" name="event" id="myEvent" value="M" autocomplete="off" checked>
                              <label class="my-event-btn btn btn-outline-warning" for="myEvent" name="M">내 일정</label>
       
                              <input type="radio" class="btn-check" name="event" id="tmEvent" value="T" autocomplete="off">
                              <label class="tm-event-btn btn btn-outline-warning" for="tmEvent" name="T">팀 일정</label>      
                          </div>
                        </th>
                      </tr>
                      <tr>
                        <th class="modal-th">날짜 지정 *</th>
                      </tr>
                      <tr>
                        <td colspan="3">
                          <div class="event-td">
                            <input type="date" name="dateStart" class="date-box box-shadow-put" required> 시작 <input type="date" name="dateEnd" class="date-box box-shadow-put" required> 종료
                          </div>
                        </td>
                      </tr>
                      <tr>
                        <th class="modal-th">일정 제목 *</th>
                      </tr>
                      <tr>
                        <td colspan="3">
                          <div class="event-td"><input id="event-title" class="modal-event-title box-shadow-put form-control" type="text" aria-label="default input example" maxlength="20" required></div>
                        </td>
                      </tr>
                      <tr class="apv-hidden">
                        <th class="modal-th">일정 내용</th>
                      </tr>
                      <tr class="apv-hidden">
                        <td colspan="3">
                          <div class="event-td mb-3">
                            <textarea class="event-content modal-event-cnt box-shadow-put form-control" id="exampleFormControlTextarea1" rows="3" maxlength="500" style="width:300px"></textarea>
                          </div>
                        </td>
                      </tr>
                      <tr class="apv-hidden">
                        <th class="modal-th">색 지정</th>
                      </tr>
                      <tr class="apv-hidden">
                        <td colspan="3">
                          <div class="event-td my-event-col-box">
                            <input type="radio" class="btn-check" name="color" id="col1" value="var(--col1)" autocomplete="off">
                            <label class="color color1" for="col1"></label>

                            <input type="radio" class="btn-check" name="color" id="col2" value="var(--col2)" autocomplete="off">
                            <label class="color color2" for="col2"></label>
                            
                            <input type="radio" class="btn-check" name="color" id="col3" value="var(--col3)" autocomplete="off">
                            <label class="color color3" for="col3"></label>
                            
                            <input type="radio" class="btn-check" name="color" id="col4" value="var(--col4)" autocomplete="off">
                            <label class="color color4" for="col4"></label>
                            
                            <input type="radio" class="btn-check" name="color" id="col5" value="var(--col5)" autocomplete="off">
                            <label class="color color5" for="col5"></label>
                            
                            <input type="radio" class="btn-check" name="color" id="col6" value="var(--col6)" autocomplete="off">
                            <label class="color color6" for="col6"></label>
                            
                            <input type="radio" class="btn-check" name="color" id="col7" value="var(--col7)" autocomplete="off">
                            <label class="color color7" for="col7"></label>
                            
                            <input type="radio" class="btn-check" name="color" id="col8" value="var(--col8)" autocomplete="off">
                            <label class="color color8" for="col8"></label>
                          </div>
                          <div class="event-td tm-event-col-box">
                            <input type="radio" class="btn-check" name="t-color" id="col11" value="var(--col11)" autocomplete="off">
                            <label class="color color11" for="col11"></label>
                            
                            <input type="radio" class="btn-check" name="t-color" id="col12" value="var(--col12)" autocomplete="off">
                            <label class="color color12" for="col12"></label>
                            
                            <input type="radio" class="btn-check" name="t-color" id="col13" value="var(--col13)" autocomplete="off">
                            <label class="color color13" for="col13"></label>
                            
                            <input type="radio" class="btn-check" name="t-color" id="col14" value="var(--col14)" autocomplete="off">
                            <label class="color color14" for="col14"></label>
                          </div>
                        </td>
                      </tr>
                      <tr class="apv-hidden">
                        <th class="modal-th">D-day 표시</th>
                      </tr>
                      <tr class="apv-hidden">
                        <td>
                          <div class="form-check form-switch">
                            <input name="event-d-day" value="Y" class="box-shadow-none form-check-input" type="checkbox" role="switch" id="flexSwitchCheckDefault">
                          </div>
                        </td>
                      </tr>
                  </table>
                </form>
            </div>
            <div class="modal-footer">
            
              <button type="button" class="w90-btn btn btn-outline-danger" id="dlt-event-btn" style="display:none" data-apv="${H}">일정삭제</button>
              <button type="button" class="w90-btn btn btn-primary" id="modal-update-btn" style="display:none" data-update="${cno}">일정수정</button>
              <button type="button" class="w90-btn btn btn-primary" id="modal-submit-btn"style="display:none" data-submit="${cno}">일정등록</button>
              <button type="button" class="w90-btn btn btn-outline-primary" id="modal-cancel-btn" data-bs-dismiss="modal" aria-label="Close">취소</button>
          </div>
        </div>
    </div>
</div>

<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
      <div class="modal-content">
        

      </div>
    </div>
</div>


<script type="module" src="${path}/resources/js/calendar/calendar.js"></script>



</body>
</html>