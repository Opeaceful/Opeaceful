// input file 의 파일들 잠깐 저장해둘 용도의 변수
let fileList;

// 기안서 작성/수정 모달 안의 이벤트 부여 구역
function approvalModalEvent() {
  // datePicker 기본 세팅
  // 나중에 따로 만들어둔 setDatePickerType() 함수 실행시켜야 제대로 보여짐
  $('#date').daterangepicker();
  $('#date').on('show.daterangepicker', function (ev, picker) {
    $('.yearselect').css('float', 'left');
    $('.monthselect').css('float', 'right');
    $('.cancelBtn').css('float', 'right');
  });

  // 결재라인 모달 닫기
  document
    .getElementById('btn-approval-line-modal-close')
    .addEventListener('click', function () {
      document.getElementById('approval-line-modal').style.display = 'none';
    });

  // 사원 테이블에서 사원명 더블클릭시 결재자 라인에 추가
  document
    .getElementById('select-member-table')
    .addEventListener('dblclick', function (e) {
      if (e.target.className == 'org-table-member') {
        let userNoList = [];
        document.querySelectorAll('.selected-lines > ol > li').forEach((li) => {
          userNoList.push(Number(li.dataset.user));
        });

        let userNo = e.target.getAttribute('value');

        // 기존에 추가되지 않은 사용자만 추가 가능
        if (!userNoList.includes(Number(userNo))) {
          let userName = e.target.innerText;
          let li = document.createElement('li');
          // 만들어둔 li 요소에 유저번호 세팅
          li.dataset.user = userNo;
          let html = `<select name="type" >
                        <option value="A" selected>결재</option>
                        <option value="R">참조</option>
                      </select>
                      <div value="${userNo}">
                        ${userName}
                        <button
                          class="btn-selected-delete btn btn-outline-primary"
                        >
                          <div class="div-minus"></div>
                        </button>
                      </div>`;

          li.innerHTML = html;

          document.querySelector('.selected-lines > ol').appendChild(li);
        } else {
          swal('이미 선택된 사원입니다.', {
            buttons: { cancel: '확인' },
          });
        }
      }
    });

  // 선택된 결재자 삭제버튼 클릭시 이벤트 할당
  document
    .querySelector('.selected-lines ol')
    .addEventListener('click', function (e) {
      let currentNode = e.target;

      if (
        currentNode.classList.contains('btn-selected-delete') ||
        currentNode.classList.contains('div-minus')
      ) {
        let li;
        while (currentNode !== null) {
          currentNode = currentNode.parentNode;
          if (currentNode.tagName === 'LI') {
            li = currentNode;
            break;
          }
        }

        li.remove();
      }
    });

  // 선택된 라인 리스트 드래그로 순서 바꿀수 있게끔 하는 jquery Sortable
  $('#approval-line-modal .selected-lines ol').sortable();
  $('#approval-line-modal .selected-lines ol').disableSelection();

  // 즐겨찾기 추가 버튼 클릭시 즐겨찾기 모달 오픈
  document.getElementById('btn-add-favor').addEventListener('click', () => {
    // 인풋창 값 리셋
    document.getElementById('input-favor-title').value = '';
    document.querySelector('.favor-modal-back').style.display = 'flex';
  });

  // 즐겨찾기 창 닫기 버튼 이벤트
  document
    .querySelector('#favor-add-modal .modal-header .btn-close')
    .addEventListener('click', () => {
      // 인풋창 값 리셋
      document.getElementById('input-favor-title').value = '';
      // 즐겨찾기 창 닫기
      document.querySelector('.favor-modal-back').style.display = 'none';
    });

  // 결재라인 저장 버튼 클릭시 동작
  document.getElementById('btn-submit-line').addEventListener('click', () => {
    let liList = document.querySelectorAll(
      '#approval-line-modal .selected-lines > ol > li'
    );
    let html = '';
    liList.forEach((li, index) => {
      // let level = index + 1;
      let div = li.getElementsByTagName('div')[0];
      let userName = div.innerText;
      let userNo = Number(div.getAttribute('value'));
      let type = li.getElementsByTagName('select')[0].value;

      html += `<li data-type="${type}" data-user="${userNo}"><b>${
        type === 'A' ? '결재' : '참조'
      }</b> ${userName}</li>`;
    });

    document.querySelector(
      '#approval .approval-lines ol.scroll-bar'
    ).innerHTML = html;

    document.getElementById('btn-approval-line-modal-close').click();
  });

  // 첨부 파일 추가 버튼 클릭시 이벤트
  document.getElementById('btn-add-file').addEventListener('click', () => {
    // 파일리스트 리셋
    fileList = new DataTransfer();

    // 인풋태그에 있던 파일들 따로 저장해놓기
    const files = document.querySelector('#input-add-file').files;

    for (let i = 0; i < files.length; i++) {
      fileList.items.add(files[i]);
    }
    console.log(fileList.files);
    document.querySelector('#input-add-file').click();
  });

  // 첨부파일 저장된 인풋태그의 값이 변경되었을 경우 이벤트
  document.querySelector('#input-add-file').addEventListener('change', (e) => {
    console.log('파일');
    const files = Array.from(e.target.files);

    for (let i = 0; i < files.length; i++) {
      let file = files[i];

      // 인풋창 열리기 전에 따로 저장해두었던 파일리스트에 새로 들어온 파일들 더해주기
      fileList.items.add(file);

      let html = `<div id="file-item-${file.lastModified + '' + i}">
                    <button data-index='file-item-${
                      file.lastModified + '' + i
                    }' type="button" class="btn-file-delete">
                      <div class ="div-minus">
                    </button>
                    ${file.name}
                  </div>`;

      document.querySelector('.approval-files > .scroll-bar').innerHTML += html;
    }

    // 기존파일 + 신규파일 한 파일리스트를 인풋요소에 다시 넣어줌
    e.target.files = fileList.files;
  });

  // 첨부파일 삭제버튼 클릭시 이벤트
  document
    .querySelector('.approval-files > .scroll-bar')
    .addEventListener('click', (e) => {
      let currentTarget;
      // 만약 클릭된게 삭제 버튼 요소가 아니면 이벤트 종료
      if (e.target.className == 'btn-file-delete') {
        currentTarget = e.target;
      } else if (e.target.classList.contains('div-minus')) {
        currentTarget = e.target.parentNode;
      } else {
        return;
      }

      const removeTargetId = currentTarget.dataset.index;
      const removeTarget = document.getElementById(removeTargetId);
      const files = document.querySelector('#input-add-file').files;
      const dataTranster = new DataTransfer();

      Array.from(files)
        .filter((file) => file.lastModified != removeTargetId)
        .forEach((file) => {
          dataTranster.items.add(file);
        });

      // 인풋요소에 클릭된 파일을 삭제한 버전으로 파일들 다시 세팅
      document.querySelector('#input-add-file').files = dataTranster.files;

      // 미리보기 요소 삭제
      removeTarget.remove();
    });
}

// 기본 이벤트들 세팅 실행
approvalModalEvent();
