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

.condition{
font-size: 14px;
font-weight: normal;
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
//     	scaleControl: false,
//         logoControl: false,
//         mapDataControl: false,
//         zoomControl: false,
//         minZoom: 1,
    	zoom: 12
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
			          		'<input type="hidden" name="ttt" value="'+value.title+'">' + value.title +'</div></td><td><div class="tdA">'+value.address + '</td></td>'+
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
// 				        	scaleControl: false,
// 				            logoControl: false,
// 				            mapDataControl: false,
// 				            zoomControl: false,
// 				            minZoom: 1,
	  				    	zoom: 12
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
  		 		
//   		 	 $('#myModal').modal('show');
  	 	}//키워드로 지도 찾는 경우 끝
  	 	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  	 	/*
  	 	주소로 검색하는 경우
  	 	*/
  	 	else if(way == 1){//주소로 검색하는 경우(way==1)
//  	 		$('#table tr:gt(0)').empty();
  	 		$('#table').empty();
  	 		$('#table').append('<tr><th width="30"></th><th width="230">주소</th></tr>');
				
  	 		
		    naver.maps.Service.geocode({address: $('#inputAddr').val()}, function(status, response) {
		    	if (status !== naver.maps.Service.Status.OK) {
		    		return alert('검색방법이 잘못 되었거나 기타 네트워크 에러');
		        }
		    	$('#mapDiv').css('display', 'inline');
		    	$('#mapTr').css('border-top', '1px solid #ddd' );
		        map.destroy();
		        map = new naver.maps.Map('map', {
// 		        	scaleControl: false,
// 		            logoControl: false,
// 		            mapDataControl: false,
// 		            zoomControl: false,
// 		            minZoom: 1,
			    	zoom: 12
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
		          			'<td><div><input class="addrRadio" type="radio" name="address" value="'+value.address+'">'+
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
// 		   $('#myModal').modal('show');
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
				
	    naver.maps.Service.geocode({address:myaddress}, function(status, response) {

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
	}

	
	
	
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
	$("#tableOption").empty();//옵션추가 테이블 한번 비우고
    $('input[type=checkbox]').on('click',function(){
    	if($(this).is(':checked')){//체크되면
    		$('#optionResult').val(0);
    		$('#tableOption').append(
    				 '<tr><th>옵션종류</th><th>추가가격</th><th><input type="button" class="add" value="추가"></th></tr>'+
                     '<tr>'+
                        '<td><input type="text" pattern="[가-힣\\sa-zA-Z0-9!\\-#$%^&*.()?+=\/]{1,20}" title="옵션명은 20자 이하로 입력하세요" name="option[]" class="optionName"></td>'+
                        '<td><input type="number" min="0" max="999999" name="optionPrice[]" step="100" class="optionPrice" title="가격은 100원 단위로 입력하세요(100만원 미만)"></td>'+
//                         '<td><button class="delete">삭제</button></td>'+
                     '</tr>'
    		);
    		$('.cndtn').text('가격은 100원 단위로 입력하세요(100만원 미만)');
    	}else{//체크 안되면
    		$('#optionResult').val(4);
    		$('#tableOption').empty();
    		$('.cndtn').text('');
    	}
    });
	
	
	//옵션 추가 클릭
   	$(document).on('click', '.add', function(){
   		var no = 0;
   		$.each($('#tableOption').find('.optionName'), function(index, value){
   			no += 1;
   		});
   		if(no>4){
			alert("옵션은 최대 5개까지 추가 가능합니다");
		}else{
	   		$('#tableOption').append(
	  				'<tr>'+
				'<td><input type="text" pattern="[가-힣\\sa-zA-Z0-9!\\-#$%^&*.()?+=\/]{1,20}" title="옵션명은 20자 이하로 입력하세요" name="option[]" class="optionName"></td>'+
				'<td><input type="number" min="0" max="999999" name="optionPrice[]" step="100" class="optionPrice" title="가격은 100원 단위로 입력하세요(100만원 미만)"></td>'+
				'<td><button class="delete">삭제</button></td>'+
				'</tr>'
	   		);
		}

   		
   	});
	
	
	//content글자수 오버되면 막기
	$(document).on("keyup", 'textarea[name=content]', function(){
		//글자수 체크해서 알려주기
		var contentLength = $('textarea[name=content]').val().length;
		console.log(contentLength+"//길이");
		$(this).parent().find('div').empty();
		$(this).parent().find('div').html(
				'상세내용은 1000자 이하로 입력하세요&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp' + contentLength+'/1000');

		//1000자 넘으면 막기
		if($('textarea[name=content]').val().length > 1000 ){
			alert("상세 내용은 글자수 1000자 이하로 쓰세요");
			$(this).parent().find('div').html(
					'상세내용은 1000자 이하로 입력하세요&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp1000/1000');
			var cntnt = $(this).val().substr(0,10);
			console.log(cntnt);
			$(this).val(cntnt);
		}
	});

	
	
	
   	//글등록
   	$(document).on('click', '#go', function(){
		if($('#major option:selected').val() == '대분류'){//카테고리
			alert('카테고리를 선택하세요');
			return false;
		}
		if($('#minor option:selected').val() == '소분류'){//카테고리
			alert('카테고리 소분류를 선택하세요');
			return false;
		}
		if($('input[name=title]').val()=='' || $('input[name=title]').val().trim() == ''){
			alert('제목을 쓰세요');
			$('input[name=title]').focus();
			return false;
		}
		if($('input[name=quantity]').val()=='' || $('input[name=quantity]').val().trim() == ''){
			alert('인원 또는 건수를 쓰세요');
			$('input[name=quantity]').focus();
			return false;
		}
		if($('input[name=price]').val()=='' || $('input[name=price]').val().trim()==''){
			alert('가격을 쓰세요');
			$('input[name=price]').focus();
			return false;
		}

		
		if($('input[type=checkbox]').is(':checked')){
			var check1 = true;
			var check2 = true;
			
			$.each($('#tableOption').find('.optionName'), function(index, value){
				if(value.value == ''){
					alert("옵션종류를 입력하세요");
					check1 = false;
					return false;//바깥 each 나가기
				}
				if(value.value != ''){
					$.each($('#tableOption').find('.optionName'), function(index2, value2){
						if(index != index2){
							if(value.value == value2.value){
								alert("옵션종류가 중복됩니다");
								check1 = false;
								check2 = false;
								return false;//내부 each 나가기
							}
						}
					});//inner each 끝
				}
				if(!check2){//옵션종류가 중복이면 바깥each 더 돌지말고 나가
					return false;
				}
			});	//옵션종류 each문 끝
			
			if(check1){
				$.each($('#tableOption').find('.optionPrice'), function(index, value){
					if(value.value == ''){
						alert("옵션가격을 입력하세요");
						check1 = false;
						return false;
					}else if(!$.isNumeric(value.value)){
						alert("옵션가격에는 숫자를 입력하세요");
						check1 = false;
						return false;
					}
				});	//옵션가격 each문 끝
			}; //if(a)끝
			if(check1 && check2){
				return true;
			}else{
				return false;
			}
		};//옵션 입력값 체크
		return true;
   	});
   	
   	
   	

   	
   	
});//document.ready
</script>
<body>


	
	<!-- 	<div id="fh5co-main"> -->
		<div class="container">
			<div class="row">
				<div class="col-md-8 col-md-offset-2">
					<h2>판매등록</h2>
					<div class="fh5co-spacer fh5co-spacer-sm"></div>
					<div class="row">
						
						<div class="col-md-4">
							<div class="fh5co-pricing-table" id="bckground">
							<form id="detailInfo" action="insertBoard.do" method="post" enctype="multipart/form-data" >
								<table class="table" id="bckgrndtable">
									<tr><th>* 카테고리(필수) </th><th width="515">
									<select name="major" id="major">
										<option>대분류</option>
										<c:forEach items="${categoryList}" var="high">
											<option value="${high.no}">${high.category_name}</option>
										</c:forEach>
									</select> 
									<select name="minor" id="minor">
										<option>소분류</option><option>대분류를 선택하세요</option>
									</select>
									</th></tr>
									<tr><th>* 글제목(필수)</th><th class="condition"> 
									<input type="text" pattern="[가-힣\sa-zA-Z0-9!\-#$%^&*\.()?+=\/]{1,30}" title="제목은 30자 이하로 입력하세요"  name="title"><br>
									제목은 30자 이내로 입력하세요 </th></tr>
									<tr><th>* 등록 마감일(필수)</th><th> <input type="date" name="end_date" id="datePicker" title="오늘 이전 날짜는 선택할 수 없습니다"> </th></tr>
									<tr><th>* 인원 또는 건수(필수)</th><th class="condition"> <input type="number" min="1" max="99" name="quantity" title="100명 미만으로 입력하세요"><br>
									1명 이상 100명 미만으로 입력하세요 </th></tr>
									<tr><th>장소 또는 지역</th><th>
									
										<input type="radio" name="way" value="1" checked="checked">주소
          								<input type="radio" name="way" value="2"> 키워드<br>
										<input type="text" id="inputAddr" name="inputAddr" > 
										<button type="button" class="btn btn-info btn-sm"  id="mapSearch">검색</button> 
										<button type="button" class="btn btn-info btn-sm"  id="cancel">취소</button> 
										<div id="addrResult"></div>
										<input type="hidden" id="hidn" name="info_address">
										<input type="hidden" id="hidn2" name="info_address2">
										<input type="hidden" id="hidn3" name="info_title">
										<input type="hidden" id="hidn4" name="lat">
										<input type="hidden" id="hidn5" name="lng">
										<input type="hidden" id="optionResult" name="optionResult" value="4">
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
									<tr><th>* 기본가격(필수)</th><th class="condition"> <input type="number" min="0" max="999999" step="100" name="price" title="가격은 100원 단위로 입력하세요(100만원 미만)"><br>
									가격은 100원 단위로 입력하세요(100만원 미만) </th></tr>
									<tr><th>옵션사항</th><th> 
										<input type="checkbox" id="optionRadio"> 판매옵션 있음
										<table id="tableOption">
			                            </table>
			                            <div class="condition cndtn"></div>
									</th></tr>
									<tr><th>썸네일</th><th> <input type="file" name="files" > </th></tr>
									<tr><th>상세내용</th><th class="condition"> <textarea rows="10" cols="60" name="content"></textarea>
									<div>상세내용은 1000자 이하로 입력하세요&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp0/1000</div> </th></tr>
									<tr><th>상세 이미지</th>
									<th> 
									<input type="file" name="files">
									<input type="file" name="files">
									<input type="file" name="files">
									</th></tr>
								</table>
								<div class="fh5co-spacer fh5co-spacer-sm"></div>
								<div id="idDiv">
								<button type="button" class="btn btn-sm btn-primary" onclick="history.back()">뒤로가기</button>
<!-- 								<button type="button" class="btn btn-sm btn-primary" id="go">등록하기</button> -->
								<input type="submit" class="btn btn-sm btn-primary" id="go" value="등록하기">
								</div>
							</form>
							</div>
						</div>
					
					</div>

					
				</div>
        	</div>
       </div>
	</div>


 

</body>
</html>