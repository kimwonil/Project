<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<title>로그인</title>

<meta name="google-signin-scope" content="profile email">
<meta name="google-signin-client_id"
	content="213529835589-o9bu7h0nedcukofo2mldo1o2mpetsorh.apps.googleusercontent.com">
<script src="https://apis.google.com/js/platform.js" async defer></script>
<script type="text/javascript"
	src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js"
	charset="utf-8"></script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

<style type="text/css">
#wrapper{
	position: absolute;
	left:40%;
	top:30%;
}
.logo{
	text-decoration: none;
	position: absolute;
	left:44%;
	top:10%;
}
</style>
</head>
<body>
<a class="logo" href="load.do"><h1>ShareAbility</h1></a>
	<div id="wrapper">
		<div id="naver_id_login"></div>
		<p>
			<a id="custom-login-btn" href="javascript:loginWithKakao()"> <img
				src="//mud-kage.kakao.com/14/dn/btqbjxsO6vP/KPiGpdnsubSq3a0PHEGUK1/o.jpg"
				width="300" height="60" />
			</a>
		<p>
		<div id="googleBtn" class="g-signin2" data-onsuccess="onSignIn" data-width="300"
			data-height="65" data-longtitle="true" data-theme="dark"></div>
	</div>
	
	<form action="insertForm.do" method="post" id="insertForm">
		<input id="id" type="hidden" name="email" value=""> 
		<input id="login" type="hidden" name="login" value="">
		<input id="googleAuto" type="hidden" value="0"> 	
	</form>
	<form action="load.do" method="post" id="main"></form>

</body>
<script type="text/javascript">
	var naver_id_login = new naver_id_login("q9jIL5jkbHpYtx4IhwrT", "http://localhost:8080/FinalProject/login.jsp");
	var state = naver_id_login.getUniqState();
	naver_id_login.setButton("green", 3, 65);
	naver_id_login.setState(state);
	naver_id_login.init_naver_id_login();

	naver_id_login.get_naver_userprofile("naverSignInCallback()");
	function naverSignInCallback() {
		var email = naver_id_login.getProfileData('email');
		$.ajax({
			url : "login.do",
			type : "POST",
			data : {
				email : email,
				login : 1
			},
			dataType : "json",
			success : function(data) {
				if (data.result) {
					$('#main').submit();
				} else {
					$('#id').val(data.id);
					$('#login').val(data.login);
					$('#insertForm').submit();
				}

			},
			error : function() {
				alert("실패");
			}
		});
	}
</script>
<script type='text/javascript'>
	Kakao.init('4c6164f326f50c784de915d84d2b5249');

	function loginWithKakao() {
		Kakao.Auth.login({
			success : function(authObj) {
				Kakao.API.request({
					url : '/v1/user/me',
					success : function(res) {
						console.log(res.kaccount_email);
						var email = res.kaccount_email;

						$.ajax({
							url : "login.do",
							type : "POST",
							data : {
								email : res.kaccount_email,
								login : 2
							},
							dataType : "json",
							success : function(data) {
								if (data.result) {
									$('#main').submit();
								} else {
									$('#id').val(data.id);
									$('#login').val(data.login);
									$('#insertForm').submit();
								}
							},
							error : function() {
								alert("실패");
							}
						});
					},
					fail : function(error) {
						console.log(JSON.stringify(error));
					}
				});
			},
			fail : function(err) {
				alert(JSON.stringify(err));
			}
		});
	}
	;
</script>
<script>
	function googleLogin(){
		
		$.ajax({
			url : "login.do",
			type : "POST",
			data : {
				email : $('#id').val(),
				login : 3
			},
			dataType : "json",
			success : function(data) {

// 					  			alert(data.result);

				if (data.result) {
					$('#main').submit();
				} else {
					$('#id').val(data.id);
					$('#login').val(data.login);
					$('#insertForm').submit();
				}
			},
			error : function() {
				alert("실패");
			}
		});
	}
	
	$(document).on('click', '.g-signin3', function(){
		googleLogin();
	});
	
	$(document).on('change', '#googleAuto', function(){
		googleLogin();
	});
	
	$('#googleAuto').on('textchange',function(){
		alert("변경");
	});

	function onSignIn(googleUser) {
		var profile = googleUser.getBasicProfile();
		console.log(profile);
		
		$('#googleAuto').val(1);
		$('#googleBtn').addClass("g-signin3");
		$('#id').val(profile.getEmail());
		$('#login').val(3);
	};
</script>



</html>