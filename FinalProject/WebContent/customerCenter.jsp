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

<title>ShareAbility</title>



<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script>
	$(function() {
		$("#tabs").tabs();
	 	noticeList(1,0,"0");
	 	qnaList(1,0,"0");
	 	reportList(1,0,"0");
	 	
	});
	
	var member_id = "<%=session.getAttribute("member")%>"
	var a=member_id.indexOf(",");
	var b=member_id.indexOf(",",a+1);

	var admin=member_id.indexOf("admin");
	var num=member_id.substr(admin+6,1);
	var n=member_id.indexOf("nickname");
	var id=member_id.substr(n+9,b-(n+9));
	
	var Noticepage=1;
	var Noticetype=0;
	var Noticekeyword;
	var Noticestart;
	var Noticeend;
	
	var QnApage=1;
	var QnAtype=0;
	var QnAkeyword;
	var QnAstart;
	var QnAend;
	
	
	var Reportpage=1;
	var Reporttype=0;
	var Reportkeyword;
	var Reportstart;
	var Reportend;
	

	
		
	//공지 리스트
function noticeList(page,type,keyword,start,end){

		if(type==null || keyword==null)
			{
			type=0;
			keyword="0";
			}
	
		var startDate=new String();
		startDate=start;

		var endDate=new String();
		endDate=end;

		noticePage(page,type,keyword,start,end);
		$.ajax({
			url:"noticeList.do",
			type:"POST",
			dataType:"json",
			data:{
			page:page,
			type:type,
			keyword:keyword,
			start:startDate,
			end:endDate
			},
			success:function(data){
				console.log(data);
				$('#noticeTable tr:gt(0)').remove();

				for(var i=0;i<data.length;i++){
				$('#noticeTable').append("<tr><td>"+data[i].date+"</td><td>"
												+data[i].no+"</td><td>"
												+"<a id='"+data[i].no+"'class='NoticeDetail' data-toggle='modal' data-target='#NoticeContentModal'>"
												+data[i].title+"</a></td><td>"
												+data[i].writer+"</td><td>"
												+data[i].read_count+"</td></tr>");
				}
// 				$('#noticeTable').append("")
			},
			error:function(jqXHR, textStatus, errorThrown){
				console.log(textStatus);
				console.log(errorThrown);
			}
		});
		
	};
	//공지 페이징
	function noticePage(pagenum,type,keyword,start,end){
		Noticepage=pagenum;
		if(type==null || keyword==null)
			{
			type=0;
			keyword="0";
			}
		var startDate=new String();
		startDate=start;
		
		var endDate=new String();
		endDate=end;
	
		$.ajax({
			url:"noticePage.do",
			type:"POST",
			dataType:"json",
			data:{
				page:pagenum,
				type:type,
				keyword:keyword,
				start:startDate,
				end:endDate
			
			},
			success:function(data){
				console.log(data);
				$('#noticePage tr:gt(0)').remove();
// 				$('#noticePage').closest('li').remove(); 
				var str="<tr><td align=\"center\">";
				
// 				var str="<li>";
				
				if(data.start!=1)
					{
					str=str+
					"<a href='#' onclick='noticeList(1,"+type+",\""+keyword+"\",\""+start+"\",\""+end+"\")'>[처음]</a><a href='#' onclick='noticeList("+
							(data.start-1)+","+type+",\""+keyword+"\",\""+start+"\",\""+end+"\")'>[이전]</a>";
					}
					
				for(var i=data.start;i<=(data.end<data.last?data.end:data.last);i++){
					if(i==data.current)
						{
						str=str+"<b>["+i+"]</b>";
						}
					else
						{
						str=str+"<a href='#' onclick='noticeList("+i+","+type+",\""+keyword+"\",\""+start+"\",\""+end+"\")'>["+i+"]</a>";
						}
				}
				if(data.end<data.last)
					{
					str=str+"<a href='#' onclick='noticeList("+(data.end+1)+","+type+",\""+keyword+"\",\""+start+"\",\""+end+"\")'>[다음]</a>";
					str=str+"<a href='#' onclick='noticeList("+(data.last)+","+type+",\""+keyword+"\",\""+start+"\",\""+end+"\")'>[마지막]</a>";
					}
				str=str+"</td></tr>";
				
				$('#noticePage').append(str);


			},
			error:function(jqXHR, textStatus, errorThrown){
				console.log(textStatus);
				console.log(errorThrown);
			}
		});
		
	}
	
	
	//질문 리스트
