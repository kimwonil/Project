<%@page import="model.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../menu.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="css/starStyle.css">
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
.thumbnail{
width : 573px;
height : 500px;
}
</style>

<script>
  $( function() {
    $( "#tabs" ).tabs();
  } );
  
  function selectUserReview(){
	  $.ajax({
		  url : "selectUserReview.do",
		  type : "post",
		  data : $('#boardNo'),
		  dataType : "json",
		  success : function(data){
			  $.each(data, function(index, value){
				  console.log(value.content);
				  //사용자 리뷰 탭에 table만들어서 넣을거야
				  $('#selectUserReview').append(
						  '<table border="1" width="80%">'+
					    	'<tr><td>'+value.nickname+'</td><td>'+
					    	'<div class="star-ratings-css">'+
					    	  '<div class="star-ratings-css-top" style="width:'+value.star*25+'%"><span>★</span><span>★</span><span>★</span><span>★</span><span>★</span></div>'+
					    	  '<div class="star-ratings-css-bottom"><span>★</span><span>★</span><span>★</span><span>★</span><span>★</span></div>'+
					    	'</div>'+
					    	'<td>'+value.date+'</td>'+
					    	'</td></tr>'+
					    	'<tr><td colspan="3">'+value.content+'</td></tr>'+
					    	'</table>'
// '<h5>사용자 리뷰리뷰리뷰</h5>'
				  );
			  });
		  },error : function(){
			  alert("실패");
		  }
	  });//ajax 끝
	  
  }
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
	
	
	//사용자리뷰 탭 내용 뿌리기(star_point)
	$(document).on('click', '#selectUserReviewBTN', function(){
		selectUserReview();
	})
	
	
	
	
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
					'<td name="kind[]" class="kind">'+ data.kind +'</td>'+ 
					'<td name="price[]" class="price">'+ data.price +'</td>'+
					'<td>'+ 
						'<table class="quantityBox" border="1" cellspacing="0">'+
						'<tr>'+
							'<td width="20%"><a href="#" class="minus">-</a></td>'+
							'<td width="40%"><input type="text" size="1" name="quantity[]" class="quantity" value=1>'+
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
	
	
	//찜하기
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
	
	
	//구매버튼클릭
	$(document).on('click', '#buy', function(){
		
		var kind = [];
		$('.kind').each(function(){
			kind.push($(this).text());
		})
		console.log(kind);
		
		var price = [];
		$('.price').each(function(){
			price.push($(this).text());
		})
		console.log(price);
		
		var quantity = [];
		$('.quantity').each(function(){
			quantity.push($(this).val());
		})
		console.log(quantity);
		jQuery.ajaxSettings.traditional = true;
		
		$.ajax({
			url : "thisIsAllMine.do",
			type : "post",
			data : {
				kind : kind,
				price : price,
				quantity : quantity,
				no : $('#boardNo').val(),
				totalPrice : $('#totalPrice').text()
				},
			dataType : "json",
			success : function(data){
				alert(data.result);
				if(data.state == 1){
					location.href="purchasing.jsp";
				}
			},error : function(jpXHR, textStatus, errorThrown){
                alert(textStatus);
                alert(errorThrown);
            }
		})
	});
	
	//쪽지문의 모달 띄우기
	$(document).on('click', '#msgModal', function(){
		$('#myModal').modal();
	});
	
	$(document).on('click', '#messageSend', function(){
		 if($('#messageTitle').val() == "" ){
			alert("제목을 입력하세요")
		}else if($('#messageContent').val() == ""){
			alert("내용을 입력하세요")
		}else{
		
			$.ajax({
				url : "messageSend.do",
				type : "post",
				data : {
					title : $('#messageTitle').val(),
					content : $('#messageContent').val(),
					receiver : $('#receiver').text()
				},
				success:function(){
					alert("성공");
					$('#myModal').modal('hide'); 
					$('#messageTitle').val("");
					$('#messageContent').val("");
				},
				error:function(jqXHR, textStatus, errorThrown){
					alert("로그인 후에 이용하세요");
					$('#myModal').modal('hide'); 
				}
			})
		}
	});
	
	

	
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
									<c:choose>
										<c:when test="${board.file_name1 eq ''}">
											<img class="thumbnail" src='<c:url value="/user/board/nothumbnail"/>/noimage.jpg' >
										</c:when>
										<c:when test="${board.file_name1 eq null}">
											<img class="thumbnail" src='<c:url value="/user/board/nothumbnail"/>/noimage.jpg' >
										</c:when>
										<c:otherwise >
											<img class="thumbnail" src='<c:url value="/user/board/${board.no}"/>/${board.file_name1}' >
										</c:otherwise>
									</c:choose>
								</a>
							</div>
							
							<table>
							<tr>
								<td><div class="fh5co-desc">${board.title}</div></td>
								<td width="57%">
								<div class="star-ratings-css">
								  
								  <div class="star-ratings-css-top" id="starPercent" style="width:${board.ratingForDetail}%"><span>★</span><span>★</span><span>★</span><span>★</span><span>★</span></div>
								  <div class="star-ratings-css-bottom"><span>★</span><span>★</span><span>★</span><span>★</span><span>★</span></div>
								</div>
								</td>
								<td>(${board.num_evaluator})</td>
							</tr>
							</table>
							
						</div>

						<div class="item deal-info">
							
							판매자 닉네임 : <a href="profile.do?nickname=${board.writer}" id="writer" style="display: inline-block;">${board.writer}</a><br>
							<input type="hidden" value="${board.no}" name="no" id="boardNo">
