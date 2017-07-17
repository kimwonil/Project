<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="menu.jsp" %>
    <%@ include file="miniProfile.jsp"%>
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
				$('#messageList tr:gt(0)').remove();
				for(var i=0;i<data.length;i++){
				$('#messageList').append("<tr><td>"+data[i].date+"</td><td><a id='"+data[i].no+"'class='messageDetail' data-toggle='modal' data-target='#messageModal'>"
												+data[i].title+"</a></td><td>"
												+data[i].sender+"</td><td>"
												+(data[i].state==1?"읽지 않음":"읽음")+"</td></tr>");
				}
			},
			error:function(jqXHR, textStatus, errorThrown){
				console.log(textStatus);
				console.log(errorThrown);
			}
		});
		
	};
	
	messageList();
	
	
	$(document).on('click','.messageDetail',function(){
		$.ajax({
			url:"messageDetail.do",
			type:"POST",
			data:{no:$(this).attr('id')},
			dataType:"json",
			success:function(data){
				messageList();
				$('#messageTitle').text(data.title);
				$('#messageSender').text(data.sender);
				$('#messageContent').text(data.content);
			},
			error:function(){
				alert("실패");
			}
		});
		
	});
	
	
	
	
	
</script>
<style type="text/css">
	#messageList{
		text-align: center;
	}
	#messageList, #messageWrite{
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
	#messageList td{
		
		border:1px solid black;
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
							<li><a href="#tabs-1">쪽지 내역</a></li>
							<li><a href="#tabs-2">쪽지 작성</a></li>
						</ul>
						<div id="tabs-1">
							<table id="messageList">
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
									<td width="80%">제&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목 : <input type="text" class="messageInput" name="title"></td>
									<td width="20%" rowspan="2"  align="center"><button type="button" id="messageBtn" class="btn btn-sm btn-info">보내기</button></td>
								</tr>
								<tr>
									
									<td width="80%">받는사람 : <input type="text" class="messageInput" name="title">	</td>
								</tr>
								<tr>
									<td colspan="3"><textarea rows="10" cols="85"></textarea></td>
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
												: <label id="messageTitle">메세지 리스트</label>
											</td>
											<td width="20%" rowspan="2" align="center"><button
													type="button" id="messageDelete" class="btn btn-sm btn-danger">삭제</button></td>
										</tr>
										<tr>

											<td width="80%">보낸사람 : <label id="messageSender">운영자</label>
											</td>
										</tr>
										<tr>
											<td colspan="3"><textarea id="messageContent" rows="10" cols="78" readonly="readonly">내용입니다.</textarea></td>
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