/**
 * 
 */
 
 let topDp = document.querySelector(".topD-plus");
 
 topDp.addEventListener("click", () => {
 	$.ajax({
 		url : "/plusDname",
 		success : function(result) {
 		consol.log(result);
 		}
 	})
 })