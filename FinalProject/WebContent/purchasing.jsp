<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="menu.jsp"%>
<%@ include file="miniProfile.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ShareAbility</title>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="css/starStyle.css">

<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script>
	function comma(str) {
		str = String(str);
		return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
	}

	$(function() {
		$("#tabs").tabs();
	});
	
	function purchase(page){
		$.ajax({
			url:"purchase.do",
			type:"POST",
			data:{
				state:0,
				page:page
			},
			dataType:"json",
			success:function(data){
				console.log(data);
				
				$('#tabs-1 > table tr:gt(0)').remove();
				if(data.list == ""){
					$('#tabs-1 > table').append(
							'<tr><td colspan="6">내역이 없습니다.</td></tr>'		
					);
				}else{
					$.each(data.list, function(index, value){
							
							var total = 0;
							
							$.each(value.optionList, function(index2, option){
								total += option.price * option.amount;
							});
							
							$('#tabs-1 > table').append(
									'<tr><td>' + value.date + '</td><td><a href="detailOneBoard.do?no='+value.no+'"><div class="titlecut1">' + 
									value.boardTitle + '</div></a></td><td>' +
									value.seller + '</td><td><a href="#" class="optionList"><span>'+comma(total)+'</span></a><input type="hidden" value="'+value.purchase_no+'"></td><td>'+
									(value.state==0?"대기중":value.state==10?"진행중":value.state==11?'<button class="btn-sm btn-info completeBtn" value="'+value.no+'">완료</button>':"완료")+'</td><td>'+
									'<button class="btn-sm btn-info stopBtn" value="'+value.purchase_no+'">취소</button></td></tr>'		
							);								
					});
					$('#currentPage').val(data.page);
					$('.prev').val(data.page==0?0:data.page-8);
					$('.next').val(data.totalPage-8>data.page?data.page+8:data.page);
				}
				
				
			},
			error:function(jqXHR, textStatus, errorThrown){
				console.log(textStatus);
				console.log(errorThrown);
			}
		})
	}
	
	function completePurchase(page){
		$.ajax({
			url:"purchase.do",
			type:"POST",
			data:{
				state:20,
				page:page
			},
			dataType:"json",
			success:function(data){
				console.log(data);
				
				$('#tabs-2 > table tr:gt(0)').remove();
				if(data.list == ""){
					$('#tabs-2 > table').append(
							'<tr><td colspan="5">내역이 없습니다.</td></tr>'		
					);
				}else{
					$.each(data.list, function(index, value){
							
							var total = 0;
							
							$.each(value.optionList, function(index2, option){
								total += option.price * option.amount;
							});
							
							$('#tabs-2 > table').append(
									'<tr><td>' + value.date + '</td><td><a href="detailOneBoard.do?no='+value.no+'"><div class="titlecut2">' + 
									value.boardTitle + '</div></a></td><td>' +
									value.seller + '</td><td><a href="#" class="optionList"><span>'+comma(total)+'</span></a><input type="hidden" value="'+value.purchase_no+'"></td><td>'+
									(value.state==0?"대기중":value.state==10?"진행중":value.state==11?'<button class="btn-sm btn-info completeBtn" value="'+value.no+'">완료</button>':"완료")+
									'</td></tr>'		
							);								
					});
					$('#currentPage').val(data.page);
					$('.prev').val(data.page==0?0:data.page-8);
					$('.next').val(data.totalPage-8>data.page?data.page+8:data.page);
				}
				
				
			},
			error:function(jqXHR, textStatus, errorThrown){
				console.log(textStatus);
				console.log(errorThrown);
			}
		})
	}
	
	
	function canceledPurchase(page){
		$.ajax({
			url:"purchase.do",
			type:"POST",
			data:{
				state:40,
				page:page
			},
			dataType:"json",
			success:function(data){
				console.log(data);
				
				$('#tabs-3 > table tr:gt(0)').remove();
				if(data.list == ""){
					$('#tabs-3 > table').append(
							'<tr><td colspan="5">내역이 없습니다.</td></tr>'		
					);
				}else{
					$.each(data.list, function(index, value){
							
							var total = 0;
							
							$.each(value.optionList, function(index2, option){
								total += option.price * option.amount;
							});
							
							$('#tabs-3 > table').append(
									'<tr><td>' + value.date + '</td><td><a href="detailOneBoard.do?no='+value.no+'"><div class="titlecut3">' + 
									value.boardTitle + '</div></a></td><td>' +
									value.seller + '</td><td><a href="#" class="optionList"><span>'+comma(total)+'</span></a><input type="hidden" value="'+value.purchase_no+
									'"></td><td>'+(value.state==40?'취소 대기':value.state==41?'<button class="btn-sm btn-info cancelBtn" value="' + value.purchase_no + '">취소</button>':'취소 완료')+'</td></tr>'		
							);								
					});
					$('#currentPage').val(data.page);
					$('.prev').val(data.page==0?0:data.page-8);
					$('.next').val(data.totalPage-8>data.page?data.page+8:data.page);
				}
				
				
			},
			error:function(jqXHR, textStatus, errorThrown){
				console.log(textStatus);
				console.log(errorThrown);
			}
		})
	}
	
	
	
	
	
	
	
	
	
	$(document).ready(function(){
		
		purchase(0);
		
		
		$(document).on({
			mouseover : function(event){
				
				$.ajax({
					url:"purchaseOption.do",
					type:"POST",
					data:{no:$(this).siblings('input[type=hidden]').val()},
					dataType:"json",
					success:function(data){
						var optionStr="";
						var optionPrice=""; 
						
						var optionAmount="";
						var total = 0;
						
						$.each(data, function(index, option){
							optionStr += option.kind + "<br>";
							optionPrice += comma(option.price) + "<br>";
							optionAmount += option.amount +"<br>";
							total += option.price * option.amount;
						});
						
						$('.popupLayer').html(
								'<table><tr><td width="60%">옵션</td><td width="10%">수량</td><td width="15%">금액</td><td width="15%">총액</td></tr>'+
								'<tr><td>'+optionStr+'</td><td>'+optionAmount+'</td><td>'+optionPrice+'</td><td>'+comma(total)+'</td></tr></table>'
						);
					},
					error:function(){
						alert("실패");
					}
				});
				
				var Wwidth = window.innerWidth;
				var Wheight = window.innerHeight;
				var popWidth = $('.popupLayer').width();
				var popHeight = $('.popupLayer').height();
				var mouseX=event.pageX;
				var mouseY=event.pageY+30;
				
				if(Wwidth < popWidth + event.pageX){
					mouseX -= popWidth;
				}
				
				if(Wheight < popHeight + event.pageY){
					mouseY -= popHeight;
				}
				
				
	 			$('.popupLayer').css({
	 				"top": mouseY,
	 				"left": mouseX,
	 				"visibility":"visible"
	 			});
				
				
				
			},
			mouseout : function(event){
				$('.popupLayer').css({
	 				"visibility":"hidden"
	 			});
			}
		}, '.optionList');
		
			
		
		//완료 버튼 누르면 별점&리뷰 입력창 띄우기
		$(document).on('click', '.completeBtn', function(){
			$('#myModal').modal();
			$('#hiddenBoard_no').val($(this).val());
			$('#hiddenPurchase_no').val($(this).parent().parent().find('input').val());
		});
		//content글자수 오버되면 막기
        $(document).on("keyup", '#review', function(){
               //글자수 체크해서 알려주기
               var contentLength = $('#review').val().length;
               console.log(contentLength);
               $('#count').empty();
               $('#count').html(
                            '리뷰는 100자 이하로 입력하세요&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp' + contentLength+'/100');
               //1000자 넘으면 막기
               if($('#review').val().length > 100 ){
                     alert("리뷰는 100자 이하로 입력하세요");
                     $('#count').html(
                                   '리뷰는 100자 이하로 입력하세요&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp100/100');
                     var cntnt = $(this).val().substr(0,100);
                     console.log(cntnt);
                     $(this).val(cntnt);
               }
        });
		
		//별점&리뷰 입력 후 확인 누르면 ajax
		$(document).on('click', '#starReview', function(){
			var complete = confirm("완료 하시겠습니까?");
			if(complete){
				$.ajax({
					url:"progress.do",
					type:"POST",
					data:{
						board_no:$('#hiddenBoard_no').val(),
						purchase_no:$('#hiddenPurchase_no').val(),
						state:20,
						star:$('input[name="rating"]:checked').val(),
						content:$('#review').val()
					},
					success:function(){
// 						alert("성공");
						purchase(0);
						$('#rating-3').attr('ckecked','checked');
						$('#myModal').modal('hide');
						$('#review').val("");
					},
					error:function(){
						alert("실패");
					}
				})
			}
		});
		
		//취소버튼(판매자 취소시)
		$(document).on('click', '.cancelBtn', function(){
			var cancel = confirm("취소하시겠습니까?");
			
			if(cancel){
				$.ajax({
					url:"progress.do",
					type:"POST",
					data:{
						no:$(this).val(),
						state:42
					},
					dataType:"json",
					success:function(data){
// 						alert("성공");
						canceledPurchase(0);
						console.log(data);
						$('.balance').text(data.balanceResult);
					},
					error:function(jqXHR, textStatus, errorThrown){
		    			alert(textStatus);     //응답상태
		    			alert(errorThrown);     //응답에 대한 메세지
		    		}
					
				});
			}
		});
		
		
		//취소버튼(구매자 취소시)
		$(document).on('click', '.stopBtn', function(){
			var cancel = confirm("취소하시겠습니까?");
			
			if(cancel){
				$.ajax({
					url:"progress.do",
					type:"POST",
					data:{
						no:$(this).val(),
						state:40
					},
					success:function(data){
// 						alert("성공");
						purchase(0);
// 						$('.balance').text();
					},
					error:function(jqXHR, textStatus, errorThrown){
		    			alert(textStatus);     //응답상태
		    			alert(errorThrown);     //응답에 대한 메세지
		    		}
					
				});	
			}
			
			
			
		});
		
		$('#ongoing').click(function(){
			purchase(0);
		});
		
		$('#completion').click(function(){
			completePurchase(0);
		});
		
		$('#canceled').click(function(){
			canceledPurchase(0);
		});
		
		
		$('#tabs-1 button').click(function(){
			purchase($(this).val());
		});
		$('#tabs-2 button').click(function(){
			completePurchase($(this).val());
		});
		$('#tabs-3 button').click(function(){
			canceledPurchase($(this).val());
		});
		

	});
	