<%-- 							<c:choose> --%>
<%-- 								<c:when test="${member.admin eq 1}"> --%>
<%-- 									<button id="modify" value="${board.state}">글수정</button> --%>
<%-- 									<button onclick="location.href='deleteBoard.do?no=${board.no}'">글삭제</button><br> --%>
<%-- 								</c:when> --%>
<%-- 								<c:when test="${member.nickname eq board.writer}"> --%>
									<button id="modify" value="${board.state}">글수정</button>
<%-- 								</c:when> --%>
<%-- 							</c:choose> --%>
							등록일 : ${board.date}<br>
							마감일 : ${board.end_date}<br>
							조회수 : ${board.read_count} <br>
							인원 또는 건수 : ${board.count}/${board.quantity}<br>

							<table>
								<tr>
									<th>기본항목</th><td><fmt:formatNumber value="${board.price}" groupingUsed="true"/>원</td>
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
							<form action="thisIsAllMine.do" method="post">
								<table id="purchaseList">
								<tr>
								<td name="kind[]" class="kind">기본항목</td>
								<td name="price[]" class="price"><fmt:formatNumber value="${board.price}" groupingUsed="true"/>원</td>
								<td>
									<table class="quantityBox" border="1" cellspacing="0">
										<tr>
											<td width="20%"><a href="#" class="minus">-</a></td>
											<td width="40%"><input type="text" size="1" name="quantity[]" class="quantity" value=1>
											<input type="hidden" value="${board.price}" class="hiddenPrice" ></td>
											<input type="hidden" name="no" value="${board.no}">
											<td width="20%"><a href="#" class="plus">+</a></td>
										</tr>
									</table>
								</td>
								<td><div class="optionResult"><fmt:formatNumber value="${board.price}" groupingUsed="true"/>원</div></td>
								<td>
								</td>
								</tr>
								</table>
							</form>
							<br>
							<div id="totalPrice">${board.price }</div>
							<p><button id="buy">구매하기</button>
							<button id="dips">찜하기</button>
							<button id="msgModal">쪽지문의</button></p>
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
						    <li><a href="#tabs-3" id="selectUserReviewBTN">사용자 리뷰</a></li>
						  </ul>
						  <div id="tabs-1">
						    <div>${board.content}</div>
						    <div id="img"></div>
						  </div>
						  <div id="tabs-2">
						    <p>주문시 유의사항 내용</p>
						  </div>
						  <div id="tabs-3">
						    <div id="selectUserReview"></div>
						  </div>
						</div>
						
					</div>
				</div>
			</div>
		</div>
	</div>
	

<!-- Modal -->
<div id="myModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title"></h4>
      </div>
      <div class="modal-body">
		<table id="messageWrite">
			<tr>
				<td width="80%">제&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목 : <input type="text" class="messageInput" id="messageTitle"></td>
				<td width="20%" rowspan="2"  align="center"><button type="button" id="messageSend" class="btn btn-sm btn-info">보내기</button></td>
			</tr>
			<tr>
				
				<td width="80%">받는사람 : <div id="receiver" style="display: inline;;">${board.writer}</div></td>
			</tr>
			<tr>
				<td colspan="3"><textarea rows="10" cols="78" id="messageContent"></textarea></td>
			</tr>
		</table>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>
<!-- modal end -->
</body>
</html>