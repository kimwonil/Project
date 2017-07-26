<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	
function qnaList(){
		
		$.ajax({
			url:"qnaList.do",
			type:"POST",
			dataType:"json",
			success:function(data){
				console.log(data);
				$('#qnaTable tr:gt(0)').remove();
				for(var i=0;i<data.length;i++){
				$('#qnaTable').append("<tr><td>"+data[i].date+"</td><td>"
												+data[i].no+"</td><td>"
												+data[i].category_no+"</td><td><a id='"+data[i].no+"'class='QnADetail' data-toggle='modal' data-target='#QnAContentModal'>"
												+(data[i].open==0?data[i].title:"비공개")+"</a></td><td>"
												+(data[i].open==0?data[i].writer:"비공개")+"</td><td>"
												+(data[i].state==0?"미답변":"답변완료")+"</td><td>"
												+data[i].read_count+"</td></tr>");
				}
			},
			error:function(jqXHR, textStatus, errorThrown){
				console.log(textStatus);
				console.log(errorThrown);
			}
		});
		
	};
	
function noticeList(){
		
		$.ajax({
			url:"noticeList.do",
			type:"POST",
			dataType:"json",
			success:function(data){
				console.log(data);
				$('#noticeTable tr:gt(0)').remove();
				for(var i=0;i<data.length;i++){
				$('#noticeTable').append("<tr><td>"+data[i].date+"</td><td>"
												+data[i].no+"</td><td>"
												+data[i].category_no+"</td><td><a id='"+data[i].no+"'class='NoticeDetail' data-toggle='modal' data-target='#NoticeContentModal'>"
												+data[i].title+"</a></td><td>"
												+data[i].writer+"</td><td>"
												+data[i].read_count+"</td></tr>");
				}
			},
			error:function(jqXHR, textStatus, errorThrown){
				console.log(textStatus);
				console.log(errorThrown);
			}
		});
		
	};
	
