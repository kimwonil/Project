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
@import url('http://fonts.googleapis.com/earlyaccess/nanumgothic.css');

h3, h2, .ui-tabs-anchor{
	font-family:'Nanum Gothic';
}
.category_img{
	width: 50px;
	height: 50px;
}
.home-brand{
	font-weight: 100 !important;
}



#linkGroup {
	position: relative;
	float: right;
	font-family:'Nanum Gothic';
	color: #f3f3f3;
	font-weight: bold;
}

#alarm-content {
	position: absolute;
	display: none;
	top: 20%;
	right: 5%;
	overflow:hidden;
	border-radius:10px;
	box-shadow:0px 0px 9px 0px;
	min-height: 250px;
}


#alarm-content table>tbody>tr:first-child{
	background-color: #cecece;
}
#alarm-content table>tbody>tr {
	border-bottom: 1px solid #e4e4e4;
	border-top: 1px solid #e4e4e4;
}
#alarm-content table{
	text-align: center;
}


textarea{
	width: 100%;
}

/* ///////////////////////DropDown/////////////////////////////////// */
.menu, .menu ul, .menu li, .menu a {
	margin: 0;
	padding: 0;
	border: none;
	outline: none;
}

.menu {
	height: 35px;
	position: fixed;
	z-index:10;
	left:0%;
	width: 100%;
	padding-left:6%;
	padding-right:6%;
	margin: -10px auto;
	background: #60ccbd;
	background: -webkit-linear-gradient(top, #60ccbd 0%, #60ccbd 100%);
	background: -moz-linear-gradient(top, #60ccbd 0%, #60ccbd 100%);
	background: -o-linear-gradient(top, #60ccbd 0%, #60ccbd 100%);
	background: -ms-linear-gradient(top, #60ccbd 0%, #60ccbd 100%);
	background: linear-gradient(top, #60ccbd 0%, #60ccbd 100%);
	-webkit-border-radius: 5px;
	-moz-border-radius: 5px;
	border-radius: 5px;
}
.categoryMenu>li{
	text-align: center;
}

.menu li {
	position: relative;
	list-style: none;
	float: left;
	width:11.1%;
	display: block;
	height: 40px;
	padding: 0px 6px;
}

/* 	.menu ul { display: none; } */
.menu li a {
	display: block;
	padding: 0 14px;
	line-height: 28px;
	text-decoration: none;
	font-family:'Nanum Gothic';
	font-weight: bold;
	font-size: 15px;
	color: #fff;
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
	top: 35px;
	left: 0;
	opacity: 0;
	background: #60ccbd; 
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
	width:100%;
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

.fh5co-header{

	position: fixed;
	z-index: 10;
	background: white;

}
#fh5co-header{
	opacity:0.8;
}



/* //////////////////////////////////////////////////////////////// */
#categoryForSearch{
	height: 30px;
	border-radius:5px;
}
#searchInput{
	height: 43px;
	width:170px;
	display: inline;
	color: white;
}
.searchIcon{
	width: 20px;
	height: 20px;
}
#searchForm{
	position: absolute;
	left: 60px;
	top: 30px;
}
.fh5co-menu-btn{
	display: none;
}
#messagetable{
	width: 400px;
}
#receiverLabel{
	height: 20px;
}


/* //////////////////////////////////// */
#chtIcon{
	position: fixed;
	left: 93%;
	top: 90%;
	z-index: 20;
}
#chtIcon img{
	width: 65px !important;
	height: 65px !important;
}

.iframeDiv{
	position:fixed;
    left:100%;
    width:300px;
    height:500px;
    -webkit-transition: left 1s; /* Safari */
    transition: left 1s;
    background-color: white;
}
#iframeDiv{
    -webkit-transition-timing-function: ease;
    transition-timing-function: ease;
    box-shadow:0px 0px 9px 0px rgba(0, 0, 0, 0.3);
    border-radius:7px;
}
#iframeMain{
	height: 500px;
	border:0px;
}
:target{
	left:80%;
}

