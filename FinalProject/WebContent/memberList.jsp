<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="menu.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	
	<script type="text/javascript">
		$(document).ready(function(){
			function memberList(){
				$.ajax({
					url:"memberList.do",
					type:"POST",
					dataType:"json",
					success:function(data){
						console.log(data);
						$('#memberTable tr:gt(0)').remove();
						for(var i=0;i<data.length;i++){
							$('#memberTable').append("<tr><td><input type='radio' name='memberCheck' value='"+data[i].id+"'></td><td>"
									+data[i].id+"</td><td>"
									+data[i].nickName+"</td><td>"
									+data[i].photo+"</td><td>"
									+data[i].balance+"</td><td>"
									+(data[i].admin==1?"관리자":"일반회원")+"</td></tr>");
						}
						
					},
					error:function(){
						alert("실패");
					}
				});
			};
			
			memberList();
			
			$(document).on('click','#updateMember',function(){
				
				$('#updateTable').empty();
				
				$.ajax({
					url:"memberUpdateForm.do",
					type:"POST",
					data:{id:$('input[name=memberCheck]:checked').val()},
					dataType:"json",
					success:function(data){
						console.log(data);
						$('#updateTable').append(
								"<tr><td width='20%'>아이디</td><td width='40%'><label>"+data.id+"</label></td></tr>"
								+"<tr><td>닉네임</td><td><input type='text' value='"+data.nickName+"'></td></tr>"
								+"<tr><td>사진</td><td><input type='text' value='"+data.photo+"'></td></tr>"
								+"<tr><td>포인트</td><td><input type='text' value='"+data.balance+"'></td></tr>"
								+"<tr><td>비고</td><td>"+data.admin+"</td></tr>"
						);
					},
					error:function(){
						alert("실패");
					}
					
				});
				
				
				$('#updateModal').modal();
				
				
			});
			
		});//document.ready
	
	
	</script>
	<style type="text/css">
	
	.photo{
		width: 100px;
		height: 100px;
	}
	#memberTable{
		width: 800px;
		margin: 10px auto;
	}
	#updateTable{
		margin: 0 auto;
	}
	
	#memberTable td, #updateTable td{
		border:1px solid black;
		text-align: center;
	}
	#updateTable input[type=text]{
		width:100%;
	}
	
	.updateBtn{
		position: relative;
		left:45%;
	}
	
	</style>
	</head>
	<body>
	
	<div id="fh5co-main">
		<div class="container">
			<div class="row">
			
				<div class="col-md-8 col-md-offset-2">
					<h2>멤버 관리</h2>
					<table id="memberTable">
						<tr>
							<td width="10%">체크</td>
							<td width="20%">아이디</td>
							<td width="20%">닉네임</td>
							<td width="20%">사진</td>
							<td width="15%">포인트</td>
							<td width="15%">비고</td>
						</tr>
						
					</table>
					<a href="#" class="btn btn-sm btn-info" id="updateMember">회원수정</a>
					<a href="#" class="btn btn-sm btn-info" data-toggle="modal"	data-target="#deleteModal">회원삭제</a>
					
					
				</div>
        	</div>
       </div>
	</div>
	<!-- 회원 수정  Modal -->
					<div class="modal fade" id="updateModal" role="dialog">
						<div class="modal-dialog">

							<!-- Modal content-->
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h4 class="modal-title">회원 정보 수정</h4>
								</div>
								<div class="modal-body">
									<table id="updateTable">
									
									</table>
									
								</div>
								<div>
									<button class="btn btn-sm btn-info updateBtn">수정</button>
								</div>
							</div>

						</div>
					</div>
					<!-- Modal -->
	</body>
</html>