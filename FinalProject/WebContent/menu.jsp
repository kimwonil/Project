<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js">
<!--<![endif]-->
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>ShareAbility</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="Free HTML5 Template by FREEHTML5.CO" />
<meta name="keywords"
	content="free html5, free template, free bootstrap, html5, css3, mobile first, responsive" />
<meta name="author" content="FREEHTML5.CO" />



<!-- 
	//////////////////////////////////////////////////////

	FREE HTML5 TEMPLATE 
	DESIGNED & DEVELOPED by FREEHTML5.CO
		
	Website: 		http://freehtml5.co/
	Email: 			info@freehtml5.co
	Twitter: 		http://twitter.com/fh5co
	Facebook: 		https://www.facebook.com/fh5co

	//////////////////////////////////////////////////////
	 -->

<!-- Facebook and Twitter integration -->
<meta property="og:title" content="" />
<meta property="og:image" content="" />
<meta property="og:url" content="" />
<meta property="og:site_name" content="" />
<meta property="og:description" content="" />
<meta name="twitter:title" content="" />
<meta name="twitter:image" content="" />
<meta name="twitter:url" content="" />
<meta name="twitter:card" content="" />

<!-- Place favicon.ico and apple-touch-icon.png in the root directory -->
<link rel="shortcut icon" href="favicon.ico">

<!-- Google Webfonts -->
<link
	href='http://fonts.googleapis.com/css?family=Roboto:400,300,100,500'
	rel='stylesheet' type='text/css'>
<link href='https://fonts.googleapis.com/css?family=Montserrat:400,700'
	rel='stylesheet' type='text/css'>

<!-- Animate.css -->
<link rel="stylesheet" href="css/animate.css">
<!-- Icomoon Icon Fonts-->
<link rel="stylesheet" href="css/icomoon.css">
<!-- Magnific Popup -->
<link rel="stylesheet" href="css/magnific-popup.css">
<!-- Salvattore -->
<link rel="stylesheet" href="css/salvattore.css">
<!-- Theme Style -->
<link rel="stylesheet" href="css/style.css">
<!-- Modernizr JS -->
<script src="js/modernizr-2.6.2.min.js"></script>
<!-- FOR IE9 below -->
<!--[if lt IE 9]>
	<script src="js/respond.min.js"></script>
	<![endif]-->
</head>
<style>
#linkGroup {
	position: relative;
	right: 1%;
	float: right;
}

#alarm-content {
	position: absolute;
	display: none;
	top: 15%;
	border: 1px solid red;
}

/* ///////////////////////DropDown/////////////////////////////////// */
.menu, .menu ul, .menu li, .menu a {
	margin: 0;
	padding: 0;
	border: none;
	outline: none;
}

