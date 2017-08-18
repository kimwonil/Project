<%@page import="model.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../menu.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="css/starStyle.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript"
	src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=A5owm24oXM2NprihulHy&submodules=geocoder"></script>
</head>
<style>
#miniProfile {
	background-color: lightgray;
	border-radius: 10px;
	position: absolute;
/*  	text-align: right; */
	width: 300px;
	top:20%;
	left:0%;
}

.miniImg {
	width: 100px;
	height: 100px;
	position: absolute;
	z-index: 4;
	left: 47%;
	top: 0%;
}

#imgSpace {
	height: 50px;
}

.btn {
	margin: 10px 0px 20px 0px;
}

#miniProfile div {
	display: inline;
}
#positionTD{
	vertical-align: top;
}

#infoTD{
	vertical-align: top;
	width: 380px;
}

#optionsTable{
	width: 100%;
}

#purchaseList{
	width: 100%
}





.deal-info{
padding: 15px;
}

.quantityBox td {
	width: 20px;
	text-align: center;
}

.quantityBox input {
	height: 26px;
}

.quantityBox a {
	text-decoration: none;
}

.thumbnail {
	width: 100%;
	height: 500px;
	margin: 0px auto;
}

#fh5co-board .item .fh5co-desc {
	padding: 0px;
}

h5 {
	text-align: center;
}

#test{
margin-left: auto;
margin-right: auto;
}
#evaluator{
	padding-left: 40px;
}

#selectUserReview table{
width: 100%;
}

.smaller{
font-size: smaller;
}
#notice {
font-size: small; 
}
#selectUserReview .star-ratings-css{
font-size: 16px;
}
.deal-info table{
	width: 100%;
}
.quantity{
	width: 100%;
}
.kind, .price{
	text-align: center;
}
#totalPrice{
	display: block;
	margin-top: 20px;
}
#introduce{
	resize:none;
}
</style>

<script>
	var a = true;
	var b = true;
	$(function() {
		$("#tabs").tabs();
	});




	function selectUserReview() {
		$.ajax({
			url : "selectUserReview.do",
			type : "post",
			data : $('#boardNo'),
			dataType : "json",
			success : function(data) {
				$('#selectUserReview').empty();
				$.each(data, function(index, value) {
					console.log(value);
					//사용자 리뷰 탭에 table만들어서 넣을거야
					$('#selectUserReview').append(
						'<table>' +
						'<tr class="smaller"><td>' + value.nickname + '</td><td>' +
						'<div class="star-ratings-css">' +
						'<div class="star-ratings-css-top" style="width:' + value.star * 16 + '%"><span>★</span><span>★</span><span>★</span><span>★</span><span>★</span></div>' +
						'<div class="star-ratings-css-bottom"><span>★</span><span>★</span><span>★</span><span>★</span><span>★</span></div>' +
						'</div>' +
						'<td>' + value.date + '</td>' +
						'</td></tr>' +
						'<tr><td colspan="3">' + value.content + '</td></tr>' +
						'</table>'
					// '<h5>사용자 리뷰리뷰리뷰</h5>'
					);
					
				});
			},
			error : function() {
				alert("실패");
			}
		}); //ajax 끝
	}
	
	
	function notice(){
		$('#notice').empty();
		$('#notice').append(
			'<table boarder="1">'+
			'<tr><td>'+
			'· 판매자의 설명과 옵션을 다시 한번 확인하시기 바랍니다.<br>'+
			'· 판매자가 직거래를 요구하는 경우, 즉시 고객센터로 신고해 주십시오.<br>'+
			'· 본 사이트의 결제시스템을 이용하지 않고 판매자와 직거래를 하는 경우,<br> &nbsp 문제발생 시 아무런 도움을 드릴 수 없습니다.<br>'+
			'· 직거래로 인한 피해발생시 ShareAbility는 이에 대한 일체의 책임을 지지 않습니다.<br>'+
			'· 구매한 공유가 설명과 다르거나 판매자와 연락이 되지 않는 경우,<br> &nbsp 고객센터로 연락 주시기 바랍니다.<br>'+
			'</td></tr>'+
			'<table>'
		);
	}
</script>

