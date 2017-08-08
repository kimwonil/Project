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


<title>이메일 주소로 로그인</title>


</head>
<body>

<!--                        Login - Naver                         -->

<!-- 네이버 로그인에 한해 로그인 작업을 끝내면
http://localhost:8080/FinalProject/printEmailN.jsp로 redirect 후 
해당 페이지에서 이메일주소가 출력됨
-->
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

<!-- 해당 주석처리된 코드는 kakao 로그인 성공시 토큰값을 반환하고 있음.-->
<!-- 
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
 -->


<script type="text/javascript" src="http://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

<!-- 카카오 로그인 버튼 -->
<a id="kakao-login-btn"></a>
<!-- 카카오 로그인 버튼 -->
<script type='text/javascript'>

    // 사용할 앱의 JavaScript 키를 설정 : kakao developer 에서 설정
    Kakao.init('13308cd14b4fa75d3ba8015f7fff2604');
    // 카카오 아이디로 로그인 버튼 생성시 호출되는 기능
    Kakao.Auth.createLoginButton({
      container: '#kakao-login-btn',
      success: function(authObj) {
        // 로그인 성공시 API 호출 - /v1/user/me : 개인정보 호출(kakaodeveloper 제공)
        Kakao.API.request({
          url: '/v1/user/me',
          success: function(res) {
            // 호출된 개인정보 중 이메일주소만 EmailK에 출력 
    		$('#EmailK').append(JSON.stringify(res.kaccount_email));
     
            
            //test0003 : loginsuccess.do로 이동 -> loginsuccess.do에서 DB에 정보 추가하는게 목적
            //테스트페이지 menu.jsp -> <a href="profile.do?id=${member.id}">바이럴/마케팅/광고</a>

    	//	location.replace("http://localhost:8080/FinalProject/loginsuccess.do");

    		//test 0002 : 프로필페이지(id=메일)로 이동시도 
    //		location.replace("http://localhost:8080/FianlProject/profile.do?id="+JSON.stringify(res.kaccount_email));

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
<!-- 구글 로그인 버튼 -->
  <script>
  /**
   * Handler for the signin callback triggered after the user selects an account.
   */
   
   //콜백시 무슨 행동을 할 것인가? -> 정보 불러오기
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
	//test 0002 : 프로필페이지(id=메일)로 이동시도 
	//location.replace("http://localhost:8080/FianlProject/profile.do?id="+primaryEmail);

	 
 }
  
  </script>


<!--                        Login - Google                         -->
<form action="loginsuccess.do" method="get">
카카오 이메일 : <div id="EmailK"></div><br>
Google 이메일 : <div id="EmailG"> </div>
</form>
</body>
</html>