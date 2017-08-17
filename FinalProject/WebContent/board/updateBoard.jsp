<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../menu.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript"
	src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=A5owm24oXM2NprihulHy&submodules=geocoder"></script>

</head>
<style>
#bckground{
width: 750px;
}

#bckgrndtable{
text-align: left;
}
#idDiv{
text-align: right !important;
}

#mapContent{
position: absolute;
display : none;
right: 15%;
top: 10%;
border: 1px solid red;
}

#map{
float: right;
}

.tdT{
overflow: hidden; 
text-overflow: ellipsis;
white-space: nowrap; 
width: 130px;
height: 20px;
display: block;
}

.tdA{
overflow: hidden; 
text-overflow: ellipsis;
white-space: nowrap; 
width: 240px;
height: 20px;
display: block;
}
#mapTableList{
	vertical-align: top;
}

#bckground input[name="title"]{
	width: 100%;
}
#bckground input[type="date"]{
	width: 185px;
}
#major{
	width: 30%;
}
#minor{
	width: 69%;
}
textarea{
	resize:none;
}
#scroll{
overflow: scroll;
width: 380px;
height: 300px;
/* overflow-x: hidden; */
/* overflow-y: hidden; */
}
#mapTr{
border-top: hidden;
}

#mapDiv{
display: none;
}
.fileTable td{
padding-right: 10px;
}
</style>

