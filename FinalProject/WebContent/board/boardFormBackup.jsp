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
width: 655px;
text-align: right;
}

#mapContent{
position: absolute;
display : none;
right: 15%;
top: 10%;
border: 1px solid red;
}
</style>

<script type="text/javascript">
$(document).ready(function(){
    var map = new naver.maps.Map('map', {
    	zoom: 11
    });
    var marker;
    var info_title = ""; //장소명
    var info_address = "";//도로명
    var info_address2 = "";//지번
    var latlng="";//위도경도
//     var infowindow;
    
    
    $(document).on('click', '#mapSearch', function(){
    	var way = $('input[name=way]:checked').val(); //검색방식 1은 주소/ 2는 키워드
 		
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
			          		'<td><input class="addrRadio" type="radio" name="address" value="'+value.address+'">'+
			          		'<input type="hidden" name="ttt" value="'+value.title+'">' + value.title +'</td><td>'+value.address + '</td>'+
			          		'</tr>'
			          	);
			        });//each 끝
			        
			        map.destroy();//원래있던 지도 지우고
			        map = new naver.maps.Map('map', {//다시 넣어주기
  				    	zoom: 11
  				    });
	  				
	  				if(data.items[0] == null){//검색결과가 없으면
	  					$('#table tbody').append('<tr><th><h3>검색결과가 올바르지 않습니다. 검색방법이 맞는지 확인하세요</h3></th></tr>');
	  				}else{
	  				
	  					info_title = data.items[0].title;
	  					info_address = data.items[0].address;
	  					info_address2 = "";
	  					
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
	  			        	
			  			    console.log(response.result.item);
			  			    console.log(marker.position.x);
			  			    console.log(result.items[0].address);
			  			    console.log(result.items[0].title);
	  						
		  			      	//직접 지도에서 찍은 곳으로 마커 이동
				  			naver.maps.Event.addListener(map, 'click', function(e) {
			  				
		// 		  				infowindow.close();
							    marker.setPosition(e.latlng);
							
							    console.log(e.latlng);
							    searchCoordinateToAddress(e.latlng);
							    info_title = "";
							    
							});
				  	        
				  	        infowindow = new naver.maps.InfoWindow({
				  	        	  content : "<h5>"+info_title+"</h5><h6>"+info_address+"</h6>"
				  	        });
				  	        
				  	        infowindow.open(map, marker);
				  	        lat = marker.position.y;
				  	        lng = marker.position.x;
	
	  			      	});//geocode 
	  			      	
	  				}//검색 결과 else
	  			},
	  			error : function(jpXHR, textStatus, errorThrown){
	                  alert(textStatus);
	                  alert(errorThrown);
	            }
	  		 });//키워드 검색 ajax 끝
  		 
  		 	 $('#myModal').modal();
  	 	}//키워드로 지도 찾는 경우 끝
  	 		////////////////////////////////////////////////////////////////////////////////////////////////////
  	 	else if(way == 1){//주소로 검색하는 경우(way==1)
 	 		$('#table tr:gt(0)').empty();
			info_address = $('#inputAddr').val();
			info_address2 = "";
			info_title = "";
			
	        map.destroy();
	        map = new naver.maps.Map('map', {
			    	zoom: 11
			    });
				
		    naver.maps.Service.geocode({address: info_address}, function(status, response) {
		    	if (status !== naver.maps.Service.Status.OK) {
		    		return alert('검색방법이 잘못 되었거나 기타 네트워크 에러');
		        }
		    	
		        var result = response.result;
		        // 검색 결과 갯수: result.total
		        // 첫번째 결과 결과 주소: result.items[0].address
		        // 첫번째 검색 결과 좌표: result.items[0].point.y, result.items[0].point.x
	        
		        var myaddr = new naver.maps.Point(result.items[0].point.x, result.items[0].point.y);
		        map.setCenter(myaddr); // 검색된 좌표로 지도 이동  		
		        
		        
		        //얘도 리스트 뿌릴수잇나
	        	$.each(result.items, function(index, value){
		          	$('#table tbody').append('<tr><td><input class="addrRadio" type="radio" name="address" value="'+value.address+'"><input type="hidden" name="ttt" value="'+value.title+'"></td><td>'+ value.address + '</td></tr>');
		        });
		        
	          
		        // 마커 표시
		        marker = new naver.maps.Marker({
		        	position: myaddr,
		            map: map
		        });
			        
	        	console.log(result);
	      		console.log(response.result.items);

				
	      		//직접 지도에서 찍은 곳으로 마커 이동
				naver.maps.Event.addListener(map, 'click', function(e) {

		  				//infowindow.close();
	    			marker.setPosition(e.latlng);
	
				    searchCoordinateToAddress(e.latlng);
				    info_title="";
				});
 	        
	  	        //인포윈도우 오픈
	  	        infowindow = new naver.maps.InfoWindow({
	  	        	content : result.userquery
	  	        });
	  	        console.log(info_title);
	  	        infowindow.open(map, marker);
	  	        lat = marker.position.y;
	  	        lng = marker.position.x;
	    		
           $('#myModal').modal();
	       });//geocode 끝
	    
 	 	}//(way==1) else 끝
  	 		
    })//검색버튼 누른 후 모달 결과 페이지까지 뽑기 끝 
    
    
    
    //라디오 선택
    $(document).on('click',".addrRadio",function(){
    	alert($(this).val());
    	
		var myaddress = $(this).val();// 도로명 주소나 지번 주소만 가능 (건물명 불가!!!!)
				
	    naver.maps.Service.geocode({address: myaddress}, function(status, response) {
// 	    	map = new naver.maps.Map('map', {
// 	        	zoom: 11
// 	        });
	    	if (status !== naver.maps.Service.Status.OK) {
	    		return alert(myaddress + '의 검색 결과가 없거나 기타 네트워크 에러');
	        }
	        var result = response.result;
	        console.log(result);
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
	        console.log(result.items);
	        info_address = myaddress;
	        info_address2 = "";
	        info_title = $('input[name=address]:checked + input').val()
	        

          // 인포윈도우 오픈
          infowindow = new naver.maps.InfoWindow({
        	  content : "<h5>"+info_title+"</h5><h6>"+info_address+"</h6>"
          });
          
          infowindow.open(map, marker);
	     
	    });

    });//라디오 선택 끝

    
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
        
  	          // 인포윈도우 오픈
  	        infowindow = new naver.maps.InfoWindow({
  	        	content : "<h6>" + items[0].address+"</h6><h6>"+items[1].address+"</h6>"
  	        });
  	          
  	        infowindow.open(map, marker);
  	        info_address = items[0].address;
  	        info_address2 = items[1].address
    	});
	}//searchCoordinateToAddress 함수 끝
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
    //클릭하면 지도 검색한 주소 가지고 부모창으로 가기
    $(document).on('click', "#submit", function(){
    	console.log('클릭');
    	
    	//infowindow에 있는 내용 담아두자
    	var addrResult = $('h6').text();
    	console.log($('h6').text());
    	
    	//부모창 div에 넣기
    	$('#addrResult').html(info_title +"<br>"+ info_address +"<br>"+info_address2);
    	$('#hidn').val(info_address);
    	$('#hidn2').val(info_address2);
    	$('#hidn3').val(info_title);
    	$('#hidn4').val(lat);
    	$('#hidn5').val(lng);
    	console.log($('#hidn').text());
    });//부모창에 주소 가져가기 끝
    
    
    
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//가격 입력하기

   	$(document).on('click', '.add', function(){
   		$('#tableOption').append(
  				'<tr>'+
			'<td><input type="text" name="option[]" class="optionName"></td>'+
			'<td><input type="text" name="optionPrice[]" class="optionPrice"></td>'+
			'<td><button class="delete">삭제</button></td>'+
			'</tr>'
   		);
   	});

    
   	//옵션삭제
   	$(document).on('click', '.delete', function(){
   		$(this).parent().parent().remove();	
   	});

    	
	//대분류 선택하면 소분류 나와
