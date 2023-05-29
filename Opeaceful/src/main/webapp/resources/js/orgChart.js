/**
 * 
 */
import {path} from './common/common.js';

$(document).ready (function () {                
	$('.topD-plus').click (function () {                                        
		$('.inputs').append (                        
			`<div class="accordion-item accordion-item-common">
				<h2 class="accordion-header" id="flush-headingOne">
					<button class="accordion-button oc-accordion-btn accordion-button-common collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseOne" aria-expanded="false" aria-controls="flush-collapseOne" aria-label="펼치기">
						<input type="text" id="dept-code" class="topD-name" name="department" aria-label="부서이름인풋">
						<i class="fa-solid fa-plus team-plus"></i> 
						<i class="fa-solid fa-minus team-minus"></i> 
						<i class="fa-solid fa-pen team-change"></i>
					</button>
				</h2>
			</div>`                    
		); // end append                            
		$('.team-minus').on('click', function () { 
			$(this).prev().remove (); // remove the textbox
            $(this).next ().remove (); // remove the <br>
            $(this).remove (); // remove the button
        });
	}); // end click                                            
}); // end ready 