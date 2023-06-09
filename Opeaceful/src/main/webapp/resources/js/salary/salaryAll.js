/**
 * 작성자 윤지영
 * 사원별 급여관리 js
 */

import {path} from '../common/common.js';

/*검색에 따라 데이터를 불러오는*/
$("#salary-year,#salary-month,#d-select").change(function(){
    let year = $("#salary-year").val(); 
    let month = $("#salary-month").val();
    let team = document.getElementById('d-select').options[document.getElementById('d-select').selectedIndex].text;

    location.href=`${path}/salary/AllSalary?year=${year}&month=${month}&team=${team}`;

});

$(document).ready(function(){
    const urlParams = new URLSearchParams(window.location.search);
    const urlTeam = urlParams.get('team');

    if(urlTeam){
        console.log(urlMonth);
        $("#salary-month").val(urlMonth)
    }

})
