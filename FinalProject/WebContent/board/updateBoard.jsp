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
    	zoom: 12
    });
    var marker;
    var info_title = ""; //장소명
    var info_address = "";//도로명
    var info_address2 = "";//지번
    var latlng="";//위도경도
    var information = "";//infowindow에 표시할 내용
    
    
    $(document).on('click', '#mapSearch', function(){
    	var way = $('input[name=way]:checked').val();
 		console.log("검색방식 1은 주소/ 2는 키워드 : " + way);
 		
    	if($('#inputAddr').val() == ""){
	  		 alert('검색어를 입력하세요');
	  	}else{
	  		
  		 	if(way == 2){//키워드로 검색할 경우
  		  		 
		  		 $.ajax({
		  			type : 'post',
		  			url : 'searchAddr.do',
		  			data : {inputAddr:$('#inputAddr').val()},
		  			dataType : 'json',
		  			success : function(data){
		  				console.log(data.items);
		  				
		  				//주소리스트
		  				$('#table tr:gt(0)').empty();
		  			
				        $.each(data.items, function(index, value){
				          	$('#table tbody').append('<tr><td><input class="addrRadio" type="radio" name="address" value="'+value.address+'"><input type="hidden" name="ttt" value="'+value.title+'">' + value.title +'</td><td>'+ value.address + '</td></tr>');
				        });
				        
				        map.destroy();
		  			
				        map = new naver.maps.Map('map', {
	  				    	zoom: 12
	  				    });
		  				
		  				if(data.items[0] == null){
		  					$('#table tbody').append('<tr><th><h3>검색결과가 올바르지 않습니다. 검색방법이 맞는지 확인하세요</h3></th></tr>');
		  				}else{
		  				
		  					info_title = data.items[0].title;
		  					info_address = data.items[0].address;
		  					info_address2 = "";
		  					
		  					
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
		  			        
				  			    console.log("검색어로 검색할때 " + response.result.item);
				  			    console.log("78번째줄"+marker.position.x);
				  			    console.log("78번째줄"+ result.items[0].address);
				  			    console.log("78번째줄"+ result.items[0].title);
		  						
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
  	 		else{//주소로 검색하는 경우(way==1)
  	 			$('#table tr:gt(0)').empty();
				info_address = $('#inputAddr').val();
				info_address2 = "";
				info_title = "";
				
		        map.destroy();
		        map = new naver.maps.Map('map', {
				    	zoom: 12
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

// 		  				infowindow.close();
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
  	 		
	  	}//검색어 입력 else
    })//검색방식 선택 했을경우 
    
    
    
    //라디오 선택
    $(document).on('click',".addrRadio",function(){
    	alert($(this).val());
    	
		var myaddress = $(this).val();// 도로명 주소나 지번 주소만 가능 (건물명 불가!!!!)
				
	    naver.maps.Service.geocode({address: myaddress}, function(status, response) {
// 	    	map = new naver.maps.Map('map', {
// 	        	zoom: 12
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
	'<td><input type="text" name="option[]"></td>'+
	'<td><input type="text" name="optionPrice[]"></td>'+
	'<td><button class="delete">삭제</button></td>'+
	'</tr>'
	);
	});
	
	
	$(document).on('click', '.delete', function(){
	$(this).parent().parent().remove();	
	});
	
   	$('#go').click(function(){
   		$('#detailInfo').submit(function(){
   		});
   	});
	
	
   	$.when($.ready).then(function(){
   		$.ajax({
   			url:"categoryLow.do",
   			type:"POST",
   			data:{high_no:$('#major').val()},
   			dataType:"json",
   			success:function(data){
   				console.log(data);
   				$('#minor').empty();
   				$.each(data, function(index, value){
	   				$('#minor').append(
	   						(value.no == $('#minorSelected').val() ? '<option value="'+value.no+'" selected>'+value.category_name+'</option>' : '<option value="'+value.no+'">'+value.category_name+'</option>')
	   				);
   				});
   			},
   			error:function(){
   				alert("실패");
   			}
   		});
   	});//카테고리 ajax 끝
   	
   	
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
							<input type="hidden" id="minorSelected" value="${board.category_minor}">
							<form id="detailInfo" action="updateBoard.do" method="post" enctype="multipart/form-data">
								<table class="table">
									<tr><th>카테고리 </th><th>
									<select name="major" id="major">
										<c:forEach items="${categoryList}" var="high">
											<c:if test="${high.no eq board.category_major}">
												<option value="${high.no}" selected>${high.category_name}</option>
											</c:if>											
											<option value="${high.no}">${high.category_name}</option>
										</c:forEach>
									</select> 
									<select name="minor" id="minor">
										<option>소분류</option><option>대분류를 선택하세요</option>
									</select>
									</th></tr>
									<tr><th>글제목</th><th> <input type="text" name="title" value="${board.title}"> </th></tr>
									<tr><th>등록 마감일</th><th> <input type="date" name="end_date" value="${board.end_date }"> </th></tr>
									<tr><th>인원 또는 건수</th><th> <input type="text" name="quantity" value="${board.quantity }"> </th></tr>
									<tr><th>장소 또는 지역</th><th>
										<input type="radio" name="way" value="1" checked="checked">주소
          								<input type="radio" name="way" value="2"> 키워드<br>
										<input type="text" id="inputAddr" name="inputAddr" > 
										<button type="button" class="btn btn-info btn-sm"  id="mapSearch">검색</button> 
										<div id="addrResult">
											<c:if test="${mapinfo.title ne ''}">
											${mapinfo.title}<br>
											</c:if>
											${mapinfo.address}<br>
											<c:if test="${mapinfo.address2 ne '' }">
											${mapinfo.address2 }
											</c:if>
										</div>
										<input type="hidden" id="hidn" name="info_address" value="${mapinfo.address }">
										<input type="hidden" id="hidn2" name="info_address2" value="${mapinfo.address2 }">
										<input type="hidden" id="hidn3" name="info_title" value="${mapinfo.title }">
										<input type="hidden" id="hidn4" name="lat" value="${mapinfo.lat}">
										<input type="hidden" id="hidn5" name="lng" value="${mapinfo.lng}">
										<input type="hidden" name="no" value="${board.no}">
									</th></tr>
									<tr><th>기본가격</th><th> <input type="text" name="price" value="${board.price}"> </th></tr>
									<tr><th>옵션사항</th><th> 
										<table id="tableOption">
											<tr>
											<th>옵션종류</th><th>추가가격</th><th><input type="button" class="add" value="추가"></th>
											</tr>
											
											<c:forEach items="${board_optionList }" var="board_option">
											
											<tr>
											<td><input type="text" name="option[]" value="${board_option.kind}"></td>
											<td><input type="text" name="optionPrice[]" value="${board_option.price }"></td>
											<td><button class="delete">삭제</button></td>
											</tr>
											
											</c:forEach>
											
										</table> 
									</th></tr>
									<tr><th>썸네일</th><th> <input type="file" name="files">
									<div>${files.file_name1}</div>
									 </th></tr>
									<tr><th>상세내용</th><th> <textarea rows="10" cols="10" name="content">${board.content}</textarea> </th></tr>
									<tr><th>상세 이미지 또는 동영상</th>
									<th>
									<input type="file" name="files" >
									<div>${files.file_name2}</div>
									<input type="file" name="files" >
									<div>${files.file_name3}</div>
									<input type="file" name="files" >
									<div>${files.file_name4}</div>
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