// 	$.when($.ready).then(function(){
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
   	
   	
	
	
// 	//옵션 추가 라디오 선택
// 	$("#tableOption").hide();//옵션추가 테이블 일단 숨겨놓고 시작!
//     $('input[type=checkbox]').on('click',function(){
//         $("#tableOption").toggle();
//     	if($(this).is(':checked')){
//     		$('#optionResult').val(0);
//     	}else{
//     		$('#optionResult').val(4);
//     	}
//     });


	//옵션 추가 체크박스 선택
	$("#tableOption").empty();//옵션추가 테이블 일단 숨겨놓고 시작!
    $('input[type=checkbox]').on('click',function(){
    	if($(this).is(':checked')){//체크되면
    		$('#optionResult').val(0);
    		$('#tableOption').append(
    				 '<tr><th>옵션종류</th><th>추가가격</th><th><input type="button" class="add" value="추가"></th></tr>'+
                     '<tr>'+
                        '<td><input type="text" name="option[]" class="optionName"></td>'+
                        '<td><input type="text" name="optionPrice[]" class="optionPrice"></td>'+
//                         '<td><button class="delete">삭제</button></td>'+
                     '</tr>'
    		);
    	}else{//체크 안되면
    		$('#optionResult').val(4);
    		$('#tableOption').empty();
    	}
    
    });
	
	
		
	
