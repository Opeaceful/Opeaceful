/**
 * 작성자 윤지영
 * 사원별 급여관리 js
 */

import { path } from "../common/common.js";
import { checkMemberNo } from "../common/memberSelect.js";

let selectButton = false;
let swalPaymentDateValue;
let UserCope;

let totalSalary = document.getElementById("total-salary");
let totalDeductions = document.getElementById("total-Deductions");
let netSalary = document.querySelector("#net-salary span");

/*검색에 따라 데이터를 불러오는*/
$("#salary-year,#salary-month,#dpSelect").change(function () {
  let year = $("#salary-year").val();
  let month = $("#salary-month").val();
  let team =
    document.getElementById("dpSelect").options[
      document.getElementById("dpSelect").selectedIndex
    ].text;

  location.href = `${path}/salary/AllSalary?year=${year}&month=${month}&team=${team}`;
});

/*급여 입력에 따라 총합 자동계산*/
function SalaryTableCalculate() {
  //만들어진 tr태그에 급여합산 이벤트 부여
  $(
    '#salary-table-pay input[type="number"],#salary-table-deduction input[type="number"]'
  ).keyup(function () {
    let totalGP = tatalPay("pay");
    let totalDD = tatalPay("ded");
    let netP = totalGP - totalDD;

    totalGP = totalGP.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    totalDD = totalDD.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    netP = netP.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

    totalSalary.innerText = totalGP;
    totalDeductions.innerText = totalDD;
    netSalary.innerText = netP;
  });
}

//조회된 급여의 상세내역을 띄워주는 클릭이벤트
function allSalaryTable() {
  //만들어진 tr태그에 이벤트 부여
  const AllsalaryTableTr = document.querySelectorAll(
    "#Am-salary-table tr[data-id]"
  );
  AllsalaryTableTr.forEach(function (tr) {
    tr.addEventListener("click", function (e) {
      const dataId = this.getAttribute("data-id");
      allSalaryData(dataId);
    });
  });
}

allSalaryTable();

/*각각의 급여명세서의 데이터를 불러오는 함수*/
function allSalaryData(dataId) {
  let data = dataId.split(",");

  $.ajax({
    url: `${path}/salary/salaryOne`,
    dataType: "JSON",
    method: "post",
    data: {
      id: data[0],
    },
    success: function (s) {
      document.querySelector("#salaryModalTitle").innerHTML =
        s.yearReported + "-" + s.monReported + "월 급여명세서";
      document.querySelector("#salryUserData").innerHTML = `
                <div class="hstack gap-3">
                <div><b>직원명 :  </b><span>${data[1]}</span> </div> 
                <div><b>부서 : </b><span>${s.deptName}</span>  </div> 
                <div><b>직급 : </b><span>${s.pName}</span> </div> 
                </div>

                <div><b>지급일 : </b>${s.sPaymentDate}</div>
            `;

      let payment = s.payments.split(",");
      let deduction = s.deduction.split(",");
      let phtml = "";
      let dhtml = "";

      if (payment.length > 1) {
        for (let i = 0; i < payment.length; i += 2) {
          phtml += `
                    <tr>
                        <td>${payment[i]}</td>
                        <td><input type="number" name="pay" class="form-control" required value=${
                          payment[i + 1]
                        }></td>
                        <td><button class="btn btn-danger"  type="button"><i class="fa-solid fa-minus"></i></button></td>
                    </tr>
                    `;
        }
      }

      if (deduction.length > 1) {
        for (let i = 0; i < deduction.length; i += 2) {
          dhtml += `
                <tr>
                <td name="payName">${deduction[i]}</td>
                <td><input type="number" name ="ded" class="form-control" required value=${
                  deduction[i + 1]
                }></td>
                <td><button class="btn btn-danger"  type="button"><i class="fa-solid fa-minus"></i></button></td>
                </tr>
                `;
        }
      }
      document.getElementById("salary-table-pay").innerHTML = phtml;
      document.getElementById("salary-table-deduction").innerHTML = dhtml;

      totalSalary.innerText = s.totalGrosspay;
      totalDeductions.innerText = s.totalDeductions;
      netSalary.innerHTML = s.netPay;
      $("#salary-delete").val(s.salaryNo);

      deleteTableClick();
      SalaryTableCalculate();
    },
    error: function (request) {
      console.log(request.status);
      swal(
        "데이터 로딩에 실패했습니다.",
        "지속적으로 발생시 담당자에게 문의하세요."
      );
    },
  });

  $("#salaryModal").modal("show");
}

