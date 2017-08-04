<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../menu.jsp" %>
    <%@ include file="../miniProfile.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.2.js"></script>
<title>Insert title here</title>
<script>
	$(function() {
		$("#tabs").tabs();
	});
	
	function messageList(){
		
		$.ajax({
			url:"messageList.do",
			type:"POST",
			dataType:"json",
			success:function(data){
				console.log(data);
				$('#messageTable tr:gt(0)').remove();
				if(data == ""){
					$('#messageTable').append('<tr><td colspan="4">내역이 없습니다.</td></tr>');
				}else{
					for(var i=0;i<data.length;i++){
						$('#messageTable').append("<tr><td>"+data[i].date+"</td><td><a id='"+data[i].no+"'class='messageDetail' data-toggle='modal' data-target='#messageModal'>"
													+data[i].title+"</a></td><td>"
													+data[i].sender+"</td><td>"
													+(data[i].state==1?"읽지 않음":"읽음")+"</td></tr>");
					}
				}
			},
			error:function(jqXHR, textStatus, errorThrown){
				console.log(textStatus);
				console.log(errorThrown);
			}
		});
		
	};
	
	messageList();
	
	$(document).on('click','#messageList',function(){
		messageList();
	});
	
	$(document).on('click','.messageDetail',function(){
		$.ajax({
			url:"messageDetail.do",
			type:"POST",
			data:{no:$(this).attr('id')},
			dataType:"json",
			success:function(data){
				messageList();
				$('#titleLabel').text(data.title);
				$('#senderLabel').text(data.sender);
				$('#contentLabel').text(data.content);
			},
			error:function(){
				alert("실패");
			}
		});
		
	});
	
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
				alert("성공");
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
	
	
	
	
</script>
<style type="text/css">
#messageTable{
	text-align: center;
}
#messageTable, #messageWrite{
	width:700px;
	margin: 0 auto;
	
}
#messageDetail{
	width: 548px;
	margin: 0 auto;
}
#messageDetail > button{
	margin: 0 auto;
}
textarea{
	resize:none;
	overflow: hidden;
}
.messageInput{
	width: 300px;
}
#messageBtn{
	margin:0 auto;
}
#tabs-2 div, #tabs-1 div{
	text-align:center;
	position: absolute;
	top: 90%;
	left: 40%;
}
#tabs-2, #tabs-1{
	height: 370px;
}
.col-md-8{
	position: relative;
	left: 10%;
}
#tabs-2 tr{
	height: 45px;
}
#tabs-1 table>tbody>tr:first-child{
	background-color: #cecece;
}
#tabs-1 table>tbody>tr {
	border-bottom: 1px solid #e4e4e4;
	border-top: 1px solid #e4e4e4;
}

</style>
</head>
<body>

	
	<div id="fh5co-main">
		<div class="container">
			<div class="row">
			<div class="col-md-8 col-md-offset-2">
			<h2>쪽지관리</h2>
					<div id="tabs">
						<ul>
							<li><a href="#tabs-1" id="messageList">쪽지 내역</a></li>
							<li><a href="#tabs-2">쪽지 작성</a></li>
						</ul>
						<div id="tabs-1">
							<table id="messageTable">
								<tr>
									<td width="15%">작성일</td>
									<td width="50%">제목</td>
									<td width="20%">보낸사람</td>
									<td width="15%">상태</td>
								</tr>
							</table>
						</div>
						<div id="tabs-2">
							<table id="messageWrite">
								<tr>
									<td width="80%">제&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목 : <input type="text" class="messageInput" id="messageTitle"></td>
									<td width="20%" rowspan="2"  align="center"><button type="button" id="messageBtn" class="btn btn-sm btn-info">보내기</button></td>
								</tr>
								<tr>
									
									<td width="80%">받는사람 : <input type="text" class="messageInput" id="messageReceiver"></td>
								</tr>
								<tr>
									<td colspan="3"><textarea rows="10" cols="85" id="messageContent"></textarea></td>
								</tr>
							</table>
						</div>
					</div>
					

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
											<td colspan="3"><textarea id="contentLabel" rows="10" cols="78" readonly="readonly"></textarea></td>
										</tr>
									</table>
								</div>
							</div>

						</div>
					</div>
					<!-- Modal -->
				</div>
        	</div>
       </div>
	</div>
</body>
</html>