<script type="text/javascript">
	$(document).ready(function() {

		//지도 넣기
		$.ajax({
			url : "selectOneMap.do",
			type : "post",
			data : {
				board_no : $('#boardNo').val()
			},
			dataType : "json",
			success : function(data) {
				alert("성공");

				var map = new naver.maps.Map('map', {
					center : new naver.maps.LatLng(data.lat, data.lng),
					zoom : 10
				});

				var marker = new naver.maps.Marker({
					position : new naver.maps.LatLng(data.lat, data.lng),
					map : map
				});

				//infowindow에 들어갈 내용
				var a = "";
				a += '<div class="iw_inner" >';
				if (data.title != "undefined") {
					a += '<h5>' + data.title + '</h5>';
				}
				a += '<h6>' + data.address + '</h6>';
				if (data.address2 != null) {
					a += '<h6>' + data.address2 + '</h6>';
				}
				a += '</div>';

				var infowindow = new naver.maps.InfoWindow({
					content : a
				});

				infowindow.open(map, marker);
				$('#map').css("display","block");
			}, //success 끝
			error : function() {
				$('#map').css("display","none");
				$('#allRound').append('<h5>전지역 가능</h5>');
			} //error 끝
		}); //ajax끝



		//상세 내용에 img삽입
		$.ajax({
			url : "detailImg.do",
			type : "post",
			data : {
				no : $('#boardNo').val()
			},
			dataType : "json",
			success : function(data) {
				console.log(data);
				if (data.file_name2 != '') {
					$('#img').append('<img src="" id="file_name2">');
					$('#file_name2').attr('src', "<c:url value='/user/board/" + data.no + "'/>/" + data.file_name2);
				}
				if (data.file_name3 != '') {
					$('#img').append('<img src="" id="file_name3">');
					$('#file_name3').attr('src', "<c:url value='/user/board/" + data.no + "'/>/" + data.file_name3);
				}
				if (data.file_name4 != '') {
					$('#img').append('<img src="" id="file_name4">');
					$('#file_name4').attr('src', "<c:url value='/user/board/" + data.no + "'/>/" + data.file_name4);
				}
			},
			error : function() {
				alert("file 가져오기 실패");
			}
		}); //상세내용 탭에 img 넣기 끝



		//사용자리뷰 탭 내용 뿌리기(star_point)
		$(document).on('click', '#selectUserReviewBTN', function() {
			selectUserReview();
		})
		
		$(document).on('click', '#noticeBTN', function() {
			notice();
		})


		//판매자 아이디 마우스 오버 했을때 정보 보여주는부분
		$(document).on('mouseover', '#writerProfile', function() {
			a = true;
	

			function mouseX(event) {
				x = event.pageX;
				return x;
			}
			function mouseY(event) {
				Y = event.pageY;
				return Y;
			}
			x = mouseX(event);
			y = mouseY(event);

			$.ajax({
				url : "getWriterInfo.do",
				type : "post",
				data : {
					nickname : $('#writerProfile').text()
				},
				dataType : "json",
				success : function(data) {
					console.log(data);
					$('#star').css('width', data.star*20+'%');
					$('#writerNick').text(data.nickname);
					$('#introduce').val(data.introduce);
					$('#End').text(data.count);
					$('#circleImg').attr('src', "<c:url value='/user/profile/" + data.id + "/"+data.login+"'/>/" + data.photo);
			
				},
				error : function() {
					alert("file 가져오기 실패");
				}
			});
			$('#writerMini').css("position",'absolute');
			$('#writerMini').css("left",x - 200);
			$('#writerMini').css("top",y -100);
			$('#writerMini').css("width",300);
			$('#writerMini').css("height",270);

			$('#writerMini').css("display", "block");
			

			
		})
		//판매자 아이디 마우스 아웃했을때 안보이게하는 부분
		$(document).on('mouseleave', '#writerMini', function() {
			a = false;
// 			alert(a);
			$('#writerMini').css("display", "none");
		})

		
// $('#writerMini').css("display", "none");

		//글수정 가기 전에 state확인
		$('#modify').on('click', function() {
			var state = $('#modify').val();
			if (state == 0) {
				location.href = "updateBoardForm.do?no=" + $('#boardNo').val();
			} else {
				alert("거래 진행 후에는 글을 수정할 수 없습니다");
			}
		}); //글수정 state확인 끝

		$('#img') //상세정보 tab안에 사진 넣기

		
		function optionReset(){
			console.log("옵션 리셋");
			$('#optionList option:eq(0)').attr("selected", "selected");
		}

		var optionArr = new Array();
		//옵션추가
		$(document).on('change', '#optionList', function() {
			
			console.log($(this).val());
			$.ajax({
				url : 'searchOption.do',
				type : 'post',
				data : {
					no : $('#boardNo').val(),
					kind : $(this).val()
				},
				dataType : 'json',
				success : function(data) {
					
					var duplicate = optionArr.some(function(item, index, array){
						return !!~item.search(data.kind);
					});
					
					if(!duplicate){
						optionArr.push(data.kind);
						
						var nf = Intl.NumberFormat();
						var dataPrice = data.price;
						
						//table에 넣기
						$('#purchaseList').append(
							'<tr>' +
							'<td name="kind[]" class="kind"  style="width:345px;">' + data.kind + '</td>' +
							'<td name="price[]" class="price"  style="width:88px;">' + nf.format(dataPrice) + '</td>' +
							'<td style="width:56px;">' +
							'<input type="number" min="1" max="99" value="1" class="quantity" name="quantity[]">'+
							'<input type="hidden" value="${board.price}" class="hiddenPrice">'+
							'</td>' +
							'<td align="center"  style="width:88px;"><span class="optionResult">' + nf.format(dataPrice) + '</span>'+
							'<input type="hidden" class="hiddenOptionResult" value="'+data.price+'"></td>' +
							'<td  style="width:40px;"><button class="optionDelete">x</button></td>' +
							'</tr>'
						)
						totalPrice();
						
					}else{
						alert("옵션 중복입니다.");
					}
					
				},
				
				complete:function(){
					optionReset();
				}
			}); //ajax 끝
		}); //옵션추가하면 밑에 테이블에 띄우기


		//추가한 옵션 삭제하기
		$(document).on('click', '.optionDelete', function() {
			var optionName = $(this).parent().parent().find('.kind').text();
			var num = optionArr.indexOf(optionName);
			optionArr.splice(num, 1); 
			$(this).parent().parent().remove();
			totalPrice();
		}) //추가한 옵션 삭제하기


		//클릭해서 구매 수량 변하게!
		var nf = Intl.NumberFormat();
		
		$(document).on('click', '.quantity', function() {
			//수량 조절 박스의 quantity 바꿔주기
			var q = $(this).val();//원래있던 수량을 잡아서
			
			//각 옵션의 optionResult 바꿔주기
			var hiddenPrice = parseInt($(this).next().val());//hiddenPrice값을 가져와서
			var price = hiddenPrice*q;//구매수량 곱해주고
			$(this).parent().parent().find('.hiddenOptionResult').val(price);//hiddenOptionPrice에 변환전 숫자 넣고
			$(this).parent().parent().find('.optionResult').text(nf.format(price)); //변환 후 숫자 넣고
		
			totalPrice();//totalPrice 바꾸기
		}); //마이너스 클릭하면 줄어들고

		//찜하기
		$(document).on('click', '#dips', function() {
			$.ajax({
				url : "dips.do",
				type : "post",
				data : {board_no : $('#boardNo').val()},
				dateType : "json",
				success : function(data) {
					alert(data);
				},
				error : function(jpXHR, textStatus, errorThrown){
	                  alert(textStatus);
	                  alert(errorThrown);
	            }
			})
		}); //찜하기


		//구매버튼클릭
		$(document).on('click', '#buy', function() {

			var kind = [];
			$('.kind').each(function() {
				kind.push($(this).text());
			})
			console.log(kind);

			var price = [];
			$('.hiddenPrice').each(function() {
				price.push($(this).val());
			})
			console.log(price);

			var quantity = [];
			$('.quantity').each(function() {
				quantity.push($(this).val());
			})
			console.log(quantity);
			console.log("확인");
			jQuery.ajaxSettings.traditional = true;

			$.ajax({
				url : "thisIsAllMine.do",
				type : "post",
				data : {
					kind : kind,
					price : price,
					quantity : quantity,
					no : $('#boardNo').val(),
					totalPrice : $('#hiddenTotalPrice').val()				
				},
				dataType : "json",
				success : function(data) {
					alert(data.result);
					if (data.state == 1) {
						location.href = "purchasing.jsp";
					}
				},
				error : function(jpXHR, textStatus, errorThrown) {
					alert(textStatus);
					alert(errorThrown);
				}
			})
		});

		//쪽지문의 모달 띄우기
		$(document).on('click', '#msgModal', function() {
			$('#myModal').modal();
		});

		$(document).on('click', '#messageSend', function() {
			if ($('#messageTitle').val() == "") {
				alert("제목을 입력하세요")
			} else if ($('#messageContent').val() == "") {
				alert("내용을 입력하세요")
			} else {

				$.ajax({
					url : "messageSend.do",
					type : "post",
					data : {
						title : $('#messageTitle').val(),
						content : $('#messageContent').val(),
						receiver : $('#receiver').text()
					},
					success : function() {
						alert("성공");
						$('#myModal').modal('hide');
						$('#messageTitle').val("");
						$('#messageContent').val("");
					},
					error : function(jqXHR, textStatus, errorThrown) {
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
		var nf = Intl.NumberFormat();
		var result = 0;
		$('.hiddenOptionResult').each(function(){
			result += parseInt($(this).val());
		});
		$('#hiddenTotalPrice').val(result);
		$('#totalPrice').text("총액 : "+nf.format(result)+"원");
	}
</script>


<body>

	<div id="fh5co-main">
		<div class="container">
			<div class="row">

				<div id="fh5co-board" data-columns>
				<table id="test" width="1000px">
						<tr>
							<td id="positionTD">

								<div class="item deal-position">
									<div class="animate-box">
										<c:choose>
											<c:when test="${board.file_name1 eq ''}">
												<img class="thumbnail"
													src='<c:url value="/images"/>/noimage.jpg'>
											</c:when>
											<c:when test="${board.file_name1 eq null}">
												<img class="thumbnail"
													src='<c:url value="/images"/>/noimage.jpg'>
											</c:when>
											<c:otherwise>
												<img class="thumbnail"
													src='<c:url value="/user/board/${board.no}"/>/${board.file_name1}'>
											</c:otherwise>
										</c:choose>
									</div>

									<table>
										<tr>
											<td colspan="3" style="padding: 10px;">${board.title}</td>
										</tr>
										<tr>
											<td width="70%" style="padding: 10px;">${category_major}<br>
												${category_minor}
											</td>
											<td width="15%">
												<div class="star-ratings-css">

													<div class="star-ratings-css-top" id="starPercent"
														style="width:${board.ratingForDetail}%">
														<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
													</div>
													<div class="star-ratings-css-bottom">
														<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
													</div>
												</div>
											</td>
											<td width="15%"><div id="evaluator">(${board.num_evaluator})</div></td>
										</tr>
									</table>
								</div>

							</td>
							<td rowspan="2" id="infoTD">

								<div class="item deal-info">

									<table>
										<tr>
											<td>판매자</td>
											<td><a href="" id="writerProfile"
												style="display: inline-block;">${board.writer}</a><input
												type="hidden" value="${board.no}" name="no" id="boardNo"></td>
										</tr>
										<tr>
											<td colspan="2"><c:choose>
													<c:when test="${member.admin eq 1}">
														<button class="btn btn-sm btn-primary" id="modify"
															value="${board.state}">글수정</button>
														<button class="btn btn-sm btn-primary"
															onclick="location.href='deleteBoard.do?no=${board.no}'">글삭제</button>
													</c:when>
													<c:when test="${member.nickname eq board.writer && show}">
														<button class="btn btn-sm btn-primary" id="modify"
															value="${board.state}">글수정</button>
														<button class="btn btn-sm btn-primary"
															onclick="location.href='deleteBoard.do?no=${board.no}'">글삭제</button>
													</c:when>
												</c:choose></td>
										</tr>
										<tr>
											<td>등록일</td>
											<td>${board.date}</td>
										</tr>
										<tr>
											<td>마감일</td>
											<td>${board.end_date}</td>
										</tr>
										<tr>
											<td>조회수</td>
											<td>${board.read_count}</td>
										</tr>
										<tr>
											<td>인원 & 건수</td>
											<td>${board.count}/${board.quantity}</td>
										</tr>

										<tr>
											<td colspan="2">장소<br>
												<div id="allRound"></div>
												<div id="map"
													style="width: :250px; height: 250px; z-index: 0;"></div>
											</td>
										</tr>
									</table>
									<!-- 						                     -->
								</div>
							</td>
						</tr>
						<tr>
							<td>
						
						<tr>
						<td>
						<div class="item deal-options">
						<table id="optionsTable">
						<tr>
							<td colspan="2">
								<table>
									<tr>
										<th>기본항목</th>
										<td>&nbsp;&nbsp;&nbsp;&nbsp;<fmt:formatNumber value="${board.price}"
												groupingUsed="true" />원</td>
									</tr>
									<c:if test="${board_option ne null}">
										<tr>
											<th>옵션항목</th>
											<td>&nbsp;&nbsp;&nbsp;&nbsp;<select id="optionList">
													<option>옵션없음</option>
													<c:forEach var="i" items="${board_option}">
														<option value="${i.kind}">${i.kind}(+${i.price})</option>
													</c:forEach>
											</select></td>
										</tr>
									</c:if>
								</table>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<form action="thisIsAllMine.do" method="post">
									<table id="purchaseList" align="center">
										<tr>
											<td class="kind" style="width:345px;">기본항목</td>
											<td class="price" style="width:88px;"><fmt:formatNumber
													value="${board.price}" groupingUsed="true" /></td>
											<td  style="width:56px;">
												<input type="number" min="1" max="99" value="1" class="quantity" name="quantity[]">
												<input type="hidden" value="${board.price}" class="hiddenPrice">
											</td>
											<td align="center"  style="width:88px;"><span
												class="optionResult"><fmt:formatNumber
														value="${board.price}" groupingUsed="true" /></span> <input
												type="hidden" class="hiddenOptionResult"
												value="${board.price}"></td>
											<td  style="width:40px;"></td>
										</tr>
									</table>
								</form>
							</td>
						</tr>
						<tr>
							<td colspan="2" align="right"><span id="totalPrice">총액
									: <fmt:formatNumber value="${board.price}" groupingUsed="true" />원
							</span> <input type="hidden" id="hiddenTotalPrice"
								value="${board.price}"></td>
						</tr>
						<tr>
							<td colspan="2" align="center"><c:if test="${board.state eq 0 }">
									<button class="btn btn-sm btn-primary" id="buy">구매하기</button>
									<button class="btn btn-sm btn-primary" id="dips">찜하기</button>
								</c:if>
								<button class="btn btn-sm btn-primary" id="msgModal">쪽지문의</button>
							</td>
						</tr>
						</table>
						</div>
						</td>
					<td></td>
				</tr>
				<tr><td  id="detailTD">
				
				<div class="item deal-detail">
					<div id="tabs">
						<ul>
							<li><a href="#tabs-1">상세정보</a></li>
							<li><a href="#tabs-2" id="noticeBTN">주문시 유의사항</a></li>
							<li><a href="#tabs-3" id="selectUserReviewBTN">사용자 리뷰</a></li>
						</ul>
						<div id="tabs-1">
							<div>${board.content}</div>
							<div id="img"></div>
						</div>
						<div id="tabs-2">
							<div id="notice"></div>
						</div>
						<div id="tabs-3">
							<div id="selectUserReview"></div>
						</div>
					</div>
				</div>
				
				</td></tr>
				</table>

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
							<td width="80%">제&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목
								: <input type="text" class="messageInput" id="messageTitle">
							</td>
							<td width="20%" rowspan="2" align="center"><button
									type="button" id="messageSend" class="btn btn-sm btn-info">보내기</button></td>
						</tr>
						<tr>

							<td width="80%">받는사람 :
								<div id="receiver" style="display: inline;">${board.writer}</div>
							</td>
						</tr>
						<tr>
							<td colspan="3"><textarea rows="10" cols="78"
									id="messageContent"></textarea></td>
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


	<div id="writerMini" style="display: none;">
		<img id="circleImg" src="" class="img-circle miniImg">

			<table id="miniProfile">
					<tr>
						<td id="imgSpace" colspan="2"></td>
					</tr>

					<tr>
						<td>아이디 : </td>
						<td><span id="writerNick"></span></td>
					</tr>
					<tr>
						<td>별점 :</td>
						<td>						
							<div class="star-ratings-css">
								<div class="star-ratings-css-top" id="star">
									<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
								</div>
								<div class="star-ratings-css-bottom">
									<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td>완료된 작업수 :</td>
						<td><label id="End"></label></td>
					</tr>
					<tr>
					<td colspan="2">소개글 :</td>
					</tr>
					<tr>
						<td colspan="2">
							<textarea id="introduce" rows="5" cols="50" disabled="disabled"></textarea>
						</td>
					</tr>
					<tr>
						<td colspan="2" align="center">
						<a class="btn btn-sm btn-danger" href='search.do?major=2&word=${board.writer}' >판매자의 다른 글 보기</a>
						</td>
					</tr>
			</table>
		
	</div>


</body>
</html>