function qnaList(page,type,keyword,start,end){
	if(type==null || keyword==null)
	{
	type=0;
	keyword="0";
	}

	var startDate=new String();
	startDate=start;

	var endDate=new String();
	endDate=end;

	qnaPage(page,type,keyword,start,end);
	$.ajax({
		url:"qnaList.do",
		type:"POST",
		dataType:"json",
		data:{
		page:page,
		type:type,
		keyword:keyword,
		start:startDate,
		end:endDate
		},
		success:function(data){
		console.log(data);
		
				$('#qnaTable tr:gt(0)').remove();
				for(var i=0;i<data.length;i++){
					$('#qnaTable').append("<tr><td>"+data[i].date+"</td><td>"
							+data[i].no+"</td><td>"
							+"<a id='"+data[i].no+"'class='QnADetail' data-toggle='modal' data-target='#QnAContentModal'>"
							+(data[i].open==1?"비공개":data[i].title)+"</a></td><td>"
							+data[i].writer+"</td><td>"
							+(data[i].state==0?"미답변":"답변완료")+"</td><td>"
							+data[i].read_count+"</td></tr>");
							};
				
			},
			error:function(jqXHR, textStatus, errorThrown){
				console.log(textStatus);
				console.log(errorThrown);
			}
		});
		
	};

	
	//질문 페이징
	function qnaPage(pagenum,type,keyword,start,end){
		QnApage=pagenum;
		if(type==null || keyword==null)
			{
			type=0;
			keyword="0";
			}
		var startDate=new String();
		startDate=start;
		
		var endDate=new String();
		endDate=end;
	
		$.ajax({
			url:"qnaPage.do",
			type:"POST",
			dataType:"json",
			data:{
				page:pagenum,
				type:type,
				keyword:keyword,
				start:startDate,
				end:endDate
			
			},
			success:function(data){
				console.log(data);
				$('#qnaPage tr:gt(0)').remove();
				var str="<tr><td align=\"center\">";

				if(data.start!=1)
					{
					str=str+
					"<a href='#' onclick='qnaList(1,"+type+",\""+keyword+"\",\""+start+"\",\""+end+"\")'>[처음]</a><a href='#' onclick='qnaList("+
							(data.start-1)+","+type+",\""+keyword+"\",\""+start+"\",\""+end+"\")'>[이전]</a>";
					}
					
				for(var i=data.start;i<=(data.end<data.last?data.end:data.last);i++){
					if(i==data.current)
						{
						str=str+"<b>["+i+"]</b>";
						}
					else
						{
						str=str+"<a href='#' onclick='qnaList("+i+","+type+",\""+keyword+"\",\""+start+"\",\""+end+"\")'>["+i+"]</a>";
						}
				}
				if(data.end<data.last)
					{
					str=str+"<a href='#' onclick='qnaList("+(data.end+1)+","+type+",\""+keyword+"\",\""+start+"\",\""+end+"\")'>[다음]</a>";
					str=str+"<a href='#' onclick='qnaList("+(data.last)+","+type+",\""+keyword+"\",\""+start+"\",\""+end+"\")'>[마지막]</a>";
					}
				str=str+"</td></tr>";
				
				$('#qnaPage').append(str);


			},
			error:function(jqXHR, textStatus, errorThrown){
				console.log(textStatus);
				console.log(errorThrown);
			}
		});
		
	}
	
	//신고 리스트
