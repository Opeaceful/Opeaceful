/**
 *  가영 : 부서, 직급, 인사발령 js
 */
import {path} from '../common/common.js';
import {topDeptRoad, positionRoad} from '../common/dtcodeselect.js';

$(document).ready(function() {

	selectDept();

	let currentInfo = {
		deptCode : '', 
		topDeptCode : '',
		topDeptName : '',
		deptName: ''	
	};	

/* 부서+팀명 조회 */
function selectDept() {

	let html = "";
	
	$.ajax({
		url:path+"/orgChart/selectDept",
		type : "POST",
		dataType : "JSON",
		success: function(result){

			for (let dept of result) {
				if(dept.topDeptCode == 0){
					
					html += `<div class="accordion-item accordion-item-common org-accordion${dept.deptCode}" id="org-accordion">
								<h2 class="accordion-header org-accordion-header" id="heading${dept.deptCode}">
									<button class="accordion-button oc-accordion-btn accordion-button-common" type="button" data-bs-toggle="collapse" data-bs-target="#collapse${dept.deptCode}" aria-expanded="true" aria-controls="collapse${dept.deptCode}">
										<input type="text" id="${dept.deptCode}" data-id="${dept.deptCode},${dept.topDeptCode},${dept.deptName}" class="topD-name" name="department" value="${dept.deptName}" aria-label="부서이름인풋">
									</button>
									<div class="icons hidden">
										<i class="fa-solid fa-plus team-plus" id="team-plus${dept.deptCode}"></i> 
										<i class="fa-solid fa-minus team-minus" id="team-minus${dept.deptCode}"></i> 
										<i class="fa-solid fa-pen team-change" id="team-change${dept.deptCode}"></i>
									</div>
								</h2>
								<div id="collapse${dept.deptCode}" class="accordion-collapse collapse org-accordion-collapse" aria-labelledby="heading${dept.deptCode}" data-bs-parent="#accordionExample">
									<ul class="accordion-body accordion-body-common oc-all" id="oc-all${dept.deptCode}">`
									
					for (let team of result) {
						if (team.topDeptCode == dept.deptCode) {
				
							html += `<li class="team low-common">
										<span class="input-click" data-id="${team.deptCode},${team.topDeptCode},${team.deptName},${dept.deptName}">
											<input type="text" name="team" id="${team.deptCode}" data-id="${team.deptCode},${team.topDeptCode},${team.deptName},${dept.deptName}" class="team-name" value="${team.deptName}">
										</span>
										<div class="count" id="count">(${team.deptCount})</div>
										<div class="team-icons hidden">
											<i class="fa-solid fa-minus li-team-minus" id="li-team-minus${team.deptCode}"></i> 
											<i class="fa-solid fa-pen li-team-change" id="li-team-change${team.deptCode}"></i>
										</div>
									</li>`
						}
										
					}
							html += `</ul>
									</div>
									</div>`

				}
			}

			let orcAccordion = document.getElementById("accordionExample");
			orcAccordion.innerHTML = html;
			// orcAccordion.insertAdjacentHTML('afterend', html);

			deptListClick();

			if(currentInfo.topDeptCode){
				$(`#heading${currentInfo.topDeptCode}>button`).click();
			}
		},
		error : function(request){
			console.log("에러발생");
			console.log(request.status);
		}
	})
}

// 해당 부서에 있는 사원 조회
function selectDeptList(deptCode, topDeptCode, deptName, topDeptName) {
	
	let str = ""
    let html = "";
	
	currentInfo.deptCode = deptCode;
	currentInfo.topDeptCode = topDeptCode;
	currentInfo.topDeptName = topDeptName;
	currentInfo.deptName = deptName;

    $.ajax({
		url : path+"/orgChart/selectAll",   
		type : 'post', 
		data : {deptCode : deptCode},
		dataType : "JSON",
		success : function(result){
			
			for (let team of result) {
				if (topDeptCode == team.topDeptCode) {

					str = `<div class="department-name-box">${topDeptName}</div>
							<button class="btn btn-primary personnel-btn" data-id="${deptCode},${topDeptCode}" data-bs-toggle="modal" data-bs-target="#change" type="button">인사발령</button>`

					html += `<tr id="user-info">
								<td>${team.eno}</td>
								<td>${team.userName}</td>
								<td>${team.deptName}</td>
								<td>${team.pName}</td>
							</tr>`
				}
			}
			let TopDeptName = document.querySelector(".name-btn-box");
			TopDeptName.innerHTML = str;

			let deptUserList = document.getElementById("org-tbody");
			deptUserList.innerHTML = html;
			
			personnelClick();

		}
	})

}
// 하위부서 input을 감싸고 있는 sapn태그에 사원 조회 이벤트 부여
function deptListClick() {

    let deptInput = document.querySelectorAll(".input-click"); 

    // 각 버튼에 클릭 이벤트 리스너 추가
    deptInput.forEach(sapn => {
        sapn.addEventListener("click", function(e) {
            let code = e.target.dataset.id.split(",");
			let deptCode = code[0];
            let topDeptCode = code[1];
            let deptName = code[2];
			let topDeptName = code[3];
            selectDeptList(deptCode, topDeptCode, deptName, topDeptName);
        });
    });
	
}

// 인사발령 모달에 정보 뿌려주는 ajax
function selectPersonnel(deptCode, topDeptCode) {

	let html = "";

	$.ajax({
		url : path+"/orgChart/personnel",   
		type : 'post', 
		data : {deptCode : deptCode,
				topDeptCode : topDeptCode},
		dataType : "JSON",
		success : function(result){

			let TIME_ZONE = 9 * 60 * 60 * 1000; // 9시간

			for (let team of result) {
				if (topDeptCode == team.topDeptCode) {

					html += `<tr class="change-tr" data-userno="${team.userNo}" data-deptcode="${deptCode}" data-pcode="${team.pCode}" data-id="${topDeptCode}">
								<td>${new Date(Date.now() + TIME_ZONE).toISOString().split('T')[0]}</td>
								<td>${team.userName}</td>
								<td>${team.topDeptName}</td>
								<td>
									<select class="form-select box-shadow-none topDeptName" data-id="${topDeptCode}" id="topDeptName" name="topDeptCode" aria-label="Default select example">
										<option value="" selected>부서선택</option>
									</select>
								</td>
								<td>${team.deptName}</td>
								<td>
									<select class="form-select box-shadow-none deptName" data-id="${deptCode}" id="deptName" name="deptCode"  aria-label="Default select example">
										<option selected>부서선택</option>
									</select>
								</td>
								<td>${team.pName}</td>
								<td>
									<select class="form-select box-shadow-none pName" data-id=${team.pCode} id="pName" name="pCode" aria-label="Default select example">
										<option value="" selected>직급선택</option>
									</select>
								</td>
							</tr>`
				}
			}
			
			
			let personnelUserList = document.getElementById("org-modal-tbody");
			personnelUserList.innerHTML = html;
			
			topDeptRoad();
			deptSelcet();
			positionRoad();

		}
	})
}

/* 인사발령 버튼 이벤트 */
function personnelClick() {

	let personnel = document.querySelectorAll(".personnel-btn"); 

	// 각 버튼에 클릭 이벤트 리스너 추가
	personnel.forEach(btn => {
		btn.addEventListener("click", function(e) {
			let id = e.target.dataset.id.split(",");
			selectPersonnel(id[0], id[1]);
			$("#pesonnel-modal").modal('show');
		});
	});
}

/* 상위부서 옵션 선택에 따라 해당 상위부서의 하위부서 뜨게하기 */ 
function deptSelcet() {
	$(".topDeptName").change(function(e){

		e.target.parentElement.parentElement.classList.add("changeValue");
		
		let topDeptCode = $("option:selected", this).attr("value");

		// console.log( $(this).val());
		// console.log( $("option:selected", this).attr("value"));
		// console.log(this);
		// console.dir(this);
		let deptCode = this.parentElement.parentElement.querySelectorAll("[name=deptCode]");

		$.ajax({
			url:`${path}/dept/selectDept`,
			dataType : "JSON",
			success: function(result){
				
				for(let i = 0; i < deptCode.length; i++){
					deptCode[i].innerHTML = "";
					for(let dept of result){
						if (dept.topDeptCode !== 0) {
							if (topDeptCode == dept.topDeptCode) {
								const option = document.createElement("option");
								option.value = dept.deptCode;
								option.text = dept.deptName;
								deptCode[i].appendChild(option);
							} // 하위 부서 셀렉트
						}
					};
				}

				// 하위부서가 없는 상위부서 선택 시 저장버튼 비활성화
				let changeDept = false;

				for (let dept of deptCode) {
					if(!$(dept).val() || $(dept).val() == null) {
						changeDept = true;
						swal('하위부서가 존재하지 않습니다. 다시 선택해 주세요.', {
							buttons: { cancel: '확인' },
						  });
					}
				}
				if (changeDept) {
					$("#ok-personnel").attr("disabled", true);
				} else {
					$("#ok-personnel").attr("disabled", false);
				}
			},
			error : function(request){
				console.log("에러발생");
				console.log(request.status);
			}
		})
		
		
	})
}

/* 저장 버튼 클릭 시 인사발령 ajax */
$('#ok-personnel').click(function(e) {
	let changeValue = document.querySelectorAll(".changeValue");

	let Arr = [];

	let jsonData;
	let changeDeptCode = ""; 


	changeValue.forEach(tr => {

		let originUserNo = tr.dataset.userno;

		let originDeptCode = tr.dataset.deptcode;
		changeDeptCode = tr.querySelector(".deptName").value;

		let originPcode = tr.dataset.pcode;
		let changePcode =  tr.querySelector(".pName").value;

		let data = {
				userNo : originUserNo,
				deptCode : (originDeptCode != changeDeptCode) ? changeDeptCode : originDeptCode,
				pCode: (changePcode !== "" && changePcode !== originPcode) ? changePcode : originPcode

		}; 

		if (changeDeptCode != "" ) {
			Arr.push(data);
		}

		jsonData = JSON.stringify(Arr);
    	jQuery.ajaxSettings.traditional = true;

	});

	if(changeDeptCode == "") {
		swal('하위부서가 존재하지 않습니다. 다시 선택해 주세요.', {
			buttons: { cancel: '확인' },
		  });
        return;
    }
	if (Arr.length > 0) {
		$.ajax({
			url : path+"/orgChart/updatePersonnel",
			type: 'POST',
			data: {"jsonData" : jsonData},
			dataType:'json',
			success: function(result) {
				swal('해당 사원들의 인사가 변경되었습니다.', {
					buttons: { cancel: '확인' },
				  });
				
				$("#pesonnel-modal").modal('hide');
				selectDept();
				selectDeptList(currentInfo.deptCode,currentInfo.topDeptCode,currentInfo.deptName,currentInfo.topDeptName);
				
			},
			error: function(x, e) {
				//err msg 출력
				$.failMsg('error');
			}
		});
		
	} else{
		$("#pesonnel-modal").modal('hide');
	}
	
})

	/* 클릭 시에만 추가, 수정, 삭제 아이콘 뜨게 */
	$(document).on("click",".org-accordion-header",function(e){
		$(this).find(".hidden").show();
	})

	$(document).on("click",".team",function(e){
		$(this).find(".hidden").toggle();
	})


	/* 상위부서 추가 */

	// 부서추가 버튼 클릭 시 부서 이름 입력할 수 있는 input 생성           
	$('.topD-plus').click (function () {
		
		// 동적으로 아코디언 생성해서 사용하기 위해 클래스 이름 뒤에 숫자 추가
		// let num = document.getElementsByClassName('accordion-item').length;
		let num = 0;

		$('.inputs').append(
			`<div class="accordion-item accordion-item-common org-accordion${num}" id="org-accordion">
				<h2 class="accordion-header org-accordion-header" id="heading${num}">
					<button class="accordion-button oc-accordion-btn accordion-button-common" type="button" data-bs-toggle="collapse" data-bs-target="#collapse${num}" aria-expanded="true" aria-controls="flush-collapse${num}" aria-label="펼치기">
						<input type="text" id="dept-code" class="topD-name" name="department${num}" aria-label="부서이름인풋">
					</button>
					<div class="icons hidden">
						<i class="fa-solid fa-plus team-plus"></i> 
						<i class="fa-solid fa-minus team-minus"></i> 
						<i class="fa-solid fa-pen team-change"></i>
					</div>
				</h2>
				<div id="collapse${num}" class="accordion-collapse org-accordion-collapse collapse" aria-labelledby="heading${num}" data-bs-parent="#accordionExample">
					<ul class="accordion-body accordion-body-common oc-all" id="oc-all"></ul>
				</div>
			</div>`
		);

		// 생성된 input에 포커스
		$(`input[name=department${num}]`).focus();
	});
	
	let topDeptCode = '';

	// input 포커스 아웃 시 상위부서 db에 부서추가
	$(".inputs").on("blur", ".topD-name", function(e) {
		
		let input = $(e.target).val();
		let id= $(e.target).attr("id");
		// let topDeptCode = $(e.target).parents(".accordion-item").find('.topD-name').attr("data-id").split(",")[0];
		
		// 부서이름 입력 안했을 시 input 삭제
		if (input == "") {
			$(e.target).closest("#org-accordion").remove();
		} else {
			if (id == "dept-code") {
				//부서추가 ajax
				$.ajax({
					url : path+"/orgChart/insertDeptCode",   
					type : 'post', 
					data : {deptName: input},
					success : function(result){
						if (result > 0) {
							$(e.target).closest("#org-accordion").remove();
							$('.inputs').append(
								`<div class="accordion-item accordion-item-common org-accordion${result}">
									<h2 class="accordion-header org-accordion-header" id="heading${result}">
										<button class="accordion-button oc-accordion-btn accordion-button-common" type="button" data-bs-toggle="collapse" data-bs-target="#collapse${result}" aria-expanded="true" aria-controls="flush-collapse${result}" aria-label="펼치기">
											<input type="text" id="${result}" data-id="${result}" class="topD-name" value="${input}" name="department${result}" aria-label="부서이름인풋">
										</button>
										<div class="icons hidden">
											<i class="fa-solid fa-plus team-plus" id="team-plus${result}"></i> 
											<i class="fa-solid fa-minus team-minus" id="team-minus${result}"></i> 
											<i class="fa-solid fa-pen team-change" id="team-change${result}"></i>
										</div>
									</h2>
									<div id="collapse${result}" class="accordion-collapse org-accordion-collapse collapse" aria-labelledby="heading${result}" data-bs-parent="#accordionExample">
										<ul class="accordion-body accordion-body-common oc-all" id="oc-all"></ul>
									</div>
								</div>`
							);
							topDeptCode = `${result}`;
							$(e.target).attr("id", result);
							swal('해당 부서가 추가되었습니다.', {
								buttons: { cancel: '확인' },
							  });
						}
						$(".topD-name").css('pointer-events','none');
						$(".oc-accordion-btn").css('cursor','default');
					}
				});
			} else {
				// 부서이름 수정 ajax
				$.ajax({
					url : path+"/orgChart/updateDeptName",   
					type : 'post', 
					data : {deptName: input, deptCode : id},
					success : function(result){
						if (result > 0) {
							$(e.target).attr("id", result);
							swal('해당 부서명이 변경되었습니다.', {
								buttons: { cancel: '확인' },
							  });
						}
						$(".topD-name").css('pointer-events','none');
						$(".oc-accordion-btn").css('cursor','default');
					}
				});
			}
		}
	}).on("keydown", ".topD-name", function(e) {
		if (e.which === 13) { // 엔터 키의 keyCode는 13입니다.
			e.preventDefault();
			$(this).blur(); // 포커스 아웃 이벤트를 트리거합니다.
		}
	});

	//////////////////////////////////////////////////////////////////// 수정버튼 클릭 시 부서명 수정
	$(".inputs").on("click", ".team-change", function(e) {
		let topDeptNameChange = $(this).parent().siblings(".oc-accordion-btn").find("input");

		let inputLen = topDeptNameChange.val().length;
		topDeptNameChange.focus();
		topDeptNameChange[0].setSelectionRange(inputLen, inputLen);

		topDeptNameChange.css('pointer-events','auto');
	})

	$(".inputs").on("click", ".li-team-change", function(e) {
		let deptNameChange = $(this).parent().siblings(".input-click").find("input");

		let inputLen = deptNameChange.val().length;
		deptNameChange.focus();
		deptNameChange[0].setSelectionRange(inputLen, inputLen);

		deptNameChange.css('pointer-events','auto');

		// console.log(e.target);
		// console.log(e.target.id);
		// let id =  e.target.id.replace("li-team-change", '');

		// console.log(e.target.id, id, $('#'+id));

		
		// let inputLen = $('#'+id).val().length;
		// $('#'+id).focus();
		// $('#'+id)[0].setSelectionRange(inputLen, inputLen);
	})

	/////////////////////////////////////////////////////////////////////// 상위부서 삭제
	$(".inputs").on("click", ".team-minus", function(e) { 
			
		let deptCode = $(e.target).parents(".accordion-item").find('.topD-name').attr("data-id").split(",")[0];
		// let deptCode = $(e.target).parents(".accordion-item").find('.team-name').attr("data-id").split(",")[0];

		swal('부서를 삭제 하시겠습니까?', {
			buttons: { confirm: '확인', cancel: '취소' },
		  }).then(function (isConfirm) {
			if (isConfirm) {
				$.ajax({
					url : path+"/orgChart/deleteTopDeptCode",
					type : "POST",
					data : {deptCode : deptCode},
					success : function(result) {
						if (result > 0) {
							swal('사용중인 부서입니다. 다시 확인해주세요.', {
								buttons: { cancel: '확인' },
							  });
						} else {
							swal('해당 부서가 삭제되었습니다.', {
								buttons: { cancel: '확인' },
							  });
							$(e.target).parents(".accordion-item").remove();
						}
					}
				})
			}
		  });
    });
	
	/* 하위부서 삭제 */
	$(".inputs").on("click", ".li-team-minus", function(e) { 
		let topDeptCode = $(e.target).parents(".accordion-item").find('.topD-name').attr("data-id").split(",")[0];
		// let deptCode =  e.target.id.replace("li-team-minus", '');
		let deptCode = $(e.target).parents(".accordion-item").find('.team-name').attr("data-id").split(",")[0];

		swal('부서를 삭제 하시겠습니까?', {
			buttons: { confirm: '확인', cancel: '취소' },
		  }).then(function (isConfirm) {
			if (isConfirm) {
				$.ajax({
					url : path+"/orgChart/deleteTopDeptCode",
					type : "POST",
					data : {deptCode : deptCode,
							topDeptCode : topDeptCode},
					success : function(result) {
						console.log("하위부서 : ",result);
						if (result > 0) {
							swal('사용중인 부서입니다. 다시 확인해주세요.', {
								buttons: { cancel: '확인' },
							  });
						} else {
							swal('해당 부서가 삭제되었습니다.', {
								buttons: { cancel: '확인' },
							  });
							$(e.target).closest(".team").remove();
						}
					}
				})
			}
		  });
	});

	/* 하위부서 추가 */ 
	$(".inputs").on("click", ".team-plus", function() {
		
		let num = 0;
			                             
		$(this).parents('.accordion-item').find('.oc-all').append(
			`<li class="team low-common">
				<span class="input-click">
					<input type="text" name="team${num}" id="team-code" class="team-name">
				</span>
				<div class="team-icons hidden">
					<i class="fa-solid fa-minus li-team-minus"></i> 
					<i class="fa-solid fa-pen li-team-change"></i>
				</div>
			</li>`
		);

		// 생성된 input에 포커스
		$(`input[name=team${num}]`).focus();
	})
	
	// input 포커스 아웃 시 db에 하위부서 추가
	$(".inputs").on("blur", "[name^=team]", function(e) {
		// [name^=team]

		let input = $(e.target).val();
		let id = $(e.target).attr("id");
		let code = $(e.target).parents(".accordion-item").find('.topD-name').attr("id");
		// .parents(".accordion-item").find('.topD-name')

		// 부서이름 입력 안했을 시 input 삭제
		if (input == "") {
			$(e.target).closest(".team").remove();
		} else {

			if (id == "team-code") {
				//부서추가 ajax
				$.ajax({
					url : path+"/orgChart/insertTopDeptCode",   
					type : 'post', 
					data : {deptName: input,
							topDeptCode : code},
					success : function(result){
						if (result > 0) {
							let parent = $(e.target).parents('.accordion-item');

							$(e.target).closest(".team").remove();

							$(parent).find('.oc-all').append(
								`<li class="team low-common">
									<span class="input-click">
										<input type="text" value="${input}" data-id="${result},${topDeptCode}" name="team${result}" id="${result}" class="team-name">
									</span>
									<div class="team-icons hidden">
										<i class="fa-solid fa-minus li-team-minus" id="li-team-minus${result}"></i> 
										<i class="fa-solid fa-pen li-team-change" id="li-team-change${result}"></i>
									</div>
								</li>`
							);
							swal('해당 부서가 추가되었습니다.', {
								buttons: { cancel: '확인' },
							  });
						}
						$(".team-name").css('pointer-events','none');
						$(".team").css('cursor','default');
					}
				});
			} else {
				// 부서이름 수정 ajax
				$.ajax({
					url : path+"/orgChart/updateDeptName",   
					type : 'post', 
					data : {deptName: input, 
							deptCode : id},
					success : function(result){
						if (result > 0) {
							$(e.target).attr("id", result);
							swal('해당 부서명이 변경되었습니다.', {
								buttons: { cancel: '확인' },
							  });
						}
						$(".team-name").css('pointer-events','none');
						$(".team").css('cursor','default');
					}
				});
			}
		}
	}).on("keydown", "[name^=team]", function(e) {
		if (e.which === 13) { // 엔터 키의 keyCode는 13입니다.
			e.preventDefault();
			$(this).blur(); // 포커스 아웃 이벤트를 트리거합니다.
		}
	});

	/* 직급조회 */
	function selectPosition() {
		
		$.ajax({
			url:path+"/orgChart/selectPosition",
			type : "POST",
			dataType : "JSON",
			success: function(result){

        		for (let p of result) {
						$('.org-modal-body').append(
							`<ul class="list-group list-group-flush org-list-group">
								<li class="list-group-item position-list">
									<input type="text" name="position-name${p.pCode}" class="pName" id="p${p.pCode}" value="${p.pName}">
									<div class="postion-icons hidden"> 
										<i class="fa-solid fa-minus position-minus" id="position-minus${p.pCode}"></i> 
										<i class="fa-solid fa-pen position-change" id="position-change${p.pCode}"></i>
									</div>
								</li>
							</ul>`
						); 
						$(".pName").css('pointer-events','none');
						$(".position-list").css('cursor','default'); 
				}
			},
			error : function(request){
				console.log("에러발생");
				console.log(request.status);
			}
		})
	}
	selectPosition();

	/* 직급추가 */

	$(document).on("click",".position-list",function(e){
		$(this).find(".hidden").toggle();
	})

	// 직급추가 버튼 클릭 시 직급 이름 입력할 수 있는 input 생성
	$('.position-plus-btn').click (function () {
		
		// 동적으로 아코디언 생성해서 사용하기 위해 클래스 이름 뒤에 숫자 추가
		let num = 0;

		$('.org-modal-body').append(
			`<ul class="list-group list-group-flush org-list-group">
				<li class="list-group-item position-list">
					<input type="text" name="position-name${num}" class="pName" id="pCode">
					<div class="postion-icons hidden"> 
						<i class="fa-solid fa-minus position-minus"></i> 
						<i class="fa-solid fa-pen position-change"></i>
					</div>
				</li>
			</ul>`
		);

		// 생성된 input에 포커스
		$(`input[name=position-name${num}]`).focus();
	});

	// input 포커스 아웃 시 db에 직급추가
	$(".org-position-modal").on("blur", "[name^=position-name]", function(e) {

		let input = $(e.target).val();
		let id = $(e.target).attr("id");

		// 직급이름 입력 안했을 시 input 삭제
		if (input == "") {
			$(e.target).closest(".position-list").remove();
		} else {
			if (id == "pCode") {
				//직급추가 ajax
				$.ajax({
					url : path+"/orgChart/insertPosition",   
					type : 'post', 
					data : {pName: input},
					success : function(result){
						if (result > 0) {
							$(e.target).closest(".position-list").remove();

							$('.org-modal-body').append(
								`<ul class="list-group list-group-flush org-list-group">
									<li class="list-group-item position-list">
										<input type="text" name="position-name${result}" class="pName" id="p${result}" value="${input}">
										<div class="postion-icons hidden"> 
											<i class="fa-solid fa-minus position-minus" id="position-minus${result}"></i> 
											<i class="fa-solid fa-pen position-change" id="position-change${result}"></i>
										</div>
									</li>
								</ul>`
							);
							swal('해당 직급이 추가되었습니다.', {
								buttons: { cancel: '확인' },
							  });
						}
						$(".pName").css('pointer-events','none');
						$(".position-list").css('cursor','default');
					}
				});
			} else { 
				id = id.replace('p','');

				// 부서이름 수정 ajax
				$.ajax({
					url : path+"/orgChart/updatePname",   
					type : 'post', 
					data : {pName: input, 
							pCode : id},
					success : function(result){
						if (result > 0) {
							$(e.target).attr("id", result);
							swal('해당 직급명이 변경되었습니다.', {
								buttons: { cancel: '확인' },
							  });
						}
						$(".pName").css('pointer-events','none');
						$(".position-list").css('cursor','default');
					}
				});
			}
		}
	}).on("keydown", "[name^=position-name]", function(e) {
		if (e.which === 13) { // 엔터 키의 keyCode는 13입니다.
			e.preventDefault();
			$(this).blur(); // 포커스 아웃 이벤트를 트리거합니다.
		}
	});

	// 수정버튼 클릭 시 직급명 수정
	$(document).on("click", ".position-change", function(e) {

		let id =  e.target.id.replace("position-change", 'p');

		$('#'+id).css('pointer-events','auto');
		
		let inputLen = $('#'+id).val().length;
		$('#'+id).focus();
		$('#'+id)[0].setSelectionRange(inputLen, inputLen);
	})

	/////////////////////////////////////////////////////////////////////// 직급 삭제
	$(".org-position-modal").on("click", ".position-minus", function(e) { 
			
		let pCode =  e.target.id.replace("position-minus", '');

		swal('해당 직급을 삭제하시겠습니까?', {
			buttons : {confirm : '확인', cancel : '취소'},
		}).then(function (isConfirm) {
			if (isConfirm) {
				$.ajax({
					url : path+"/orgChart/deletePosition",
					type : "POST",
					data : {pCode : pCode},
					success : function(result) {
						if (result > 0) {
							swal('해당 직급을 사용중인 사원이 있습니다. 다시 확인해주세요.', {
								buttons: { cancel: '확인' },
							  });
						} else {
							swal('해당 직급이 삭제되었습니다.', {
								buttons: { cancel: '확인' },
							  });
							$(e.target).closest(".position-list").remove();
						}
					}
				})
			}
		})
	});
})

	
	