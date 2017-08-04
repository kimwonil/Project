<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width"/>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.2.1.min.js"></script>


<title>API Demo - Kakao JavaScript SDK</title>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

</head>
<body>


유저정보 출력 [카카오 로그인 성공시!]

<a id="kakao-login-btn"></a>
<script type='text/javascript'>
  //<![CDATA[
    // 사용할 앱의 JavaScript 키를 설정 : kakao developer 에서 설정
    Kakao.init('13308cd14b4fa75d3ba8015f7fff2604');
    // 버튼 생성
    Kakao.Auth.createLoginButton({
      container: '#kakao-login-btn',
      success: function(authObj) {
        // 로그인 성공시 API 호출 - /v1/user/me : 개인정보 호출(kakaodeveloper 제공)
        Kakao.API.request({
          url: '/v1/user/me',
          success: function(res) {
            alert(JSON.stringify(res));
            //EmailK에 호출한 개인정보 출력 
    		$('#EmailK').append(JSON.stringify(res.kaccount_email));
          },
          fail: function(error) {
            alert(JSON.stringify(error));
          }
        });
      },
      fail: function(err) {
        alert(JSON.stringify(err));
      }
    });
    
    
  //]]>
</script>

<div id=EmailK></div>



</body>
</html>