function reportList(page,type,keyword,start,end){
	if(type==null || keyword==null)
	{
	type=0;
	keyword="0";
	}

	var startDate=new String();
	startDate=start;

	var endDate=new String();
	endDate=end;

	reportPage(page,type,keyword,start,end);
	$.ajax({
		url:"reportList.do",
		type:"POST",
		dataType:"json",
		data:{
		page:page,
		type:type,
		keyword:keyword,
		start:startDate,
		end:endDate
		},
		success:function(data){
		console.log(data);
		$('#reportTable tr:gt(0)').remove();
				for(var i=0;i<data.length;i++){
				$('#reportTable').append("<tr><td>"+data[i].date+"</td><td>"
												+data[i].no+"</td><td>"
												+"<a id='"+data[i].no+"'class='ReportDetail' data-toggle='modal' data-target='#ReportContentModal'>"
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

	//질문 페이징
		function reportPage(pagenum,type,keyword,start,end){
			Reportpage=pagenum;
			if(type==null || keyword==null)
				{
				type=0;
				keyword="0";
				}
			var startDate=new String();
			startDate=start;
			
			var endDate=new String();
			endDate=end;
		
			$.ajax({
				url:"reportPage.do",
				type:"POST",
				dataType:"json",
				data:{
					page:pagenum,
					type:type,
					keyword:keyword,
					start:startDate,
					end:endDate
				
				},
				success:function(data){
					console.log(data);
					$('#reportPage tr:gt(0)').remove();
					var str="<tr><td align=\"center\">";

					if(data.start!=1)
						{
						str=str+
						"<a href='#' onclick='reportList(1,"+type+",\""+keyword+"\",\""+start+"\",\""+end+"\")'>[처음]</a><a href='#' onclick='reportList("+
								(data.start-1)+","+type+",\""+keyword+"\",\""+start+"\",\""+end+"\")'>[이전]</a>";
						}
						
					for(var i=data.start;i<=(data.end<data.last?data.end:data.last);i++){
						if(i==data.current)
							{
							str=str+"<b>["+i+"]</b>";
							}
						else
							{
							str=str+"<a href='#' onclick='reportList("+i+","+type+",\""+keyword+"\",\""+start+"\",\""+end+"\")'>["+i+"]</a>";
							}
					}
					if(data.end<data.last)
						{
						str=str+"<a href='#' onclick='reportList("+(data.end+1)+","+type+",\""+keyword+"\",\""+start+"\",\""+end+"\")'>[다음]</a>";
						str=str+"<a href='#' onclick='reportList("+(data.last)+","+type+",\""+keyword+"\",\""+start+"\",\""+end+"\")'>[마지막]</a>";
						}
					str=str+"</td></tr>";
					
					$('#reportPage').append(str);


				},
				error:function(jqXHR, textStatus, errorThrown){
					console.log(textStatus);
					console.log(errorThrown);
				}
			});
			
		}
		$(document).on('click','#NoticeinsertBtn',function(){
			$('#noticeMajor option:eq(0)').prop("selected", true);
			$('#noticeMinor').empty();
			$('#noticeMinor').append('<option>소분류</option><option>대분류를 선택하세요</option>');
			$('#noticeMinor option:eq(0)').prop("selected", true);
		});
		$(document).on('click','#QnAinsertBtn',function(){
			$('#qnaMajor option:eq(0)').prop("selected", true);
			$('#qnaMinor').empty();
			$('#qnaMinor').append('<option>소분류</option><option>대분류를 선택하세요</option>');
			$('#qnaMinor option:eq(0)').prop("selected", true);
		});
		$(document).on('click','#ReportinsertBtn',function(){
			$('#reportMajor option:eq(0)').prop("selected", true);
		});
		//공지 등록
		$(document).on('click','#noticeinsert',function(){
			
			var titleChk=true;
			var contentChk=true;
			
			
			
			if($('#noticeTitle').val()=='')
				{
				alert("제목을 입력하세요.");
				titleChk=false;
				}
			else if($('#noticeContent').val()=='')
				{
				alert("내용을 입력하세요.");
				contentChk=false;
				}
			
			if(titleChk==true && contentChk==true)
				{
				$.ajax({
					url:"insertNotice.do",
					type:"POST",
					data:{
						
						title:$('#noticeTitle').val(),
						content:$('#noticeContent').val(),
					},
					success:function(){
						
						noticeList(Noticepage,Noticetype,Noticekeyword,Noticestart,Noticeend);
						$('#NoticeinsertModal').modal('hide');
						$('#noticeTitle').val("");
						$('#noticeContent').val("");
					},
					error:function(jqXHR, textStatus, errorThrown){
						console.log(textStatus);
						console.log(errorThrown);
						alert("실패");
					}
				});
				}
			
			
			
		});
	
	
	//공지 상세
		$(document).on('click','.NoticeDetail',function(){
			$.ajax({
				url:"noticeContent.do",
				type:"POST",
				data:{no:$(this).attr('id')},
				dataType:"json",
				success:function(data){
					noticeList(Noticepage,Noticetype,Noticekeyword,Noticestart,Noticeend);
					$('#NoticetitleLabel').text(data.title);
					$('#NoticewriterLabel').text(data.writer);

					$('#NoticecontentLabel').text(data.content);
					$('#NoticeUpdateForm').val(data.no);
					$('#NoticeDelete').val(data.no);
					
					if(num==0)
					{
					$('#NoticeUpdateForm').hide();
					$('#NoticeDelete').hide();
					}
				},
				error:function(jqXHR, textStatus, errorThrown){
	    			alert(textStatus);     //응답상태
	    			alert(errorThrown);     //응답에 대한 메세지
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
					noticeList(Noticepage,Noticetype,Noticekeyword,Noticestart,Noticeend);

				
					
					$('#NoticeContentModal').modal('hide');
					$('#NoticetitleUpdate').val(data.title);
					$('#NoticecontentUpdate').val(data.content);
					$('#NoticeUpdateBtn').val(data.no);
					
				},
				error:function(){
					alert("실패");
				}
			});
			
		});
		//공지 수정
		$(document).on('click','#NoticeUpdateBtn',function(){

		

			
			var titleChk=true;
			var contentChk=true;
			
			
			
			if($('#NoticetitleUpdate').val()=='')
				{
				alert("제목을 입력하세요.");
				titleChk=false;
				}
			else if($('#NoticecontentUpdate').val()=='')
				{
				alert("내용을 입력하세요.");
				contentChk=false;
				}
			
			if(titleChk==true && contentChk==true)
				{
			
			$.ajax({
				url:"NoticeUpdate.do",
				type:"POST",
				data:{
				no:$("#NoticeUpdateBtn").val(),
				title:$('#NoticetitleUpdate').val(),
				content:$('#NoticecontentUpdate').val()
				},
				success:function(){
					noticeList(Noticepage,Noticetype,Noticekeyword,Noticestart,Noticeend);
					
					$('#NoticeContentUpdateModal').modal('hide');
				},
				error:function(){
					alert("실패");
				}
			});
				}
			
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
					noticeList(Noticepage,Noticetype,Noticekeyword,Noticestart,Noticeend);
				
					$('#NoticeContentModal').modal('hide');
				},
				error:function(){
					alert("실패");
				}
			});
			
		});
	//공지 검색
	$(document).on('click','#noticeSerchBtn',function(){
		Noticetype=$('#noticeSerch').val();
		Noticekeyword=$('#noticeSerchKeyword').val();
		Noticestart=$('#noticestartDate').val();
		Noticeend=$('#noticeendDate').val();
		noticeList(1,$('#noticeSerch').val(),$('#noticeSerchKeyword').val(),$('#noticestartDate').val(),$('#noticeendDate').val());
	
	});
	
	//공지 검색 초기화
	$(document).on('click','#noticeResetBtn',function(){
		
		Noticetype=0
		Noticekeyword=null;
		Noticestart=null;
		Noticeend=null;
		$('#noticeSerch option:eq(0)').prop("selected", true);
		$('#noticeSerchKeyword').val("");
		$('#noticestartDate').val("");
		$('#noticeendDate').val("");
		noticeList(1,0,"0",null,null);
	
	});
	
	//질문 상세
	$(document).on('click','.QnADetail',function(){
	
		$.ajax({
			url:"qnaContent.do",
			type:"POST",
			data:{no:$(this).attr('id')},
			dataType:"json",
			success:function(data){
				qnaList(QnApage,QnAtype,QnAkeyword,QnAstart,QnAend);
				$('#QnAtitleLabel').text(data.title);
				$('#QnAwriterLabel').text(data.writer);
				$('#QnAMajorLabel').text(data.HighName);
				$('#QnAMinorLabel').text(data.LowName);
				$('#QnAcontentLabel').text("질문 내용 : "+data.content);
				$('#AnswercontentLabel').text("답변 내용 : "+(data.answercontent==null?"":data.answercontent));
				
				$('#QnAUpdateForm').val(data.no);
				$('#QnADelete').val(data.no);
				$('#AnswerInsertForm').val(data.no);
			
				
				if(id!=data.writer && num==0)
					{
					$("#QnAUpdateForm").hide();
					$("#QnADelete").hide();
					}
				
				if(data.state==0)
					{
					$("#AnswerInsertForm").attr("name","AnswerInsertname")
					
					$("#AnswerInsertForm").attr('data-toggle',"modal");
					$("#AnswerInsertForm").attr('data-target',"#AnswerInsertModal");
					
					$('#AnswerInsertForm').text("답변 등록");
					}
				else
					{
					$("#AnswerInsertForm").attr("name","AnswerUpdate");
					$("#AnswerInsertForm").attr('data-toggle',"modal");
					$("#AnswerInsertForm").attr('data-target',"#AnswerUpdateModal");

					$('#AnswerInsertForm').text("답변 수정");
					}
				if(num==0)
					{
					$('#AnswerInsertForm').hide();
					}
				
			
			},
			error:function(jqXHR, textStatus, errorThrown){
				alert("실패");
				console.log(textStatus);
				console.log(errorThrown);
			}
		});
		
	});
	
	
	//질문 등록
	$(document).on('click','#qnainsert',function(){
		var cateChk=true;
		var titleChk=true;
		var contentChk=true;
		var openChk=true;

		if($('#qnaMajor').val()=='대분류')
			{
			alert("카테고리를 입력하세요.");
			cateChk=false;
			}
		else if($('#qnaTitle').val()=='')
			{
			alert("제목을 입력하세요.");
			titleChk=false;
			}
		else if($('#qnaContent').val()=='')
			{
			alert("내용을 입력하세요.");
			contentChk=false;
			}
		else if($(":input:radio[name=qnaopen]:checked").val()==null)
			{
			alert("공개/비공개를 체크하세요");
			openChk=false;
			}
		
		if(cateChk==true && titleChk==true && contentChk==true && openChk==true)
			{
		
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
				
				qnaList(QnApage,QnAtype,QnAkeyword,QnAstart,QnAend);
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
			}
	});
	
	//답변 폼
	$(document).on('click','button[name=AnswerInsertname]',function(){

		

		$.ajax({
			url:"qnaContent.do",
			type:"POST",
			data:{
			no:$("#AnswerInsertForm").val(),
			},
			dataType:"json",
			success:function(data){
				qnaList(QnApage,QnAtype,QnAkeyword,QnAstart,QnAend);
				$('#QnAAnswertitleLabel').text(data.title);
				$('#QnAAnswerwriterLabel').text(data.writer);
				$('#QnAAnswercontentLabel').text("질문 내용 : "+data.content);
				
				$('#QnAContentModal').modal('hide');
			},
			error:function(jqXHR, textStatus, errorThrown){
				alert("실패");
				console.log(textStatus);
				console.log(errorThrown);
			}
		});
		
	});
	
	//답변 등록
		$(document).on('click','#AnswerInsert',function(){
				
			
			var titleChk=true;
			var contentChk=true;
		
			
	
			if($('#AnswerInsertContent').val()=='')
				{
				alert("내용을 입력하세요.");
				contentChk=false;
				}
			
			
			if(contentChk==true )
				{
	
				$.ajax({
					url:"insertAnswer.do",
					type:"POST",
					data:{
					
						qna_no:$("#AnswerInsertForm").val(),
						content:$('#AnswerInsertContent').val()
					
					},
					success:function(){
						
						qnaList(QnApage,QnAtype,QnAkeyword,QnAstart,QnAend);
						$('#AnswerInsertModal').modal('hide');
					
						$('#AnswerInsertContent').val("");
					
					},
					error:function(jqXHR, textStatus, errorThrown){
						console.log(textStatus);
						console.log(errorThrown);
						alert("실패");
					}
				});
				}
			});
	
	//답변 수정 폼
	$(document).on('click','button[name=AnswerUpdate]',function(){

		

		$.ajax({
			url:"qnaContent.do",
			type:"POST",
			data:{
			no:$("#AnswerInsertForm").val(),
			},
			dataType:"json",
			success:function(data){
				qnaList(QnApage,QnAtype,QnAkeyword,QnAstart,QnAend);
				$('#AnswertitleLabel').text(data.title);
				$('#AnswerwriterLabel').text(data.writer);
				$('#AnswerUpdatecontentLabel').text("질문 내용 : "+data.content);
				$('#AnswerUpdateContent').val(data.answercontent);
				$('#QnAContentModal').modal('hide');
			},
			error:function(jqXHR, textStatus, errorThrown){
				alert("실패");
				console.log(textStatus);
				console.log(errorThrown);
			}
		});
		
	});
	
	//답변 수정
			$(document).on('click','#AnswerUpdate',function(){
				var cateChk=true;
				var titleChk=true;
				var contentChk=true;
			

		
				if($('#AnswerUpdateContent').val()=='')
					{
					alert("내용을 입력하세요.");
					contentChk=false;
					}
				
				
				if(contentChk==true)
					{
				
				

				$.ajax({
					url:"AnswerUpdate.do",
					type:"POST",
					data:{
					qna_no:$("#AnswerInsertForm").val(),
					content:$("#AnswerUpdateContent").val()
					
				
					},
					success:function(){
						qnaList(QnApage,QnAtype,QnAkeyword,QnAstart,QnAend);
						$("#AnswerUpdateContent").val("");
						$('#AnswerUpdateModal').modal('hide');
					},
					error:function(){
						alert("실패");
					}
				});
					}
			});
	
	
	
	//질문 수정폼
		$(document).on('click','#QnAUpdateForm',function(){
			
			
			$.ajax({
				url:"qnaContent.do",
				type:"POST",
				data:{no:$("#QnAUpdateForm").val()},
				dataType:"json",
				success:function(data){
					qnaList(QnApage,QnAtype,QnAkeyword,QnAstart,QnAend);
				
					var cate=data.category_no+"";
					
					var major=cate.substr(0, 3);
					var minor=cate.substring(3, cate.lengh);
					
					major/=100;
					minor*=1;
		
					$('#QnAContentModal').modal('hide');
					$('#QnAMajorUpdate option:eq('+major+')').prop("selected", true);
					$('#QnAtitleUpdate').val(data.title);
					$('#QnAcontentUpdate').val(data.content);
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

			var cateChk=true;
			var titleChk=true;
			var contentChk=true;
			
			
			if($('#QnAMajorUpdate').val()=='대분류')
				{
				alert("카테고리를 입력하세요.");
				cateChk=false;
				}
			else if($('#QnAtitleUpdate').val()=='')
				{
				alert("제목을 입력하세요.");
				titleChk=false;
				}
			else if($('#QnAcontentUpdate').val()=='')
				{
				alert("내용을 입력하세요.");
				contentChk=false;
				}
			
			if(cateChk==true && titleChk==true && contentChk==true)
				{
			
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
					qnaList(QnApage,QnAtype,QnAkeyword,QnAstart,QnAend);
				
					$('#QnAContentUpdateModal').modal('hide');
				},
				error:function(){
					alert("실패");
				}
			});
				}
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
				qnaList(QnApage,QnAtype,QnAkeyword,QnAstart,QnAend);
			
				$('#QnAContentModal').modal('hide');
			},
			error:function(){
				alert("실패");
			}
		});
		
	});
	
	
	//질문 검색
	$(document).on('click','#qnaSerchBtn',function(){
		QnAtype=$('#qnaSerch').val();
		QnAkeyword=$('#qnaSerchKeyword').val();
		QnAstart=$('#qnastartDate').val();
		QnAend=$('#qnaendDate').val();
		qnaList(1,$('#qnaSerch').val(),$('#qnaSerchKeyword').val(),$('#qnastartDate').val(),$('#qnaendDate').val());
	
	});
	
	//질문 검색 초기화
	$(document).on('click','#qnaResetBtn',function(){
		
		QnAtype=0
		QnAkeyword=null;
		QnAstart=null;
		QnAend=null;
		$('#qnaSerch option:eq(0)').prop("selected", true);
		$('#qnaSerchKeyword').val("");
		$('#qnastartDate').val("");
		$('#qnaendDate').val("");
		qnaList(1,0,"0",null,null);
	
	});
		
		
	
	//신고 상세
	$(document).on('click','.ReportDetail',function(){
		$.ajax({
			url:"reportContent.do",
			type:"POST",
			data:{no:$(this).attr('id')},
			dataType:"json",
			success:function(data){
				console.log(data);
				reportList(Reportpage,Reporttype,Reportkeyword,Reportstart,Reportend);
				$('#ReporttitleLabel').text(data.title);
				$('#ReportwriterLabel').text(data.writer);
				$('#ReportMajorLabel').text(data.category);
				$('#ReportcontentLabel').text(data.content);
				if(data.board_no!=0){
					$('#ReprotBoardLabelP').css('display','block');
					$('#ReportBoardLabel').text(data.board_name);
				}else{
					$('#ReprotBoardLabelP').css('display','none');
				}
				$('#ReportUpdateForm').val(data.no);
				$('#ReportDelete').val(data.no);
				$('#ReportClearBtn').val(data.no);
				if(id!=data.writer && num==0)
					{
					$("#ReportDelete").hide();
					}
				if(data.state==0)
					{
					$("#ReportClearBtn").attr("name","ReportClearBtn")
					$('#ReportClearBtn').text("완료 메세지 전송");
					}
				else
					{
					$("#ReportClearBtn").attr("name","ReportClearEndBtn")
					$('#ReportClearBtn').text("처리 완료");
					}

					if(num==0)
					{
					$('#ReportClearBtn').hide();
					}
			},
			error:function(){
				alert("실패");
			}
		});
		
	});
	
	//신고 수정폼
	$(document).on('click','#ReportUpdateForm',function(){
		
		
		$.ajax({
			url:"reportContent.do",
			type:"POST",
			data:{no:$("#ReportUpdateForm").val()},
			dataType:"json",
			success:function(data){
				reportList(Reportpage,Reporttype,Reportkeyword,Reportstart,Reportend);
				
				var cate=data.category;
				
	
				$('#ReportContentModal').modal('hide');
				$('#ReporttitleUpdate').val(data.title);
				$('#ReportcontentUpdate').val(data.content);
				$('#ReportUpdateBtn').val(data.no);
				

			},
			error:function(){
				alert("실패");
			}
		});
		
	});
	
	
	//신고 완료 메세지 전송
			$(document).on('click','button[name=ReportClearBtn]',function(){
// 				alert($("#ReportClearBtn").val());
// 				alert("aa");

				$.ajax({
					url:"ReportClear.do",
					type:"POST",
					data:{
					no:$("#ReportClearBtn").val(),
					},
					success:function(){
						reportList(Reportpage,Reporttype,Reportkeyword,Reportstart,Reportend);
						
						$('#ReportContentModal').modal('hide');
					},
					error:function(){
						alert("실패");
					}
				});
				
			});
	//신고 처리 완료 버튼 클릭
		$(document).on('click','button[name=ReportClearEndBtn]',function(){

			reportList(Reportpage,Reporttype,Reportkeyword,Reportstart,Reportend);
			
				$('#ReportContentModal').modal('hide');

			
				
			});
	
		//신고 삭제
		$(document).on('click','#ReportDelete',function(){
			var deleteCheck = confirm("삭제 하시겠습니까?");
			
			if(deleteCheck){
			
				$.ajax({
					url:"deleteReport.do",
					type:"POST",
					data:{
					no:$('#ReportDelete').val(),
					
					},
					success:function(){
						reportList(Reportpage,Reporttype,Reportkeyword,Reportstart,Reportend);
					
						$('#ReportContentModal').modal('hide');
					},
					error:function(){
						alert("실패");
					}
				});
			}
			
		});
	
	//신고 등록