<script type="text/javascript">
$(document).ready(function(){
	//지도인포 잘라주는 함수
	function valueCut(str){
		var index=0;
		
		for(var i=1;i<=4;i++){
			index = str.indexOf(" ", index+1);
		}
		return index;
	}
	
	
    var map = new naver.maps.Map('map', {
    	scaleControl: false,
        logoControl: false,
        mapDataControl: false,
        zoomControl: true,
        minZoom: 1,
    	zoom: 11
    });
    var way;
    var juso; //지도검색 후 라디오 버튼으로 선택할 때 infowindow에 써
    var marker;
    var info_title; //장소명
    var info_address;//도로명
    var info_address2;//지번
    var latlng="";//위도경도
    var infowindow;
    
    
    $(document).on('click', '#mapSearch', function(){
    	way = $('input[name=way]:checked').val(); //검색방식 1은 주소/ 2는 키워드
    	if($('#inputAddr').val() == ""){
	  		 alert('검색어를 입력하세요');
	  	}else if(way == 2){//키워드 검색
	  		 $.ajax({ //검색 api ajax
	  			type : 'post',
	  			url : 'searchApi.do',
	  			data : {inputAddr:$('#inputAddr').val()},
	  			dataType : 'json',
	  			success : function(data){
	  				$('#table tr:gt(0)').empty();//주소 결과리스트 내용 지우고
			      
	  				$.each(data.items, function(index, value){//결과들 table에 표시
			          	$('#table tbody').append(
			          		'<tr>'+
			          		'<td><div class="tdT"><input class="addrRadio" type="radio" name="address" value="'+value.address+'">'+
			          		'<input type="hidden" name="ttt" value="'+value.title+'">' + value.title +'</div></td><td><div class="tdA">'+value.address + '</div></td>'+
			          		'</tr>'
			          	);
			        });//each 끝
			        
	  				
	  				if(data.items[0] == null){//검색결과가 없으면
	  					alert("검색결과가 올바르지 않습니다. 검색방법이 맞는지 확인하세요");
	  				}else{
	  			    	$('#mapDiv').css('display', 'inline');
	  			    	$('#mapTr').css('border-top', '1px solid #ddd' );
	  				
				        map.destroy();//원래있던 지도 지우고
				        map = new naver.maps.Map('map', {//다시 넣어주기
				        	scaleControl: false,
				            logoControl: false,
				            mapDataControl: false,
				            zoomControl: true,
				            minZoom: 1,
	  				    	zoom: 11
	  				    });

				        info_title = data.items[0].title;
	  					info_address = data.items[0].address;
	  					info_address2 = '';
	  					
	  					//검색결과에서 받아온 주소를 지도 api에 넣어서 표시할거야
	  			    	naver.maps.Service.geocode({address: info_address}, function(status, response) {
		  			    	if (status !== naver.maps.Service.Status.OK) {
		  			    		return alert(info_address + '의 검색 결과가 없거나 기타 네트워크 에러');
		  			        }
		  			        var result = response.result;
		  			        // 검색 결과 갯수: result.total
		  			        // 첫번째 결과 결과 주소: result.items[0].address
		  			        // 첫번째 검색 결과 좌표: result.items[0].point.y, result.items[0].point.x
	  			        
		  			        var myaddr = new naver.maps.Point(result.items[0].point.x, result.items[0].point.y);
		  			        map.setCenter(myaddr); // 검색된 좌표로 지도 이동  			          
	  			          
		  			        // 마커 표시
		  			        marker = new naver.maps.Marker({
		  			        	position: myaddr,
		  			            map: map
		  			        });
	  			        	
		  			    	//지도인포 자르기
			  			    if(info_address.length > 20){
				  			  var check = valueCut(info_address);
				  			  info_address = info_address.substring(0, check)+"<br>"+info_address.substring(check);
			  			    }
			  			 	 console.log(info_address);
	  						
				  	        infowindow = new naver.maps.InfoWindow({
				  	        	  content : "<h5>"+info_title+"</h5><h6>"+info_address+"</h6>"
				  	        });
				  	        
				  	        infowindow.open(map, marker);
				  	        lat = marker.position.y;
				  	        lng = marker.position.x;
	
	  			      	});//geocode 
	  			        $('.addrRadio:first').attr('checked', true);
	  			    	$('.addrRadio:eq(0)').trigger('click');
	  			     	selectRadio();
	  				}//검색 결과 else
	  			},
	  			error : function(jpXHR, textStatus, errorThrown){
	                  alert(textStatus);
	                  alert(errorThrown);
	            }
	  		 });//키워드 검색 ajax 끝
  		 
  		 	 $('#myModal').modal('show');
  	 	}//키워드로 지도 찾는 경우 끝
  	 	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  	 	/*
  	 	주소로 검색하는 경우
  	 	*/
  	 	else if(way == 1){//주소로 검색하는 경우(way==1)
 	 		$('#table tr:gt(0)').empty();
			
				
		    naver.maps.Service.geocode({address: $('#inputAddr').val()}, function(status, response) {
		    	if (status !== naver.maps.Service.Status.OK) {
		    		return alert('검색방법이 잘못 되었거나 기타 네트워크 에러');
		        }
		    	$('#mapDiv').css('display', 'inline');
		    	$('#mapTr').css('border-top', '1px solid #ddd' );
		        map.destroy();
		        map = new naver.maps.Map('map', {
		        	scaleControl: false,
		            logoControl: false,
		            mapDataControl: false,
		            zoomControl: true,
		            minZoom: 1,
			    	zoom: 11
			    });

		        var result = response.result;
		        // 검색 결과 갯수: result.total
		        // 첫번째 결과 결과 주소: result.items[0].address
		        // 첫번째 검색 결과 좌표: result.items[0].point.y, result.items[0].point.x
		        info_title='';
		        info_address = result.items[0].address;
		        info_address2 = '';
	        
		        var myaddr = new naver.maps.Point(result.items[0].point.x, result.items[0].point.y);
		        map.setCenter(myaddr); // 검색된 좌표로 지도 이동  		
		        
		        
		        //얘도 리스트 뿌릴수잇나
	        	$.each(result.items, function(index, value){
		          	$('#table tbody').append(
		          			'<tr>'+
		          			'<td><div class="tdT"><input class="addrRadio" type="radio" name="address" value="'+value.address+'">'+
		          			'<input type="hidden" name="ttt" value="'+value.title+'"></div></td><td><div class="tdA">'+ value.address + '</div></td></tr>'
		          	);
		        });
		        
	          
		        // 마커 표시
		        marker = new naver.maps.Marker({
		        	position: myaddr,
		            map: map
		        });
			        
		      //인포 자르기!
		        if(info_address.length > 20){
	  			  var check = valueCut(info_address);
	  			  info_address = info_address.substring(0, check)+"<br>"+info_address.substring(check);
  			    }
	        	 console.log(info_address);    
		        
	  	        //인포윈도우 오픈
	  	        infowindow = new naver.maps.InfoWindow({
	  	        	content : "<h6>"+info_address+"</h6>"
	  	        });
	  	        infowindow.open(map, marker);
	  	        lat = marker.position.y;
	  	        lng = marker.position.x;
		    
  	       $('.addrRadio:first').attr('checked', true);
           $('.addrRadio:eq(0)').trigger('click');
		   selectRadio();
	       });//geocode 끝
 	 	}//(way==1) else 끝
  	 		
    })//검색버튼 누른 후 모달 결과 페이지까지 뽑기 끝 
    
    
    
    //라디오 선택
    $(document).on('click',".addrRadio",function(){
    	selectRadio();
    	insertToHidden();
    });//라디오 선택 끝
    
    
   	//직접 지도에서 찍은 곳으로 마커 이동
   	$(document).on('click', map, function(){
		naver.maps.Event.addListener(map, 'click', function(e){
		    marker.setPosition(e.latlng);//내가 찍은 곳의 좌표로 마커 이동
		    searchCoordinateToAddress(e.latlng);//찍은 곳의 좌표를 주소로 변환
		    info_title = "";//직접 찍으면 지점 이름은 안나와
		});
   	});

    
    function selectRadio(){
		way = $('input[name=way]:checked').val(); //검색방식 1은 주소/ 2는 키워드
    	
		var myaddress = $('.addrRadio:checked').val();// 도로명 주소나 지번 주소만 가능 (건물명 불가!!!!)
				
	    naver.maps.Service.geocode({address: myaddress}, function(status, response) {

	    	if (status !== naver.maps.Service.Status.OK) {
	    		return alert(myaddress + '의 검색 결과가 없거나 기타 네트워크 에러');
	        }
	        var result = response.result;
	        // 검색 결과 갯수: result.total
	        // 첫번째 결과 결과 주소: result.items[0].address
	        // 첫번째 검색 결과 좌표: result.items[0].point.y, result.items[0].point.x
	        
	        var myaddr = new naver.maps.Point(result.items[0].point.x, result.items[0].point.y);
	          
	    	marker.setMap(null);
	        // 마커 표시
	        marker = new naver.maps.Marker({
	        	position: myaddr,
	            map: map
	        });
	        map.setCenter(myaddr); // 검색된 좌표로 지도 이동  
	        info_address = myaddress;
	        
	      //지도인포 자르기
		    if(info_address.length > 20){
  			  var check = valueCut(info_address);
  			  info_address = info_address.substring(0, check)+"<br>"+info_address.substring(check);
		    }
	        
	        if(way == 1){
	        	info_title = '';
	        	info_address2 = '';
				juso = "<h6>"+info_address+"</h6>";     	
	        }else if(way == 2){
		        info_title = $('input[name=address]:checked + input').val();
		        info_address2 = '';
	        	juso = "<h5>"+info_title+"</h5><h6>"+info_address+"</h6>";
	        }

          // 인포윈도우 오픈
          infowindow = new naver.maps.InfoWindow({
        	  content : juso
          });
          
          infowindow.open(map, marker);
          insertToHidden();
	     
	    });
    }
    
    //지점 찍었을 때 해당 좌표 -> 주소로 변환해주는 함수
    function searchCoordinateToAddress(latlng) {
    	var tm128 = naver.maps.TransCoord.fromLatLngToTM128(latlng);//위경도를 tm128로 바꾸고

    	naver.maps.Service.reverseGeocode({
	        location: tm128,
	        coordType: naver.maps.Service.CoordType.TM128
    	}, function(status, response) {
    	
	        if (status === naver.maps.Service.Status.ERROR) {
	            return alert('Something Wrong!');
	        }
	
	        var items = response.result.items,
            htmlAddresses = [];
  	        info_address = items[0].address;
  	        info_address2 = items[1].address
        
  	          // 인포윈도우 오픈
  	        infowindow = new naver.maps.InfoWindow({
  	        	content : "<h6>" + info_address+"</h6><h6>"+info_address2+"</h6>"
  	        });
  	          
  	        infowindow.open(map, marker);
  	      insertToHidden();
    	});
	}//searchCoordinateToAddress 함수 끝
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
    //확인 클릭하면 지도 검색한 주소 가지고 부모창으로 가기
    function insertToHidden(){
   		//일단 있던거 비우고
    	$('#addrResult').empty();
   		$('#hidn').empty();
    	$('#hidn2').empty();
    	$('#hidn3').empty();
    	$('#hidn4').empty();
    	$('#hidn5').empty();
    
    	
    	//infowindow에 있는 내용 담아두자
    	var addrResult = $('h6').text();
    	
    	var jusoResult = info_address; //jusoResult는 부모창 addrResult에 넣을 애야
    	if(info_title != ''){
    		jusoResult = info_title +"<br>"+ info_address
    	}
    	if(info_address2 != ''){
    		jusoResult += "<br>"+info_address2;
    	}
    	
    	//부모창 div에 넣기
//     	$('#addrResult').html(info_title +"<br>"+ info_address +"<br>"+info_address2);
    	$('#addrResult').html(jusoResult);
    	$('#hidn').val(info_address);
    	$('#hidn2').val(info_address2);
    	$('#hidn3').val(info_title);
    	$('#hidn4').val(lat);
    	$('#hidn5').val(lng);
    	console.log($('#hidn').text());
    }//부모창에 주소 가져가기 끝
    
   	//지도 모달창에서 취소 누르면 부모창으로 주소 안가져갈거야
   	$(document).on('click', '#cancel', function(){
   		$('#addrResult').empty();
   		$('#hidn').empty();
    	$('#hidn2').empty();
    	$('#hidn3').empty();
    	$('#hidn4').empty();
    	$('#hidn5').empty();
   		$('#inputAddr').val('');
   	});
    
    
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//가격 입력하기

   	$(document).on('click', '.add', function(){
   		$('#optionTable').append(
   				'<tr><td><input type="text" name="option[]"></td>'+
				'<td><input type="text" name="optionPrice[]"></td>'+
				'<td>'+'<input type="button" class="delete" value="삭제">'+'</td></tr>'
   		);
   		
   	});

    
   	//옵션삭제
   	$(document).on('click', '.delete', function(){
   		$(this).parent().parent().remove();	
   	});

    	
	//대분류 선택하면 소분류 나와
   	$(document).on('change', '#major', function(){
   		$.ajax({
   			url:"categoryLow.do",
   			type:"POST",
   			data:{high_no:$('#major').val()},
   			dataType:"json",
   			success:function(data){
   				$('#minor').empty();
   				$('#minor').append('<option>소분류</option>');
   				$.each(data, function(index, value){
	   				$('#minor').append(
	   						'<option value="'+value.no+'">'+value.category_name+'</option>'	
	   				);
   				});
   			},
   			error:function(){
   				alert("실패");
   			}
   		});
   	});
	
   	
   	
	
   	//등록 마감일 당일기준으로 설정
	document.getElementById('datePicker').valueAsDate = new Date();
   	//오늘 날짜 이전으로 선택 못하게
   	var year = new Date().getFullYear();
   	var month = new Date().getMonth()+1;
   	var date = new Date().getDate();
   	if(month<10){
		month = '0'+month; 		
   	}
   	if(date<10){
   		date = '0'+date; 
   	}
   	var dateVal = year+'-'+month+'-'+date;
   	$('#datePicker').attr('min', dateVal);
   	


   	
   	
   	
   	

//옵션 추가 체크박스 선택
	$("#tableOption").empty();//옵션추가 테이블 일단 숨겨놓고 시작!
    $('#optionRadio').on('click',function(){
    	if($(this).is(':checked')){//체크되면
    		console.log("체크");
    		$('#optionResult').val(0);
    		$('#optionTable').append(
    				 '<tr><td>옵션종류</td><td>추가가격</td><td><input type="button" class="add" value="추가"></td></tr>'+
                     '<tr>'+
                        '<td><input type="text" name="option[]" class="optionName"></td>'+
                        '<td><input type="text" name="optionPrice[]" class="optionPrice"></td>'+
                     '</tr>'
    		);
    	}else{//체크 안되면
    		console.log("체크노노");
    		$('#optionResult').val(4);
    		$('#optionTable').empty();
    	}
    });
	



	
	
	
	
   	//글등록
   	$(document).on('click', '#go', function(){
   		var updateSubmit = confirm("사진파일 미선택시 글에 포함된 사진이 지워집니다. \n수정 하시겠습니까?");
   		var check=false;
   		if(updateSubmit){
			if($('#major option:selected').val() == '대분류'){//카테고리
				alert('카테고리를 선택하세요');
				check = false;
			}else
			if($('#minor option:selected').val() == '소분류'){//카테고리
				alert('카테고리 소분류를 선택하세요');
				check = false;
			}else
			if($('input[name=title]').val()=='' || $('input[name=title]').val().trim() == ''){
				alert('제목을 쓰세요');
				check = false;
			}else
			if($('input[name=quantity]').val()=='' || $('input[name=quantity]').val().trim() == ''){
				alert('인원 또는 건수를 쓰세요');
				check = false;
			}else
			if($('input[name=price]').val()=='' || $('input[name=price]').val().trim()==''){
				console.log('가격을 쓰세요');
				check = false;
			}else{
				check = true;
			}
			
			if($('input[type=checkbox]').is(':checked')){
				var check1 = true;
				var check2 = true;
				
				$.each($('#tableOption').find('.optionName'), function(index, value){
					if(value.value == ''){
						alert("옵션종류를 입력하세요");
						check1 = false;
						check = false;//바깥 each 나가기
						return;
					}
					if(value.value != ''){
						$.each($('#tableOption').find('.optionName'), function(index2, value2){
							if(index != index2){
								if(value.value == value2.value){
									alert("옵션종류가 중복됩니다");
									check1 = false;
									check2 = false;
									check = false;//내부 each 나가기
									return;
								}
							}
						});//inner each 끝
					}
					if(!check2){//옵션종류가 중복이면 바깥each 더 돌지말고 나가
						check = false;
						return;
					}
				});	//옵션종류 each문 끝
				
				if(check1){
					$.each($('#tableOption').find('.optionPrice'), function(index, value){
						if(value.value == ''){
							alert("옵션가격을 입력하세요");
							check1 = false;
							check = false;
							return;
						}else if(!$.isNumeric(value.value)){
							alert("옵션가격에는 숫자를 입력하세요");
							check1 = false;
							check = false;
							return;
						}
					});	//옵션가격 each문 끝
				}; //if(a)끝
				
				if(check1 && check2){
					check = true;
				}else{
					check = false;
				}
			};//옵션 입력값 체크
			if(check){
				$('#detailInfo').submit();
			};
	   	};
   	});
   	
  //옵션 가져오기
	function bringOption(no){
	    alert(no);
	  	$.ajax({
	  		url:"bringOption.do",
	  		type:"POST",
	  		data:{
	  			no:no
	  		},
	  		dataType:"json",
	  		success:function(data){
	  			console.log(data);
				if(data != ''){
					$('#optionRadio').attr("checked","checked");
					$('#optionTable tr:gt(0)').remove();
					$('#optionTable').append(
						'<tr><td>옵션종류</td><td>추가가격</td><td><input type="button" class="add" value="추가"></td></tr>'
					);	
					$.each(data,function(index, value){
						if(index==0){
							$('#optionTable').append(
								'<tr><td><input type="text" name="option[]" value="'+value.kind+'"></td>'+
								'<td><input type="text" name="optionPrice[]" value="'+value.price+'"></td>'+
								'<td></td></tr>'
							);
						}else{
							$('#optionTable').append(
								'<tr><td><input type="text" name="option[]" value="'+value.kind+'"></td>'+
								'<td><input type="text" name="optionPrice[]" value="'+value.price+'"></td>'+
								'<td>'+'<input type="button" class="delete" value="삭제">'+'</td></tr>'
							);
						}					
						
					});
				}	  			
	  		},
	  		error:function(){
	  			alert("실패");
	  		}
	  	});
    };
   	
   	bringOption($('#hidn6').val());
   	
   	//기존이미지 삭제 체크박스
   	$(document).on('click', '.dlt', function(){
   		//체크하면 기존이미지&현재선택한 이미지 hide
   		//체크박스 value=1 넣어서 가져가
   			console.log("check");
   			$(this).parent().parent().find('.original').empty();
   			$(this).parent().parent().prev().find('input[type=file]').val('');
   			$(this).siblings('input').val('');
   		return false;
   	});//체크박스 클릭
   	
   	
//    	//원글 end_date가 왜 안먹히냐
//    	var end_date = $('#datePicker').val();
//    	console.log(end_date);
// //    	$('#datePicker').val(end_date);
   	
});//document.ready
</script>
<body>
	<!-- 	<div id="fh5co-main"> -->
		<div class="container">
			<div class="row">
				<div class="col-md-8 col-md-offset-2">
					<h2>판매글 수정</h2>
					<div class="fh5co-spacer fh5co-spacer-sm"></div>
					<div class="row">
						
						<div class="col-md-4">
							<div class="fh5co-pricing-table" id="bckground">
							<form id="detailInfo" action="updateBoard.do" method="post" enctype="multipart/form-data" >
								<table class="table" id="bckgrndtable">
									<tr><th>* 카테고리 </th><th>
										<select name="major" id="major">
											<c:forEach items="${categoryList}" var="high">
												<c:if test="${high.no eq board.category_major}">
													<option value="${high.no}" selected>${high.category_name}</option>
												</c:if>	
												<c:if test="${high.no ne board.category_major}">
													<option value="${high.no}">${high.category_name}</option>
												
												</c:if>									
												
											</c:forEach>
										</select> 
										<select name="minor" id="minor">
											<c:forEach items="${categoryLowList}" var="low">
												<c:if test="${low.no eq board.category_minor}">
													<option value="${low.no}" selected>${low.category_name}</option>
												</c:if>											
												<option value="${low.no}">${low.category_name}</option>
											</c:forEach>
										</select>
									</th></tr>
									<tr><th>* 글제목</th><th> <input type="text" pattern="[가-힣\sa-zA-Z0-9!#$%^&*()?+=\/]{1,30}" name="title" value="${board.title}"> </th></tr>
									<tr><th>* 등록 마감일</th><th> <input type="date" name="end_date" id="datePicker" value="${board.end_date}"> </th></tr>
									<tr><th>* 인원 또는 건수</th><th> <input type="number" min="1" max="99" name="quantity" value="${board.quantity }"> </th></tr>
									<tr><th>장소 또는 지역</th><th>
										<input type="radio" name="way" value="1" checked="checked">주소
          								<input type="radio" name="way" value="2"> 키워드<br>
										<input type="text" id="inputAddr" name="inputAddr" > 
										<button type="button" class="btn btn-info btn-sm"  id="mapSearch">검색</button> 
										<button type="button" class="btn btn-info btn-sm"  id="cancel">취소</button> 
										<div id="addrResult">
											<c:choose>
												<c:when test="${mapinfo ne null}">
													<c:if test="${mapinfo.title ne ''}">
														${mapinfo.title}<br>
													</c:if>
														${mapinfo.address}<br>
													<c:if test="${mapinfo.address2 ne '' }">
														${mapinfo.address2 }
													</c:if>
												</c:when>
												<c:otherwise>
												</c:otherwise>
											</c:choose>
										</div>
										<input type="hidden" id="hidn" name="info_address" value="${mapinfo.address }">
										<input type="hidden" id="hidn2" name="info_address2" value="${mapinfo.address2 }">
										<input type="hidden" id="hidn3" name="info_title" value="${mapinfo.title }">
										<input type="hidden" id="hidn4" name="lat" value="${mapinfo.lat}">
										<input type="hidden" id="hidn5" name="lng" value="${mapinfo.lng}">
										<input type="hidden" id="hidn6" name="no" value="${board.no}">
										<c:if test="${board_optionList eq null}">
										<input type="hidden" id="optionResult" name="optionResult" value="4">
										</c:if>
										<c:if test="${board_optionList ne null}">
										<input type="hidden" id="optionResult" name="optionResult" value="0">
										</c:if>
									</th></tr>
									<tr id="mapTr"><td colspan="2">
									<div id="mapDiv">
									
									
									<table>
										<tr><td id="mapTableList" width="50%">
											<div id="scroll">
											<table id="table">
											<tr><th width="100">명칭</th><th width="230">주소</th></tr>
											</table>
											</div>
										</td><td width="50%">
											<div id="map" style="width:330px;height:300px;text-align: center;"></div>
										</td></tr>
									</table>
									
									</div>
									
									
									</td></tr>
									<tr><th>* 기본가격</th><td><input type="number" min="0" max="999900" name="price"></td></tr>
									<tr><th>옵션사항</th>
									<td>
									<div><input type="checkbox" id="optionRadio">옵션 여부</div>
										<table id="optionTable">
										</table>
									</td></tr>
									<tr><th>썸네일</th><th> <input type="file" name="files"> 
									<div>
										<table class="fileTable">
											<tr><td colspan="3"></td></tr>
											<tr><td>기존이미지</td><td class="original">${files.file_name1}</td><td><button type="button" class="dlt">x</button><input type="hidden" name="original[]" value="${files.file_name1}"></td></tr>
										</table>
									</div>
									</th></tr>
									<tr><th>상세내용</th><th> <textarea rows="10" cols="60" name="content">${board.content}</textarea> </th></tr>
									<tr><th>상세 이미지</th>
									<th> 
										<table class="fileTable">
										<tr><td colspan="3"><input type="file" name="files" ></td></tr>
										<tr><td>기존이미지</td><td class="original">${files.file_name2}</td><td><button type="button" class="dlt">x</button><input type="hidden" name="original[]" value="${files.file_name2}"></td></tr>
										<tr><td colspan="3"><input type="file" name="files" ></td></tr>
										<tr><td>기존이미지</td><td class="original">${files.file_name3}</td><td><button type="button" class="dlt">x</button><input type="hidden" name="original[]" value="${files.file_name3}"></td></tr>
										<tr><td colspan="3"><input type="file" name="files" ></td></tr>
										<tr><td>기존이미지</td><td class="original">${files.file_name4}</td><td><button type="button" class="dlt">x</button><input type="hidden" name="original[]" value="${files.file_name4}"></td></tr>
										</table>
									</th></tr>
								</table>
								<div class="fh5co-spacer fh5co-spacer-sm"></div>
								<div>
								<button class="btn btn-sm btn-primary" onclick="historyback">취소</button>
								<button class="btn btn-sm btn-primary" id="go">등록</button>
