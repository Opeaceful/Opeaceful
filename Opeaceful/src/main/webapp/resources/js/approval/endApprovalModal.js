// 하단 버튼들 이벤트 부여 구역
let footerEvent = () => {
  // 메모 버튼 클릭 이벤트
  document.getElementById('btn-memo-open').addEventListener('click', () => {
    /* 메모 리스트 오픈 */
    document.querySelector('#memo-modal-back .memo-list').style.display =
      'block';
    /* 메모 추가/디테일 화면 감추기 */
    document.querySelector('#memo-modal-back .memo-detail').style.display =
      'none';

    // 메모 모달 오픈
    document.getElementById('memo-modal-back').style.display = 'flex';
  });

  // 메모 닫기 버튼 클릭이벤트
  document
    .getElementById('btn-memo-modal-close')
    .addEventListener('click', () => {
      // 메모 모달 감추기
      document.getElementById('memo-modal-back').style.display = 'none';
    });

  // 작성버튼 클릭시 메모 추가 화면 리셋 후 열기
  document.getElementById('btn-add-memo').addEventListener('click', () => {
    // 인풋요소 파일 리셋
    document.getElementById('input-memo-add-file').files =
      new DataTransfer().files;

    // 메모 내용부분 리셋
    document.getElementById('memo-add-content').value = '';

    // 삭제버튼 감추기
    document.getElementById('btn-add-memo-delete').style.display = 'none';
    // 저장버튼 안의 값 저장용으로 세팅
    document.getElementById('btn-add-memo-save').dataset.memono = 'null';
    // 첨부파일들 리셋
    document.querySelector('#end-approval .memo-files').innerHTML = '';

    /* 메모 리스트 감추기 */
    document.querySelector('#memo-modal-back .memo-list').style.display =
      'none';
    /* 메모 추가/디테일 화면 오픈 */
    document.querySelector('#memo-modal-back .memo-detail').style.display =
      'block';
  });

  // 메모 작성화면 뒤로가기 버튼 클릭 이벤트
  document.getElementById('btn-add-memo-back').addEventListener('click', () => {
    /* 메모 리스트 오픈 */
    document.querySelector('#memo-modal-back .memo-list').style.display =
      'block';
    /* 메모 추가/디테일 화면 감추기 */
    document.querySelector('#memo-modal-back .memo-detail').style.display =
      'none';
  });
};

footerEvent();
