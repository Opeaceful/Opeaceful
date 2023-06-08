/**
 *  가영 : 부서, 직급, 인사발령 js
 */
import {path} from './common/common.js';

$(document).ready (function () {     

	//////////////////////////////////////////////////////////// 부서조회
	function selectDept() {

		$.ajax({
			url:path+"/orgChart/selectDept",
			type : "POST",
			dataType : "JSON",
			success: function(result){

				console.log(result);

        		for (let dept of result) {
					if(dept.topDeptCode == 0){
						
						$("#accordionFlushExample").append(
							`<div class="accordion-item accordion-item-common org-accordion${dept.deptCode}" id="org-accordion">
								<h2 class="accordion-header org-accordion-header" id="heading${dept.deptCode}">
									<button class="accordion-button oc-accordion-btn accordion-button-common" type="button" data-bs-toggle="collapse" data-bs-target="#collapse${dept.deptCode}" aria-expanded="true" aria-controls="flush-collapse${dept.deptCode}" aria-label="펼치기">
										<input type="text" id="${dept.deptCode}" class="topD-name" name="department" value="${dept.deptName}" aria-label="부서이름인풋">
									</button>
									<div class="icons">
										<i class="fa-solid fa-plus team-plus" id="team-plus${dept.deptCode}"></i> 
										<i class="fa-solid fa-minus team-minus" id="team-minus${dept.deptCode}"></i> 
										<i class="fa-solid fa-pen team-change" id="team-change${dept.deptCode}"></i>
									</div>
								</h2>
								<div id="collapse${dept.deptCode}" class="accordion-collapse org-accordion-collapse collapse" aria-labelledby="heading${dept.deptCode}" data-bs-parent="#accordionExample">
									<ul class="accordion-body accordion-body-common oc-all" id="oc-all${dept.deptCode}"></ul>
								</div>
							</div>`
						) 
					}
					$(".topD-name").css('pointer-events','none');
					$(".oc-accordion-btn").css('cursor','default'); 
					
					for (let team of result) {
						if (team.topDeptCode == dept.deptCode) {
							$(`#oc-all${dept.deptCode}`).append(
								`<li class="team low-common">
									<span class="input-click" id="${team.topDeptCode}">
										<input type="text" name="team" id="${team.deptCode}" class="team-name" value="${team.deptName}">
									</span>
									<i class="fa-solid fa-minus li-team-minus" id="li-team-minus${team.deptCode}"></i> 
									<i class="fa-solid fa-pen li-team-change" id="li-team-change${team.deptCode}"></i>
								</li>`
							)
							$(".team-name").css('pointer-events','none');
							$(".team").css('cursor','default');
						}
						
						
					}

				}
				
			},
			error : function(request){
				console.log("에러발생");
				console.log(request.status);
			}
		})
	}
	selectDept();


	// 하위부서 클릭 시 해당 부서에 있는 사원 조회
	$(".inputs").on("click", `.input-click`, function(e) {
							
		let deptName = $(e.target).parents(".accordion-item").find('.topD-name').val();
		let deptCode = $(e.target).parents(".accordion-item").find('.topD-name').attr("id");

		let teamDeptCode = $(e.target).find('.team-name').attr("id");
		let topDeptCode = $(e.target).attr("id");

		console.log('id : ',teamDeptCode);

		$.ajax({
			url : path+"/orgChart/selectAll",   
			type : 'post', 
			data : {deptCode : teamDeptCode ? teamDeptCode : 0},
			dataType : "JSON",
			success : function(result){
				console.log('result: ' +JSON.stringify(result));

				let html = "";
				let str = ""

				if (topDeptCode == deptCode) {
					str += `<div class="department-name-box">${deptName}</div>
								<button class="btn btn-primary dp-btn" data-bs-toggle="modal" data-bs-target="#change" type="button">인사발령</button>`
					$('.name-btn-box').html(str);
				}

				for (let all of result) {
					if (teamDeptCode == all.deptCode) {
						
						html += `<tbody>
									<tr>
										<td>${all.eno}</td>
										<td>${all.userName}</td>
										<td>${all.deptName}</td>
										<td>${all.pName}</td>
									</tr>
								</tbody>`
					}
				}
				$('.org-thead').html(html);
			}
		})
	})

	///////////////////////////////////////////////////////////////////////////// 상위부서 추가

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
					<div class="icons">
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

	// input 포커스 아웃 시 상위부서 db에 부서추가
	$(".inputs").on("blur", ".topD-name", function(e) {

		// console.log(e.target);

		let input = $(e.target).val();
		let id= $(e.target).attr("id");
		// console.log(id);
		
		// 부서이름 입력 안했을 시 input 삭제
		if (input == "") {
			$(e.target).closest("#org-accordion").remove();
		} else {
			if (id == "dept-code") {
				console.log('input 변경전 : '+input);
				console.log('id 변경전 : '+$(e.target).attr("id"));
				//부서추가 ajax
				$.ajax({
					url : path+"/orgChart/insertDeptCode",   
					type : 'post', 
					data : {deptName: input},
					success : function(result){
						console.log('변경전 result: ' +result);
						if (result > 0) {
							$(e.target).closest("#org-accordion").remove();
							$('.inputs').append(
								`<div class="accordion-item accordion-item-common org-accordion${result}">
									<h2 class="accordion-header org-accordion-header" id="heading${result}">
										<button class="accordion-button oc-accordion-btn accordion-button-common" type="button" data-bs-toggle="collapse" data-bs-target="#collapse${result}" aria-expanded="true" aria-controls="flush-collapse${result}" aria-label="펼치기">
											<input type="text" id="${result}" class="topD-name" value="${input}" name="department${result}" aria-label="부서이름인풋">
										</button>
										<div class="icons">
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
						}
						$(".topD-name").css('pointer-events','none');
						$(".oc-accordion-btn").css('cursor','default');
					}
				});
			} else {
				console.log('input 변경후 : '+input);
				console.log('id 변경후 : '+$(e.target).attr("id"));
				// 부서이름 수정 ajax
				$.ajax({
					url : path+"/orgChart/updateDeptName",   
					type : 'post', 
					data : {deptName: input, deptCode : id},
					success : function(result){
						console.log('변경후 result: ' +result);
						if (result > 0) {
							$(e.target).attr("id", result);
						}
						$(".topD-name").css('pointer-events','none');
						$(".oc-accordion-btn").css('cursor','default');
					}
				});
			}
		}
	})

	//////////////////////////////////////////////////////////////////// 수정버튼 클릭 시 부서명 수정
	$(".inputs").on("click", ".team-change", function(e) {

		let id =  e.target.id.replace("team-change", '');
		console.log(e.target.id, id, $('#'+id));

		$('#'+id).css('pointer-events','auto');
		
		let inputLen = $('#'+id).val().length;
		$('#'+id).focus();
		$('#'+id)[0].setSelectionRange(inputLen, inputLen);
	})

	/////////////////////////////////////////////////////////////////////// 상위부서 삭제
	$(".inputs").on("click", ".team-minus", function(e) { 
			
		let deptCode = $(e.target).parents(".accordion-item").find('.topD-name').attr("id");
		let topDeptCode = $(e.target).parents(".accordion-item").find('.input-click').attr("id");

		console.log(deptCode);
		console.log(topDeptCode);

		$.ajax({
			url : path+"/orgChart/deleteDeptCode",
			type : "POST",
			data : {deptCode : deptCode,
					topDeptCode : topDeptCode ? topDeptCode : 0},
			success : function(result) {
				console.log(result)
				if (result > 0) {
					alert('사용중인 부서입니다. 다시 확인해주세요.');
				} else {
					$(e.target).parents(".accordion-item").remove();
				}
			}
		})
            // $(`.org-accordion${num}`).remove (); // remove the button
        });

		$(".inputs").on("click", ".li-team-minus", function(e) { 
			
			let deptCode = $(e.target).parents(".accordion-item").find('.topD-name').attr("id");
			let topDeptCode = $(e.target).parents(".accordion-item").find('.input-click').attr("id");
	
			console.log(deptCode);
			console.log(topDeptCode);
	
			$.ajax({
				url : path+"/orgChart/deleteDeptCode",
				type : "POST",
				data : {deptCode : deptCode,
						topDeptCode : topDeptCode ? topDeptCode : 0},
				success : function(result) {
					console.log(result)
					if (result > 0) {
						alert('사용중인 부서입니다. 다시 확인해주세요.');
					} else {
						$(e.target).closest(".team").remove();
					}
				}
			})
				// $(`.org-accordion${num}`).remove (); // remove the button
			});

	/////////////////////////////////////////////////////////////////////// 하위부서 추가 
	$(".inputs").on("click", ".team-plus", function() {
		
		let num = 0;
			                             
		$(this).parents('.accordion-item').find('.oc-all').append(
			`<li class="team low-common">
				<span class="input-click">
					<input type="text" name="team${num}" id="team-code" class="team-name">
				</span>
				<i class="fa-solid fa-minus li-team-minus"></i> 
				<i class="fa-solid fa-pen li-team-change"></i>
			</li>`
		);

		// 생성된 input에 포커스
		$(`input[name=team${num}]`).focus();
	})

	// input 포커스 아웃 시 db에 하위부서 추가
	$(".inputs").on("blur", "[name^=team]", function(e) {
		// [name^=team]
		console.log(e.target);

		let input = $(e.target).val();
		let id = $(e.target).attr("id");
		let code= $(e.target).parents(".accordion-item").find('.topD-name').attr("id");
		// .parents(".accordion-item").find('.topD-name')
		console.log(code);

		// 부서이름 입력 안했을 시 input 삭제
		if (input == "") {
			$(e.target).closest(".team").remove();
		} else {
			console.log('input 변경전 : '+input);
			console.log('id 변경전 : '+ $(e.target).attr("id"));

			if ($(e.target).attr("id") == "team-code") {
				//부서추가 ajax
				$.ajax({
					url : path+"/orgChart/insertTopDeptCode",   
					type : 'post', 
					data : {deptName: input,
							topDeptCode : code},
					success : function(result){
						console.log('추가된 result: ' +result);
						if (result > 0) {
							let parent = $(e.target).parents('.accordion-item');

							$(e.target).closest(".team").remove();

							$(parent).find('.oc-all').append(
								`<li class="team low-common">
									<span class="input-click${result}">
										<input type="text" value="${input}" name="team${result}" id="${result}" class="team-name">
									</span>
									<i class="fa-solid fa-minus li-team-minus" id="li-team-minus${result}"></i> 
									<i class="fa-solid fa-pen li-team-change" id="li-team-change${result}"></i>
								</li>`
							);
						}
						$(".team-name").css('pointer-events','none');
						$(".team").css('cursor','default');
					}
				});
			} else {
				console.log('input 변경후 : '+input);
				console.log('id 변경후 : '+$(e.target).attr("id"));
				// 부서이름 수정 ajax
				$.ajax({
					url : path+"/orgChart/updateDeptName",   
					type : 'post', 
					data : {deptName: input, 
							deptCode : id},
					success : function(result){
						console.log('변경후 result: ' +result);
						if (result > 0) {
							$(e.target).attr("id", result);
						}
						$(".team-name").css('pointer-events','none');
						$(".team").css('cursor','default');
					}
				});
			}
		}
	})

	// 수정버튼 클릭 시 하위부서 이름 수정
	$(".inputs").on("click", ".li-team-change", function(e) {

		let id =  e.target.id.replace("li-team-change", '');

		console.log(e.target.id, id, $('#'+id));

		$('#'+id).css('pointer-events','auto');
		
		let inputLen = $('#'+id).val().length;
		$('#'+id).focus();
		$('#'+id)[0].setSelectionRange(inputLen, inputLen);
	})

	/////////////////////////////////////////////////////////////////////////////// 직급조회
	function selectPosition() {
		
		$.ajax({
			url:path+"/orgChart/selectPosition",
			type : "POST",
			dataType : "JSON",
			success: function(result){

				console.log(result);

        		for (let p of result) {
						$('.org-modal-body').append(
							`<ul class="list-group list-group-flush org-list-group">
								<li class="list-group-item position-list">
									<input type="text" name="position-name${p.pCode}" class="pName" id="p${p.pCode}" value="${p.pName}">
									<div class="postion-icons"> 
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

	/////////////////////////////////////////////////////////////////////////////// 직급추가
	// 직급추가 버튼 클릭 시 직급 이름 입력할 수 있는 input 생성
	$('.position-plus-btn').click (function () {
		
		// 동적으로 아코디언 생성해서 사용하기 위해 클래스 이름 뒤에 숫자 추가
		let num = 0;

		$('.org-modal-body').append(
			`<ul class="list-group list-group-flush org-list-group">
				<li class="list-group-item position-list">
					<input type="text" name="position-name${num}" class="pName" id="pCode">
					<div class="postion-icons"> 
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

		console.log(e.target);

		let input = $(e.target).val();
		let id = $(e.target).attr("id");

		// 직급이름 입력 안했을 시 input 삭제
		if (input == "") {
			$(e.target).closest(".position-list").remove();
		} else {
			console.log('input 직급추가 : '+input);
			console.log('id 변경전 : '+ $(e.target).attr("id"));

			if (id == "pCode") {
				//직급추가 ajax
				$.ajax({
					url : path+"/orgChart/insertPosition",   
					type : 'post', 
					data : {pName: input},
					success : function(result){
						console.log('변경전 result: ' +result);
						if (result > 0) {
							$(e.target).closest(".position-list").remove();

							$('.org-modal-body').append(
								`<ul class="list-group list-group-flush org-list-group">
									<li class="list-group-item position-list">
										<input type="text" name="position-name${result}" class="pName" id="p${result}" value="${input}">
										<div class="postion-icons"> 
											<i class="fa-solid fa-minus position-minus" id="position-minus${result}"></i> 
											<i class="fa-solid fa-pen position-change" id="position-change${result}"></i>
										</div>
									</li>
								</ul>`
							);
						}
						$(".pName").css('pointer-events','none');
						$(".position-list").css('cursor','default');
					}
				});
			} else { 
				id = id.replace('p','');

				console.log('input 변경후 : '+input);
				console.log('id 변경후 : '+$(e.target).attr("id"));
				// 부서이름 수정 ajax
				$.ajax({
					url : path+"/orgChart/updatePname",   
					type : 'post', 
					data : {pName: input, 
							pCode : id},
					success : function(result){
						console.log('변경후 result: ' +result);
						if (result > 0) {
							$(e.target).attr("id", result);
						}
						$(".pName").css('pointer-events','none');
						$(".position-list").css('cursor','default');
					}
				});
			}
		}
	})

	// 수정버튼 클릭 시 직급명 수정
	$(".org-position-modal").on("click", ".position-change", function(e) {

		let id =  e.target.id.replace("position-change", 'p');
		console.log($('#'+id).val());

		console.log(e.target.id, id, $('#'+id));

		$('#'+id).css('pointer-events','auto');
		
		let inputLen = $('#'+id).val().length;
		$('#'+id).focus();
		$('#'+id)[0].setSelectionRange(inputLen, inputLen);
	})

	

	// document.getElementsByClassName("team-change").onclick = function() {

	// 	document.getElementsByClassName("topD-name").style.pointerEvents = "auto";
	// 	// $(".topD-name").css('pointer-events','auto');

	// 	let input = document.getElementsByClassName("topD-name");
	// 	input.focus();
	 
	// 	let val = input.value;
	// 	input.value = '';
	// 	input.value = val;
	// }

	// const tempEvent = { 
	// 	click: function() {
	// 		$(".topD-name").css('pointer-events','auto');
	// 	},
	// 	focus: function() {
	// 		$(".topD-name").focus;
	// 	}
	// }
	// for(let key in tempEvent){
	// 	$('.inputs').on(key , '.team-change',tempEvent[key]);

	// }
		
		// } else if (input == "") {
		// 	$(`.org-accordion${num}`).remove();
		// }
	
});