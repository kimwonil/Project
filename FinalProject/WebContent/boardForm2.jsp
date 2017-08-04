<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="menu.jsp" %>
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
    var info_title = "";
    var info_address = "";//도로명
    var info_address2 = "";//지번
    var infoWindow;
    
    
    $(document).on('click', '#mapSearch', function(){
    	var way = $('input[name=way]:checked').val();
 		console.log("검색방식 1은 주소/ 2는 키워드 : " + way);
 		
 		map = new naver.maps.Map('map', {
 	    	zoom: 12
 	    });
 		
 		
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
				  			    console.log("78번째줄"+marker.position);
				  			    console.log("78번째줄"+ result.items[0].address);
				  			    console.log("78번째줄"+ result.items[0].title);
		  						
			  			      	//직접 지도에서 찍은 곳으로 마커 이동
					  			naver.maps.Event.addListener(map, 'click', function(e) {
				  				
			// 		  				infowindow.close();
								    marker.setPosition(e.latlng);
								
								    console.log(e.latlng);
								    searchCoordinateToAddress(e.latlng);
								    
								});
					  	        
					  	        infowindow = new naver.maps.InfoWindow({
					  	        	  content : "<h5>"+info_title+"</h5><h6>"+info_address+"</h6>"
					  	        });
					  	        
					  	        infowindow.open(map, marker);
		
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
  	 			$('#table tr:gt(0)').remove();
				info_address = $('#inputAddr').val();
				info_address2 = "";
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
	          
			        // 마커 표시
			        marker = new naver.maps.Marker({
			        	position: myaddr,
			            map: map
			        });
				        
		        	console.log(result);
		      		console.log(response.result.items);
		// 		    console.log("78번째줄"+marker.position);
		// 			console.log("78번째줄"+ result.items[0].address);
		// // 		console.log(result.items[1].address);
					
		      		//직접 지도에서 찍은 곳으로 마커 이동
					naver.maps.Event.addListener(map, 'click', function(e) {

// 		  				infowindow.close();
		    			marker.setPosition(e.latlng);
		
					    searchCoordinateToAddress(e.latlng);
					});
  	        
		  	        //인포윈도우 오픈
		  	        var infowindow = new naver.maps.InfoWindow({
		  	        	content : info_address
		  	        });
		  	        console.log(info_title);
		  	        infowindow.open(map, marker);
		    		
		      });//geocode 끝
		      $('#myModal').modal();
		    
  	 	}//(way==1) else 끝
  	 		
	  	}//검색어 입력 else
    })//검색방식 선택 했을경우 
  	  
    
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
  	        	content : "<h5>title이 없어서 미안해</h5><h6>"+items[0].address+"</h6><h6>"+items[1].address+"</h6>"
  	        });
  	          
  	        infowindow.open(map, marker);
  	        info_address = items[0].address;
  	        info_address2 = items[1].address
    	});
	}
	
	
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
							<form id="detailInfo">
								<table class="table">
									<tr><th>카테고리 </th><th>
									<select><option>대분류</option><option>카테고리2</option><option>카테고리3</option> </select> 
									<select><option>소분류</option><option>카테고리2</option><option>카테고리3</option> </select>
									</th></tr>
									<tr><th>글제목</th><th> <input type="text" name="title"> </th></tr>
									<tr><th>등록 마감일</th><th> <input type="text" name="end_date"> </th></tr>
									<tr><th>인원 또는 건수</th><th> <input type="text" name="limit"> </th></tr>
									<tr><th>장소 또는 지역</th><th> 
									          <input type="radio" name="way" value="1" checked="checked">주소
          									<input type="radio" name="way" value="2"> 키워드<br>
									
									<input type="text" id="inputAddr" name="inputAddr" > 
									<button type="button" class="btn btn-info btn-sm"  id="mapSearch">검색</button> 
										<div id="addrResult"></div>
									</th></tr>
									<tr><th>기본가격</th><th> <input type="text" name="price"> </th></tr>
									<tr><th>옵션가격</th><th> <input type="text"> </th></tr>
									<tr><th>썸네일</th><th> <input type="file" name="thumbnail"> </th></tr>
									<tr><th>상세내용</th><th> <textarea rows="10" cols="10" name="content"></textarea> </th></tr>
									<tr><th>상세 이미지 또는 동영상</th><th> <input type="file" name="file_name"> </th></tr>
								</table>
							</form>
								<div class="fh5co-spacer fh5co-spacer-sm"></div>
								<a href="#" class="btn btn-sm btn-primary" id="go">GO!</a>
							</div>
						</div>
					
					</div>

					
				</div>
        	</div>
       </div>
<!-- 	</div> asdf-->


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

</body>
</html>