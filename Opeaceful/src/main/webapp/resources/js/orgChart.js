/**
 *  가영 : 부서, 직급추가, 인사발령 js
 */
import {path} from './common/common.js';

$(document).ready (function () {     
	// 부서추가 버튼 클릭 시 부서 이름 입력할 수 있는 input 생성           
	$('.topD-plus').click (function () {
		
		// 동적으로 아코디언 생성해서 사용하기 위해 클래스 이름 뒤에 숫자 추가
		let num = document.getElementsByClassName('accordion-item').length;

		$('.inputs').append(
			`<div class="accordion-item accordion-item-common org-accordion${num}">
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
					<ul class="accordion-body accordion-body-common oc-all"></ul>
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

		console.log(e.target);

		let input = $(e.target).val();
		let id= $(e.target).attr("id");
		console.log(id);

		// 부서이름 입력 안했을 시 input 삭제
		if (input == "") {
			$(e.target).closest(".accordion-item").remove();
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
							$(e.target).attr("id", result);
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
	$(".inputs").on("click", ".team-plus", function(e) {
		
		let num = document.getElementsByClassName('team').length;
			                             
		$(this).parents('.accordion-item').find('.oc-all').append(
			`<li class="team low-common">
					<input type="text" name="team${num}" id="team-code" class="team-name">
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
		
		let inputLen = $(".topD-name").val().length;
		$(".team-name").focus();
		$(".team-name")[0].setSelectionRange(inputLen, inputLen);
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