<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="menu.jsp"%>
<%@ include file="miniProfile.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
	$(function() {
		$("#tabs").tabs();
	});




	//등록한 재능 글 조회
	function sellingList(page) {
		$.ajax({
			url : "sellingList.do",
			type : "POST",
			data : {
				page : page
			},
			dataType : "json",
			success : function(data) {
				console.log(data);
				$('#tabs-1 > table tr:gt(0)').remove();
				if (data.list == "") {
					$('#tabs-1 > table').append(
						'<tr><td colspan="6">내역이 없습니다.</td></tr>'
					);
				} else {
					$.each(data.list, function(index, value) {
						$('#tabs-1 > table').append(
							'<tr><td><input type="radio" value="' + value.no + '" name="premiumRadio"></td><td>' + value.date + '</td><td>' + value.title + '</td><td>' +
							value.count + ' / ' + value.quantity + '</td><td>' + (value.state == 0 ? "대기중" : value.state == 1 ? "인원마감" : "마감일 초과") + '</td><td>' +
							'<button class="btn-sm btn-info continueBtn" value="' + value.no + '">진행</button> <button class="btn-sm btn-info stopBtn" value="' + value.no + '">중단</button></td></tr>'
						);
					});
					$('#tabs-1 input:radio:eq(0)').attr("checked", "checked");
					$('#currentPage').val(data.page);
					$('.prev').val(data.page == 0 ? 0 : data.page - 8);
					$('.next').val(data.totalPage - 8 > data.page ? data.page + 8 : data.page);
				}

			},
			error : function() {
				alert("실패");
			}
		})
	}

	//진행중 거래 조회
	function ongoingList(page) {
		$.ajax({
			url : "ongoing.do",
			type : "POST",
			data : {
				page : page
			},
			dataType : "json",
			success : function(data) {
				//					alert("성공");
				console.log(data);

				$('#tabs-2 > table tr:gt(0)').remove();
				if (data.list == "") {
					$('#tabs-2 > table').append(
						'<tr><td colspan="6">내역이 없습니다.</td></tr>'
					);
				} else {
					$.each(data.list, function(index, value) {

						var total = 0;

						$.each(value.optionList, function(index2, option) {
							total += option.price * option.amount;
						});

						$('#tabs-2 > table').append(
							'<tr><td>' + value.date + '</td><td>' + value.boardTitle + '</td><td>' +
							value.purchaser + '</td><td><a href="#" class="optionList"><span>' + total + '</span></a><input type="hidden" value="' + value.purchase_no + '"></td><td>진행중</td><td>' +
							'<button class="btn-sm btn-info completeBtn" value="' + value.purchase_no + '">완료</button> <button class="btn-sm btn-info stopBtn" value="' + value.purchase_no + '">취소</button></td></tr>'
						);
					});
					$('#currentPage').val(data.page);
					$('.prev').val(data.page == 0 ? 0 : data.page - 8);
					$('.next').val(data.totalPage - 8 > data.page ? data.page + 8 : data.page);

				}


			},
			error : function() {
				alert("실패");
			}
		});

	}

	//완료된 거래 조회
	function completionList(page) {
		$.ajax({
			url : "completion.do",
			type : "POST",
			data : {
				page : page
			},
			dataType : "json",
			success : function(data) {
				//					alert("성공");
				console.log(data);

				$('#tabs-3 > table tr:gt(0)').remove();
				if (data.list == "") {
					$('#tabs-3 > table').append(
						'<tr><td colspan="6">내역이 없습니다.</td></tr>'
					);
				} else {
					$.each(data.list, function(index, value) {

						var total = 0;

						$.each(value.optionList, function(index2, option) {
							total += option.price * option.amount;
						});

						$('#tabs-3 > table').append(
							'<tr><td>' + value.date + '</td><td>' + value.boardTitle + '</td><td>' +
							value.purchaser + '</td><td><a href="#" class="optionList">' + total + '</a><input type="hidden" value="' + value.purchase_no + '"></td><td>' +
							(value.state == 11 ? "완료 대기" : value.state == 20 ? "정산 대기" : "정산 완료") + '</td><td>' +
							(value.state == 11 ? "" : value.state == 20 ? '<button class="btn-sm btn-info calculateBtn" value="' +
							value.purchase_no + '">정산</button><input type="hidden" value="' + total + '"> ' : "") + '</td></tr>'
						);
					});
					$('#currentPage').val(data.page);
					$('.prev').val(data.page == 0 ? 0 : data.page - 8);
					$('.next').val(data.totalPage - 8 > data.page ? data.page + 8 : data.page);
				}


			},
			error : function() {
				alert("실패");
			}
		});

	}


	//취소된 거래 조회
	function canceledList(page) {
		$.ajax({
			url : "canceledList.do",
			type : "POST",
			data : {
				page : page
			},
			dataType : "json",
			success : function(data) {
				console.log(data);

				$('#tabs-4 > table tr:gt(0)').remove();
				if (data.list == "") {
					$('#tabs-4 > table').append(
						'<tr><td colspan="6">내역이 없습니다.</td></tr>'
					);
				} else {
					$.each(data.list, function(index, value) {

						var total = 0;

						$.each(value.optionList, function(index3, option) {
							total += option.price * option.amount;
						});

						$('#tabs-4 > table').append(
							'<tr><td>' + value.date + '</td><td>' + value.boardTitle + '</td><td>' +
							value.purchaser + '</td><td><a href="#" class="optionList">' + total + '</a><input type="hidden" value="' + value.purchase_no + '"></td><td>' +
							(value.state == 40 ? "구매자 취소" : value.state == 41 ? "취소 대기" : "취소 완료") + '</td><td>' +
							(value.state == 40 ? '<button class="btn-sm btn-info cancellComfirm" value="' + value.purchase_no + '">확인</button> ' : "")
						);
					});
					$('#currentPage').val(data.page);
					$('.prev').val(data.page == 0 ? 0 : data.page - 8);
					$('.next').val(data.totalPage - 8 > data.page ? data.page + 8 : data.page);
				}


			},
			error : function() {
				alert("실패");
			}
		});

	}

	//프리미엄 목록 조회
		function premiumList(page) {
			$.ajax({
				url : "premiumList.do",
				type : "POST",
				data : {
					page : page
				},
				dataType : "json",
				success : function(data) {
					console.log(data);
					$('#tabs-5 > table tr:gt(0)').remove();
					if (data.list == "") {
						$('#tabs-5 > table').append(
							'<tr><td colspan="6">내역이 없습니다.</td></tr>'
						);
					} else {
						console.log(data);
						$.each(data.list, function(index, value) {
							$('#tabs-5 > table').append(
								'<tr><td>' + value.date + '</td><td>' + value.title + '</td><td>' +
								value.time + '일 </td><td>' + value.formatPrice + '</td><td>' +
								(value.state==1?"대기중<br>"+value.start+"부터":value.state==2?"진행중<br>"+value.end+"까지":"종료") + '</td><td>비고</td></tr>'
							);
						});
						$('#currentPage').val(data.page);
						$('.prev').val(data.page == 0 ? 0 : data.page - 5);
						$('.next').val(data.totalPage - 5 > data.page ? data.page + 5 : data.page);
					}

				},
				error : function() {
					alert("실패");
				}
			})
		}



	$(document).ready(function() {

		//최초 화면 리스트 조회
		sellingList(0);


		//등록한 재능글에서 진행 버튼 -> modal
		$(document).on('click', '.continueBtn', function() {
			$.ajax({
				url : "purchaseList.do",
				type : "POST",
				data : {
					no : $(this).val()
				},
				dataType : "json",
				success : function(data) {
					console.log(data);
					$('#purchaseTable tr:gt(0)').remove();
					if (data == "") {
						$('#purchaseTable').append(
							'<tr>' +
							'<td colspan="6">현재 구매자가 없습니다.</td>' +
							'</tr>'
						);
					} else {
						$.each(data, function(index, value) {
							var optionStr = "";
							var optionPrice = "";
							var optionAmount = "";
							var total = 0;

							$.each(value.optionList, function(index, option) {
								optionStr += option.kind + "<br>";
								optionPrice += option.price + "<br>";
								optionAmount += option.amount + "<br>";
								total += option.price * option.amount;
							});

							$('#purchaseTable').append(
								'<tr>' +
								'<td><input type="checkbox" name="purchaseCheck" value="' + value.purchase_no + '"></td>' +
								'<td>' + value.purchaser + '</td>' +
								'<td>' + optionStr + '</td>' +
								'<td>' + optionAmount + '</td>' +
								'<td>' + optionPrice + '</td>' +
								'<td>' + total + '</td>' +
								'</tr>'


							);
						});
					}
				},
				error : function() {
					alert("실패");
				}
			});



			$('#continueModal').modal('show');


		});


		//중단 버튼
		$(document).on('click', '.stopBtn', function() {
			alert($(this).val());
			$.ajax({
				url : "progress.do",
				type : "POST",
				data : {
					no : $(this).val(),
					state : 41
				},
				success : function(data) {
					alert("성공");
					$('#continueModal').modal('hide');
					ongoingList($('#currentPage').val());
				},
				error : function() {
					alert("실패");
				}
			});
		});


		//정산 버튼
		$(document).on('click', '.calculateBtn', function() {
			// 			alert($(this).siblings('input').val());

			$.ajax({
				url : "progress.do",
				type : "POST",
				data : {
					no : $(this).val(),
					state : 30,
					amount : $(this).siblings('input').val()
				},
				dataType : "json",
				success : function(data) {
					console.log(data);
					completionList($('#currentPage').val());
					$('.balance').text(data.balanceResult);
				},
				error : function() {
					alert("실패");
				}
			});
		});


		//modal 안에 있는 진행 버튼
		$(document).on('click', '#submitBtn', function() {
			var Arr = new Array();
			$($('input[name=purchaseCheck]:checked')).each(function() {
				Arr.push($(this).val());
			});
			console.log(Arr);
			jQuery.ajaxSettings.traditional = true;

			$.ajax({
				url : "progress.do",
				type : "POST",
				data : {
					list : Arr,
					state : 10
				},
				// 				dataType:"json",
				success : function(data) {
					alert("성공");
					$('#continueModal').modal('hide');
					sellingList($('#currentPage').val());
				},
				error : function() {
					alert("실패");
				}
			});

		})


		//modal 닫기 버튼
		$(document).on('click', '#closeBtn', function() {
			$('#continueModal').modal('hide');
			$('#premiumModal').modal('hide');
		});


		//각각 이전, 다음 버튼
		$('#tabs-1 button').click(function() {
			sellingList($(this).val());
		});
		$('#tabs-2 button').click(function() {
			ongoingList($(this).val());
		});
		$('#tabs-3 button').click(function() {
			completionList($(this).val());
		});
		$('#tabs-4 button').click(function() {
			canceledList($(this).val());
		});
		$('#tabs-5 button').click(function() {
			premiumList($(this).val());
		});


		// 		탭 기능

		$('#registrationList').click(function() {
			sellingList(0);
			$('#premiumBtn').css("display","inline");
		});

		$('#ongoing').click(function() {
			ongoingList(0);
			$('#premiumBtn').css("display","none");
		});

		$('#completion').click(function() {
			completionList(0);
			$('#premiumBtn').css("display","none");
		});

		$('#canceled').click(function() {
			canceledList(0);
			$('#premiumBtn').css("display","none");
		});
		$('#premiumTab').click(function() {
			premiumList(0);
			$('#premiumBtn').css("display","none");
		});

		//진행중 거래에서 완료 버튼 
		$(document).on('click', '.completeBtn', function() {
			// 			alert("완료");
			$.ajax({
				url : "progress.do",
				type : "POST",
				data : {
					no : $(this).val(),
					state : 11
				},
				success : function() {
					alert("성공");
					ongoingList($('#currentPage').val());
				},
				error : function() {
					alert("실패");
				}
			});
		});


		//옵션 창 띄우기
		$(document).on({
			mouseover : function(event) {

				$.ajax({
					url : "purchaseOption.do",
					type : "POST",
					data : {
						no : $(this).siblings('input[type=hidden]').val()
					},
					dataType : "json",
					success : function(data) {
						var optionStr = "";
						var optionPrice = "";

						var optionAmount = "";
						var total = 0;

						$.each(data, function(index, option) {
							optionStr += option.kind + "<br>";
							optionPrice += option.price + "<br>";
							optionAmount += option.amount + "<br>";
							total += option.price * option.amount;
						});

						$('.popupLayer').html(
							'<table><tr><td>옵션</td><td>수량</td><td>금액</td><td>총액</td></tr>' +
							'<tr><td>' + optionStr + '</td><td>' + optionAmount + '</td><td>' + optionPrice + '</td><td>' + total + '</td></tr></table>'
						);
					},
					error : function() {
						alert("실패");
					}
				});

				var Wwidth = window.innerWidth;
				var Wheight = window.innerHeight;
				var popWidth = $('.popupLayer').width();
				var popHeight = $('.popupLayer').height();
				var mouseX = event.pageX+20;
				var mouseY = event.pageY+10;

				if (Wwidth < popWidth + event.pageX) {
					mouseX -= popWidth;
				}

				if (Wheight < popHeight + event.pageY) {
					mouseY -= popHeight;
				}

				$('.popupLayer').css({
					"top" : mouseY,
					"left" : mouseX,
					"visibility" : "visible"
				});

			},
			mouseout : function(event) {
				$('.popupLayer').css({
					"visibility" : "hidden"
				});
			}
		}, '.optionList');


		//프리미엄 신청
		$('#premiumBtn').click(function() {
			// 			alert("프리미엄 등록");
// 						alert($('#tabs-1 input:radio:checked').val());
			var no = $('#tabs-1 input:radio:checked').val();
			$('#boardNo').val(no);
			$.ajax({
				url : "premiumSelect.do",
				type : "POST",
				data : {
					no : no
				},
				dataType : "json",
				success : function(data) {
					console.log(data);
					if(data.result){
						$('#boardTitle').empty();
						$('#boardTitle').text(data.title);
						$('#premiumModal').modal('show');
					}else{
						alert("이미 프리미엄 게시중 입니다.");
					}
				},
				error : function() {
					alert("실패");
				}
			});
		});

		
		$('#premiumTime').change(function(){
			var time = $(this).val();
			var price = "";
			if(time == 7){
				price = "10,000P";
			}else if(time == 14){
				price = "20,000P";
			}else if(time == 30){
				price = "40,000P";
			}else{
				price = "60,000P";
			}
			
			$('#premiumPrice').empty();
			
			$('#premiumPrice').text(price);
		});
		
		$('#premiumSubmit').click(function(){
// 			alert($('#premiumTime').val());
// 			alert($(this).siblings('input').val());
			
			$.ajax({
				url:"premiumUpdate.do",
				type:"POST",
				data:{
					no:$(this).siblings('input').val(),
					time:$('#premiumTime').val(),
					premium:0
				},
				dataType:"text",
				success:function(data){
					alert(data);
					$('#premiumModal').modal('hide');
				},
				error:function(){
					alert("실패");
				}
			});
			
			
		});
		
		
		$(document).on('click', '.cancellComfirm', function(){
			alert($(this).val()+"취소한다");
			
			$.ajax({
				url:"progress.do",
				type:"POST",
				data:{
					no:$(this).val(),
					state:42
				},
				success:function(){
					alert("성공");
					canceledList(0);
				},
				error:function(){
					alert("실패");
				}
			});
			
			
		});
		
		
	}); //document ready
	
	
	
	
	
