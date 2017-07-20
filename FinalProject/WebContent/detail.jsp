<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="menu.jsp" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <script type="text/javascript"
	src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=A5owm24oXM2NprihulHy&submodules=geocoder"></script>
</head>
<style>
.deal-info {
	position: absolute;
	right: 20%;
	left: 57%;
	width: 340px;
	height: 564px;
	top:25%;
	padding: 1%;
}

.deal-position {
	position: absolute;
	left: 20%;
	top:25%;
}

.deal-detail {
	position: absolute;
	left: 20%;
	right: 20%;
	top: 100%;
}
</style>

<script>
  $( function() {
    $( "#tabs" ).tabs();
  } );
</script>
<script type="text/javascript">
$(document).ready(function(){
	
	$.ajax({
		url : "selectOneMap.do",
		type : "post",
		data : {board_no:$('#board_no').val()},
		dataType: "json",
		success : function(data){
			alert(data.address);
        	var map = new naver.maps.Map('map', {
        	    center: new naver.maps.LatLng(data.lat, data.lng),
        	    zoom: 10
        	});
        	
        	var marker = new naver.maps.Marker({
        	    position: new naver.maps.LatLng(data.lat, data.lng),
        	    map: map
        	});
			
        	var a="";
        	
        	a +='<div class="iw_inner" >';
        	
     		if(data.title != "undefined"){
     			a += '<h5>'+data.title+'</h5>';
     		}
     		
     		a += '<h6>'+data.address+'</h6>';
     		
            if(data.address2 != null){
            	a += '<h6>'+data.address2+'</h6>';
            }
            a += '</div>';
        	
        	var contentString = [
        		a
            ].join('');
        	
        	var infowindow = new naver.maps.InfoWindow({
        	    content: contentString
        	});
        	
        	infowindow.open(map, marker);
			
		},//success 끝
		error : function(){
			alert("실패");
		
      	}//error 끝
	});//ajax끝
	
	
	
	
	
})
</script>

<body>
	<div id="fh5co-main">
		<div class="container">
			<div class="row">

				<div class="col-md-offset-2">

					<div id="fh5co-board" data-columns>
						<div class="item deal-position">
							<div class="animate-box">
								<a href="images/img_1.jpg" class="image-popup fh5co-board-img"
									title="Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo, eos?">
									<img src="images/img_1.jpg" alt="Free HTML5 Bootstrap template"	style="width: 573px; height: 500px;">
									</a>
							</div>
							<div class="fh5co-desc">${board.title }</div>
						</div>

						<div class="item deal-info">
							판매자 닉네임 : ${board.writer } <button>프로필</button><br>
							글 등록 날짜 : <fmt:formatDate value="${board.date}" pattern="yyyy-MM-dd"/><br>
							마감 일 : ${board.end_date}<br>
							<p>인원 또는 건수 : ${board.limit }</p>
							장소 (지도 api)<br>
							<div id="map" style="width::250px;height:250px;"></div>
							<input type="hidden" value="${board.no}" id="board_no">
							기본가격 : ${board.price }<br>
							옵션추가<br>
							<p>옵션가격 : ${board.optionprice }</p>
							<button>구매하기</button>
							<button>찜하기</button>
							<button>쪽지문의</button>
						</div>

					</div>
				</div>
			</div>
			<div class="row">
				<div id="fh5co-board" data-columns>
					<div class="item deal-detail">
					
						<div id="tabs">
						  <ul>
						    <li><a href="#tabs-1">상세정보</a></li>
						    <li><a href="#tabs-2">주문시 유의사항</a></li>
						    <li><a href="#tabs-3">사용자 리뷰</a></li>
						  </ul>
						  <div id="tabs-1">
						    <p>Proin elit arcu, rutrum commodo, vehicula tempus, commodo a, risus. Curabitur nec arcu. Donec sollicitudin mi sit amet mauris. Nam elementum quam ullamcorper ante. Etiam aliquet massa et lorem. Mauris dapibus lacus auctor risus. Aenean tempor ullamcorper leo. Vivamus sed magna quis ligula eleifend adipiscing. Duis orci. Aliquam sodales tortor vitae ipsum. Aliquam nulla. Duis aliquam molestie erat. Ut et mauris vel pede varius sollicitudin. Sed ut dolor nec orci tincidunt interdum. Phasellus ipsum. Nunc tristique tempus lectus.</p>
						  </div>
						  <div id="tabs-2">
						    <p>Morbi tincidunt, dui sit amet facilisis feugiat, odio metus gravida ante, ut pharetra massa metus id nunc. Duis scelerisque molestie turpis. Sed fringilla, massa eget luctus malesuada, metus eros molestie lectus, ut tempus eros massa ut dolor. Aenean aliquet fringilla sem. Suspendisse sed ligula in ligula suscipit aliquam. Praesent in eros vestibulum mi adipiscing adipiscing. Morbi facilisis. Curabitur ornare consequat nunc. Aenean vel metus. Ut posuere viverra nulla. Aliquam erat volutpat. Pellentesque convallis. Maecenas feugiat, tellus pellentesque pretium posuere, felis lorem euismod felis, eu ornare leo nisi vel felis. Mauris consectetur tortor et purus.</p>
						  </div>
						  <div id="tabs-3">
						    <p>Mauris eleifend est et turpis. Duis id erat. Suspendisse potenti. Aliquam vulputate, pede vel vehicula accumsan, mi neque rutrum erat, eu congue orci lorem eget lorem. Vestibulum non ante. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Fusce sodales. Quisque eu urna vel enim commodo pellentesque. Praesent eu risus hendrerit ligula tempus pretium. Curabitur lorem enim, pretium nec, feugiat nec, luctus a, lacus.</p>
						    <p>Duis cursus. Maecenas ligula eros, blandit nec, pharetra at, semper at, magna. Nullam ac lacus. Nulla facilisi. Praesent viverra justo vitae neque. Praesent blandit adipiscing velit. Suspendisse potenti. Donec mattis, pede vel pharetra blandit, magna ligula faucibus eros, id euismod lacus dolor eget odio. Nam scelerisque. Donec non libero sed nulla mattis commodo. Ut sagittis. Donec nisi lectus, feugiat porttitor, tempor ac, tempor vitae, pede. Aenean vehicula velit eu tellus interdum rutrum. Maecenas commodo. Pellentesque nec elit. Fusce in lacus. Vivamus a libero vitae lectus hendrerit hendrerit.</p>
						  </div>
						</div>
						
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>