function reportList(){
		
		$.ajax({
			url:"reportList.do",
			type:"POST",
			dataType:"json",
			success:function(data){
				console.log(data);
				$('#reportTable tr:gt(0)').remove();
				for(var i=0;i<data.length;i++){
				$('#reportTable').append("<tr><td>"+data[i].date+"</td><td>"
												+data[i].no+"</td><td>"
												+data[i].category_no+"</td><td><a id='"+data[i].no+"'class='ReportDetail' data-toggle='modal' data-target='#ReportContentModal'>"
												+data[i].title+"</a></td><td>"
												+data[i].writer+"</td><td>"
												+(data[i].state==0?"미처리":"처리완료")+"</td><td>"
												+data[i].read_count+"</td></tr>");
				}
			},
			error:function(jqXHR, textStatus, errorThrown){
				console.log(textStatus);
				console.log(errorThrown);
			}
		});
		
	};
	noticeList();
	qnaList();
	reportList();
	//질문 상세
	$(document).on('click','.QnADetail',function(){
		$.ajax({
			url:"qnaContent.do",
			type:"POST",
			data:{no:$(this).attr('id')},
			dataType:"json",
			success:function(data){
				qnaList();
				$('#QnAtitleLabel').text(data.title);
				$('#QnAwriterLabel').text(data.writer);
				$('#QnAcontentLabel').text(data.content);
				$('#QnAUpdateForm').val(data.no);
				$('#QnADelete').val(data.no);
			},
			error:function(){
				alert("실패");
			}
		});
		
	});
	//질문 수정폼
		$(document).on('click','#QnAUpdateForm',function(){
			
			
			$.ajax({
				url:"qnaContent.do",
				type:"POST",
				data:{no:$("#QnAUpdateForm").val()},
				dataType:"json",
				success:function(data){
					qnaList();

					var cate=data.category_no;
					var minor=cate%10;
					var major=(cate-minor)/10;
					alert(data.title);
					alert(data.content);
					$('#QnAContentModal').modal('hide');
					$('#QnAMajorUpdate option:eq('+major+')').prop("selected", true);
					$('#QnAMinorUpdate option:eq('+minor+')').prop("selected", true);
					$('#QnAtitleUpdate').val(data.title);
					$('#QnAcontentUpdate').text(data.content);
					$('#QnAUpdateBtn').val(data.no);
					$('input:radio[name=QnAUpdateopen]:input[value=' + data.open + ']').attr("checked", true);

				},
				error:function(){
					alert("실패");
				}
			});
			
		});
	
	
		//질문 수정
		$(document).on('click','#QnAUpdateBtn',function(){

			var category=""+$('#QnAMajorUpdate').val()+""+$('#QnAMinorUpdate').val();

			$.ajax({
				url:"QnAUpdate.do",
				type:"POST",
				data:{
				no:$("#QnAUpdateBtn").val(),
				category_no:category,
				title:$('#QnAtitleUpdate').val(),
				content:$('#QnAcontentUpdate').val(),
				open:$(":input:radio[name=QnAUpdateopen]:checked").val()
				},
				success:function(){
					qnaList();
					alert("성공");
					$('#QnAContentUpdateModal').modal('hide');
				},
				error:function(){
					alert("실패");
				}
			});
			
		});
		//질문 삭제
	$(document).on('click','#QnADelete',function(){

		

		$.ajax({
			url:"deleteQnA.do",
			type:"POST",
			data:{
			no:$('#QnADelete').val(),
			
			},
			success:function(){
				qnaList();
				alert("성공");
				$('#QnAContentModal').modal('hide');
			},
			error:function(){
				alert("실패");
			}
		});
		
	});
	//공지 상세
	$(document).on('click','.NoticeDetail',function(){
		$.ajax({
			url:"noticeContent.do",
			type:"POST",
			data:{no:$(this).attr('id')},
			dataType:"json",
			success:function(data){
				noticeList();
				$('#NoticetitleLabel').text(data.title);
				$('#NoticewriterLabel').text(data.writer);
				$('#NoticecontentLabel').text(data.content);
				$('#NoticeUpdateForm').val(data.no);
				$('#NoticeDelete').val(data.no);
			},
			error:function(){
				alert("실패");
			}
		});
		
	});
	//공지 수정폼
	$(document).on('click','#NoticeUpdateForm',function(){
		
		
		$.ajax({
			url:"noticeContent.do",
			type:"POST",
			data:{no:$("#NoticeUpdateForm").val()},
			dataType:"json",
			success:function(data){
				noticeList();
// 				alert(data.category_no);
// 				alert(data.content);
				var cate=data.category_no;
				var minor=cate%10;
				var major=(cate-minor)/10;
			
				
				$('#NoticeContentModal').modal('hide');
				$('#NoticeMajorUpdate option:eq('+major+')').prop("selected", true);
				$('#NoticeMinorUpdate option:eq('+minor+')').prop("selected", true);
				$('#NoticetitleUpdate').val(data.title);
				$('#NoticecontentUpdate').text(data.content);
				$('#NoticeUpdateBtn').val(data.no);
				
			},
			error:function(){
				alert("실패");
			}
		});
		
	});
	//공지 수정
	$(document).on('click','#NoticeUpdateBtn',function(){

		var category=""+$('#NoticeMajorUpdate').val()+""+$('#NoticeMinorUpdate').val();

		$.ajax({
			url:"NoticeUpdate.do",
			type:"POST",
			data:{
			no:$("#NoticeUpdateBtn").val(),
			category_no:category,
			title:$('#NoticetitleUpdate').val(),
			content:$('#NoticecontentUpdate').val()
			},
			success:function(){
				noticeList();
				alert("성공");
				$('#NoticeContentUpdateModal').modal('hide');
			},
			error:function(){
				alert("실패");
			}
		});
		
	});
	//공지 삭제
	$(document).on('click','#NoticeDelete',function(){

		

		$.ajax({
			url:"deleteNotice.do",
			type:"POST",
			data:{
			no:$('#NoticeDelete').val(),
			
			},
			success:function(){
				noticeList();
				alert("성공");
				$('#NoticeContentModal').modal('hide');
			},
			error:function(){
				alert("실패");
			}
		});
		
	});
	
	
	
	$(document).on('click','.ReportDetail',function(){
		$.ajax({
			url:"reportContent.do",
			type:"POST",
			data:{no:$(this).attr('id')},
			dataType:"json",
			success:function(data){
				reportList();
				$('#ReporttitleLabel').text(data.title);
				$('#ReportwriterLabel').text(data.writer);
				$('#ReportcontentLabel').text(data.content);
			},
			error:function(){
				alert("실패");
			}
		});
		
	});

	
	$(document).on('click','#qnainsert',function(){
		
		
		$.ajax({
			url:"insertQuestion.do",
			type:"POST",
			data:{
				major:$('#qnaMajor').val(),
				minor:$('#qnaMinor').val(),
				title:$('#qnaTitle').val(),
				content:$('#qnaContent').val(),
				open:$(":input:radio[name=qnaopen]:checked").val()
			},
			success:function(){
				alert("성공");
				qnaList();
				$('#QnAinsertModal').modal('hide');
				$('#qnaMajor option:eq(0)').prop("selected", true);
				$('#qnaMinor option:eq(0)').prop("selected", true);
				$('#qnaTitle').val("");
				$('#qnaContent').val("");
				$(":input:radio[name=qnaopen]").removeAttr('checked');
			},
			error:function(jqXHR, textStatus, errorThrown){
				console.log(textStatus);
				console.log(errorThrown);
				alert("실패");
			}
		});
		
	});
	