<!-- 								<input type="button" class="btn btn-sm btn-primary" id="go" value="GO!"> -->
								</div>
							</form>
							</div>
						</div>
					
					</div>

					
				</div>
        	</div>
       </div>
<!-- <!-- 	</div> --> -->


<!--   <!-- Modal --> -->
<!--   <div class="modal fade" id="myModal" role="dialog"> -->
<!--     <div class="modal-dialog modal-lg"> -->
<!--       <div class="modal-content"> -->
<!--         <div class="modal-header"> -->
<!--           <button type="button" class="close" data-dismiss="modal">&times;</button> -->
<!--           <h4 class="modal-title">주소를 선택하거나 지도상에서 직접 찍은 후 확인을 눌러주세요</h4> -->

<!--         </div>   -->
<!--         <div class="modal-body"> -->
<!--           <table> -->
<!-- 				<tr><td id="mapTableList" width="50%"> -->
<!-- 					<table id="table"> -->
<!-- 					<tr><th width="100">명칭</th><th width="230">주소</th></tr> -->
<!-- 					</table> -->
<!-- 				</td><td width="50%"> -->
<!-- 					<div id="map" style="width:450px;height:400px;text-align: center;"></div> -->
<!-- 				</td></tr> -->
<!-- 			</table> -->
<!--         </div> -->
<!--         <div class="modal-footer"> -->
<!--        	  <button type="button" class="btn btn-default" data-dismiss="modal" id="cancel">취소</button> -->
<!--           <button type="button" class="btn btn-default" data-dismiss="modal" id="submit">확인</button> -->
<!--         </div> -->
<!--       </div> -->
<!--     </div> -->
<!--   </div> -->
  
  
<!-- <!--   손연경 --> -->

</body>
</html>