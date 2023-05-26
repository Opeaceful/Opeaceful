/**
 * 
 */
import {path} from './common/common.js';

 let topDp = document.querySelector(".topD-plus");
 
 topDp.addEventListener("click", () => {
 	
    
    $(".accordion-button").append("<input type='text' id='dept-code' class='topD-name' name='department' aria-label='부서이름인풋'>");
    
    

 })
 
 const arrInput = new Array(0);
 const arrInputValue = new Array(0);
 
function addInput() {
  arrInput.push(arrInput.length);
  arrInputValue.push("");
  display();
}
 
function display() {
  document.getElementById('parah').innerHTML="";
  for (intI=0;intI<arrInput.length;intI++) {
    document.getElementById('parah').innerHTML+=createInput(arrInput[intI], arrInputValue[intI]);
  }
}
 
function saveValue(intId,strValue) {
  arrInputValue[intId]=strValue;
}  
 
function createInput(id,value) {
  return "<input type='text' id='test "+ id +"' onChange='javascript:saveValue("+ id +",this.value)' value='"+ 
 
value +"'><br>";
}
 
function deleteInput() {
  if (arrInput.length > 0) { 
     arrInput.pop(); 
     arrInputValue.pop();
  }
  display(); 
}