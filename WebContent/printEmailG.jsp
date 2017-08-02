<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src = "https://plus.google.com/js/client:platform.js" async defer></script>

</head>
<body>

이메일 출력 [구글 아이디 로그인 성공시!]

<br>

<div id="EmailG"> </div>

<br>

<!-- 버튼 -->
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





</body>
</html>