/**
 *  작성자 윤지영
 *  권한 부여에 들어가는 js
 */

import { path } from "../common/common.js";

allDeptRoad();

/*부서+팀명 불러오고 세팅해주는 ajax */
function allDeptRoad() {
  let html = "";

  $.ajax({
    url: `${path}/dept/selectAllDept`,
    dataType: "JSON",
    success: function (result) {
      for (let dapt of result.dList) {
        if (dapt.topDeptCode == 0) {
          html += `
                    <div class="accordion-item accordion-item-common">
                        <h2 class="accordion-header">
                            <button class="accordion-button accordion-button-common collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#dept${dapt.deptCode}" aria-expanded="true" aria-controls="panelsStayOpen-collapseOne">
                            ${dapt.deptName}
                            </button>
                        </h2>
                        <div id="dept${dapt.deptCode}" class="accordion-collapse collapse ">
                            <div class="accordion-body">
                                <div class="accordion">
                    `;

          for (let team of result.dList) {
            if (team.topDeptCode == dapt.deptCode) {
              html += `
                             <div class="accordion-item accordion-item-common">
                                <h2 class="accordion-header">
                                    <button class="accordion-button accordion-button-common collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#team${team.deptCode}" aria-expanded="true" aria-controls="panelsStayOpen-collapseOne">
                                    ${team.deptName}
                                    </button>
                                </h2>
                                <div id="team${team.deptCode}" class="accordion-collapse collapse ">
                                    <div class="accordion-body">
                                    <ul class="list-group list-group-flush">
                                    
                            `;
              for (let p of result.PList) {
                html += `<li class="list-group-item list-group-item-action" data-id="${team.deptCode},${p.pCode}">${p.pName}</li>`;
              }

              html += `           
                                        </ul>
                                        </div>
                                    </div>
                                </div>
                            `;
            }
          }

          html += `
                                </div>
                            </div>   
                        </div>
                    </div>       
                    `;
        }
      }

      let RoleAccordion = document.getElementById("role-accordion");
      RoleAccordion.innerHTML = html;

      //ajax호출 이벤트 부여
      liRoleClick();
    },
    error: function (request) {
      console.log(request.status);
      swal(
        "데이터 로딩에 실패했습니다.",
        "지속적으로 발생시 담당자에게 문의하세요."
      );
    },
  });
}

//권한을 불러오는 ajax
function roleSelect(dept, p) {
  let html = "";

  $.ajax({
    url: `${path}/role/roleSelect`,
    dataType: "JSON",
    method: "post",
    data: {
      deptCode: dept,
      pCode: p,
    },
    success: function (result) {
      for (let role of result.rl) {
        html += `
                    <div class="form-check form-switch">   
                        <label class="form-check-label">${role.roleName}</label>
                        <input class="form-check-input" type="checkbox" role="switch" id="${dept},${p},${role.roleCode}">
                    </div>
                    `;
      }

      let grantingTable = document.getElementById("granting-table");
      grantingTable.innerHTML = html;

      for (let check of result.dr) {
        document.getElementById(
          dept + "," + p + "," + check.roleCode
        ).checked = true;
      }
      checkboxRole();
    },
    error: function (request) {
      console.log(request.status);
      swal(
        "데이터 로딩에 실패했습니다.",
        "지속적으로 발생시 담당자에게 문의하세요."
      );
    },
  });
}

//li태그에 해당 권한을 호출하는 click이벤트 부여
function liRoleClick() {
  //li태그 이벤트 추가
  let roleLi = document.querySelectorAll(".list-group-item"); //li 태그 이벤트 추가

  // 각 페이지 버튼에 클릭 이벤트 리스너 추가
  roleLi.forEach((li) => {
    li.addEventListener("click", function (e) {
      let code = e.target.dataset.id.split(",");
      roleSelect(code[0], code[1]);
    });
  });
}

//check박스에 권한을 수정하는 이벤트 부여
function checkboxRole() {
  //li태그 이벤트 추가
  let checkboxRole = document.querySelectorAll("#granting-table input"); //input 태그 이벤트 추가

  // 각 페이지 버튼에 클릭 이벤트 리스너 추가
  checkboxRole.forEach((check) => {
    check.addEventListener("click", function (e) {
      RoleGranting(e.target.id, e.target.checked);
      e.target.classList.add("active");
    });
  });
}

function RoleGranting(id, checked) {
  let code = id.split(",");

  $.ajax({
    url: `${path}/role/roleGranting`,
    dataType: "JSON",
    method: "post",
    data: {
      deptCode: code[0],
      pCode: code[1],
      roleCode: code[2],
      checked: checked,
    },
    success: function (result) {
      if (result > 0) {
        if (checked) {
          swal("권한이 등록되었습니다.");
        } else {
          swal("권한이 삭제되었습니다.");
        }
      } else {
        swal(
          "권한 수정이 실패하였습니다. 지속적으로 발생한다면 담당자에게 문의하세요."
        );
      }
    },
    error: function (request) {
      console.log(request.status);
      swal(
        "데이터 로딩에 실패했습니다.",
        "지속적으로 발생시 담당자에게 문의하세요."
      );
    },
  });
}

//이외의 버튼 부서등 누를때
$("#role-accordion").click(function () {
  document.getElementById("granting-table").innerHTML = "";
});
