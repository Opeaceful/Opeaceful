<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Opeaceful</title>
  <link rel="stylesheet" href="${path}/resources/css/common/memberSelect.css">
</head>
<body>

  <!--data-bs-target="#all-user-view" 조회할 구역에 data-target넣어주기-->
  <!--버튼에 id =  "id="all-member-view-button" 값 넣어주기-->
  <!--예시) <button type="button" class="search-btn" id="all-member-view-button"><i class="fa-solid fa-magnifying-glass" data-bs-toggle="modal" data-bs-target="#all-user-view"></i></button> -->

  <!--input 창으로도 검색하고 싶다면 input창에 id="member-search-keyword" 넣어주기!!!!!!!!!!!!-->

  
 <!-- 멤버 조회 모달 Modal -->
  <div class="modal fade" id="all-user-view" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" id="modal-user-view">
      <div class="modal-content"  id="all-user-view-content" >
        <!--헤더-->
        <div class="modal-header">
          <h1 class="modal-title fs-5">사용자 검색</h1>
          <button type="button" class="btn-close" id="all-uesr-btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>

        <div class="modal-body scroll-bar">
            <!--검색창-->
            <div class="search-wrap2 input-group mb-3 ms-1">
                <input type="text" class="search-input2 form-control box-shadow-none" placeholder="사원번호 또는 이름 입력" id="all-user-view-int">
                <button class="btn btn-outline-secondary search-btn2" type="button"><i class="fa-solid fa-magnifying-glass"></i></button>
            </div>
            <div>
                <form>
                    <table class="table table-hover table-common" id="all-member-table">
                        <thead>
                            <tr>
                              <th scope="col" class="W-10">
                                <input class="form-check-input" type="checkbox" id="all-tcode" data-key="A1">
                              </th>
                              <th scope="col">팀명</th>
                              <th scope="col" class="W-10">
                                <input class="form-check-input" type="checkbox" id="all-userName" data-key="" disabled>
                              </th>
                              <th scope="col">성명</th>
                            </tr>
                          </thead>
                          <tbody class="table-group-divider" id="all-member-table-body">
                      </tbody>
                    </table>     
                </form>
            </div>
        </div>
        
        <div class="modal-footer">
          <button type="button" class="btn btn-primary ms-1 ok-common" id="all-member-modal-button" data-dismiss="modal">확인</button>
        </div>

      </div>
    </div>
  </div>
  <script type="module" src="${path}/resources/js/common/memberSelect.js"></script>
</body>
</html>