.menu {
	height: 40px;
	width: 1130px;
	margin: 0px auto;
	background: #4c4e5a;
	background: -webkit-linear-gradient(top, #4c4e5a 0%, #2c2d33 100%);
	background: -moz-linear-gradient(top, #4c4e5a 0%, #2c2d33 100%);
	background: -o-linear-gradient(top, #4c4e5a 0%, #2c2d33 100%);
	background: -ms-linear-gradient(top, #4c4e5a 0%, #2c2d33 100%);
	background: linear-gradient(top, #4c4e5a 0%, #2c2d33 100%);
	-webkit-border-radius: 5px;
	-moz-border-radius: 5px;
	border-radius: 5px;
}

.menu li {
	position: relative;
	list-style: none;
	float: left;
	display: block;
	height: 40px;
	padding: 0px 6px;
}

/* 	.menu ul { display: none; } */
.menu li a {
	display: block;
	padding: 0 14px;
	margin: 6px 0;
	line-height: 28px;
	text-decoration: none;
	border-left: 1px solid #393942;
	border-right: 1px solid #4f5058;
	font-family: Helvetica, Arial, sans-serif;
	font-weight: bold;
	font-size: 13px;
	color: #f3f3f3;
	text-shadow: 1px 1px 1px rgba(0, 0, 0, .6);
	-webkit-transition: color .2s ease-in-out;
	-moz-transition: color .2s ease-in-out;
	-o-transition: color .2s ease-in-out;
	-ms-transition: color .2s ease-in-out;
	transition: color .2s ease-in-out;
}

.menu li:first-child a {
	border-left: none;
}

.menu li:last-child a {
	border-right: none;
}

.menu li:hover>a {
	color: #8fde62;
}

.menu ul {
	position: absolute;
	z-index: 5;
	top: 40px;
	left: 0;
	opacity: 0;
	background: #1f2024;
	-webkit-border-radius: 0 0 5px 5px;
	-moz-border-radius: 0 0 5px 5px;
	border-radius: 0 0 5px 5px;
	-webkit-transition: opacity .25s ease .1s;
	-moz-transition: opacity .25s ease .1s;
	-o-transition: opacity .25s ease .1s;
	-ms-transition: opacity .25s ease .1s;
	transition: opacity .25s ease .1s;
}

.menu li:hover>ul {
	opacity: 1;
}

.menu ul li {
	height: 0;
	overflow: hidden;
	padding: 0;
	-webkit-transition: height .25s ease .1s;
	-moz-transition: height .25s ease .1s;
	-o-transition: height .25s ease .1s;
	-ms-transition: height .25s ease .1s;
	transition: height .25s ease .1s;
}

.menu li:hover>ul li {
	height: 36px;
	overflow: visible;
	padding: 0;
}

.menu ul li a {
	width: 300px;
	z-index: 5;
	/* 	    padding: 4px 0 4px 40px; */
	/* 	    margin: 0; */

	/* 	    border: none; */
	/* 	    border-bottom: 1px solid #353539; */
}

/* 	.menu ul li:last-child a { border: none; } */

/* //////////////////////////////////////////////////////////////// */
#categoryForSearch{
	height: 30px;
}
#searchInput{
	height: 30px;
}
.searchIcon{
	width: 20px;
	height: 20px;
}


</style>

<script src="https://code.jquery.com/jquery-2.2.4.min.js"
	integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44="
	crossorigin="anonymous"></script>


<script>


	function MessageList() {
		$.ajax({
			url : "getMessage.do",
			type : "POST",
			dataType : "json",
			success : function(data) {
				console.log(data);
				$('#messagetable tr:gt(0)').remove();
				for (var i = 0; i < data.length; i++) {
					$('#messagetable').append("<tr><td><a id='" + data[i].no + "'class='messageDetail' data-toggle='modal' data-target='#messageModal'>"
						+ data[i].title + "</a></td><td>"
						+ data[i].receiver + "</td></tr>");
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				console.log(textStatus);
				console.log(errorThrown);
			}
		});
	}
	//메뉴페이지가 처음불러와질때 알림에 표시되는 읽지않은 메세지 숫자
	function MessageNum() {
		$.ajax({
			url : "getMessageCount.do",
			type : "POST",
			dataType : "json",
			success : function(data) {
				console.log(data);
				$('#togglerNum').text(data);

			},
			error : function(jqXHR, textStatus, errorThrown) {
				console.log(textStatus);
				console.log(errorThrown);
			}
		});
	}
	$(document).on('click', '.messageDetail', function() {

		$.ajax({
			url : "messageDetail.do",
			type : "POST",
			data : {
				no : $(this).attr('id')
			},
			dataType : "json",
			success : function(data) {

				$('#titleLabel').text(data.title);
				$('#senderLabel').text(data.sender);
				$('#contentLabel').text(data.content);
				MessageList();
				MessageNum();
			},
			error : function() {
				alert("실패");
			}
		});

	});

	$(document).ready(function() {


		MessageNum();

		//인터벌로 3초마다 알림에 표시되는 읽지않은 메세지 숫자
		setInterval(function() {
			$.ajax({
				url : "getMessageCount.do",
				type : "POST",
				dataType : "json",
				success : function(data) {
					console.log(data);

					$('#togglerNum').text(data);

				},
				error : function(jqXHR, textStatus, errorThrown) {
					console.log(textStatus);
					console.log(errorThrown);
				}
			});
		}, 3000)

		//알림 눌렀을때 읽지않은 메세지 제목과 보낸사람 표시

		$("#toggler").click(function() {
			var a = $("#toggler").offset();

			var left = a.left - 150;

			$("#alarm-content").css({
				"left" : left
			});
			$("#alarm-content").slideToggle(1000);
			MessageList();

		});
		
		//검색부분 카테고리 가져오기
		$.ajax({
			url : "bringCategory.do",
			type : "post",
			dataType : "json",
			success : function(data){
				$('#categoryForSearch').empty();
				$('#categoryForSearch').append('<option value="0">카테고리</option>');
				$.each(data, function(index, value){
					$('#categoryForSearch').append(
							(value.no == $('#hiddenMajor').val() ? '<option value="'+value.no+'" selected>'+value.category_name+'</option>' : '<option value="'+value.no+'">'+value.category_name+'</option>')
					);//append 끝
				});//each 끝
			},error:function(jqXHR, textStatus, errorThrown){
    			alert(textStatus);     //응답상태
    			alert(errorThrown);     //응답에 대한 메세지
    		}
		});//카테고리 가져오는 ajax 끝
		
		//검색시작!
		$(document).on('keydown', '#searchInput', function(key){
			if(key.keyCode == 13){ //엔터눌렀을때
				console.log($('#searchInput').val()+"11111111111");
				if($('#searchInput').val() == ''){
					alert("검색어를 입력하세요");
					return false;
				}else{
					$('#searchInput').parent().submit();
				}				
			};
		});//검색 끝

		
		$('.searchIcon').click(function(){
			if($('#searchInput').val() == ''){
				alert("검색어를 입력하세요");
				return false;
			}else{
				$('#searchInput').parent().submit();
			}	
		});
	
	
		//판매등록 누르면 로그인 검사하고 보내기
// 		$(document).on('click', '#boardForm', function(){
// 			if(${member.nickname} == null || ${member.nickname} == ''){
// 				alert('로그인 후에 이용하실 수 있습니다');
// 			}else{
// 				locaiton.href = "boardForm.do";
// 			}
// 		});
		
	
	
	
	
	});
</script>

<body>
	<!-- 	알림띄울 내용 -->
	<div id="alarm-content" style="background: white; z-index: 9;">
		<table class="table" id="messagetable" style="">
			<tr>
				<th>새로도착한 쪽지</th>
				<th>보낸이</th>
			</tr>
		</table>
	</div>


	<!-- 	메뉴 -->
	<div id="fh5co-offcanvass">
		<a href="#" class="fh5co-offcanvass-close js-fh5co-offcanvass-close">Menu
			<i class="icon-cross"></i>
		</a>
		<h1 class="fh5co-logo">
			<a class="navbar-brand" href="index.jsp">Home</a>
		</h1>
		<ul>
			<li><a href="profile.do?id=kwi1222@naver.com">프로필</a></li>
			<li><a href="authority.do">권한 신청</a></li>
			<li><a href="selling.do">판매관리</a></li>
			<li><a href="purchasing.do">구매관리</a></li>
			<li><a href="cashPage.do">캐시관리</a></li>
			<li><a href="message.do">쪽지관리</a></li>
			<li><a href="customerCenterCall.do">고객센터</a></li>
		</ul>
	</div>
	<!-- 	메뉴 끝 -->


	<!-- 메세지 상세  Modal -->
	<div class="modal fade" id="messageModal" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">상세내용</h4>
				</div>
				<div class="modal-body">
					<table id="messageDetail">
						<tr>
							<td width="80%">제&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목
								: <label id="titleLabel"></label>
							</td>
							<td width="20%" rowspan="2" align="center"><button
									type="button" id="messageDelete" class="btn btn-sm btn-danger">삭제</button></td>
						</tr>
						<tr>

							<td width="80%">보낸사람 : <label id="senderLabel"></label>
							</td>
						</tr>
						<tr>
							<td colspan="3"><textarea id="contentLabel" rows="10"
									cols="78" readonly="readonly"></textarea></td>
						</tr>
					</table>
				</div>
			</div>

		</div>
	</div>
	<!-- Modal -->



	<header id="fh5co-header" role="banner">
	<div class="container">
		<div class="row">
			<form action="search.do" method="post">
				<select name="major" id="categoryForSearch">
				</select> 
				<input type="text" id="searchInput" name="word" value="${word}">
				<a href="#"><img src="images/search.png" class="searchIcon"></a>
			</form>
			<div id="linkGroup">
				<a href='boardForm.do' id="boardForm">판매등록</a> <a href='loginprototype.jsp'>로그인</a>
				<a href='#' id="toggler">알림 <span class="badge" id="togglerNum"></span>
					<a href='#'>마이페이지</a>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<a href="#" class="fh5co-menu-btn js-fh5co-menu-btn">Menu <i
					class="icon-menu"></i></a> <a class="navbar-brand" href="index.jsp">ShareAbility</a>
			</div>
		</div>

		<!-- 		카테고리 메뉴                    -->
		<div class="row">
			<ul class="menu">
				<li><a href="profile.do?id=a@naver.com">디자인/그래픽</a>
					<ul>
						<li><a href="#101" class="documents">캐리커쳐/인물/캐릭터/아이콘</a></li>
						<li><a href="#102" class="documents">일러스트/초상화/스케치</a></li>
						<li><a href="#103" class="documents">PPT
								디자인/인포그래픽/캘리그라피/폰트/싸인</a></li>
						<li><a href="#104" class="documents">만화/웹툰</a></li>
						<li><a href="#105" class="documents">사진/명함/이미지/포토샵/보정/합성</a></li>
						<li><a href="#106" class="documents">블로그&카페 디자인/페이지/배경</a></li>
						<li><a href="#107" class="documents">로고/심볼/마크/앰블럼/배너</a></li>
						<li><a href="#108" class="documents">현수막/전단/간판/포스터</a></li>
						<li><a href="#109" class="documents">도면/CAD/인테리어/3D</a></li>
						<li><a href="#110" class="documents">기타</a></li>
					</ul></li>
				<li><a href="profile.do?id=${member.id}">바이럴/마케팅/광고</a>
					<ul>
						<li><a href="#201" class="documents">블로그/카페/체험단</a></li>
						<li><a href="#202" class="documents">인스타그램/페이스북/카카오/트위터</a></li>
						<li><a href="#203" class="documents">일반광고/옥외광고/광고대행/디스플레이
								광고</a></li>
						<li><a href="#204" class="documents">기획/컨설팅/분석/마케팅자료</a></li>
						<li><a href="#205" class="documents">언론/기사/보도자료</a></li>
						<li><a href="#206" class="documents">기타</a></li>
					</ul></li>
				<li><a href="profile.do?id=c@naver.com">문서/서식/레포트</a>
					<ul>
						<li><a href="#301" class="documents">워드/타이핑/엑셀/통계</a></li>
						<li><a href="#302" class="documents">창작/대본/시나리오/카피라이팅</a></li>
						<li><a href="#303" class="documents">교정/교열/편집</a></li>
						<li><a href="#304" class="documents">PPT제작/프리젠테이션</a></li>
						<li><a href="#305" class="documents">글작성/리뷰/서평</a></li>
						<li><a href="#306" class="documents">문서서식/자료/폼</a></li>
						<li><a href="#307" class="documents">자기소개서/이력서</a></li>
						<li><a href="#308" class="documents">사업계획서/제안서</a></li>
						<li><a href="#309" class="documents">논문 컨설팅/보고서/리서치</a></li>
						<li><a href="#310" class="documents">기타</a></li>
					</ul></li>
				<li><a href="#">컴퓨터/개발</a>
					<ul>
						<li><a href="#401" class="documents">홈페이지/웹개발</a></li>
						<li><a href="#402" class="documents">모바일/Web/App/어플</a></li>
						<li><a href="#403" class="documents">수리/최적화/PC/서버/견적</a></li>
						<li><a href="#404" class="documents">프로그래밍/프로그램/소스</a></li>
						<li><a href="#405" class="documents">플래시/스크립트</a></li>
						<li><a href="#406" class="documents">기타</a></li>
					</ul></li>
				<li><a href="#">음악/영상</a>
					<ul>
						<li><a href="#501" class="documents">영상제작/자막제작/편집</a></li>
						<li><a href="#502" class="documents">작사/작곡/MR/음악편집/녹음</a></li>
						<li><a href="#503" class="documents">나레이션/성우/목소리</a></li>
						<li><a href="#504" class="documents">음악레슨/노래/댄스</a></li>
						<li><a href="#505" class="documents">인디음악/창작음악</a></li>
						<li><a href="#506" class="documents">기타</a></li>
					</ul></li>
				<li><a href="#">생활/대행/상담</a>
					<ul>
						<li><a href="#601" class="documents">고민상담/진로상담/취업상담/기타상담</a></li>
						<li><a href="#602" class="documents">점/운세/사주/토정비결/궁합</a></li>
						<li><a href="#603" class="documents">개인학습/강습</a></li>
						<li><a href="#604" class="documents">이벤트/행사도우미/레크레이션</a></li>
						<li><a href="#605" class="documents">미용/코디/스타일링/모델/피팅/건강</a></li>
						<li><a href="#606" class="documents">하객대행/역할/MC/사회/연주/축가</a></li>
						<li><a href="#607" class="documents">심부름/가사도우미/청소/이사</a></li>
						<li><a href="#608" class="documents">단기알바/부업</a></li>
						<li><a href="#609" class="documents">구매대행</a></li>
						<li><a href="#610" class="documents">기타</a></li>
					</ul></li>
				<li><a href="#">노하우/여행</a>
					<ul>
						<li><a href="#701" class="documents">생활지식/비법/수리/노하우/팁</a></li>
						<li><a href="#702" class="documents">투자/재테크</a></li>
						<li><a href="#703" class="documents">자동차/연비/부품부속/튜닝</a></li>
						<li><a href="#704" class="documents">요리/레시피</a></li>
						<li><a href="#705" class="documents">국내여행/해외여행</a></li>
						<li><a href="#706" class="documents">가이드/여행코스/여행지추천</a></li>
						<li><a href="#707" class="documents">온라인게임</a></li>
						<li><a href="#708" class="documents">기타</a></li>
					</ul></li>
				<li><a href="#">비즈니스/창업/사업</a>
					<ul>
						<li><a href="#801" class="documents">사업계획/사업제안</a></li>
						<li><a href="#802" class="documents">법인설립/사업자등록/통신판매</a></li>
						<li><a href="#803" class="documents">리서치/컨설팅</a></li>
						<li><a href="#804" class="documents">투자/금융/경매</a></li>
						<li><a href="#805" class="documents">법무/인사/노동법/세무/회계</a></li>
						<li><a href="#806" class="documents">창업상담/비즈니스 모델진단</a></li>
						<li><a href="#807" class="documents">창업정보/창업자료/창업노하우</a></li>
						<li><a href="#808" class="documents">기타</a></li>
					</ul></li>
				<li><a href="#">번역/외국어</a>
					<ul>
						<li><a href="#901" class="documents">영어</a></li>
						<li><a href="#902" class="documents">일본어</a></li>
						<li><a href="#903" class="documents">중국어</a></li>
						<li><a href="#904" class="documents">러시아어</a></li>
						<li><a href="#905" class="documents">프랑스어</a></li>
						<li><a href="#906" class="documents">스페인어</a></li>
						<li><a href="#907" class="documents">독일어</a></li>
						<li><a href="#908" class="documents">기타</a></li>
					</ul></li>
			</ul>
		</div>

	</div>
	</header>
	<!-- END .header -->




	<!-- jQuery -->
	<!-- 	<script src="js/jquery.min.js"></script> -->
	<!-- jQuery Easing -->
	<script src="js/jquery.easing.1.3.js"></script>
	<!-- Bootstrap -->
	<script src="js/bootstrap.min.js"></script>
	<!-- Waypoints -->
	<script src="js/jquery.waypoints.min.js"></script>
	<!-- Magnific Popup -->
	<script src="js/jquery.magnific-popup.min.js"></script>
	<!-- Salvattore -->
	<script src="js/salvattore.min.js"></script>
	<!-- Main JS -->
	<script src="js/main.js"></script>
</body>
</html>