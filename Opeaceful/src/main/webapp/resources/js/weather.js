// $.getJSON('https://api.openweathermap.org/data/2.5/weather?q=Seoul&appid=19b55bb6f31f76e1ed9c216a460a592e&units=metric',function(result){
//     $(".ctemp").append(result.main.temp);
//     $(".lowtemp").append(result.main.temp_min);
//     $(".hightemp").append(result.main.temp_max);
//     let iconUrl = '<img src="https://openweathermap.org/img/wn/'+result.weather[0].icon+'.png" alt="'+result.weather[0].description+'">'

//     $(".weather-icon").html(iconUrl);
// });
import {path} from './common/common.js';

/* 현재 위치 확인 함수 */
//  function requestCoords() {
//      navigator.geolocation.getCurrentPosition(handleGeoSucc, handleGeoErr);
//  }
//  function handleGeoSucc(position) {
//     console.log(position);
//     const latitude = position.coords.latitude;  // 경도  
//     const longitude = position.coords.longitude;  // 위도
//     const coordsObj = {
//         latitude,
//         longitude
//     }
//     saveCoords(coordsObj);
//     getWeather(latitude, longitude);
// }

// function handleGeoErr(err) {
//     console.log("geo err! " + err);
// }


function getDayOfWeek(day){
    // const week = ['일', '월', '화', '수', '목', '금', '토'];
    const week = ['Sun', 'Mon', 'Tue', 'Wen', 'Thu', 'Fri', 'Sat'];
    const dayOfWeek = week[new Date(day).getDay()];
    return dayOfWeek;
};
$(document).ready(function() {
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

    // 현재날씨
    $.ajax({
        url:'https://api.openweathermap.org/data/2.5/weather?q=Seoul&appid=19b55bb6f31f76e1ed9c216a460a592e&units=metric',
        dataType:'json',
        type:'GET',
        success:function(data){
            var $city = data.name;
            var $icon = (data.weather[0].icon).substr(0,2);
            var $temp = Math.floor(data.main.temp);
            var $currWind = data.wind.speed + '㎧';
            var $currHumidity = data.main.humidity + '%';
            var $lowtTemp = Math.floor(data.main.temp_min) + 'º / ';
            var $hightTemp = Math.floor(data.main.temp_max) + 'º';
            
            $('.city').append($city);
            $('.currIcon').append('<img src="'+path+'/resources/image/weather/white/'+weatherIcon[$icon]+'.png">');
            $('.currTemp').prepend($temp);
            $('.currWind').append($currWind);
            $('.currHumidity').append($currHumidity);
            $(".currLowTemp").append($lowtTemp);
            $(".currHighTemp").append($hightTemp);
        }
    });

    //주간 날씨
    $.ajax({
        url:'https://api.openweathermap.org/data/2.5/forecast?lat=37.5683&lon=126.9778&appid=19b55bb6f31f76e1ed9c216a460a592e&units=metric',
        dataType:'json',
        type:'GET',
        success:function(data){

            for (let i = 1; i < 6; i++) {
                console.log((i * 8) -1);
                var $day =  getDayOfWeek(data.list[(i * 8) -1].dt_txt);
                var $icon = (data.list[(i * 8)-1].weather[0].icon).substr(0, 2);
                var $weekTemp = Math.floor(data.list[(i * 8)-1].main.temp) + 'º';

                var $weekDiv = $('<div>').addClass('week col');
    
                var $weekDayDiv = $('<div>').addClass('weekDay').text($day);
                var $weekIconDiv = $('<div>').addClass('weekIcon').append('<img src="' + path + '/resources/image/weather/white/' + weatherIcon[$icon] + '.png">');
                var $weekTempDiv = $('<div>').addClass('weekTemp weather_text_s').text($weekTemp)

                $weekDiv.append($weekDayDiv, $weekIconDiv, $weekTempDiv, $weekTempDiv);
    
                $('.week-weather .row').append($weekDiv);
            }
            
        }
    });

});