$(document).on('click','#reportinsert',function(){
		
		
		$.ajax({
			url:"insertReport.do",
			type:"POST",
			data:{
				major:$('#reportMajor').val(),
				minor:$('#reportMinor').val(),
				title:$('#reportTitle').val(),
				content:$('#reportContent').val()
				
			},
			success:function(){
				alert("성공");
				reportList();
				$('#ReportinsertModal').modal('hide');
				$('#reportMajor option:eq(0)').prop("selected", true);
				$('#reportMinor option:eq(0)').prop("selected", true);
				$('#reportTitle').val("");
				$('#reportContent').val("");
			
			},
			error:function(jqXHR, textStatus, errorThrown){
				console.log(textStatus);
				console.log(errorThrown);
				alert("실패");
			}
		});
		
	});
</script>
<style type="text/css">
#tabs tr, #tabs td, #tabs th {
	border: 1px solid black;
}
</style>
</head>
<body>

	<div id="fh5co-main">
		<div class="container">
			<div class="row">
				<div class="col-md-8 col-md-offset-2">
					<h2>고객센터</h2>
					<div id="tabs">
						<ul>
							<li><a href="#tabs-1" id="noticeList">공지사항</a></li>
							<li><a href="#tabs-2" id="qnaList">Q & A</a></li>
							<li><a href="#tabs-3" id="reportList">신 고</a></li>

						</ul>
						<div align="center">
							<select>
								<option>검색조건</option>
								<option>닉네임</option>
								<option>글제목</option>
								<option>날짜</option>
							</select> <input type="text">
							<button>검색</button>
						</div>
						<div class="fh5co-spacer fh5co-spacer-sm"></div>
						<div id="tabs-1">
							<table id="noticeTable" style="width: 100%;">
								<tr>
									<th>등록일</th>
									<th>글번호</th>
									<th>분류</th>
									<th>글제목</th>
									<th>작성자</th>
									<th>조회수</th>

								</tr>


							</table>
							<c:choose>

								<c:when test="${member.admin==1}">
									<br>
									<div class="form-group" style="text-align: right;">
										<form action="noticeForm.jsp">
											<input type="submit" class="btn btn-primary btn-sm"
												value="공지사항등록" style="width: 145px; height: 40px;">
										</form>
									</div>
								</c:when>
							</c:choose>
						</div>
						<div id="tabs-2">
							<table id="qnaTable" style="width: 100%;">
								<tr>
									<th>등록일</th>
									<th>글번호</th>
									<th>분류</th>
									<th>글제목</th>
									<th>작성자</th>
									<th>답변상태</th>
									<th>조회수</th>

								</tr>


							</table>

							<br>
							<div class="form-group" style="text-align: right;">
								<button type="button" class="btn btn-info btn-lg"
									data-toggle="modal" data-target="#QnAinsertModal">Q &
									A 등록</button>
							</div>
							<!-- Modal -->
							<div class="modal fade" id="QnAinsertModal" role="dialog">
								<div class="modal-dialog modal-lg">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal">&times;</button>
											<h4 class="modal-title">Q & A 등록</h4>
										</div>
										<div class="modal-body">




											<table class="table">
												<tr>
													<th>카테고리</th>
													<th><select name="major" id="qnaMajor">
															<option>대분류</option>
															<option value="1">카테고리1</option>
															<option value="2">카테고리2</option>
															<option value="3">카테고리3</option>
													</select> <select name="minor" id="qnaMinor">
															<option>소분류</option>
															<option value="1">카테고리1</option>
															<option value="2">카테고리2</option>
															<option value="3">카테고리3</option>
													</select></th>
												</tr>
												<tr>
													<th>질문 제목</th>
													<th><input type="text" name="title" id="qnaTitle"></th>
												</tr>
												<tr>
													<th>질문 내용</th>
													<th><textarea rows="10" cols="50" name="content"
															id="qnaContent"></textarea></th>
												</tr>
												<tr>
													<th>공개/비공개</th>
													<th><input type="radio" name="qnaopen" value="0">공개
														<input type="radio" name="qnaopen" value="1">비공개</th>
												</tr>
											</table>
											<div class="fh5co-spacer fh5co-spacer-sm"></div>
											<input type="button" class="btn btn-sm btn-primary"
												id="qnainsert" value="질문하기">
											<button type="button" class="btn btn-primary btn-sm"
												data-dismiss="modal">취소하기</button>


										</div>

									</div>
								</div>
							</div>
						</div>
						<div id="tabs-3">
							<table id="reportTable" style="width: 100%;">
								<tr>
									<th>등록일</th>
									<th>글번호</th>
									<th>분류</th>
									<th>글제목</th>
									<th>작성자</th>
									<th>처리상태</th>
									<th>조회수</th>
								</tr>

							</table>
							<br>
							<div class="form-group" style="text-align: right;">
								<button type="button" class="btn btn-info btn-lg"
									data-toggle="modal" data-target="#ReportinsertModal">신고
									등록</button>
							</div>
							<!-- Modal -->
							<div class="modal fade" id="ReportinsertModal" role="dialog">
								<div class="modal-dialog modal-lg">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal">&times;</button>
											<h4 class="modal-title">신고 등록</h4>
										</div>
										<div class="modal-body">




											<table class="table">
												<tr>
													<th>카테고리</th>
													<th><select name="major" id="reportMajor">
															<option>대분류</option>
															<option value="1">카테고리1</option>
															<option value="2">카테고리2</option>
															<option value="3">카테고리3</option>
													</select> <select name="minor" id="reportMinor">
															<option>소분류</option>
															<option value="1">카테고리1</option>
															<option value="2">카테고리2</option>
															<option value="3">카테고리3</option>
													</select></th>
												</tr>
												<tr>
													<th>신고 제목</th>
													<th><input type="text" name="title" id="reportTitle"></th>
												</tr>
												<tr>
													<th>신고 내용</th>
													<th><textarea rows="10" cols="50" name="content"
															id="reportContent"></textarea></th>
												</tr>

											</table>
											<div class="fh5co-spacer fh5co-spacer-sm"></div>
											<input type="button" class="btn btn-sm btn-primary"
												id="reportinsert" value="신고하기">
											<button type="button" class="btn btn-primary btn-sm"
												data-dismiss="modal">취소하기</button>


										</div>

									</div>
								</div>
							</div>
						</div>


						<div class="fh5co-spacer fh5co-spacer-sm"></div>



					</div>

					<!--QnAContentModal qna상세-->
					<div class="modal fade" id="QnAContentModal" role="dialog">
						<div class="modal-dialog">

							<!-- Modal content-->
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h4 class="modal-title">질문 상세</h4>
								</div>
								<div class="modal-body">
									<table id="QnADetail">
										<tr>
											<td width="80%">제&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목
												: <label id="QnAtitleLabel"></label>
											</td>
			
										</tr>
										<tr>

											<td width="80%">작성자 : <label id="QnAwriterLabel"></label>
											</td>
										</tr>
										<tr>
											<td colspan="3"><textarea id="QnAcontentLabel" rows="10"
													cols="78" readonly="readonly"></textarea></td>
										</tr>
										<tr>
											<td><button type="button" class="btn btn-sm btn-danger"
													id="QnAUpdateForm" data-toggle="modal"
													data-target="#QnAContentUpdateModal">질문 수정 하기</button>
												<button type="button" id="QnADelete"
													class="btn btn-sm btn-danger">질문 삭제</button></td>
										</tr>
									</table>
								</div>
							</div>

						</div>
					</div>
					<!-- qna상세 끝 -->
				<!--QnAContentUpdateModal Notice업데이트상세-->
					<div class="modal fade" id="QnAContentUpdateModal" role="dialog">
						<div class="modal-dialog">

							<!-- Modal content-->
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h4 class="modal-title">질문 수정</h4>
								</div>
								<div class="modal-body">
									<table id="qnaDetail">
										<tr>
											<th>카테고리</th>
											<th><select id="QnAMajorUpdate" name="major">
													<option>대분류</option>
													<option value="1">카테고리1</option>
													<option value="2">카테고리2</option>
													<option value="3">카테고리3</option>
											</select> <select id="QnAMinorUpdate" name="minor">
													<option>소분류</option>
													<option value="1">카테고리1</option>
													<option value="2">카테고리2</option>
													<option value="3">카테고리3</option>
											</select></th>
										</tr>
										<tr>
											<th>제목 :</th>
											<td><input size="48" type="text" id="QnAtitleUpdate"></td>
										</tr>

										<tr>
											<th>내용 :</th>
											<td><textarea id="QnAcontentUpdate" rows="10"
													cols="50"></textarea></td>
										</tr>
											<tr><th>공개/비공개</th>
									<th> 
									<input type="radio" name="QnAUpdateopen" value="0">공개
									<input type="radio" name="QnAUpdateopen" value="1">비공개 
									</th>
									</tr>
										<tr>
											<td><button type="button" class="btn btn-sm btn-danger"
													id="QnAUpdateBtn">질문 수정</button></td>
										</tr>
									</table>
								</div>
							</div>

						</div>
					</div>
					<!--qna업데이트상세 끝 -->
					<!--NoticeContentModal Notice상세-->
					<div class="modal fade" id="NoticeContentModal" role="dialog">
						<div class="modal-dialog">

							<!-- Modal content-->
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h4 class="modal-title">공지 상세</h4>
								</div>
								<div class="modal-body">
									<table id="NoticeDetail">
										<tr>
											<td width="80%">제&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목
												: <label id="NoticetitleLabel"></label>
											</td>

										</tr>
										<tr>

											<td width="80%">작성자 : <label id="NoticewriterLabel"></label>
											</td>
										</tr>
										<tr>
											<td colspan="3"><textarea id="NoticecontentLabel"
													rows="10" cols="78" readonly="readonly"></textarea></td>
										</tr>

										<tr>
											<td><button type="button" class="btn btn-sm btn-danger"
													id="NoticeUpdateForm" data-toggle="modal"
													data-target="#NoticeContentUpdateModal">공지 수정 하기</button>
												<button type="button" id="NoticeDelete"
													class="btn btn-sm btn-danger">공지 삭제</button></td>
										</tr>
									</table>
								</div>
							</div>

						</div>
					</div>
					<!-- Notice상세 끝 -->

					<!--NoticeContentUpdateModal Notice업데이트상세-->
					<div class="modal fade" id="NoticeContentUpdateModal" role="dialog">
						<div class="modal-dialog">

							<!-- Modal content-->
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h4 class="modal-title">공지 상세</h4>
								</div>
								<div class="modal-body">
									<table id="NoticeDetail">
										<tr>
											<th>카테고리</th>
											<th><select id="NoticeMajorUpdate" name="major">
													<option>대분류</option>
													<option value="1">카테고리1</option>
													<option value="2">카테고리2</option>
													<option value="3">카테고리3</option>
											</select> <select id="NoticeMinorUpdate" name="minor">
													<option>소분류</option>
													<option value="1">카테고리1</option>
													<option value="2">카테고리2</option>
													<option value="3">카테고리3</option>
											</select></th>
										</tr>
										<tr>
											<th>제목 :</th>
											<td><input size="48" type="text" id="NoticetitleUpdate"></td>
										</tr>

										<tr>
											<th>내용 :</th>
											<td><textarea id="NoticecontentUpdate" rows="10"
													cols="50"></textarea></td>
										</tr>
										<tr>
											<td><button type="button" class="btn btn-sm btn-danger"
													id="NoticeUpdateBtn">공지 수정</button></td>
										</tr>
									</table>
								</div>
							</div>

						</div>
					</div>
					<!-- Notice업데이트상세 끝 -->

					<!--ReportContentModal Report상세-->
					<div class="modal fade" id="ReportContentModal" role="dialog">
						<div class="modal-dialog">

							<!-- Modal content-->
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h4 class="modal-title">신고 상세</h4>
								</div>
								<div class="modal-body">
									<table id="NoticeDetail">
										<tr>
											<td width="80%">제&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목
												: <label id="ReporttitleLabel"></label>
											</td>
											<td width="20%" rowspan="2" align="center"><button
													type="button" id="reportDelete"
													class="btn btn-sm btn-danger">삭제</button></td>
										</tr>
										<tr>

											<td width="80%">작성자 : <label id="ReportwriterLabel"></label>
											</td>
										</tr>
										<tr>
											<td colspan="3"><textarea id="ReportcontentLabel"
													rows="10" cols="78" readonly="readonly"></textarea></td>
										</tr>
									</table>
								</div>
							</div>

						</div>
					</div>
					<!-- Report상세 끝 -->



				</div>
			</div>
		</div>
	</div>
</body>
</html>