$(document).on('click','#reportinsert',function(){
		
	var cateChk=true;
	var titleChk=true;
	var contentChk=true;

	
	if($('#reportTitle').val()=='')
		{
		alert("제목을 입력하세요.");
		titleChk=false;
		}
	else if($('#reportContent').val()=='')
		{
		alert("내용을 입력하세요.");
		contentChk=false;
		}
	
	
	if(cateChk==true && titleChk==true && contentChk==true )
		{
		$.ajax({
			url:"insertReport.do",
			type:"POST",
			data:{
				category:$('#reportMajor').val(),
				title:$('#reportTitle').val(),
				content:$('#reportContent').val()
				
			},
			success:function(){
				
				reportList(Reportpage,Reporttype,Reportkeyword,Reportstart,Reportend);
				$('#ReportinsertModal').modal('hide');
				$('#reportMajor option:eq(0)').prop("selected", true);
				$('#reportTitle').val("");
				$('#reportContent').val("");
			
			},
			error:function(jqXHR, textStatus, errorThrown){
				console.log(textStatus);
				console.log(errorThrown);
				alert("실패");
			}
		});
		}
	});
	
	
//신고 검색
$(document).on('click','#reportSerchBtn',function(){
	Reporttype=$('#reportSerch').val();
	Reportkeyword=$('#reportSerchKeyword').val();
	Reportstart=$('#reportstartDate').val();
	Reportend=$('#reportendDate').val();
	reportList(1,$('#reportSerch').val(),$('#reportSerchKeyword').val(),$('#reportstartDate').val(),$('#reportendDate').val());

});

