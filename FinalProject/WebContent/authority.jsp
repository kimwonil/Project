<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="menu.jsp" %>
    <%@ include file="miniProfile.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<style>
	#talentList{
		border: 1px solid black;
		width: 700px;
		text-align: center;
		
	}
	#talentTable{
		margin: 0 auto;
	}
	#talentList td{
		border: 1px solid black;
		text-align: center;
	}
	
	.btn-danger{
		margin: 10px auto;
	}
	
	</style>
	
	<div id="fh5co-main">
		<div class="container">
			<div class="row">
			
				<div class="col-md-8 col-md-offset-2">
					<h2>권한신청</h2>
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
					<button type="button" class="btn btn-sm btn-info" data-toggle="modal" data-target="#addModal">재능 신청</button>

						  <!-- 재능 신청 Modal -->
						  <div class="modal fade" id="addModal" role="dialog">
						    <div class="modal-dialog">
						    
						      <!-- Modal content-->
						      <div class="modal-content">
						        <div class="modal-header">
						          <button type="button" class="close" data-dismiss="modal">&times;</button>
						          <h4 class="modal-title">재능 신청</h4>
						        </div>
						        <div class="modal-body">
						          <table id="talentTable">
										<tr>
											<td>신청 재능</td>
											<td>
												<select>
													<option>디자인/그래픽</option>
													<option>컴퓨터/개발</option>
													<option>음악/영상</option>
													<option>생활/대행/상담</option>
													<option>노하우/여행</option>
												</select>
											</td>
										</tr>
										<tr>
											<td colspan="2"><b>관련 자료</b></td>
										</tr>
										<tr>
											<td colspan="2"><input type="file"></td>
										</tr>
										<tr>
											<td colspan="2"><input type="file"></td>
										</tr>
										<tr>
											<td colspan="2"><input type="file"></td>
										</tr>
									</table>
						        </div>
						        <div class="modal-footer">
						          <button type="button" class="btn btn-sm btn-info" data-dismiss="modal">닫기</button>
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
						         	<b>등록된 재능을 삭제하시겠습니까?</b>
						          <button type="button" class="btn btn-danger">삭제</button>
						          <button type="button" class="btn btn-info" data-dismiss="modal">닫기</button>
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