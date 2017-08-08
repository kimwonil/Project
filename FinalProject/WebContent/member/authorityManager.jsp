<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../menu.jsp" %>
    <%@ include file="../miniProfile.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<!-- <script src="js/jquery.form.js"></script> -->
<!-- <script src="js/jquery.MetaData.js"></script> -->
<script src="js/jQuery.MultiFile.min.js"></script>
<script src="js/jquery.cycle2.js"></script>
<script type="text/javascript">

$(document).ready(function(){

	function telentList(page){
		$.ajax({
			url:"authorityManager.do",
			type:"POST",
			data:{
				page:page
			},
			dataType:"json",
			success:function(data){
				console.log(data);
				$('#talentList tr:gt(1)').remove();
				if(data.list == ""){
					$('#talentList').append('<tr><td colspan="6">내역이 없습니다.</td></tr>');
				}else{
					$.each(data.list, function(index, value){
						$('#talentList').append(
							"<tr><td>"+value.no+"</td><td>"+
							value.id+"</td><td>"+
							value.category_no+"</td><td>"+
							value.date+"</td><td>"+
							"<button value='"+value.no+"' class='btn-sm btn-info detailBtn'>상세보기</button></td><td>"+
							"<button type='button' value='"+value.no+"' class='btn btn-sm btn-info approvalBtn' >승인</button> / <button type='button' value='"+value.no+"' class='btn btn-sm btn-danger cancelBtn' >취소</button></td></tr>"
						);
					});	
				}
				
				$('#currentPage').val(data.page);
				$('.prev').val(data.page==0?0:data.page-10);
				$('.next').val(data.totalPage-10>data.page?data.page+10:data.page);
			},
			error:function(){
				alert("실패");
			}
		});
	}
	
	telentList(0);
	
	$('#btnDiv button').click(function(){
		telentList($(this).val());
	});
	
	
	$(document).on('click','.approvalBtn', function(){
		$.ajax({
			url:"authorityUpdate.do",
			type:"POST",
			data:{
				no:$(this).val(),
				state:2
			},
			success:function(){
				telentList(0);
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
				telentList(0);
			},
			error:function(){
				alert("실패");
			}
		});
	});
	
	$(document).on('click', '.detailBtn', function(){

		$('#cycle-slideshow').empty();
		$('#downloadList li').empty();
		
		$.ajax({
			url:"authorityDetail.do",
			type:"POST",
			data:{no:$(this).val()},
			dataType:"json",
			success:function(data){
				console.log(data);

				if(data.file1!=""){
					$('#cycle-slideshow').append('<img src="" id="imageFile1">');
					$('#imageFile1').attr('src',"<c:url value='/user/authority/"+data.no+"'/>/"+data.file1);
			
					$('#download1').html("<a href='download.do?no="+data.no+"&name="+data.file1+"'>"+data.file1+"</a>");
					$('#download2').html("첨부 파일 없음");
					$('#download3').html("첨부 파일 없음");
				}
				
				if(data.file2!=""){
					$('#cycle-slideshow').append('<img src="" id="imageFile2">');
					
					$('#imageFile2').attr('src',"<c:url value='/user/authority/"+data.no+"'/>/"+data.file2);
					$('#download2').html("<a href='download.do?no="+data.no+"&name="+data.file2+"'>"+data.file2+"</a>");
					$('#download3').html("첨부 파일 없음");
				}
				
				if(data.file3!=""){
					$('#cycle-slideshow').append('<img src="" id="imageFile3">');
					
					$('#imageFile3').attr('src',"<c:url value='/user/authority/"+data.no+"'/>/"+data.file3);
					$('#download3').html("<a href='download.do?no="+data.no+"&name="+data.file3+"'>"+data.file3+"</a>");
				}
				
				$('#cycle-slideshow').cycle({
					fx: 'fade',
					speed: 300,
					timeout:0,
					next:'#nextImg',
					prev:'#prevImg'
				});
				
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
		width: 750px;
		text-align: center;
		margin:10px 0px;
		
	}
	#talentTable{
		margin: 0 auto;
	}
	#talentList td{
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
	img{
		width: 550px;
		height: 600px;
	}
	ul{
		text-align: left;
	}
	.col-md-8{
		position: relative;
		left: 10%;
	}
	#btnDiv{
		text-align:center;
		position: absolute;
		top: 95%;
		left: 55%;
	}
	#talentList>tbody>tr:first-child{
		background-color: #cecece;
	}
	#talentList>tbody>tr{
		border-bottom: 1px solid #e4e4e4;
		border-top: 1px solid #e4e4e4;
	}
	</style>
	<input type="hidden" id="currentPage" value="">
	<div id="fh5co-main">
		<div class="container">
			<div class="row">
			
				<div class="col-md-8 col-md-offset-2">
					<h2>권한 신청 매니저</h2>
					<table id="talentList">
						<tr>
							<td>번호</td>
							<td>아이디</td>
							<td>재능</td>
							<td>신청일시</td>
							<td>첨부</td>
							<td>비고</td>
						</tr>
					</table>
						  
				</div>
				<div id="btnDiv">
					<button class="btn-sm btn-info prev" value="">이전</button>&nbsp;&nbsp;&nbsp;&nbsp;<button class="btn-sm btn-info next" value="">다음</button>
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
						        	<div id="cycle-slideshow" >
<!-- 							         	<img src="images/img_1.jpg" id="imageFile1"> -->
<!-- 							          	<img src="images/img_1.jpg" id="imageFile2"> -->
<!-- 							          	<img src="images/img_1.jpg" id="imageFile3"> -->
						          	</div>
						          	<div id="nav" class="nav">
						          		<a id="prevImg" href="#">이전</a>
						          		<a id="nextImg" href="#">다음</a>
						          	</div>
						        </div>
						        <div class="modal-footer">
						        	<ul id="downloadList">
						        		<li id="download1"></li>
						        		<li id="download2"></li>
						        		<li id="download3"></li>
						        	</ul>
						        </div>
						      </div>
						      
						    </div>
						  </div>
						  <!-- Modal -->
	
</body>
</html>