@media (min-width: 1200px) {
	.menu{
		padding-left: 4%;
		padding-right: 4%;
	}
	.menu li a{
		display: block;
		padding: 0 14px;
		line-height: 28px;
		text-decoration: none;
		font-family:'Nanum Gothic';
		font-weight: bold;
		font-size: 14px;
		color: #fff;
		text-shadow: 1px 1px 1px rgba(0, 0, 0, .6);
		-webkit-transition: color .2s ease-in-out;
		-moz-transition: color .2s ease-in-out;
		-o-transition: color .2s ease-in-out;
		-ms-transition: color .2s ease-in-out;
		transition: color .2s ease-in-out;
	}
	
	
  :target{
  	left:74%;
  }
}
@media (min-width: 1400px) {
	.menu{
		padding-left: 6%;
		padding-right: 6%;
	}
	.menu li a{
		display: block;
		padding: 0 14px;
		line-height: 28px;
		text-decoration: none;
		font-family:'Nanum Gothic';
		font-weight: bold;
		font-size: 15px;
		color: #fff;
		text-shadow: 1px 1px 1px rgba(0, 0, 0, .6);
		-webkit-transition: color .2s ease-in-out;
		-moz-transition: color .2s ease-in-out;
		-o-transition: color .2s ease-in-out;
		-ms-transition: color .2s ease-in-out;
		transition: color .2s ease-in-out;
	}
  :target{
  	left:78%;
  }
}
@media (min-width: 1600px) {
	.menu{
		padding-left: 6%;
		padding-right: 6%;
	}
	.menu li a{
		display: block;
		padding: 0 14px;
		line-height: 28px;
		text-decoration: none;
		font-family:'Nanum Gothic';
		font-weight: bold;
		font-size: 15px;
		color: #fff;
		text-shadow: 1px 1px 1px rgba(0, 0, 0, .6);
		-webkit-transition: color .2s ease-in-out;
		-moz-transition: color .2s ease-in-out;
		-o-transition: color .2s ease-in-out;
		-ms-transition: color .2s ease-in-out;
		transition: color .2s ease-in-out;
	}
  :target{
  	left:81%;
  }
}
@media (min-width: 1800px) {
	.menu{
		padding-left: 6%;
		padding-right: 6%;
	}
	.menu li a{
		display: block;
		padding: 0 14px;
		line-height: 28px;
		text-decoration: none;
		font-family:'Nanum Gothic';
		font-weight: bold;
		font-size: 15px;
		color: #fff;
		text-shadow: 1px 1px 1px rgba(0, 0, 0, .6);
		-webkit-transition: color .2s ease-in-out;
		-moz-transition: color .2s ease-in-out;
		-o-transition: color .2s ease-in-out;
		-ms-transition: color .2s ease-in-out;
		transition: color .2s ease-in-out;
	}
  :target{
  	left:84%;
  }
}

#ChtMain{
	z-index:15;
	position:fixed;
	left: 100%;
	top:240px;
}
.topMenu{
	height: 50px;
	padding: 0px;
}

/* /////////////////////////////////////// */

</style>
<style>


.select-hidden {
  display: none;
  visibility: hidden;
  padding-right: 10px;
}

.select {
  cursor: pointer;
  display: inline-block;
  position: relative;
  font-size: 14px;
  color: #fff;
  width: 150px;
  height: 40px;
}

.select-styled {
  top: 0;
  right: 0;
  bottom: 0;
  left: 0;
  background-color: #60ccbd;
  padding: 8px 15px;
  -moz-transition: all 0.2s ease-in;
  -o-transition: all 0.2s ease-in;
  -webkit-transition: all 0.2s ease-in;
  transition: all 0.2s ease-in;
  border: 2px solid #444;
  border-radius: 5px;
}

.select-styled:after {
  content: "";
  width: 0;
  height: 0;
  border: 7px solid transparent;
  border-color: #fff transparent transparent transparent;
  position: absolute;
  top: 16px;
  right: 10px;
}

