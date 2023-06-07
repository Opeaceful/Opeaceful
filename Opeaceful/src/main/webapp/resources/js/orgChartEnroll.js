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
	  
				let html = "";
				let str = "";

        		for (let list of result) {

					// let num = document.getElementsByClassName('accordion-item').length;
					// let deptName = document.getElementById("accordionFlushExample");

					if(list.topDeptCode == 0){
						$("#accordionFlushExample").append(
							`<div class="accordion-item accordion-item-common org-accordion${list.deptCode}">
								<h2 class="accordion-header org-accordion-header" id="heading${list.deptCode}">
									<button class="accordion-button oc-accordion-btn accordion-button-common" id="${list.deptCode}" type="button" data-bs-toggle="collapse" data-bs-target="#collapse${list.deptCode}" aria-expanded="true" aria-controls="flush-collapse${list.deptCode}" aria-label="펼치기">
										<input type="text" id="dept-code" class="topD-name" name="department${list.deptCode}" value="${list.deptName}" aria-label="부서이름인풋">
									</button>
									<div class="icons">
										<i class="fa-solid fa-plus team-plus"></i> 
										<i class="fa-solid fa-minus team-minus"></i> 
										<i class="fa-solid fa-pen team-change"></i>
									</div>
								</h2>
								<div id="collapse${list.deptCode}" class="accordion-collapse org-accordion-collapse collapse" aria-labelledby="heading${list.deptCode}" data-bs-parent="#accordionExample">
									<ul class="accordion-body accordion-body-common oc-all" id="oc-all"></ul>
								</div>
							</div>`
						)  
					}
				}

				for (let list of result) {
					if (0<list.topDeptCode && (list.topDeptCode == list.deptCode)) {
						$("#oc-all").append(
							`<li class="team low-common">
								<span class="input-click">
									<input type="text" name="team${list.deptCode}" id="team-code" class="team-name" value="${list.deptName}">
								</span>
								<i class="fa-solid fa-minus li-team-minus"></i> 
								<i class="fa-solid fa-pen li-team-change"></i>
							</li>`
						)
					}

				}
					// deptName.innerHTML = html;

					// console.log(list.topDeptCode == list.deptCode);
					// console.log(JSON.stringify(list.topDeptCode));
					// console.log(JSON.stringify(list.deptCode));
					// console.log("top "+list.topDeptCode);
					// console.log("dept "+list.deptCode);
					// console.log(list.deptCode.length);
        		

				// let deptCode = document.getElementById("oc-all");
				// console.log(deptCode);
				// deptCode.innerHTML = str;
				// console.log(str);

			},
			error : function(request){
				console.log("에러발생");
				console.log(request.status);
			}
		})
	}

	selectDept();

	//////////////////////////////////////////////////////////// 부서추가

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

		// $('.team-minus').on('click', function () { 
		// 	//$(this).unwrap(); // remove the textbox
        //     //$(this).next ().remove (); // remove the <br>
        //     $(`.org-accordion${num}`).remove (); // remove the button
        // });
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
					url : path+"/orgChart/insert/topDname",   
					type : 'post', 
					data : {deptName: input},
					success : function(result){
						console.log('변경전 result: ' +result);
						if (result > 0) {
							$(e.target).closest("#org-accordion").remove();
							$(e.target).attr("id", result);
							$('.inputs').append(
								`<div class="accordion-item accordion-item-common org-accordion${result}">
									<h2 class="accordion-header org-accordion-header" id="heading${result}">
										<button class="accordion-button oc-accordion-btn accordion-button-common" type="button" data-bs-toggle="collapse" data-bs-target="#collapse${result}" aria-expanded="true" aria-controls="flush-collapse${result}" aria-label="펼치기">
											<input type="text" id="dept-code" class="topD-name" value="${input}" name="department${result}" aria-label="부서이름인풋">
										</button>
										<div class="icons">
											<i class="fa-solid fa-plus team-plus"></i> 
											<i class="fa-solid fa-minus team-minus"></i> 
											<i class="fa-solid fa-pen team-change"></i>
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
					url : path+"/orgChart/update/topDname",   
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

	// 수정버튼 클릭 시 부서 이름 수정
	$(".inputs").on("click", ".team-change", function() {
		$(".topD-name").css('pointer-events','auto');
		
		let inputLen = $(".topD-name").val().length;
		$(".topD-name").focus();
		$(".topD-name")[0].setSelectionRange(inputLen, inputLen);
	})

	// 하위부서 추가 
	$(".inputs").on("click", ".team-plus", function() {
		
		let num = document.getElementsByClassName('team').length;
			                             
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

	// input 포커스 아웃 시 하위부서 db에 부서추가
	$(".inputs").on("blur", "[name^=team]", function(e) {
		// [name^=team]
		console.log(e.target);

		let input = $(e.target).val();
		let id = $(e.target).attr("id");
		let code= $(e.target).parents(".accordion-item").find('.topD-name').attr("id");
		// .parents(".accordion-item").find('.topD-name')
		// console.log(code);

		// 부서이름 입력 안했을 시 input 삭제
		if (input == "") {
			$(e.target).closest(".team").remove();
		} else {
			console.log('input 변경전 : '+input);
			console.log('id 변경전 : '+ $(e.target).attr("id"));

			if ($(e.target).attr("id") == "team-code") {
				//부서추가 ajax
				$.ajax({
					url : path+"/orgChart/insert/Dname",   
					type : 'post', 
					data : {deptName: input,
							topDeptCode : code},
					success : function(result){
						console.log('변경전 result: ' +result);
						if (result > 0) {
							$(e.target).attr("id", result);
						}
						$(".team-name").css('pointer-events','none');
						$(".team").css('cursor','default');
					}
				});
			} else { // topDeptCode 받기? 넘기기? 그거 처리 하기.
				console.log('input 변경후 : '+input);
				console.log('id 변경후 : '+$(e.target).attr("id"));
				// 부서이름 수정 ajax
				$.ajax({
					url : path+"/orgChart/update/Dname",   
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
	$(".inputs").on("click", ".li-team-change", function() {
		$(".team-name").css('pointer-events','auto');
		
		let inputLen = $(".team-name").val().length;
		$(".team-name").focus();
		$(".team-name")[0].setSelectionRange(inputLen, inputLen);
	})

	// 직급추가 버튼 클릭 시 직급 이름 입력할 수 있는 input 생성
	$('.position-plus-btn').click (function () {
		
		// 동적으로 아코디언 생성해서 사용하기 위해 클래스 이름 뒤에 숫자 추가
		let num = document.getElementsByClassName('org-list-group').length;

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
					url : path+"/orgChart/insert/Pname",   
					type : 'post', 
					data : {pName: input},
					success : function(result){
						console.log('변경전 result: ' +result);
						if (result > 0) {
							$(e.target).attr("id", result);
						}
						$(".pName").css('pointer-events','none');
						$(".position-list").css('cursor','default');
					}
				});
			} else { 
				console.log('input 변경후 : '+input);
				console.log('id 변경후 : '+$(e.target).attr("id"));
				// 부서이름 수정 ajax
				$.ajax({
					url : path+"/orgChart/update/Pname",   
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

	// 하위부서 클릭 시 해당 부서에 속한 사원 조회 화면
	$(".inputs").on("click", ".input-click", function() {

		let pCode = $(this).find('.team-name').attr("id");

		console.log('id : ',pCode);

		// $('.org-table').append(
		// 	`<tbody>
		// 		<tr>
		// 			<td>951003</td>
		// 			<td>박가영</td>
		// 			<td>인사팀</td>
		// 			<td>사원</td>
		// 		</tr>
		// 		<tr>
		// 			<td>210208</td>
		// 			<td>윤지영</td>
		// 			<td>인사팀</td>
		// 			<td>사원</td>
		// 		</tr>
		// 	</tbody>`
		// );

		$.ajax({
			url : path+"/orgChart/selectAll",   
			type : 'post', 
			data : {pCode : pCode},
			success : function(result){
				console.log('변경후 result: ' +result);
			}
		})
		
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