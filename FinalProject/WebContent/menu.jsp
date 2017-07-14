<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
<head>
<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>Hydrogen &mdash; A free HTML5 Template by FREEHTML5.CO</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="Free HTML5 Template by FREEHTML5.CO" />
	<meta name="keywords" content="free html5, free template, free bootstrap, html5, css3, mobile first, responsive" />
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
	<meta property="og:title" content=""/>
	<meta property="og:image" content=""/>
	<meta property="og:url" content=""/>
	<meta property="og:site_name" content=""/>
	<meta property="og:description" content=""/>
	<meta name="twitter:title" content="" />
	<meta name="twitter:image" content="" />
	<meta name="twitter:url" content="" />
	<meta name="twitter:card" content="" />

	<!-- Place favicon.ico and apple-touch-icon.png in the root directory -->
	<link rel="shortcut icon" href="favicon.ico">

	<!-- Google Webfonts -->
	<link href='http://fonts.googleapis.com/css?family=Roboto:400,300,100,500' rel='stylesheet' type='text/css'>
	<link href='https://fonts.googleapis.com/css?family=Montserrat:400,700' rel='stylesheet' type='text/css'>
	
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
	#linkGroup{
	position: relative;
	right: 1%;
	float: right;
	}
	
	#alarm-content{
	position: absolute;
	display : none;
	right: 15%;
	top: 10%;
	border: 1px solid red;
	}
	</style>
	
	<script src="https://code.jquery.com/jquery-2.2.4.min.js"
	integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44="
	crossorigin="anonymous"></script>
	
	
<script>
$(document).ready(function(){
    $("#toggler").click(function(){
    	$( "#alarm-content" ).slideToggle(1000);
    });   
});
</script>
	
<body>
<!-- 	알림띄울 내용 -->
<div id="alarm-content">
<!-- 		<div class="col-md-4"> -->
<!-- 			<div class="fh5co-pricing-table"> -->
				<table class="table" style="background: white;">
					<tr><th>새로도착한 쪽지</th><th>보낸이</th></tr>
					<tr><td>칼갈아드립니다</td><td>려차ㅑㅜㅎ 샣힏</td></tr>
				</table>
<!-- 			</div> -->
<!-- 		</div> -->
</div>


<!-- 	메뉴 -->
	<div id="fh5co-offcanvass">
		<a href="#" class="fh5co-offcanvass-close js-fh5co-offcanvass-close">Menu <i class="icon-cross"></i> </a>
		<h1 class="fh5co-logo"><a class="navbar-brand" href="index.html">Hydrogen</a></h1>
		<ul>
			<li class="active"><a href="index.html">Home</a></li>
			<li><a href="profile.do?id=kwi1222@naver.com">프로필</a></li>
			<li><a href="authority.jsp">권한 신청</a></li>
			<li><a href="detail.jsp">글상세(임시)</a></li>
			<li><a href="selling.jsp">판매관리</a></li>
			<li><a href="purchasing.jsp">구매관리</a></li>
			<li><a href="cash.jsp">캐시관리</a></li>
			<li><a href="message.jsp">쪽지관리</a></li>
			<li><a href="pricing.jsp">Pricing</a></li>
			<li><a href="contact.jsp">Contact</a></li>
		</ul>
		<h3 class="fh5co-lead">Connect with us</h3>
		<p class="fh5co-social-icons">
			<a href="#"><i class="icon-twitter"></i></a>
			<a href="#"><i class="icon-facebook"></i></a>
			<a href="#"><i class="icon-instagram"></i></a>
			<a href="#"><i class="icon-dribbble"></i></a>
			<a href="#"><i class="icon-youtube"></i></a>
		</p>
	</div>
<!-- 	메뉴 끝 -->
	
	
	<header id="fh5co-header" role="banner">
		<div class="container">
		<div class="row">
		검색 <input type="text"> 
		<div id="linkGroup">
			<a href='boardForm.jsp'>판매등록</a>
			<a href='#'>로그인</a>
			<a href='#' id="toggler">알림</a>
			<a href='#'>마이페이지</a>
		</div>
		</div>
			<div class="row">
				<div class="col-md-12">
					<a href="#" class="fh5co-menu-btn js-fh5co-menu-btn">Menu <i class="icon-menu"></i></a>
					<a class="navbar-brand" href="index.html">Hydrogen</a>		
				</div>
			</div>
		
		
		<div class="row">
			<a href="#" class="fh5co-logo">카테고리1</a>
			<a href="#" class="fh5co-logo">카테고리2</a>
			<a href="#" class="fh5co-logo">카테고리3</a>
			<a href="#" class="fh5co-logo">카테고리4</a>
			<a href="#" class="fh5co-logo">카테고리5</a>
			<a href="#" class="fh5co-logo">카테고리6</a>
		</div>
	
	</div>
	</header>
	<!-- END .header -->
	
	

	
	<!-- jQuery -->
	<script src="js/jquery.min.js"></script>
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