</script>
<style type="text/css">
#starCenter>h5{
	text-align: center;
}
#tabs tr,#tabs td,#tabs th{
	text-align: center;
	height: 37px;
}
#tabs table{
	width: 100%;
}
.popupLayer {
	position: absolute;
	background-color: #ffffff;
	border: solid 2px #d0d0d0;
	width: 550px;
	min-height: 100px;
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
.star-cb-group{
	margin-left: 185px;
	
}
.star-cb-group *{
 font-size: 3rem;
}

.pagingDiv{
	text-align:center;
	position: absolute;
	top: 90%;
	left: 40%;
}
#tabs-1, #tabs-2, #tabs-3{
	height: 400px;
}
.col-md-8{
	position: relative;
	left: 10%;
	top:-50px;
}
#tabs table>tbody>tr:first-child{
	background-color: #cecece;
}
#tabs table>tbody>tr {
	border-bottom: 1px solid #e4e4e4;
	border-top: 1px solid #e4e4e4;
}
#review{
	resize:none;
}
.titlecut1{
	overflow: hidden; 
	text-overflow: ellipsis;
	white-space: nowrap; 
	display:block;
	width: 295px;
	height: 20px;
}
.titlecut2, .titlecut3{
	overflow: hidden; 
	text-overflow: ellipsis;
	white-space: nowrap; 
	display:block;
	width: 291px;
	height: 20px;
	margin-right: -130px;
}
</style>
</head>
<body>
<input type="hidden" id="currentPage" value="">
	<div class="popupLayer">
	
	</div>


	<div id="fh5co-main">
		<div class="container">
			<div class="row">
				<div class="col-md-8 col-md-offset-2">
					<h2>구매관리</h2>
					<div id="tabs">
						<ul>
							<li><a href="#tabs-1" id="ongoing">진행중 거래</a></li>
							<li><a href="#tabs-2" id="completion">완료된 거래</a></li>
							<li><a href="#tabs-3" id="canceled">취소된 거래</a></li>
						</ul>
						<div id="tabs-1" >
							<table>
								<tr><th width="15%">등록일</th><th width="40%">글제목</th><th width="15%">판매자</th><th width="10%">총액</th><th width="10%">상태</th><th width="10%">비고</th></tr>
							</table>
							<div class="pagingDiv">
								<button class="btn-sm btn-info prev" value="">이전</button>&nbsp;&nbsp;&nbsp;&nbsp;<button class="btn-sm btn-info next" value="">다음</button>
							</div>
						</div>
						<div id="tabs-2">
							<table>
								<tr><th>등록일</th><th>글제목</th><th>판매자</th><th>총액</th><th>상태</th></tr>
							</table>
							<div class="pagingDiv">
								<button class="btn-sm btn-info prev" value="">이전</button>&nbsp;&nbsp;&nbsp;&nbsp;<button class="btn-sm btn-info next" value="">다음</button>
							</div>
						</div>
						<div id="tabs-3">
							<table>
								<tr><th>등록일</th><th>글제목</th><th>판매자</th><th>총액</th><th>상태</th></tr>
							</table>
							<div class="pagingDiv">
								<button class="btn-sm btn-info prev" value="">이전</button>&nbsp;&nbsp;&nbsp;&nbsp;<button class="btn-sm btn-info next" value="">다음</button>
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
		<div id="starCenter">
		<h5>별점평가</h5>
		<form>
		<div>
		  <fieldset>
		    <span class="star-cb-group">
		      <input type="radio" id="rating-5" name="rating" value="5"/><label for="rating-5">5</label>
		      <input type="radio" id="rating-4" name="rating" value="4" /><label for="rating-4">4</label>
		      <input type="radio" id="rating-3" name="rating" value="3" checked="checked"/><label for="rating-3">3</label>
		      <input type="radio" id="rating-2" name="rating" value="2"/><label for="rating-2">2</label>
		      <input type="radio" id="rating-1" name="rating" value="1"/><label for="rating-1">1</label>
		      <input type="radio" id="rating-0" name="rating" value="0" class="star-cb-clear" /><label for="rating-0">0</label>
		    </span>
		  </fieldset>
		  </div>
		</form>
		</div>
		
		<div>리뷰작성</div>
		<textarea id="review" rows="3" cols="78" ></textarea>
		<div id="count"></div>
      </div>
      <div class="modal-footer">
      	<button type="button"  id="starReview" class="btn btn-sm btn-info">확인</button>
      	<input type="hidden" id="hiddenBoard_no">
      	<input type="hidden" id="hiddenPurchase_no">
        <button type="button" class="btn btn-sm btn-info" data-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>
<!-- modal end -->
	
</body>
</html>