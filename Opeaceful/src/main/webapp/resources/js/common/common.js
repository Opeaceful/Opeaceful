/**
 * 
 */

export const path = getContextPath();
 
 //현재 페이지의 contextPath 가져오는 함수
function getContextPath() {
  let hostIndex = location.href.indexOf(location.host) + location.host.length;
  let contextPath = location.href.substring(
    hostIndex,
    location.href.indexOf("/", hostIndex + 1)
  );
  //console.log("getContextPath 불림");
  return contextPath;
}

function darkMode(){
//다크모드 설정 
const isUserColorTheme = localStorage.getItem('color-theme');
const isOsColorTheme = window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light';

//혹시 컴퓨터 내에서 다크모드가 설정되어있다면 자동 다크모드 설정
const getUserTheme = () => (isUserColorTheme ? isUserColorTheme : isOsColorTheme);

 if (getUserTheme() === 'dark') {
    localStorage.setItem('color-theme', 'dark');
    document.documentElement.setAttribute('color-theme', 'dark');
   } else {
    localStorage.setItem('color-theme', 'light');
     document.documentElement.setAttribute('color-theme', 'light');
   }
};


darkMode();