/*input박스를 추가해주는 함수*/
function addTable(tableId, tdName) {
  //테이블 id를 매개변수로 받아와 테이블마다 사용가능
  const table = document.getElementById(tableId);
  // 새 행(Row) 추가
  const newRow = table.insertRow();

  // 새 행(Row)에 Cell 추가
  const newCell1 = newRow.insertCell(0); //항목칸
  const newCell2 = newRow.insertCell(1); //금액칸
  const newCell3 = newRow.insertCell(2); //삭제칸

  // Cell에 div추가
  newCell1.innerHTML = `<td><input type="text" class="form-control" value="" name="payName" required></td>`;
  newCell2.innerHTML = `<td><input type="number" class="form-control" name="${tdName}" value="" required></td>`;
  newCell3.innerHTML = `<td><button class="btn btn-danger" type="button"><i class="fa-solid fa-minus"></i></button></td>`;

  deleteTableClick();
  SalaryTableCalculate();
}

//테이블 버튼이벤트
function deleteTableClick() {
  const deleteTablebtn = document.querySelectorAll(
    "#table-form-salary td button"
  );
  deleteTablebtn.forEach(function (tr) {
    tr.addEventListener("click", function (e) {
      e.preventDefault();
      deleteTable(e.currentTarget);
    });
  });
}

/*버튼을 클릭시 테이블 삭제*/
function deleteTable(button) {
  //누른 버튼의 부모의 부모호출
  let tabletr = button.parentNode.parentNode;
  tabletr.remove();
}

$("#salary-table-btn").click(function () {
  addTable("salary-table-pay", "pay");
});

$("#deduction-table-btn").click(function () {
  addTable("salary-table-deduction", "ded");
});

