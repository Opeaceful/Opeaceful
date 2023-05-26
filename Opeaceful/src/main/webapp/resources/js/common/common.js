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