</script>
<style type="text/css">
#tabs tr, #tabs td, #tabs th, #purchaseTable td {
	text-align: center;
	height: 37px; 
}

table {
	width: 100%;
}

.popupLayer {
	position: absolute;
	background-color: #ffffff;
	border: solid 2px #d0d0d0;
	width: 350px;
	height: 150px;
	padding: 10px;
 	visibility: hidden; 
	z-index: 5;
}

.popupLayer>table td {
	text-align: center;
}

.popupLayer>table>tbody>tr:first-child{
	background-color: #cecece;
}
.popupLayer>table>tbody>tr {
	border-bottom: 1px solid #e4e4e4;
	border-top: 1px solid #e4e4e4;
}

.popupLayer>table {
	width: 100%;
}
.optionList>span{
	line-height: 35px;
	display: block;
}


#tabs-1 div, #tabs-2 div, #tabs-3 div, #tabs-4 div, #tabs-5 div {
	text-align: center;
	position: absolute;
	top: 90%;
	left: 40%;
}

#tabs-1, #tabs-2, #tabs-3, #tabs-4, #tabs-5 {
	height: 400px;
}

.col-md-8 {
	position: relative;
	left: 10%;
}

#premiumBtn {
	position: absolute;
	left: 81%;
	top: 2%;
}
#tabs table>tbody>tr:first-child{
	background-color: #cecece;
}
#tabs table>tbody>tr {
	border-bottom: 1px solid #e4e4e4;
	border-top: 1px solid #e4e4e4;
}

