<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js" ></script>


<script type="text/javascript" src="http://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src = "https://plus.google.com/js/client:platform.js" async defer></script>



<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width"/>
<meta name="google-signin-client_id" content="427985089734-bhj7cddethlpgqgm0jqgh7i7071en55t.apps.googleusercontent.com"></meta>


<title>아이디 버튼 통합 테스트</title>


</head>
<body>

<!-- 네이버아이디로로그인 버튼 노출 영역 -->
<div id="naver_id_login"></div>
<!-- //네이버아이디로로그인 버튼 노출 영역 -->

<!-- 네이버아이디로로그인 초기화 Script -->
<script type="text/javascript">
	var naver_id_login = new naver_id_login("4hbqrclSjqpbsBAmXZy9", "http://localhost:8080/LoginTo_123_test0001/printEmailN.jsp");
	var state = naver_id_login.getUniqState();
	naver_id_login.setButton("white", 2,40);
	//naver_id_login.setDomain(".service.com");
	//: 얘는 콜백도메인이랑 네아로 로그인 버튼 달린 페이지랑 도메인이 다를때 씀. https://developers.naver.com/docs/login/web/ 접근 토큰 요청 참조
	naver_id_login.setState(state);
	
	//여기서부터 팝업설정
//	naver_id_login.setPopup();
	//여기까지 팝업설정
	naver_id_login.init_naver_id_login();
	
</script>
<!-- // 네이버아이디로로그인 초기화 Script -->

<br>



<a id="custom-login-btn" href="javascript:loginWithKakao()">
<img src="//mud-kage.kakao.com/14/dn/btqbjxsO6vP/KPiGpdnsubSq3a0PHEGUK1/o.jpg" width="300"/>
</a>
<script type='text/javascript'>
  //<![CDATA[
    // 사용할 앱의 JavaScript 키를 설정해 주세요.
    Kakao.init('13308cd14b4fa75d3ba8015f7fff2604');
    function loginWithKakao() {
      // 로그인 창을 띄웁니다.
      Kakao.Auth.login({
        success: function(authObj) {
          alert(JSON.stringify(authObj));
          //test1
     	    alert(Kakao.Auth.getStatus(scope));
          //test1
          
        },
        fail: function(err) {
          alert(JSON.stringify(err));
        }
      });
    };
  //]]>
</script>

<br>
    <!-- Container with the Sign-In button. -->
    <div id="gConnect" class="button">
      <button class="g-signin"
          data-scope="email"
          data-clientid="427985089734-bhj7cddethlpgqgm0jqgh7i7071en55t.apps.googleusercontent.com"
          data-callback="onSignInCallback"
          data-theme="dark"
          data-cookiepolicy="single_host_origin">
      </button>
    </div>

  <script>
  /**
   * Handler for the signin callback triggered after the user selects an account.
   */
  function onSignInCallback(resp) {
    gapi.client.load('plus', 'v1', apiClientLoaded);
  }

  /**
   * Sets up an API call after the Google API client loads.
   */
  function apiClientLoaded() {
    gapi.client.plus.people.get({userId: 'me'}).execute(handleEmailResponse);
  }
  
  /**
   * Response callback for when the API client receives a response.
   *
   * @param resp The API response object with the user email and profile information.
   */

  function handleEmailResponse(resp) {
    var primaryEmail;	
   for (var i=0; i < resp.emails.length; i++) {
      if (resp.emails[i].type === 'account') primaryEmail = resp.emails[i].value;
    }
	$('#EmailG').append(primaryEmail);
	 
 }
  
  </script>

Google 이메일 : <div id="EmailG"> </div>

<br>
</body>
</html>