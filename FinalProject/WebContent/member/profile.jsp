<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../menu.jsp" %>
    <%@ include file="../miniProfile.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	
	</head>
	<link rel="stylesheet" href="css/starStyle.css">
	<body>
	<style>
	.photo{
		position: relative;
		float: left;
		margin-right: 30px;
		width: 300px;
		height: 300px;
		
	}
	#mainTable{
		display: inline;
	}
	textarea{
		resize: none;
	}
	#profileTable{
		margin: 0px auto;
	}
	#profileTable input[type=text]{
		width:256px;
	}
	#profileTable select{
		height: 31px;
	}
	#introduce{
		margin-top: 70px;
	}
	#introduce textarea{
		margin: 2px 0px 4px 0px;
	}
	#bottomTable{
		
	}
	.col-md-offset-2 {margin-left: 32.66667% !important; }
	.star-ratings-css{margin: -6px 30px 5px  10px; float: left;}
	#star {width: }
	#totalNum {position: relative; top: 4px;}
	</style>
	<script type="text/javascript">
	
	//별점 넣기
	$(document).ready(function(){
		$('#star').css('width', $('#hiddenStar').val()*25+'%');
		
	});//별점넣기 끝
	
	
		$(document).on('click', '#updateBtn', function(){
			var length = $('#accountNum').val();
			if(!$.isNumeric(length) || length.length > 15){
				alert("숫자만 입력하세요.(15자 이하)");
				$('#accountNum').focus();
				$('#accountNum').val(length.substr(0,15));
			}else{
				$('#updataForm').submit();
			}
		});
	
	
	</script>
	
	<div id="fh5co-main">
		<div class="container">
			<div class="row">
			
				<div class="col-md-8 col-md-offset-2">
					<h2>프로필 관리</h2>
					<c:if test="${member.photo eq null}">
						<img class="photo" src="<c:url value="/images"/>/noimage.jpg">
					</c:if>
					<c:if test="${member.photo ne null}">
						<img class="photo" src="<c:url value="/user/profile/${member.id}/${member.login}"/>/${member.photo}">
					</c:if>
					<table id="mainTable" class="table">
						<tr>
							<td>아이디 : ${member.id}</td>
						</tr>
						<tr>
							<td>사진 : ${member.photo}</td>
						</tr>
						<tr>
							<td>계좌 : ${member.bank} / ${member.account}</td>
						</tr>
						<tr>
							<td><div>판매평점 : </div>
							<div class="star-ratings-css">
								<div class="star-ratings-css-top" id="star">
									<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
								</div>
								<div class="star-ratings-css-bottom">
									<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
								</div>
							
							<input type="hidden" value="${star}" id="hiddenStar">
							</div>
							
							<span id="totalNum"> (${totalNum})</span>	</td>
						</tr>
<!-- 						<tr> -->
<%-- 							<td>관리자 : ${member.admin}</td> --%>
<!-- 						</tr> -->
						<tr>
							<td>관심분야 : <button onclick="location.href='dipsList.do?nickname=${member.nickname}'">찜목록</button></td>
						</tr>
						<tr>
							<td>계좌 : ${member.bank} / ${member.account} </td>
						</tr>
						<tr>
						<td></td>
						</tr>
					</table>
					<table id="introduce">
					<tr><td>소개글</td></tr>
						<tr>
							<td><textarea rows="10" cols="75" readonly="readonly">${member.introduce}</textarea></td>
						</tr>
					</table>
					<table id="bottomTable">
					
						<tr>
							<td colspan="2">판매 가능 재능 목록</td>
						</tr>
						<tr>
							<td colspan="2">
								<ul>
									<c:choose>
										<c:when test="${authority ne null}">
											<c:forEach items="${authority}" var="authorityList">
												<li>${authorityList.categoryName} / 등록일 : ${authorityList.date} / 상태 : 
												<c:choose>
													<c:when test="${authorityList.state==1}">
														승인 대기중
													</c:when>
													<c:when test="${authorityList.state==2}">
														승인 완료
													</c:when>
													<c:otherwise>
														승인 취소
													</c:otherwise>
												</c:choose>
												</li>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<li>판매 가능한 재능이 없습니다.</li>	
										</c:otherwise>
									</c:choose>
								</ul>
							</td>
						</tr>
					</table>
					<div class="fh5co-spacer fh5co-spacer-sm"></div>
					<a data-toggle="modal" href="#profileModal" class="btn btn-sm btn-info">정보 수정</a>
					<c:if test="${member.admin==1}">
						<a href="memberManager.do" class="btn btn-sm btn-info">회원관리</a>
					</c:if>
				</div>
        	</div>
       </div>
	</div>

	<!-- 프로필 수정  Modal -->
	<div class="modal fade" id="profileModal" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">정보 수정</h4>
				</div>
				<div class="modal-body">
					<form id="updataForm" action="profileUpdate.do" method="post" enctype="multipart/form-data">
					<table id="profileTable">
						<tr>
							<td width="20%">계좌번호 : </td>
							<td>
								<select name="bank">
									<c:forEach items="${bankList}" var="bankValue">
										<option value="${bankValue.no}" >${bankValue.bank}</option>
									</c:forEach>
								</select>
							<input id="accountNum" type="text" name="account" value="${member.account}"></td>
						</tr>
						<tr>
							<td>소개글 : </td>
							<td><textarea rows="10" cols="50" name="introduce">${member.introduce}</textarea></td>
						</tr>
						<tr>
							<td>사진 : </td><td><input type="file" name="file"></td>
						</tr>
					</table>
					<input id="updateBtn" type="button" value="수정" class="btn-sm btn-info">
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal -->



</body>
</html>