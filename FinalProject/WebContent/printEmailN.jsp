<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
</head>
<body>
<form action="loginsuccess.do" method="get">
<div id="EmailN" ></div>
</form>

<script type="text/javascript">
 

var naver_id_login = new naver_id_login("4hbqrclSjqpbsBAmXZy9", "http://localhost:8080/FianlProject/printEmail.jsp");

// 네이버 사용자 프로필 조회
naver_id_login.get_naver_userprofile("naverSignInCallback()");

// 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
	function naverSignInCallback() {
		
	var naverEmail = naver_id_login.getProfileData('email');
//		alert(naver_id_login.getProfileData('email'));

		$('#EmailN').append('<br/>Email: ');
		//이메일 값 출력
		$('#EmailN').append(naverEmail);
		
		//test 0002 : 프로필페이지(id=메일)로 이동시도 
	//	 location.replace("http://localhost:8080/FianlProject/profile.do?id="+naverEmail);

		}
	
	

	</script>
	

</body>
</html>