//     $('#optionRadio').click(function () {
//         var className = $(this).data('class');
//         //toggling to change color
//         $(this).toggleClass(className).toggleClass(className + '1');

//         //check if its clicked already using data- attribute
//         if ($(this).data("clicked")) {
//             //remove it if yes
//             $("#newDiv").find("#tablefor-" + className).remove();
//         } else {
//             //new table - note that I've added an id to it indicate where it came from
//             var newTable = '<table id="tablefor-' + className + '" style="font-size: 14;float:left;padding-left: 13px;" cellpadding="5"><tr><td style="color: #B2B2B9;">T1' + className + '</td></tr><tr><td id="cap">20</td></tr><tr><td id="minseat">8</td></tr></table>';

//             //append table                
//             $("#newDiv").append(newTable);
//         }
//         //reverse the data of clicked
//         $(this).data("clicked", !$(this).data("clicked"));
//     });
	
   	
	
	
	
   	//글등록
   	$(document).on('click', '#go', function(){
		if($('#major option:selected').val() == '대분류'){//카테고리
			console.log('카테고리를 선택하세요');
			return false;
		}
		if($('#minor option:selected').val() == '소분류'){//카테고리
			console.log('카테고리 소분류를 선택하세요');
			return false;
		}
		if($('input[name=title]').val()==''){
			console.log('제목을 쓰세요');
			return false;
		}
		if($('input[name=quantity]').val()==''){
			console.log('인원 또는 건수를 쓰세요');
			return false;
		}
		if(!$.isNumeric($('input[name=quantity]').val())){
			console.log('인원 또는 건수에는 숫자를 입력하세요');
			return false;
		}
		if($('input[name=price]').val()==''){
			console.log('가격을 쓰세요');
			return false;
		}
		if(!$.isNumeric($('input[name=price]').val())){
			console.log('가격에는 숫자를 입력하세요');
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
						return false;
					}else if(!$.isNumeric(value.value)){
						alert("옵션가격에는 숫자를 입력하세요");
						return false;
					}
				});	//옵션가격 each문 끝
			}; //if(a)끝
			return false;
		};//옵션 입력값 체크
		return true;
   	});
   	
   	
   	
});//document.ready
</script>
<script type="text/javascript">
//function 모아둘거야

