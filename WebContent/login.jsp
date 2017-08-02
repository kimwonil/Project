<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
  <title>네이버 로그인</title>
  <script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
  <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
  <script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
</head>
<body>
<div id="naver_id_login"></div>
<a id="custom-login-btn" href="javascript:loginWithKakao()">
<img src="//mud-kage.kakao.com/14/dn/btqbjxsO6vP/KPiGpdnsubSq3a0PHEGUK1/o.jpg" width="300"/>
</a>
</body>
<script type="text/javascript">
  	var naver_id_login = new naver_id_login("q9jIL5jkbHpYtx4IhwrT", "http://localhost:8080/FinalProject/loginAfter.jsp");
  	var state = naver_id_login.getUniqState();
  	naver_id_login.setButton("green", 3,65);
  	naver_id_login.setState(state);
  	naver_id_login.init_naver_id_login();
  </script>
  
  
<script type='text/javascript'>
  //<![CDATA[
    // 사용할 앱의 JavaScript 키를 설정해 주세요.
    Kakao.init('4c6164f326f50c784de915d84d2b5249');
    
    function loginWithKakao() {
      // 로그인 창을 띄웁니다.
      Kakao.Auth.login({
        success: function(authObj) {
          Kakao.API.request({
              url: '/v1/user/me',
              success: function(res) {
                console.log(res.kaccount_email);
                var email = res.kaccount_email;
//                 location.href='loginAfter.jsp?email='+email;
				$.ajax({
					url:"kakaoLogin.do",
					type:"POST",
					data:{email:res.kaccount_email},
					datatype:"json",
					success:function(){
						alert("확인");
						location.href='loginAfter.jsp';
					},
					error:function(){
						alert("실패");
					}
					
				});
              },
              fail: function(error) {
                console.log(JSON.stringify(error));
              }
            });
//           var data=JSON.stringify(authObj);
//           location.href='loginAfter.jsp?data='+data;
        },
        fail: function(err) {
          alert(JSON.stringify(err));
        }
      });
    };
  //]]>
</script>
  
  
  
  
</html>