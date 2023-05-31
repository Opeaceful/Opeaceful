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
				<h2 class="accordion-header" id="flush-heading${num}">
					<button class="accordion-button oc-accordion-btn accordion-button-common collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapse${num}" aria-expanded="false" aria-controls="flush-collapse${num}" aria-label="펼치기">
						<input type="text" id="dept-code" class="topD-name" name="department${num}" aria-label="부서이름인풋">
						<i class="fa-solid fa-plus team-plus"></i> 
						<i class="fa-solid fa-minus team-minus"></i> 
						<i class="fa-solid fa-pen team-change"></i>
					</button>
				</h2>
			</div>`
		); // end append

		// 생성된 input에 포커스
		$(`input[name=department${num}]`).focus();

		// $('.team-minus').on('click', function () { 
		// 	//$(this).unwrap(); // remove the textbox
        //     //$(this).next ().remove (); // remove the <br>
        //     $(`.org-accordion${num}`).remove (); // remove the button
        // });
	}); // end click 

	// input 포커스 아웃 시 db에 부서추가
	$(".inputs").on("blur", ".topD-name", function(e) {

		console.log(e.target);

		let input = $(e.target).val();
		let id= $(e.target).attr("id");

		console.log('input 변경전 : '+input);
		console.log('id 변경전 : '+$(e.target).attr("id"));

		if (id == "dept-code") {
			$.ajax({
				url : path+"/orgChart/insert/topDname",   
				type : 'post', 
				data : {deptName: input},
				success : function(result){
					console.log('result: ' +result);
					if (result > 0) {
						$(e.target).attr("id", result);
					}
					$(".topD-name").css('pointer-events','none');
					$(".oc-accordion-btn").css('cursor','default');
				}
			});
		} 
		// else {
		// 	$.ajax({
		// 		url : path+"/orgChart/update/topDname",   
		// 		type : 'post', 
		// 		data : {deptName: input, deptCode : id},
		// 		success : function(result){
		// 			console.log('result: ' +result);

		// 		}
		// 	});
		// }

		// if (input != "") {
			
	})

	// $('.inputs').on('click', '.team-change', function (e) { 
		
	// 	$(".topD-name").css('pointer-events','auto');

	// 	let input = $(e.target).val();
	// 	let id= $(e.target).attr("id");

	// 	console.log('input 변경후 : '+input);
	// 	console.log('id 변경후 : '+$(e.target).attr("id"));
		
	// 	id.focus();
	// 	if (id === "dept-code") {
	// 		$.ajax({
	// 			url : path+"/orgChart/update/topDname",   
	// 			type : 'post', 
	// 			data : {deptName: input, deptCode : id},
	// 			success : function(result){
	// 				console.log('result: ' +result);
	// 			}
	// 		});
	// 	} 		
    // });
	const tempEvent = { 
		click: function(e) {
			$(".topD-name").css('pointer-events','auto');

			let input = $(e.target).val();
			let id= $(e.target).attr("id");

			console.log('input 변경후 : '+input);
			console.log('id 변경후 : '+$(e.target).attr("id"));
			
			if (id != "dept-code") {
				$.ajax({
					url : path+"/orgChart/update/topDname",   
					type : 'post', 
					data : {deptName: input, deptCode : id},
					success : function(result){
						console.log('result: ' +result);
					}
				});
			}
		},
		focus: function(e) {
			$(".topD-name").css('pointer-events','auto');

			let input = $(e.target).val();
			let id= $(e.target).attr("id");

			console.log('input 변경후 : '+input);
			console.log('id 변경후 : '+$(e.target).attr("id"));
			
			if (id != "dept-code") {
				$.ajax({
					url : path+"/orgChart/update/topDname",   
					type : 'post', 
					data : {deptName: input, deptCode : id},
					success : function(result){
						console.log('result: ' +result);
					}
				});
			}
		}
	}
	for(let key in tempEvent){
		$('.inputs').on(key , '.team-change',tempEvent[key]);

	}
		
		// } else if (input == "") {
		// 	$(`.org-accordion${num}`).remove();
		// }
	
}); // end ready 



// input 커서 맨 뒤로 위치 시키기
// const changeEditMode = (e) => {
//     const $item = e.target.closest('.item')
//     const $editInput = $item.querySelector('input[type="text"]')
//     const value = $editInput.value
    
//     $editInput.focus()
//     $editInput.value = ''
//     $editInput.value = value
// }