// function isNumeric(num, opt){ // 좌우 trim(공백제거)을 해준다.
//   num = String(num).replace(/^\s+|\s+$/g, "");
 
//   if(typeof opt == "undefined" || opt == "1"){
//     // 모든 10진수 (부호 선택, 자릿수구분기호 선택, 소수점 선택)
//     var regex = /^[+\-]?(([1-9][0-9]{0,2}(,[0-9]{3})*)|[0-9]+){1}(\.[0-9]+)?$/g;
//   }else if(opt == "2"){
//     // 부호 미사용, 자릿수구분기호 선택, 소수점 선택
//     var regex = /^(([1-9][0-9]{0,2}(,[0-9]{3})*)|[0-9]+){1}(\.[0-9]+)?$/g;
//   }else if(opt == "3"){
//     // 부호 미사용, 자릿수구분기호 미사용, 소수점 선택
//     var regex = /^[0-9]+(\.[0-9]+)?$/g;
//   }else{
//     // only 숫자만(부호 미사용, 자릿수구분기호 미사용, 소수점 미사용)
//     var regex = /^[0-9]$/g;
//   }
 
//   if( regex.test(num) ){
//     num = num.replace(/,/g, "");
//     return isNaN(num) ? false : true;
//   }else{ return false;  }
// }




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
								<table class="table">
									<tr><th>카테고리 </th><th>
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
									<tr><th>글제목</th><th> <input type="text" name="title"> </th></tr>
									<tr><th>등록 마감일</th><th> <input type="date" name="end_date" id="datePicker" > </th></tr>
									<tr><th>인원 또는 건수</th><th> <input type="text" name="quantity"> </th></tr>
									<tr><th>장소 또는 지역</th><th>
										<input type="radio" name="way" value="1" checked="checked">주소
          								<input type="radio" name="way" value="2"> 키워드<br>
										<input type="text" id="inputAddr" name="inputAddr" > 
										<button type="button" class="btn btn-info btn-sm"  id="mapSearch">검색</button> 
										<div id="addrResult"></div>
										<input type="hidden" id="hidn" name="info_address">
										<input type="hidden" id="hidn2" name="info_address2">
										<input type="hidden" id="hidn3" name="info_title">
										<input type="hidden" id="hidn4" name="lat">
										<input type="hidden" id="hidn5" name="lng">
										<input type="hidden" id="optionResult" name="optionResult" value="4">
									</th></tr>
									<tr><th>기본가격</th><th> <input type="text" name="price"> </th></tr>
									<tr><th>옵션사항</th><th> 
										<input type="checkbox" id="optionRadio"> 판매옵션 있음
										<table id="tableOption">
			                                
			                              </table>
									</th></tr>
									<tr><th>썸네일</th><th> <input type="file" name="files"> </th></tr>
									<tr><th>상세내용</th><th> <textarea rows="10" cols="10" name="content"></textarea> </th></tr>
									<tr><th>상세 이미지 또는 동영상</th>
									<th> 
									<input type="file" name="files">
									<input type="file" name="files">
									<input type="file" name="files">
									</th></tr>
								</table>
								<div class="fh5co-spacer fh5co-spacer-sm"></div>
								<input type="submit" class="btn btn-sm btn-primary" id="go" value="GO!">
							</form>
							</div>
						</div>
					
					</div>

					
				</div>
        	</div>
       </div>
<!-- 	</div> -->


  <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">주소를 선택하거나 지도상에서 직접 찍은 후 확인을 눌러주세요</h4>

        </div>  
        <div class="modal-body">
          <div id="map" style="width:858px;height:400px;text-align: center;"></div>
          <table id="table">
			<tr><th>명칭</th><th>주소</th></tr>
		  </table>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal" id="submit">Close</button>
        </div>
      </div>
    </div>
  </div>
  
  
<!--   손연경 -->

</body>
</html>