//신고 검색 초기화
$(document).on('click','#reportResetBtn',function(){
	
	Reporttype=0
	Reportkeyword=null;
	Reportstart=null;
	Reportend=null;
	$('#reportSerch option:eq(0)').prop("selected", true);
	$('#reportSerchKeyword').val("");
	$('#reportstartDate').val("");
	$('#reportendDate').val("");
	reportList(1,0,"0",null,null);

});
</script>
<style type="text/css">
#tabs table>tbody>tr:first-child{
	background-color: #cecece;
}
#tabs table>tbody>tr {
	border-bottom: 1px solid #e4e4e4;
	border-top: 1px solid #e4e4e4;
}
#tabs-2, #tabs-1, #tabs-3{
	height: 370px;
}
#tabs-1 div, #tabs-2 div, #tabs-3 div{
	text-align:center;
	position: absolute;
	top: 90%;
	left: 4%;
}
#tabs table{
	text-align: center;
}
.col-md-8{
	position: relative;
	left: 10%;
	top:-50px;
}
.btn-group .btn{
	position: absolute;
	left:570px;
	top:-378px;
}
textarea{
	resize:none;
}
#qnaTitle, #reportTitle, #noticeTitle{
	width: 703px;
}
.QnADetail, .ReportDetail, .NoticeDetail{
	overflow: hidden; 
	text-overflow: ellipsis;
	white-space: nowrap; 
	width: 300px;
	height: 20px;
	display: block;
}
#qnaMajor, #reportMajor{
	width: 703px;
}
#qnaMinor, #reportMinor{
	width: 500px;
}
#noticeMajor{
	width: 30%;
}
#noticeMinor{
	width: 61%;
}
.customerCenterBtn{
	position: relative;
	left: 70%;
}
#ReprotBoardLabelP{
	display: none;
}