$("#salary-delete").click(function (e) {
  swal("정말 삭제하시겠습니까?", "삭제시 해당 데이터는 영구 삭제됩니다.", {
    buttons: { confirm: "확인", cancel: "취소" },
  }).then(function (isConfirm) {
    if (isConfirm) {
      $.ajax({
        url: `${path}/salary/salaryDelete`,
        dataType: "JSON",
        method: "post",
        data: {
          num: e.target.value,
        },
        success: function (result) {
          location.href = window.location.href;
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
  });
});

$("#salary-update").click(function (e) {
  let totalGP = totalSalary.innerText;
  let totalDD = totalDeductions.innerText;
  let netP = netSalary.innerText;

  swal(
    "수정하시겠습니까?",
    "총 금액 : " +
      totalGP +
      "원, 공제금액 : " +
      totalDD +
      "원, 실지급액 : " +
      netP +
      "원",
    {
      buttons: { confirm: "확인", cancel: "취소" },
    }
  ).then(function (isConfirm) {
    if (isConfirm) {
      if (document.getElementById("table-form-salary").checkValidity()) {
        $.ajax({
          url: `${path}/salary/salaryUpdate`,
          dataType: "JSON",
          method: "post",
          data: {
            totalGrosspay: totalGP,
            totalDeductions: totalDD,
            netPay: netP,
            salaryNo: $("#salary-delete").val(),
            payments: tataldiv("#salary-table-pay tr"),
            deduction: tataldiv("#salary-table-deduction tr"),
          },
          success: function (result) {
            location.href = window.location.href;
          },
          error: function (request) {
            console.log(request.status);
            swal(
              "데이터 로딩에 실패했습니다.",
              "지속적으로 발생시 담당자에게 문의하세요."
            );
          },
        });
      } else {
        swal("빈 값 또는 조건에 맞지않는 입력이 있습니다.");
      }
    }
  });
});

//확인 버튼 눌렀을때 salaryAll에서 처리할 이벤트
$("#all-member-modal-button").click(function () {
  let year = $("#salary-year").val();
  let month = $("#salary-month").val();

  //해당 버튼이 select용으로 눌렸을떄만
  if (!selectButton) {
    if (checkMemberNo.length > 0) {
      location.href = `${path}/salary/AllSalary?year=${year}&month=${month}&no=${checkMemberNo}`;
    }
  } else {
    //업데이트용
    if (checkMemberNo.length > 0) {
      let JsoncheckMemberNo = JSON.stringify(checkMemberNo);

      $.ajax({
        url: `${path}/salary/insertSalary`,
        dataType: "JSON",
        method: "post",
        data: {
          year: year,
          month: month,
          checkMemberNo: JsoncheckMemberNo,
          PaymentDate: swalPaymentDateValue,
          UserCope: UserCope,
        },
        success: function (result) {
          selectButton = false;
          if (result > 0) {
            location.href = window.location.href;
          }
        },
        error: function (request) {
          console.log(request.status);
          swal(
            "데이터 로딩에 실패했습니다.",
            "지속적으로 발생시 담당자에게 문의하세요."
          );

          selectButton = false;
        },
      });
    } else {
      swal("멤버를 선택해주세요.");
      selectButton = false;
    }
  }
});

//모달 종료시
$("#all-uesr-btn-close").click(function () {
  selectButton = false;
});

//합산 세팅
function tatalPay(name) {
  let pList = document.querySelectorAll(`td input[name="${name}"]`);

  let pay = 0;
  pList.forEach(function (td) {
    pay = pay + parseInt(td.value);
  });

  return pay;
}

//div세팅
function tataldiv(tableid) {
  const trs = document.querySelectorAll(tableid);

  let payments = "";
  for (let i = 0; i < trs.length; i++) {
    if (trs[i].firstElementChild.textContent) {
      payments +=
        trs[i].firstElementChild.textContent +
        "," +
        trs[i].querySelector('input[type="number"]').value +
        ",";
    } else {
      payments +=
        trs[i].querySelector('input[type="text"]').value +
        "," +
        trs[i].querySelector('input[type="number"]').value +
        ",";
    }
  }

  payments = payments.slice(0, -1);

  return payments;
}

//급여추가 버튼 클릭시
$("#saray-button-add").click(function () {
  let year = $("#salary-year").val();
  let month = $("#salary-month").val();

  if (month == 13) {
    swal("귀속 월을 선택하세요.");
  } else {
    swal(`${year}년 ${month}월 데이터를 생성하시겠습니까?`, {
      buttons: { confirm: "확인", cancel: "취소" },
      content: {
        element: "div",
        attributes: {
          innerHTML: `
                    <label for="paymentDate">지급 년 월 : </label>
                    <input id="swalPaymentDate" type="date" >
                  `,
        },
      },
    }).then(function (isConfirm) {
      swalPaymentDateValue = document.getElementById("swalPaymentDate").value;

      if (isConfirm) {
        if (swalPaymentDateValue) {
          selectButton = true;

          swal(`전달 데이터를 복사하시겠습니까?`, {
            buttons: {
              confirm: "예",
              cancel: "아니요",
            },
          }).then((value) => {
            if (value) {
              UserCope = true;
              $("#all-user-view").modal("show");
            } else {
              UserCope = false;
              $("#all-user-view").modal("show");
            }
          });
        } else {
          swal(`지급날짜를 입력해주세요`);
        }
      }
    });
  }
});

//검색창 키워드에 따라 검색해주는 함수
$("#member-search-keyword").on("keyup", function () {
  let year = $("#salary-year").val();
  let month = $("#salary-month").val();

  if (checkMemberNo.length > 0) {
    location.href = `${path}/salary/AllSalary?year=${year}&month=${month}&no=${checkMemberNo}`;
  }
});