</style>
</head>
<body>
	<input type="hidden" id="currentPage" value="">
	<div class="popupLayer"></div>



	<div id="fh5co-main">
		<div class="container">
			<div class="row">
				<div class="col-md-8 col-md-offset-2">
					<h2>판매관리</h2>
					<div id="tabs">
						<ul>
							<li><a href="#tabs-1" id="registrationList">등록한 재능글</a></li>
							<li><a href="#tabs-2" id="ongoing">진행중 거래</a></li>
							<li><a href="#tabs-3" id="completion">완료된 거래</a></li>
							<li><a href="#tabs-4" id="canceled">취소된 거래</a></li>
							<li><a href="#tabs-5" id="premiumTab">프리미엄</a></li>
						</ul>
						<input type="button" value="프리미엄 신청" id="premiumBtn"
							class="btn-sm btn-info">
						<div id="tabs-1">
							<table id="tab1table">
								<tr>
									<th width="5%">선택</th>
									<th width="15%">등록일</th>
									<th width="35%">글제목</th>
									<th width="15%">구매자</th>
									<th width="10%">상태</th>
									<th width="20%">비고</th>
								</tr>
							</table>
							<div>
								<button class="btn-sm btn-info prev" value="">이전</button>
								&nbsp;&nbsp;&nbsp;&nbsp;
								<button class="btn-sm btn-info next" value="">다음</button>
							</div>
						</div>
						<div id="tabs-2">
							<table>
								<tr>
									<th>등록일</th>
									<th>글제목</th>
									<th>구매자</th>
									<th>총액</th>
									<th>상태</th>
									<th>비고</th>
								</tr>
							</table>
							<div>
								<button class="btn-sm btn-info prev" value="">이전</button>
								&nbsp;&nbsp;&nbsp;&nbsp;
								<button class="btn-sm btn-info next" value="">다음</button>
							</div>

						</div>
						<div id="tabs-3">
							<table>
								<tr>
									<th>등록일</th>
									<th>글제목</th>
									<th>구매자</th>
									<th>총액</th>
									<th>상태</th>
									<th>비고</th>
								</tr>
							</table>
							<div>
								<button class="btn-sm btn-info prev" value="">이전</button>
								&nbsp;&nbsp;&nbsp;&nbsp;
								<button class="btn-sm btn-info next" value="">다음</button>
							</div>
						</div>
						<div id="tabs-4">
							<table>
								<tr>
									<th>등록일</th>
									<th>글제목</th>
									<th>구매자</th>
									<th>총액</th>
									<th>상태</th>
									<th>비고</th>
								</tr>
							</table>
							<div>
								<button class="btn-sm btn-info prev" value="">이전</button>
								&nbsp;&nbsp;&nbsp;&nbsp;
								<button class="btn-sm btn-info next" value="">다음</button>
							</div>
						</div>
						<div id="tabs-5">
							<table>
								<tr>
									<th width="10%">등록일</th>
									<th width="25%">글제목</th>
									<th width="5%">기간</th>
									<th width="5%">비용</th>
									<th width="10%">상태</th>
									<th width="5%">비고</th>
								</tr>
							</table>
							<div>
								<button class="btn-sm btn-info prev" value="">이전</button>
								&nbsp;&nbsp;&nbsp;&nbsp;
								<button class="btn-sm btn-info next" value="">다음</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>



	<!-- 진행  Modal -->
	<div class="modal fade" id="continueModal" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">구매자 현황</h4>
				</div>
				<div class="modal-body">
					<table id="purchaseTable">
						<tr>
							<td>선택</td>
							<td>구매자</td>
							<td>옵션</td>
							<td>수량</td>
							<td>금액</td>
							<td>총액</td>
						</tr>
					</table>

					<button id="submitBtn" class="btn-sm btn-info">확인</button>
					<button id="closeBtn" class="btn-sm btn-info">닫기</button>

				</div>
			</div>

		</div>
	</div>
	<!-- Modal -->
	<!-- 프리미엄  Modal -->
	<div class="modal fade" id="premiumModal" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">구매자 현황</h4>
				</div>
				<div class="modal-body">
					<table id="purchaseTable">
						<tr>
							<td>제목</td>
							<td>기간</td>
							<td>금액</td>
						</tr>
						<tr>
							<td id="boardTitle"></td>
							<td>
								<select id="premiumTime">
									<option value="7">1주</option>
									<option value="14">2주</option>
									<option value="30">1개월</option>
									<option value="60">2개월</option>
								</select>
							</td>
							<td id="premiumPrice">10,000P</td>
						</tr>
					</table>

					<button id="premiumSubmit" class="btn-sm btn-info">확인</button>
					<button id="closeBtn" class="btn-sm btn-info">닫기</button>
					<input type="hidden" value="0" id="boardNo">

				</div>
			</div>

		</div>
	</div>
	<!-- Modal -->



</body>
</html>