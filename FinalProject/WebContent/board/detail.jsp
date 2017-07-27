<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../menu.jsp" %>

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
.quantityBox td{
width: 20px;
text-align: center;
}
.quantityBox input{
height: 26px;
}
.quantityBox a {
text-decoration: none;
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
		data : {board_no:$('#boardNo').val()},
		dataType: "json",
		success : function(data){
			alert("성공");
			
        	var map = new naver.maps.Map('map', {
        	    center: new naver.maps.LatLng(data.lat, data.lng),
        	    zoom: 10
        	});
        	
        	var marker = new naver.maps.Marker({
        	    position: new naver.maps.LatLng(data.lat, data.lng),
        	    map: map
        	});
			
        	//infowindow에 들어갈 내용
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

        	
        	var infowindow = new naver.maps.InfoWindow({
        	    content: a
        	});
        	
        	infowindow.open(map, marker);
			
		},//success 끝
		error : function(){
			$('#map').append('<h5>전지역 가능</h5>');
      	}//error 끝
	});//ajax끝
	
	
	//글수정 가기 전에 state확인
	$('#modify').on('click', function(){
		var state = $('#modify').val();
		if(state == 0){
			location.href = "updateBoardForm.do?no="+$('#boardNo').val();
		}else{
			alert("거래 진행 후에는 글을 수정할 수 없습니다");
		}
	});//글수정 state확인 끝
	
	$('#img')//상세정보 tab안에 사진 넣기
	
	
	
	//옵션추가
	$(document).on('change', '#optionList', function(){
		console.log($(this).val());
		$.ajax({
			url : 'searchOption.do',
			type: 'post',
			data : {no : $('#boardNo').val(), kind : $(this).val()},
			dataType : 'json',
			success : function(data){
				alert(data.kind);
				
				//table에 넣기
				$('#purchaseList').append(
						
						
					'<tr>'+
					'<td>'+ data.kind +'</td>'+ 
					'<td>'+ data.price +'</td>'+
					'<td>'+ 
						'<table class="quantityBox" border="1" cellspacing="0">'+
						'<tr>'+
							'<td width="20%"><a href="#" class="minus">-</a></td>'+
							'<td width="40%"><input type="text" size="1" class="quantity" value=1>'+
							'<input type="hidden" value="'+data.price+'" class="hiddenPrice" ></td>'+
							'<td width="20%"><a href="#" class="plus">+</a></td>'+
						'</tr>'+
						'</table>'+
					'</td>'+
					'<td><div class="optionResult">'+data.price+'</div></td>'+
					'<td><button class="optionDelete">x</button></td>'+
					'</tr>'
				)
				$('#totalPrice').text(totalPrice());
			},
		})//ajax 끝
	})//옵션추가하면 밑에 테이블에 띄우기
	
	
	//추가한 옵션 삭제하기
	$(document).on('click', '.optionDelete', function(){
		$(this).parent().parent().remove();
		$('#totalPrice').text(totalPrice());
	})//추가한 옵션 삭제하기
	
	
	//클릭해서 구매 수량 변하게!
	$(document).on('click', '.minus', function(){
		var q = parseInt($(this).parent().parent().find('.quantity').val())-1;
		$(this).parent().parent().find('.quantity').val(q);
		var hiddenPrice = parseInt($(this).parent().parent().find('.hiddenPrice').val());
		console.log(hiddenPrice);
		$(this).parent().parent().parent().parent().parent().parent().find('.optionResult').text(hiddenPrice * q);
		$('#totalPrice').text(totalPrice());
	});//마이너스 클릭하면 줄어들고
	$(document).on('click', '.plus', function(){
		var q = parseInt($(this).parent().parent().find('.quantity').val())+1;
		$(this).parent().parent().find('.quantity').val(q);
		var hiddenPrice = parseInt($(this).parent().parent().find('.hiddenPrice').val());
		console.log(hiddenPrice);
		$(this).parent().parent().parent().parent().parent().parent().find('.optionResult').text(hiddenPrice * q);
		$('#totalPrice').text(totalPrice());
	});//플러스 클릭하면 늘어나고
	
	
	$(document).on('click', '#dips', function(){
		$.ajax({
			url : "dips.do",
			type : "post",
			data : $('#boardNo'),
			dateType : "text",
			success : function(data){
				alert(data);
			},
			error : function(){
				alert("실패");
			}
		})
	});//찜하기
	
	
	

	
})
</script>
<script type="text/javascript">
function totalPrice(){
	var result=0;
	$('.optionResult').each(function(){
		result += parseInt($(this).text());
		
	});
	
	return result;
}

</script>


<body>
	<div id="fh5co-main">
		<div class="container">
			<div class="row">

				<div class="col-md-offset-2">

					<div id="fh5co-board" data-columns>
						<div class="item deal-position">
							<div class="animate-box">
								<a href="images/img_1.jpg" class="image-popup fh5co-board-img">
									<img src="<c:url value="/user/board/${board.no}"/>/${files.file_name1}" alt="Free HTML5 Bootstrap template"	style="width: 573px; height: 500px;">
									</a>
							</div>
							<div class="fh5co-desc">${board.title}</div>
						</div>

						<div class="item deal-info">
							
							판매자 닉네임 : <a href="profile.do?id=${board.writer}" id="writer" style="display: inline-block;">${board.writer}</a>
							<input type="hidden" value="${board.no}" name="no" id="boardNo">
							<button id="modify" value="${board.state}">글수정</button><br>
							등록일 : ${board.date}<br>
							마감일 : ${board.end_date}<br>
							인원 또는 건수 : ${board.quantity}<br>

							<table>
								<tr>
									<th>기본항목</th><td>${board.price}</td>
								</tr>
								<c:if test="${board_option ne null}">
									<tr>
										<th>옵션항목</th>
										<td>
											<select id="optionList">
												<option>옵션없음</option>
												<c:forEach var="i" items="${board_option}">
													<option value="${i.kind}">${i.kind} (+${i.price})</option>
												</c:forEach>
											</select>
										</td>									
									</tr>
								</c:if>
							</table>
							<table id="purchaseList">
							<tr>
							<td> 기본항목 </td>
							<td> ${board.price} </td>
							<td>
								<table class="quantityBox" border="1" cellspacing="0">
									<tr>
										<td width="20%"><a href="#" class="minus">-</a></td>
										<td width="40%"><input type="text" size="1" class="quantity" value=1>
										<input type="hidden" value="${board.price}" class="hiddenPrice" ></td>
										<td width="20%"><a href="#" class="plus">+</a></td>
									</tr>
								</table>
							</td>
							<td><div class="optionResult">${board.price}</div></td>
							<td></td>
							</tr>
							</table>
							<br>
							<div id="totalPrice">${board.price }</div>
							<p><button>구매하기</button>
							<button id="dips">찜하기</button>
							<button>쪽지문의</button></p>
							장소<br>
							<div id="map" style="width::250px;height:250px;"></div>
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
						    <div>${board.content}</div>
						    <div id="img"></div>
						  </div>
						  <div id="tabs-2">
						    <p>주문시 유의사항 내용</p>
						  </div>
						  <div id="tabs-3">
						    <p>사용자 리뷰</p>
						    <p>사용자 리뷰</p>
						  </div>
						</div>
						
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>