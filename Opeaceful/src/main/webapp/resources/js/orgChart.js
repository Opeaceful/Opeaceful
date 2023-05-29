/**
 * 
 */
import {path} from './common/common.js';

$(document).ready (function () {                
	$('.topD-plus').click (function () {
		
		let num = document.getElementsByClassName('accordion-item').length;
			                             
		$('.inputs').append(
			`<div class="accordion-item accordion-item-common org-accordion${num}">
				<h2 class="accordion-header" id="flush-heading${num}">
					<button class="accordion-button oc-accordion-btn accordion-button-common collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapse${num}" aria-expanded="false" aria-controls="flush-collapse${num}" aria-label="펼치기">
						<input type="text" id="dept-code" class="topD-name" name="department" aria-label="부서이름인풋">
						<i class="fa-solid fa-plus team-plus"></i> 
						<i class="fa-solid fa-minus team-minus"></i> 
						<i class="fa-solid fa-pen team-change"></i>
					</button>
				</h2>
			</div>`
		); // end append

		$("input[name=department]").focus();

		$("input[name=department]").blur(function(){
			let input = $("input[name=department]").val();
			console.log(input);
			$.ajax({
				url : path+"/orgChart/insert/topDname",   
				type : 'post', // 데이터 전달 방식 type
				data : {deptName: input},
				success : function(result){
					console.log('result: ' +result);
				}
			});
		})

		
		$('.team-minus').on('click', function () { 
			//$(this).unwrap(); // remove the textbox
            //$(this).next ().remove (); // remove the <br>
            $(`.org-accordion${num}`).remove (); // remove the button
        });
	}); // end click 
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