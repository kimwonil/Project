<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../menu.jsp" %>
    <%@ include file="../miniProfile.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="js/jquery.form.js"></script>
<script src="js/jquery.MetaData.js"></script>
<script src="js/jQuery.MultiFile.min.js"></script>

<script type="text/javascript">



$(document).ready(function(){
	
	function authorityList(page){
		
		$.ajax({
			url:"authorityList.do",
			type:"POST",
			data:{
				page:page
			},
			dataType:"json",
			success:function(data){
				console.log(data);
				$('#talentList tr:gt(1)').remove();
				if(data.list == ""){
					$('#talentList').append('<tr><td colspan="4">내역이 없습니다.</td></tr>');
				}else{
					$.each(data.list, function(index, value){
						$('#talentList').append(
								"<tr height='40px'><td>"+value.no+"</td><td>"+
								value.category_no+"</td><td>"+
								value.date+"</td><td>"+
								(value.state==1?"승인 대기 / <button value='"+value.no+"' type='button' class='btn btn-sm btn-danger authorityDelete' data-toggle='modal' data-target='#deleteModal' >삭제</button>":value.state==2?"승인":"취소")+"</td></tr>"
						);
						$('.prev').val(data.page==0?0:data.page-10);
						$('.next').val(data.totalPage-10>data.page?data.page+10:data.page);	
					});
				}
			},
			error:function(){
				alert("실패");
			}
		});
	}
	
	authorityList(0);
	
	$('#btnDiv button').click(function(){
		authorityList($(this).val());
	});
	
	
	$(document).on('click','.authorityDelete', function(){
		$('#authorityHidden').val($(this).val());
	});
	
	
	$(document).on('click', '#authorityDelete', function(){
		$.ajax({
			url:"authorityDelete.do",
			type:"POST",
			data:{no:$('#authorityHidden').val()},
// 			dataType:"json",
			success:function(){
				authorityList();
				$('#deleteModal').modal('hide');
			},
			error:function(){
				alert("실패");
			}
		});
	});
	
	
});


</script>

</head>
<body>
<style>
	#talentList{
		border: 1px solid black;
		width: 700px;
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
	#regBtn{
		margin-top: 20px;
		position: relative;
		left: 65%;
	}
	h2{
		float: left;
		clear: both;
	}
	
	#btnDiv{
		text-align:center;
		position: absolute;
		top: 95%;
		left: 55%;
	}
	.col-md-8{
		position: relative;
		left: 15%;
	}
	</style>
	
	<div id="fh5co-main">
		<div class="container">
			<div class="row">
			
				<div class="col-md-8 col-md-offset-2">
					<h2>권한 신청</h2><button type="button" id="regBtn" class="btn-sm btn-info" data-toggle="modal" data-target="#addModal">재능 신청</button>
					<table id="talentList">
						<tr>
							<td colspan="4">신청한 재능</td>
						</tr>
						<tr>
							<td>번호</td>
							<td>재능</td>
							<td>신청일시</td>
							<td>비고</td>
						</tr>
						<tr>
							<td>1</td>
							<td>대분류</td>
							<td>2017.07.11</td>
							<td>승인대기중 / <button type="button" class="btn btn-sm btn-danger" data-toggle="modal" data-target="#deleteModal">삭제</button></td>
						</tr>
					</table>
					
				</div>
					<div id="btnDiv">
						<button class="btn-sm btn-info prev" value="">이전</button>&nbsp;&nbsp;&nbsp;&nbsp;<button class="btn-sm btn-info next" value="">다음</button>
					</div>
						  <!-- 재능 신청 Modal -->
						  <div class="modal fade" id="addModal" role="dialog">
						    <div class="modal-dialog">
						    
						      <!-- Modal content-->
						      <div class="modal-content">
						        <div class="modal-header">
						          <button type="button" class="close" data-dismiss="modal">&times;</button>
						          <h4 class="modal-title">재능 신청</h4>
						        </div>
						        <form id="registerForm" action="authorityReg.do" method="post" enctype="multipart/form-data">
						        <div class="modal-body">
						          <table id="talentTable">
										<tr>
											<td>신청 재능</td>
											<td>
												<select name="category_no">
													<option value="1">디자인/그래픽</option>
													<option value="2">컴퓨터/개발</option>
													<option value="3">음악/영상</option>
													<option value="4">생활/대행/상담</option>
													<option value="5">노하우/여행</option>
												</select>
											</td>
										</tr>
										<tr>
											<td colspan="2"><b>관련 자료</b></td>
										</tr>
										<tr>
											<td colspan="2">
												<input name="files" type="file" />
												<input name="files" type="file" />
												<input name="files" type="file" />
											</td>
										</tr>
									</table>
						        </div>
						        <div id="btnDiv">
						          <input type="submit" class="btn btn-sm btn-info register" value="등록">
<!-- 						          <button type="button" class="btn btn-sm btn-info register" id="register">등록</button> -->
						          <button type="button" class="btn btn-sm btn-info register" data-dismiss="modal">닫기</button>
						        
						        </div>
						        </form>
						        <div class="modal-footer">
						        </div>
						      </div>
						      
						    </div>
						  </div>
						  <!-- Modal -->
						  
						  <!-- 재능 삭제 Modal -->
						  <div class="modal fade" id="deleteModal" role="dialog">
						    <div class="modal-dialog">
						    
						      <!-- Modal content-->
						      <div class="modal-content">
						        <div class="modal-header">
						          <button type="button" class="close" data-dismiss="modal">&times;</button>
						          <h4 class="modal-title">재능 삭제</h4>
						        </div>
						        <div class="modal-body">
						         	<b>재능을 삭제하시겠습니까?</b>
						         	<input type="hidden" value="" id="authorityHidden">
						          <button type="button" id="authorityDelete" class="btn-sm btn-danger">삭제</button>
						          <button type="button" class="btn-sm btn-info" data-dismiss="modal">닫기</button>
						        </div>
						      </div>
						      
						    </div>
						  </div>
						  <!-- Modal -->
        	</div>
       </div>
	</div>
</body>
</html>