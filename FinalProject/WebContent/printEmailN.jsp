<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<!-- 네이버아디디로로그인 초기화 Script는 2.1.1.을 참고 -->
<!-- 네이버아디디로로그인 Callback 페이지 처리 Script -->
<script type="text/javascript">


var naver_id_login = new naver_id_login("4hbqrclSjqpbsBAmXZy9", "http://localhost:8080/LoginTo_123_test0001/printEmail.jsp");

// 네이버 사용자 프로필 조회
naver_id_login.get_naver_userprofile("naverSignInCallback()");

// 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
	function naverSignInCallback() {
		
	var naverEmail = naver_id_login.getProfileData('email');
//		alert(naver_id_login.getProfileData('email'));

		$('#EmailN').append('<br/>Email: ');
		$('#EmailN').append(naverEmail);

		}
	

	</script>


이메일 출력 [네이버 아이디 로그인 성공시]

<div id="EmailN"></div>

</body>
</html>