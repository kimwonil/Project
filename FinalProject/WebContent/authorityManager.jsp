<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="menu.jsp" %>
    <%@ include file="miniProfile.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="js/jquery.form.js"></script>
<script src="js/jquery.MetaData.js"></script>
<script src="js/jQuery.MultiFile.min.js"></script>
<script src="js/jquery.cycle2.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	
	function telentList(){
		$.ajax({
			url:"authorityManager.do",
			type:"POST",
			dataType:"json",
			success:function(data){
				console.log(data);
				$('#talentList tr:gt(1)').remove();
				for(var i=0; i<data.length;i++){
					$('#talentList').append(
						"<tr height='40px'><td>"+data[i].no+"</td><td>"+
						data[i].id+"</td><td>"+
						data[i].category_no+"</td><td>"+
						data[i].date+"</td><td>"+
						data[i].file1+"<br>"+data[i].file2+"<br>"+data[i].file3+"</td><td>"+
						"<button value='"+data[i].no+"' class='btn-sm btn-info detailBtn'>상세보기</button></td><td>"+
						"<button type='button' value='"+data[i].no+"' class='btn btn-sm btn-info approvalBtn' >승인</button> / <button type='button' value='"+data[i].no+"' class='btn btn-sm btn-danger cancelBtn' >취소</button></td></tr>"
					);
					
				}
				
			},
			error:function(){
				alert("실패");
			}
		});
	}
	
	telentList();
	
	$(document).on('click','.approvalBtn', function(){
		$.ajax({
			url:"authorityUpdate.do",
			type:"POST",
			data:{
				no:$(this).val(),
				state:2
			},
			success:function(){
				telentList();
			},
			error:function(){
				alert("실패");
			}
		});
		
	});
	
	$(document).on('click','.cancelBtn', function(){
		$.ajax({
			url:"authorityUpdate.do",
			type:"POST",
			data:{
				no:$(this).val(),
				state:3
			},
			success:function(){
				telentList();
			},
			error:function(){
				alert("실패");
			}
		});
	});
	
	$(document).on('click', '.detailBtn', function(){
		$.ajax({
			url:"authorityDetail.do",
			type:"POST",
			data:{no:$(this).val()},
			dataType:"json",
			success:function(data){
				console.log(data);
				alert("성공");
				$('#imageFile1').attr('src','<c:url value="/user/authority/'+data.no+'"/>/'+data.file1);
				$('#detailModal').modal('show');
			},
			error:function(){
				alert("실패");
			}
			
		});
		
// 		$('#imageFile1').attr('src', '<c:url value="/user/authority/'+no+'"/>/')
		
// 		$('#detailModal').modal('show');
		
		
	});
	
	
	
	
	
});


</script>

</head>
<body>
<style>
	#talentList{
		border: 1px solid black;
		width: 900px;
		text-align: center;
		margin:10px 0px;
		
	}
	#talentTable{
		margin: 0 auto;
	}
	#talentList td{
		border: 1px solid black;
		text-align: center;
	}
	.btn{
		line-height:15px;
		margin: 10px 10px;
		padding: 3px;
	}
	.btn-danger, .register{
		margin: 10px;
	}
	#btnDiv{
		text-align: right;
	}
	.modal-body{
		text-align: center;
	}
	.cycle-pager{
		font-size: 50px;
	}
	
	</style>
	
	<div id="fh5co-main">
		<div class="container">
			<div class="row">
			
				<div class="col-md-8 col-md-offset-2">
					<h2>권한 신청 매니저</h2>
					<table id="talentList">
						<tr>
							<td colspan="7">신청한 재능</td>
						</tr>
						<tr>
							<td>번호</td>
							<td>아이디</td>
							<td>재능</td>
							<td>신청일시</td>
							<td colspan="2">첨부</td>
							<td>비고</td>
						</tr>
					</table>
						  
				</div>
        	</div>
       </div>
	</div>
	
						<!-- 상세보기 Modal -->
						  <div class="modal fade" id="detailModal" role="dialog">
						    <div class="modal-dialog">
						    
						      <!-- Modal content-->
						      <div class="modal-content">
						        <div class="modal-header">
						          <button type="button" class="close" data-dismiss="modal">&times;</button>
						          <h4 class="modal-title">상세 보기</h4>
						        </div>
						        <div class="modal-body">
						        	<div class="cycle-slideshow" cycle-slideshow data-cycle-loader="wait">
							         	<div class="cycle-pager"></div>
							         	
							         	<img src="images/img_1.jpg" id="imageFile1">
							          	<img src="images/img_1.jpg" id="imageFile2">
<!-- 							          	<img src="/images/img_1.jpg" id="imageFile3"> -->
						          	</div>
						        </div>
						        <div class="modal-footer">
						        	<button type="button" id="authorityDelete" class="btn-sm btn-danger">삭제</button>
						        	<button type="button" class="btn-sm btn-info" data-dismiss="modal">닫기</button>
						        </div>
						      </div>
						      
						    </div>
						  </div>
						  <!-- Modal -->
	
</body>
</html>