.select-styled:hover { background-color: #22a9b9; }

.select-styled:active, .select-styled.active { background-color: #60ccbd; }

.select-styled:active:after, .select-styled.active:after {
  top: 9px;
  border-color: transparent transparent #fff transparent;
}

.select-options {
  display: none;
  position: absolute;
  top: 100%;
  right: 0;
  left: 0;
  z-index: 999;
  margin: 0;
  padding: 0;
  list-style: none;
  background-color: #60ccbd;
  border: 2px solid #444;
  border-radius:0px 0px 10px 10px;
}

.select-options li {
  margin: 0;
  padding: 10px 0;
  text-indent: 15px;
  border-top: 1px solid #1c8a97;
  -moz-transition: all 0.15s ease-in;
  -o-transition: all 0.15s ease-in;
  -webkit-transition: all 0.15s ease-in;
  transition: all 0.15s ease-in;
}

.select-options li:hover {
  color: #24b1c2;
  background: #fff;
}

.select-options li[rel="hide"] { display: none; }
</style>
<script src="https://code.jquery.com/jquery-2.2.4.min.js"
	integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44="
	crossorigin="anonymous"></script>
<script type="text/javascript">
$(document).ready(function(){

	$('#searchSelect').each(function(){
	    var $this = $(this), numberOfOptions = $(this).children('option').length;
	  
	    $this.addClass('select-hidden'); 
	    $this.wrap('<div class="select"></div>');
	    $this.after('<div class="select-styled"></div>');
	
	    var $styledSelect = $this.next('div.select-styled');
	    $styledSelect.text($this.children('option').eq(0).text());
	  
	    var $list = $('<ul />', {
	        'class': 'select-options'
	    }).insertAfter($styledSelect);
	  
	    for (var i = 0; i < numberOfOptions; i++) {
	        $('<li />', {
	            text: $this.children('option').eq(i).text(),
	            rel: $this.children('option').eq(i).val()
	        }).appendTo($list);
	    }
	  
	    var $listItems = $list.children('li');
	
	 
	  
	  $styledSelect.click(function(e) {
	     if($('.select-options').is(':visible')) {
	        e.stopPropagation();
	        $styledSelect.text($(this).text()).removeClass('active');
	        $this.val($(this).attr('rel'));
	      
	        $list.hide();
	        //console.log($this.val());   
	
	     } else {
	        e.stopPropagation();
	        $('div.select-styled.active').each(function(){
	            $(this).removeClass('active').next('ul.select-options').hide();
	        });
	        $(this).toggleClass('active').next('ul.select-options').toggle();
	     }//end if
	    });
	  
	    $listItems.click(function(e) {
	        e.stopPropagation();
	        $styledSelect.text($(this).text()).removeClass('active');
	        $this.val($(this).attr('rel'));
	        $list.hide();
	        //console.log($this.val());
	    });
	    
	    $(document).click(function() {
	        $styledSelect.removeClass('active');
	        $list.hide();
	    });
	
	});
});
</script>
<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-36251023-1']);
  _gaq.push(['_setDomainName', 'jqueryscript.net']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>




<script>


	function MessageList() {
		$.ajax({
			url : "getMessage.do",
			type : "POST",
			dataType : "json",
			success : function(data) {
				console.log(data);
				$('#messagetable tr:gt(0)').remove();
				if(data == ''){
					$('#messagetable').append(
						"<tr><td colspan='2'>알림이 없습니다.</td></tr>"		
					);
				}else{
					for (var i = 0; i < data.length; i++) {
						$('#messagetable').append("<tr><td><a id='" + data[i].no + "'class='messageDetail' data-toggle='modal' data-target='#messageModal'>"
							+ data[i].title + "&nbsp;&nbsp;&nbsp;</a></td><td>"
							+ data[i].sender + "</td></tr>");
					}
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
				$('#messageDelete').val(data.no);
				$('#messageRe').val(data.no);
				MessageList();
// 				MessageNum();
			},
			error : function() {
				alert("실패");
			}
		});
	});
	
	//메세지 삭제
	$(document).on('click', '#messageDelete', function(){
		$.ajax({
			url:"messageDelete.do",
			type:"POST",
			data:{
				no:$(this).val()
			},
			success:function(){
				alert("성공");
				$('#messageModal').modal('hide');
			},
			error : function(jqXHR, textStatus, errorThrown) {
				console.log(textStatus);
				console.log(errorThrown);
			}
		});
	});
	
	//메세지 답장 modal 띄우기
	$(document).on('click','#messageRe',function(){
		$('#messageModal').modal('hide');
		$('#messageReSend').modal('show');
		$.ajax({
			url:"messageDetail.do",
			type:"POST",
			data:{
				no:$(this).val()
			},
			dataType:"json",
			success:function(data){
				console.log(data);
				$('#messageReTitle').val(data.title+" : 답변");
				$('#receiverLabel').text(data.sender);
				$('#messageReContent').val(data.content+" \n ================================================================\n");
			},
			error:function(){
				alert("실패");
			}
			
		});
		
		
	});
	
	//답장 보내기
		$(document).on('click','#messageReBtn',function(){
			
			$.ajax({
				url:"messageSend.do",
				type:"POST",
				data:{
					title:$('#messageReTitle').val(),
					receiver:$('#receiverLabel').text(),
					content:$('#messageReContent').val()
				},
				success:function(){
					alert("메세지 발송 완료");
					$('#messageReTitle').val("");
					$('#receiverLabel').text("");
					$('#messageReContent').val("");
					$('#messageReSend').modal('hide');
				},
				error:function(jqXHR, textStatus, errorThrown){
					console.log(textStatus);
					console.log(errorThrown);
				}
				
			});
			
		});
	
	
	//메세지 보내기
	$(document).on('click','#messageBtn',function(){
		
		$.ajax({
			url:"messageSend.do",
			type:"POST",
			data:{
				title:$('#messageTitle').val(),
				receiver:$('#messageReceiver').val(),
				content:$('#messageContent').val()
			},
			success:function(){
				alert("메세지 발송 완료");
				$('#messageTitle').val("");
				$('#messageReceiver').val("");
				$('#messageContent').val("");
			},
			error:function(jqXHR, textStatus, errorThrown){
				console.log(textStatus);
				console.log(errorThrown);
			}
			
		});
		
	});
	
	
	
	$(document).ready(function() {
		var menu = $('#memberLogin').val();
		$('#togglerNum').text(0);
		if(menu == ''){
			$('.fh5co-menu-btn').css('display','none');
			clearInterval(messageCount);
		}else{
			$('.fh5co-menu-btn').css('display','inline');
			//인터벌로 3초마다 알림에 표시되는 읽지않은 메세지 숫자
			var messageCount = setInterval(function() {
				MessageNum();
			}, 3000);
		}
		
		
		
		
		
		
		//알림 눌렀을때 읽지않은 메세지 제목과 보낸사람 표시

		$("#toggler").click(function() {
			var a = $("#toggler").offset();

// 			var left = a.left - 150;

// 			$("#alarm-content").css({
// 				"left" : left
// 			});
			$("#alarm-content").slideToggle(1);
			MessageList();

		});
		
		//검색시작!
		$(document).on('keydown', '#searchInput', function(key){
			if(key.keyCode == 13){ //엔터눌렀을때
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
		$(document).on('click', '#boardForm', function(){
			if($('#memberLogin').val() == null || $('#memberLogin').val() == ''){
				console.log($('#memberLogin').val());
				alert('로그인 후에 이용하실 수 있습니다');
				return false;
			}else{
				locaiton.href = "boardForm.do";
			}
		});
		
		
		$(document).on('click', '#chtIcon', function(){
			$(this).css('display','none');
		});
		
		$(document).on('click', '#chtClose', function(){
			$('#chtIcon').css('display','inline');
		});
		
		
	//////test용 로그인 연경 추가 0901
// 	$(document).on('click', '#testLogin', function(){
			
		
// 		$.ajax({
// 			url : "login.do",
// 			type : "POST",
// 			data : {
// 				email : "testAdmin@naver.com",
// 				login : "1"
// 			},
// 			dataType : "json",
// 			success : function(data) {
// 				if (data.result) {
// 					$('#main').submit();
// 					$('#memberLogin').val(1);
// 					alert("테스트용으로 로그인 되었습니다");
// 				} else {
// 					$('#id').val(data.id);
// 					$('#login').val(data.login);
// 					$('#insertForm').submit();
// 				}

// 			},
// 			error : function() {
// 				alert("실패");
// 			}
// 		});
// 	})

// 	$(document).on('click', '#testLogin', function(){
// 		location.herf="testLogin.do";
		
// 	})
	///////
	});
</script>
<body>
<input type="hidden" id="memberLogin" value="${member.login}">
	<!-- 	알림띄울 내용 -->
	<div id="alarm-content" style="background: white; z-index: 11;">
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
			<li><a href="profile.do">프 로 필</a></li>
			<li><a href="authority.do">권한신청</a></li>
			<li><a href="selling.do">판매관리</a></li>
			<li><a href="purchasing.do">구매관리</a></li>
			<li><a href="cashPage.do">캐시관리</a></li>
			<li><a href="message.do">쪽지관리</a></li>
			<li><a href="customerCenter.do">고객센터</a></li>
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
							<td width="20%" rowspan="2" align="center">
							<button type="button" id="messageRe" class="btn btn-sm btn-danger">답장</button>
							<button type="button" id="messageDelete" class="btn btn-sm btn-danger">삭제</button></td>
						</tr>
						<tr>

							<td width="80%">보낸사람 : <label id="senderLabel"></label>
							</td>
						</tr>
						<tr>
							<td colspan="3"><textarea id="contentLabel" rows="10"
									cols="75" readonly="readonly"></textarea></td>
						</tr>
					</table>
				</div>
			</div>

		</div>
	</div>
	<!-- Modal -->
	
	<!-- 메세지 답장  Modal -->
	<div class="modal fade" id="messageReSend" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">답변</h4>
				</div>
				<div class="modal-body">
					<table id="messageReTable">
						<tr>
							<td width="80%">제&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목 : <input type="text" class="messageInput" id="messageReTitle"></td>
							<td width="20%" rowspan="2" align="center"><button type="button" id="messageReBtn" class="btn btn-sm btn-info">보내기</button></td>
						</tr>
						<tr>
							
							<td width="80%">받는사람 : <label id="receiverLabel"></label></td>
						</tr>
						<tr>
							<td colspan="3"><textarea rows="10" cols="75" id="messageReContent"></textarea></td>
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
			<div class="col-md-12 topMenu">
				<a href="#" class="fh5co-menu-btn js-fh5co-menu-btn">Menu <i
					class="icon-menu"></i></a> <a class="navbar-brand home-brand" href="index.jsp">ShareAbility</a>
			</div>
			
			<div id="linkGroup">
				
				<c:if test="${member ne null}">
					<a href="logout.do">로그아웃</a>&nbsp;&nbsp;
					<a href='boardForm.do' id="boardForm">판매등록</a>&nbsp;&nbsp;
					<a href='#' id="toggler">알림 <span class="badge" id="togglerNum"></span>
				</c:if>
				<c:if test="${member eq null }">
					<a href="testLogin.do" id="testLogin">테스트로그인</a>&nbsp;&nbsp;
					<a href='loginForm.do'>로그인</a>&nbsp;&nbsp;
					<a href='boardForm.do' id="boardForm">판매등록</a>
				</c:if>
			</div>
		</div>
		<div class="row">
			<form id="searchForm" action="search.do" method="post">
				<select id="searchSelect" name="major" id="categoryForSearch" >
					  <option value="1">닉네임</option>
					  <option value="0">카테고리 전체</option>
					  <option value="100">디자인/그래픽</option>
					  <option value="200">마케팅/광고</option>
					  <option value="300">문서/서식</option>
					  <option value="400">컴퓨터/개발</option>
					  <option value="500">음악/영상</option>
					  <option value="600">생활/상담</option>
					  <option value="700">노하우/여행</option>
					  <option value="800">비즈니스/창업</option>
					  <option value="900">번역/외국어</option>
				</select> 
				<input type="text" class="form-control" id="searchInput" name="word" value="${word}">
				<a href="#"><img src="images/search.png" class="searchIcon"></a>
			</form>
		</div>
		<p>
		

		<!-- 		카테고리 메뉴                    -->
		<div class="row">
			<ul class="menu categoryMenu">
				<li><a href="#">디자인/그래픽</a>
					<ul>
						<li><a href="categoryMenu.do?no=101" class="documents">캐리커쳐/인물/캐릭터/아이콘</a></li>
						<li><a href="categoryMenu.do?no=102" class="documents">일러스트/초상화/스케치</a></li>
						<li><a href="categoryMenu.do?no=103" class="documents">PPT
								디자인/인포그래픽/캘리그라피/폰트</a></li>
						<li><a href="categoryMenu.do?no=104" class="documents">만화/웹툰</a></li>
						<li><a href="categoryMenu.do?no=105" class="documents">사진/명함/이미지/포토샵/보정/합성</a></li>
						<li><a href="categoryMenu.do?no=106" class="documents">블로그&카페 디자인/페이지/배경</a></li>
						<li><a href="categoryMenu.do?no=107" class="documents">로고/심볼/마크/앰블럼/배너</a></li>
						<li><a href="categoryMenu.do?no=108" class="documents">현수막/전단/간판/포스터</a></li>
						<li><a href="categoryMenu.do?no=109" class="documents">도면/CAD/인테리어/3D</a></li>
						<li><a href="categoryMenu.do?no=110" class="documents">기타</a></li>
					</ul></li>
				<li><a href="#">마케팅/광고</a>
					<ul>
						<li><a href="categoryMenu.do?no=201" class="documents">블로그/카페/체험단</a></li>
						<li><a href="categoryMenu.do?no=202" class="documents">인스타그램/페이스북/카카오/트위터</a></li>
						<li><a href="categoryMenu.do?no=203" class="documents">일반광고/옥외광고/광고대행</a></li>
						<li><a href="categoryMenu.do?no=204" class="documents">기획/컨설팅/분석/마케팅자료</a></li>
						<li><a href="categoryMenu.do?no=205" class="documents">언론/기사/보도자료</a></li>
						<li><a href="categoryMenu.do?no=206" class="documents">기타</a></li>
					</ul></li>
				<li><a href="#">문서/서식</a>
					<ul>
						<li><a href="categoryMenu.do?no=301" class="documents">워드/타이핑/엑셀/통계</a></li>
						<li><a href="categoryMenu.do?no=302" class="documents">창작/대본/시나리오/카피라이팅</a></li>
						<li><a href="categoryMenu.do?no=303" class="documents">교정/교열/편집</a></li>
						<li><a href="categoryMenu.do?no=304" class="documents">PPT제작/프리젠테이션</a></li>
						<li><a href="categoryMenu.do?no=305" class="documents">글작성/리뷰/서평</a></li>
						<li><a href="categoryMenu.do?no=306" class="documents">문서서식/자료/폼</a></li>
						<li><a href="categoryMenu.do?no=307" class="documents">자기소개서/이력서</a></li>
						<li><a href="categoryMenu.do?no=308" class="documents">사업계획서/제안서</a></li>
						<li><a href="categoryMenu.do?no=309" class="documents">논문 컨설팅/보고서/리서치</a></li>
						<li><a href="categoryMenu.do?no=310" class="documents">기타</a></li>
					</ul></li>
				<li><a href="#">컴퓨터/개발</a>
					<ul>
						<li><a href="categoryMenu.do?no=401" class="documents">홈페이지/웹개발</a></li>
						<li><a href="categoryMenu.do?no=402" class="documents">모바일/Web/App/어플</a></li>
						<li><a href="categoryMenu.do?no=403" class="documents">수리/최적화/PC/서버/견적</a></li>
						<li><a href="categoryMenu.do?no=404" class="documents">프로그래밍/프로그램/소스</a></li>
						<li><a href="categoryMenu.do?no=405" class="documents">플래시/스크립트</a></li>
						<li><a href="categoryMenu.do?no=406" class="documents">기타</a></li>
					</ul></li>
				<li><a href="#">음악/영상</a>
					<ul>
						<li><a href="categoryMenu.do?no=501" class="documents">영상제작/자막제작/편집</a></li>
						<li><a href="categoryMenu.do?no=502" class="documents">작사/작곡/MR/음악편집/녹음</a></li>
						<li><a href="categoryMenu.do?no=503" class="documents">나레이션/성우/목소리</a></li>
						<li><a href="categoryMenu.do?no=504" class="documents">음악레슨/노래/댄스</a></li>
						<li><a href="categoryMenu.do?no=505" class="documents">인디음악/창작음악</a></li>
						<li><a href="categoryMenu.do?no=506" class="documents">기타</a></li>
					</ul></li>
				<li><a href="#">생활/상담</a>
					<ul>
						<li><a href="categoryMenu.do?no=601" class="documents">고민상담/진로상담/취업상담/기타상담</a></li>
						<li><a href="categoryMenu.do?no=602" class="documents">점/운세/사주/토정비결/궁합</a></li>
						<li><a href="categoryMenu.do?no=603" class="documents">개인학습/강습</a></li>
						<li><a href="categoryMenu.do?no=604" class="documents">이벤트/행사도우미/레크레이션</a></li>
						<li><a href="categoryMenu.do?no=605" class="documents">미용/코디/스타일링/모델/피팅/건강</a></li>
						<li><a href="categoryMenu.do?no=606" class="documents">하객대행/역할/MC/사회/연주/축가</a></li>
						<li><a href="categoryMenu.do?no=607" class="documents">심부름/가사도우미/청소/이사</a></li>
						<li><a href="categoryMenu.do?no=608" class="documents">단기알바/부업</a></li>
						<li><a href="categoryMenu.do?no=609" class="documents">구매대행</a></li>
						<li><a href="categoryMenu.do?no=610" class="documents">기타</a></li>
					</ul></li>
				<li><a href="#">노하우/여행</a>
					<ul>
						<li><a href="categoryMenu.do?no=701" class="documents">생활지식/비법/수리/노하우/팁</a></li>
						<li><a href="categoryMenu.do?no=702" class="documents">투자/재테크</a></li>
						<li><a href="categoryMenu.do?no=703" class="documents">자동차/연비/부품부속/튜닝</a></li>
						<li><a href="categoryMenu.do?no=704" class="documents">요리/레시피</a></li>
						<li><a href="categoryMenu.do?no=705" class="documents">국내여행/해외여행</a></li>
						<li><a href="categoryMenu.do?no=706" class="documents">가이드/여행코스/여행지추천</a></li>
						<li><a href="categoryMenu.do?no=707" class="documents">온라인게임</a></li>
						<li><a href="categoryMenu.do?no=708" class="documents">기타</a></li>
					</ul></li>
				<li><a href="#">비즈니스/창업</a>
					<ul>

						<li><a href="categoryMenu.do?no=801" class="documents">사업계획/사업제안</a></li>
						<li><a href="categoryMenu.do?no=802" class="documents">법인설립/사업자등록/통신판매</a></li>
						<li><a href="categoryMenu.do?no=803" class="documents">리서치/컨설팅</a></li>
						<li><a href="categoryMenu.do?no=804" class="documents">투자/금융/경매</a></li>
						<li><a href="categoryMenu.do?no=805" class="documents">법무/인사/노동법/세무/회계</a></li>
						<li><a href="categoryMenu.do?no=806" class="documents">창업상담/비즈니스 모델진단</a></li>
						<li><a href="categoryMenu.do?no=807" class="documents">창업정보/창업자료/창업노하우</a></li>
						<li><a href="categoryMenu.do?no=808" class="documents">기타</a></li>

					</ul></li>
				<li><a href="#">번역/외국어</a>
					<ul style="left:-100px;">
						<li><a href="categoryMenu.do?no=901" class="documents">영어</a></li>
						<li><a href="categoryMenu.do?no=902" class="documents">일본어</a></li>
						<li><a href="categoryMenu.do?no=903" class="documents">중국어</a></li>
						<li><a href="categoryMenu.do?no=904" class="documents">러시아어</a></li>
						<li><a href="categoryMenu.do?no=905" class="documents">프랑스어</a></li>
						<li><a href="categoryMenu.do?no=906" class="documents">스페인어</a></li>
						<li><a href="categoryMenu.do?no=907" class="documents">독일어</a></li>
						<li><a href="categoryMenu.do?no=908" class="documents">기타</a></li>
					</ul></li>
			</ul>
		</div>

	</div>
	

	
	</header>
	<!-- END .header -->
	<div class="fh5co-spacer fh5co-spacer-lg"></div>
<div class="fh5co-spacer fh5co-spacer-sm"></div>


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
<div id="ChtMain">
	
	<div id="iframeDiv" class="iframeDiv">
		<iframe id="iframeMain" height="500" width="300" name="iframe_a" scrolling="no">
		</iframe><br>
		<a href="http://ykson8300.cafe24app.com/?nickname=${member.nickname}&admin=${member.admin}" target="iframe_a"class="btn-sm btn-primary">입장</a>
		<a id="chtClose" href="#" class="btn-sm btn-danger">닫기</a>
	</div>
	</div>

<a id="chtIcon" href="#iframeDiv"><img src="images/s.png"></a>

</body>
</html>