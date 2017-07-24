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


<title>아이디 버튼 통합 테스트 0001</title>


</head>
<body>

<!--                        Login - Naver                         -->

<!-- 네이버 아이디로 로그인 버튼 -->
<div id="naver_id_login"></div>
<!-- 네이버 아이디로 로그인 버튼 -->

<!-- 초기화 -->
<script type="text/javascript">
//첫값은 키값(naver developer에서 받아와야 함) / 두번째 값은 redirect 주소값
	var naver_id_login = new naver_id_login("4hbqrclSjqpbsBAmXZy9", "http://localhost:8080/FinalProject/printEmailN.jsp");
	var state = naver_id_login.getUniqState();
	naver_id_login.setButton("white", 2,40);

// 얘는 콜백도메인이랑 네아로 로그인 버튼 달린 페이지랑 도메인이 다를때 씀. https://developers.naver.com/docs/login/web/ 접근 토큰 요청 참조
	//naver_id_login.setDomain(".service.com");
// 얘는 콜백도메인이랑 네아로 로그인 버튼 달린 페이지랑 도메인이 다를때 씀. https://developers.naver.com/docs/login/web/ 접근 토큰 요청 참조

	naver_id_login.setState(state);
	
	//여기서부터 팝업설정
//	naver_id_login.setPopup();
	//여기까지 팝업설정
	naver_id_login.init_naver_id_login();
	
</script>
<!-- 초기화 -->

<br>
<!--                        Login - Naver                         -->

<!--                        Login - Kakao                         -->

<!-- 해당 kakaologin은 토큰값을 반환하고 있음.
이메일 주소 등의 개인정보를 출력하는 printEmailK.jsp에서 확인할것 -->
<a id="custom-login-btn" href="javascript:loginWithKakao()">
<img src="//mud-kage.kakao.com/14/dn/btqbjxsO6vP/KPiGpdnsubSq3a0PHEGUK1/o.jpg" width="300"/>
</a>
<script type='text/javascript'>
  //<![CDATA[
    // 사용할 앱의 JavaScript 키를 설정 : kakao developer 내부에서 설정
    Kakao.init('13308cd14b4fa75d3ba8015f7fff2604');
    function loginWithKakao() {
      // 로그인 창을 띄우고(팝업)
      Kakao.Auth.login({
        
    	  //성공시 토큰정보 출력
    	 success: function(authObj) {
          alert(JSON.stringify(authObj));
          
        },
        fail: function(err) {
          alert(JSON.stringify(err));
        }
      });
    };
  //]]>
</script>

<!--                        Login - Kakao                         -->


<!--                        Login - Google                         -->
<br>

<!-- 구글 로그인 버튼 -->
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
   
   //콜백시 무슨 행동을 할 것인가?
  function onSignInCallback(resp) {
    gapi.client.load('plus', 'v1', apiClientLoaded);
  }

  /**
   * Sets up an API call after the Google API client loads.
   */
   
  //handleEmailResopnse로 가져온 이메일 주소를 가져오는 기능(콜백함수에서 호출하는 그 기능) 
  function apiClientLoaded() {
    gapi.client.plus.people.get({userId: 'me'}).execute(handleEmailResponse);
  }
  
  /**
   * Response callback for when the API client receives a response.
   *
   * @param resp The API response object with the user email and profile information.
   */

//이메일 값을 받아서 출력하는 함수

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

<!--                        Login - Google                         -->

</body>
</html>