</style>
</head>
<body>

	<div id="fh5co-main">
		<div class="container">
			<div class="row">
				<div class="col-md-8 col-md-offset-2"
					style="position: absoulete; left: 100px;">
					<h2>고객센터</h2>
					<div id="tabs" >
						<ul>
							<li><a href="#tabs-1" id="noticeList">공지사항</a></li>
							<li><a href="#tabs-2" id="qnaList">Q & A</a></li>
							<li><a href="#tabs-3" id="reportList">신 고</a></li>
						</ul>
						<div id="tabs-1">
							<table id="noticeTable" 
								style="width: 100%;">
									<tr>
										<th width="15%">등록일</th>
										<th width="10%">글번호</th>
										<th width="30%">글제목</th>
										<th width="20%">작성자</th>
										<th width="10%">조회수</th>
									</tr>

							</table>
							<table id="noticePage"
								style="width: 100%; margin-left: auto; margin-right: auto;">
								<tr>
									<th></th>
								</tr>
							</table>
							
							<div style="top: 366px;">
								<input type="date" id="noticestartDate"> <input
									type="date" id="noticeendDate"> <select
									style="height: 32px;" name="noticeSerch" id="noticeSerch">
									<option value="0">검색조건</option>
									<option value="1">닉네임</option>
									<option value="2">글제목</option>
								</select> <input type="text" id="noticeSerchKeyword"
									style="width: 130px;">
								<button id="noticeSerchBtn" class="btn btn-info btn-sm" style="WIDTH: 40pt; text-align:left; padding-left: 10px; margin-top:15px;">검색</button>
								<button id="noticeResetBtn" class="btn btn-info btn-sm" style="WIDTH: 80pt; text-align:left; padding-left: 10px; margin-top:15px;">검색초기화</button>
							</div>
							<br>
							<c:choose>
								<c:when test="${member.admin==1}">
									<div class="form-group btn-group" style="text-align: right;">
										<button type="button" class="btn btn-info btn-sm"
											data-toggle="modal" data-target="#NoticeinsertModal"
											id="NoticeinsertBtn">공지 등록</button>
									</div>
								</c:when>
							</c:choose>
						</div>
						<div id="tabs-2">
							<table id="qnaTable" 
								style="width: 100%;">
								<tr>
									<th width="15%">등록일</th>
									<th width="10%">글번호</th>
									<th width="28%">글제목</th>
									<th width="22%">작성자</th>
									<th width="15%">답변상태</th>
									<th width="10%">조회수</th>
								</tr>
							</table>
							<table id="qnaPage" style="width: 100%;" align="center">
								<tr>
									<th></th>
								</tr>
							</table>
							<br>
							<div style="top: 366px;">
								<input type="date" id="qnastartDate"> <input type="date"
									id="qnaendDate"> <select style="height: 32px;"
									name="qnaSerch" id="qnaSerch">
									<option value="0">검색조건</option>
									<option value="1">닉네임</option>
									<option value="2">글제목</option>
								</select> <input type="text" id="qnaSerchKeyword" style="width: 130px;">
								<button id="qnaSerchBtn" class="btn btn-info btn-sm" style="WIDTH: 40pt; text-align:left; padding-left: 10px; margin-top:15px;">검색</button>
								<button id="qnaResetBtn" class="btn btn-info btn-sm" style="WIDTH: 80pt; text-align:left; padding-left: 10px; margin-top:15px;">검색초기화</button>
							</div>
							<br>
							<c:choose>
								<c:when test="${member.admin==0 || member.admin==1}">
							<div class="form-group btn-group" style="text-align: right;">
								<button type="button" class="btn btn-info btn-sm"
									data-toggle="modal" data-target="#QnAinsertModal"
									id="QnAinsertBtn">Q&A 등록</button>
							</div>
							</c:when>
							</c:choose>

							
						</div>
						<div id="tabs-3">



							<table id="reportTable" 
								style="width: 100%;">
								<tr>
									<th width="15%">등록일</th>
									<th width="10%">글번호</th>
									<th width="28%">글제목</th>
									<th width="22%">작성자</th>
									<th width="15%">처리상태</th>
									<th width="10%">조회수</th>
								</tr>

							</table>
							<table id="reportPage" style="width: 100%;">
								<tr>
									<th></th>
								</tr>
							</table>

							<br>
							<div style="top: 366px;"> 
								<input type="date" id="reportstartDate" size="40"> <input
									type="date" id="reportendDate" width="15%"> <select
									style="height: 32px;" name="reportSerch" id="reportSerch">
									<option value="0">검색조건</option>
									<option value="1">닉네임</option>
									<option value="2">글제목</option>
								</select> <input type="text" id="reportSerchKeyword"
									style="width: 130px;">
								<button id="reportSerchBtn" class="btn btn-info btn-sm" style="WIDTH: 40pt; text-align:left; padding-left: 10px; margin-top:15px;">검색</button>
								<button id="reportResetBtn" class="btn btn-info btn-sm" style="WIDTH: 80pt; text-align:left; padding-left: 10px; margin-top:15px;">검색초기화</button>
							</div>
							<br>
							<div class="form-group btn-group" style="text-align: right;">
								<button type="button" class="btn btn-info btn-sm"
									data-toggle="modal" data-target="#ReportinsertModal"
									id="ReportinsertBtn">신고 등록</button>
							</div>
						</div>
					</div>
					<!-- Modal -->
							<div class="modal fade" id="NoticeinsertModal" role="dialog">
								<div class="modal-dialog modal-lg">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal">&times;</button>
											<h4 class="modal-title">공지 등록</h4>
										</div>
										<div class="modal-body">
											<table class="table">
							
												<tr>
													<th>공지 제목</th>
													<th><input type="text" name="title" id="noticeTitle"></th>
												</tr>
												<tr>
													<th>공지 내용</th>
													<th><textarea rows="10" cols="85" name="content"
															id="noticeContent"></textarea></th>
												</tr>

											</table>
											<div class="customerCenterBtn">
											<input type="button" class="btn btn-sm btn-primary"
												id="noticeinsert" value="공지 등록">
											<button type="button" class="btn btn-primary btn-sm"
												data-dismiss="modal">취소하기</button>
											</div>

										</div>

									</div>
								</div>
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
													<th>질문 제목</th>
													<th><input type="text" name="title" id="qnaTitle"></th>
												</tr>
												<tr>
													<th>질문 내용</th>
													<th><textarea rows="10" cols="85" name="content"
															id="qnaContent"></textarea></th>
												</tr>
												<tr>
													<th>공개/비공개</th>
													<th><input type="radio" name="qnaopen" value="0" checked="checked">공개
														<input type="radio" name="qnaopen" value="1">비공개</th>
												</tr>
											</table>
											<div class="customerCenterBtn">
											<input type="button" class="btn btn-sm btn-primary"
												id="qnainsert" value="질문하기">
											<button type="button" class="btn btn-primary btn-sm"
												data-dismiss="modal">취소하기</button>
											</div>


										</div>

									</div>
								</div>
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
															<option value="판매 글 관련" selected>판매 글 관련</option>
															<option value="캐시 관련">캐시 관련</option>
															<option value="회원 관련">회원 관련</option>
															<option value="홈페이지 관련">홈페이지 관련</option>
															<option value="기타">기타</option>
													</th>
												</tr>
												<tr>
													<th>신고 제목</th>
													<th><input type="text" name="title" id="reportTitle"></th>
												</tr>
												<tr>
													<th>신고 내용</th>
													<th><textarea rows="10" cols="85" name="content"
															id="reportContent"></textarea></th>
												</tr>

											</table>
											<div class="customerCenterBtn">
											<input type="button" class="btn btn-sm btn-primary"
												id="reportinsert" value="신고하기">
											<button type="button" class="btn btn-primary btn-sm"
												data-dismiss="modal">취소하기</button>
											</div>


										</div>

									</div>
								</div>
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
											<td width="80%">제&nbsp;&nbsp;&nbsp;&nbsp;목
												: <label id="QnAtitleLabel"></label>
											</td>

										</tr>
										<tr>

											<td width="80%">작성자 : <label id="QnAwriterLabel"></label>
											</td>
										</tr>
										
										<tr>
											<td colspan="3"><textarea id="QnAcontentLabel" rows="5"
													cols="78" readonly="readonly"></textarea></td>
										</tr>
										<tr>
											<td><br></td>
										</tr>
										<tr>
											<td colspan="3"><textarea id="AnswercontentLabel"
													rows="5" cols="78" readonly="readonly"></textarea></td>
										</tr>
										<tr>
											<td><br></td>
										</tr>


										<tr>
											<td style="text-align: right;">
											<button type="button" class="btn btn-danger btn-sm"
														id="AnswerInsertForm" name="" data-toggle="modal"
														data-target="#AnswerInsertModal"></button>
											<button type="button" class="btn btn-sm btn-danger"
													id="QnAUpdateForm" data-toggle="modal"
													data-target="#QnAContentUpdateModal">질문 수정</button>
												<button type="button" id="QnADelete"
													class="btn btn-sm btn-danger">질문 삭제</button></td>
										</tr>


										<tr>

											<td><div class="form-group" style="text-align: right;">
													
												</div></td>

										</tr>
									</table>
								</div>
							</div>

						</div>
					</div>
					<!-- qna상세 끝 -->

					<!--QnAContentModal AnswerForm상세-->
					<div class="modal fade" id="AnswerInsertModal" role="dialog">
						<div class="modal-dialog">

							<!-- Modal content-->
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h4 class="modal-title">질문 상세</h4>
								</div>
								<div class="modal-body">
									<table id="AnswerDetail">
										<tr>
											<td width="80%">제&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목
												: <label id="QnAAnswertitleLabel"></label>
											</td>

										</tr>
										<tr>

											<td width="80%">작성자 : <label id="QnAAnswerwriterLabel"></label>
											</td>
										</tr>
										<tr>
											<td colspan="3"><textarea id="QnAAnswercontentLabel"
													rows="5" cols="78" readonly="readonly"></textarea></td>
										</tr>
										<tr>
											<td><br></td>
										</tr>
										<tr>
											<td colspan="3"><textarea id="AnswerInsertContent"
													rows="5" cols="78" placeholder="답변을 입력하세요"></textarea></td>
										</tr>
										<tr>
											<td><br></td>
										</tr>
										<tr>
											<td style="text-align: right;"><button type="button" class="btn btn-sm btn-danger"
													id="AnswerInsert">답변 등록</button>
												<button type="button" id="Answercancel"
													class="btn btn-sm btn-danger" data-dismiss="modal">취소</button></td>
										</tr>

									</table>
								</div>
							</div>

						</div>
					</div>
					<!-- qna상세 끝 -->

					<!--QnAContentModal AnswerUpdateForm상세-->
					<div class="modal fade" id="AnswerUpdateModal" role="dialog">
						<div class="modal-dialog">

							<!-- Modal content-->
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h4 class="modal-title">질문 상세</h4>
								</div>
								<div class="modal-body">
									<table id="AnswerDetail">
										<tr>
											<td width="80%">제&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목
												: <label id="AnswertitleLabel"></label>
											</td>

										</tr>
										<tr>

											<td width="80%">작성자 : <label id="AnswerwriterLabel"></label>
											</td>
										</tr>
										<tr>
											<td colspan="3"><textarea id="AnswerUpdatecontentLabel"
													rows="5" cols="78" readonly="readonly"></textarea></td>
										</tr>
										<tr>
											<td><br></td>
										</tr>
										<tr>
											<td colspan="3"><textarea id="AnswerUpdateContent"
													rows="5" cols="78">답변 입력 : </textarea></td>
										</tr>
										<tr>
											<td><br></td>
										</tr>
										<tr>
											<td style="text-align: right;"><button type="button" class="btn btn-sm btn-danger"
													id="AnswerUpdate">답변 수정</button>
												<button type="button" id="Answercancel"
													class="btn btn-sm btn-danger" data-dismiss="modal">취소</button></td>
										</tr>

									</table>
								</div>
							</div>

						</div>
					</div>
					<!-- qna상세 끝 -->


					<!--QnAContentUpdateModal qna업데이트상세-->
					<div class="modal fade" id="QnAContentUpdateModal" role="dialog">
						<div class="modal-dialog modal-lg">

							<!-- Modal content-->
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h4 class="modal-title">질문 수정 폼</h4>
								</div>
								<div class="modal-body">
									<table id="qnaDetail" class="table">
										
										<tr>
											<th>제목 :</th>
											<td><input size="48" type="text" id="QnAtitleUpdate"></td>
										</tr>

										<tr>
											<th>내용 :</th>
											<td>
												<textarea id="QnAcontentUpdate" rows="10" cols="78"></textarea>
											</td>
										</tr>
										<tr>
											<th>공개/비공개</th>
											<th><input type="radio" name="QnAUpdateopen" value="0">공개
												<input type="radio" name="QnAUpdateopen" value="1">비공개
											</th>
										</tr>
										<tr>
											<td colspan="2" style="text-align: right;"><button type="button" class="btn btn-sm btn-danger"
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
											<td><br></td>
										</tr>
										<tr>
											<td style="text-align: right;"><button type="button" class="btn btn-sm btn-danger"
													id="NoticeUpdateForm" data-toggle="modal"
													data-target="#NoticeContentUpdateModal">공지 수정</button>
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
						<div class="modal-dialog modal-lg">

							<!-- Modal content-->
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h4 class="modal-title">공지 수정 폼</h4>
								</div>
								<div class="modal-body">
									<table id="NoticeDetail" class="table">
										
										<tr>
											<th>제목 :</th>
											<td><input size="48" type="text" id="NoticetitleUpdate"></td>
										</tr>

										<tr>
											<th>내용 :</th>
											<td>
												<textarea id="NoticecontentUpdate" rows="10" cols="78"></textarea>
											</td>
										</tr>

										<tr>
											<br>
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
											<td width="80%">제&nbsp;&nbsp;&nbsp;&nbsp;목
												: <label id="ReporttitleLabel"></label>
											</td>

										</tr>
										<tr>

											<td width="80%">작성자 : <label id="ReportwriterLabel"></label>
											</td>
										</tr>
										<tr>
											<td>카테고리 : <label id="ReportMajorLabel"></label><p id="ReprotBoardLabelP">
											    신고 글 제목 : <label id="ReportBoardLabel"></label>
											    </p>
											</td>
										</tr>
										<tr>
											<td colspan="3"><textarea id="ReportcontentLabel"
													rows="10" cols="78" readonly="readonly"></textarea></td>
										</tr>
										<tr>
											<td><br></td>
										</tr>
										<tr>
											<td style="text-align: right;">
											<button type="button" class="btn btn-danger btn-sm"
														id="ReportClearBtn" name=""></button>
												<button type="button" id="ReportDelete"
													class="btn  btn-sm btn-danger">신고 삭제</button></td>
										</tr>

										<tr>

											<td></td>

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