

import {path} from './common/common.js';
var lat = 37.4923615; // 위도
var lon = 127.0292881; // 경도

//다크모드변수
let colorMode = window.localStorage.getItem('color-theme');

/* 요일 지정 함수 */
function getDayOfWeek(day){
    // const week = ['일', '월', '화', '수', '목', '금', '토'];
    const week = ['Sun', 'Mon', 'Tue', 'Wen', 'Thu', 'Fri', 'Sat'];
    const dayOfWeek = week[new Date(day).getDay()];
    return dayOfWeek;
};

$(document).ready(function() {
  
  // 아이콘 세팅
  let weatherIcon = {
    '01' : 'sun', // sun
    '02' : 'cloud-sun', // cloud-sun
    '03' : 'cloud', // cloud
    '04' : 'broken-cloud', // broken-cloud - 먹구름(만들어야될듯)
    '09' : 'shower-rain', // shower-rain - 소나기
    '10' : 'rain', // rain
    '11' : 'thunderstorm', // thunderstorm
    '13' : 'snow', // snow
    '50' : 'smog', // smog
  };

    /* 현재 위치 확인 함수 */
  if (navigator.geolocation) { // GPS를 지원하면

    navigator.geolocation.getCurrentPosition(function(position) {
      lat = position.coords.latitude;
      lon = position.coords.longitude;
      
      // 현재날씨
      $.ajax({
        url:`https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&appid=19b55bb6f31f76e1ed9c216a460a592e&units=metric`,
        dataType:'json',
        type:'GET',
        success:function(data){
          var $city = data.name;
          // var $a = data.local_names.ko;
          var $icon = (data.weather[0].icon).substr(0,2);
          var $temp = Math.floor(data.main.temp);
          var $currWind = data.wind.speed + '㎧';
          var $currHumidity = data.main.humidity + '%';
          var $lowtTemp = Math.floor(data.main.temp_min) + 'º / ';
          var $hightTemp = Math.floor(data.main.temp_max) + 'º';
          // console.log($a);
          $('.city').append($city);
          if(colorMode == 'dark'){
            $('.currIcon').append('<img src="'+path+'/resources/image/weather/dark/'+weatherIcon[$icon]+'.png">');
          }else{
            $('.currIcon').append('<img src="'+path+'/resources/image/weather/white/'+weatherIcon[$icon]+'.png">');
          }
          $('.currTemp').prepend($temp);
          $('.currWind').append($currWind);
          $('.currHumidity').append($currHumidity);
          $(".currLowTemp").append($lowtTemp);
          $(".currHighTemp").append($hightTemp);
        }
      });

      //주간 날씨
      $.ajax({
        url:`https://api.openweathermap.org/data/2.5/forecast?lat=${lat}&lon=${lon}&appid=19b55bb6f31f76e1ed9c216a460a592e&units=metric`,
        dataType:'json',
        type:'GET',
        success:function(data){
  
          for (let i = 1; i < 6; i++) {
            var $day =  getDayOfWeek(data.list[(i * 8) -1].dt_txt);
            var $icon = (data.list[(i * 8)-1].weather[0].icon).substr(0, 2);
            var $weekTemp = Math.floor(data.list[(i * 8)-1].main.temp) + 'º';

            var $weekDiv = $('<div>').addClass('week col');
            var $weekDayDiv = $('<div>').addClass('weekDay').text($day);

            if(colorMode == 'dark'){
              var $weekIconDiv = $('<div>').addClass('weekIcon').append('<img src="' + path + '/resources/image/weather/dark/' + weatherIcon[$icon] + '.png">');
            }else{
              var $weekIconDiv = $('<div>').addClass('weekIcon').append('<img src="' + path + '/resources/image/weather/white/' + weatherIcon[$icon] + '.png">');
            }
            
            var $weekTempDiv = $('<div>').addClass('weekTemp weather_text_s').text($weekTemp)

            $weekDiv.append($weekDayDiv, $weekIconDiv, $weekTempDiv, $weekTempDiv);

            $('.week-weather .row').append($weekDiv);
          }
        }
      });
    }, function(error) {
      console.error(error);
    }, {
      enableHighAccuracy: false,
      maximumAge: 0,
      timeout: Infinity
    });
  } else {
    alert('GPS를 지원하지 않습니다');
  }

    // 위치 - 일단 도시로 표현됨
    // $.ajax({
    //     url:`http://api.openweathermap.org/geo/1.0/reverse?lat=${lat}&lon=${lon}&limit=5&appid=19b55bb6f31f76e1ed9c216a460a592e`,
    //     dataType:'json',
    //     type:'GET',
    //     success:function(data){
    //         var $city = data[0].local_names.ko;

    //         $('.city').append($city);

    //     }
    // });
});