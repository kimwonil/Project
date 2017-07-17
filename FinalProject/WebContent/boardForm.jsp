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
	
    var map = new naver.maps.Map('map');
    var marker;
    var info_title = "";
    var info_address = "";
    
    $('#mapSearch').on('click', function(){
  	  
  	  if($('#inputAddr').val() == ""){
  		 alert('검색하실 주소를 입력하세요');
  	 }else{
  		 $.ajax({
  			type : 'post',
  			url : 'searchAddr.do',
  			data : {inputAddr:$('#inputAddr').val()},
  			dataType : 'json',
  			success : function(data){
  			//주소리스트
  			$('#table tr').empty();
		          $.each(data.items, function(index, value){
		        	  
		          	$('#table tbody').append('<tr><td><input class="addrRadio" type="radio" name="address" value="'+value.address+'">' + value.title +'</td><td><input type="hidden" name="ttt" value="'+value.title+'">'+ value.address + '</td></tr>');
		          });
  			
  			//검색 결과 item[0]의 address를 가져와서 지도 api에서 검색한 뒤 중심이동&마커표시
  				var myaddress = data.items[0].address;// 도로명 주소나 지번 주소만 가능 (건물명 불가!!!!)
  				info_title = data.items[0].title;
  				info_address = myaddress;
  			    naver.maps.Service.geocode({address: myaddress}, function(status, response) {
  			    	if (status !== naver.maps.Service.Status.OK) {
  			    		return alert(myaddress + '의 검색 결과가 없거나 기타 네트워크 에러');
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
  			      	console.log("78번째줄"+marker.Object);
  			      console.log("78번째줄"+marker.position);
  			    console.log("78번째줄"+marker.address);
  			  console.log("78번째줄"+ result.items[0].address);
  			console.log("78번째줄"+ result.items[0].title);
  					
  			      	//직접 지도에서 찍은 곳으로 마커 이동
		  			naver.maps.Event.addListener(map, 'click', function(e) {
					    marker.setPosition(e.latlng);
					    
					});

			          // 마커 클릭 이벤트 처리
			          naver.maps.Event.addListener(marker, "click", function(e) {
			            if (infowindow.getMap()) {
			                infowindow.close();
			            } else {
			                infowindow.open(map, marker);
			            }
			          });
  			          // 마크 클릭시 인포윈도우 오픈
  			          var infowindow = new naver.maps.InfoWindow({
  			        	  content : "<h5>"+info_title+"</h5><br><h6>"+info_address+"</h6>"
  			          });
  			      });
  				
  			},
  			error : function(jpXHR, textStatus, errorThrown){
                  alert(textStatus);
                  alert(errorThrown);
              }
  		 });
  		 
  		 $('#myModal').modal();
  	 }
  	  
    });//지도 modal 끝(검색 클릭)
    
    
    
    
    $(document).on('click',".addrRadio",function(){
    	alert($(this).val());
    	
		var myaddress = $(this).val();// 도로명 주소나 지번 주소만 가능 (건물명 불가!!!!)
				
	    naver.maps.Service.geocode({address: myaddress}, function(status, response) {
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
	        
	        console.log("여기여기"+result.items[0]);
	        console.log("title도 나오니?" + ($('input[name=address]:checked').next()).val());

        // 마커 클릭 이벤트 처리
        naver.maps.Event.addListener(marker, "click", function(e) {
          if (infowindow.getMap()) {
              infowindow.close();
          } else {
              infowindow.open(map, marker);
          }
        });
          // 마크 클릭시 인포윈도우 오픈
          var infowindow = new naver.maps.InfoWindow({
        	  content : "<h5>"+info_title+"</h5><br><h6>"+info_address+"</h6>"
          });
          
	    });
		
		

    });
    
    
    
    
		
});
</script>

<script type="text/javascript">




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
									<tr><th>장소 또는 지역</th><th> <input type="text" id="inputAddr" name="inputAddr" > 
									<button type="button" class="btn btn-info btn-sm"  id="mapSearch">검색</button> </th></tr>
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
<!-- 	</div> -->


  <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">검색 결과에서 알맞은 것을 선택 또는 지도에 찍은 뒤에 완료를 클릭하세요</h4>
        </div>  
        <div class="modal-body">
          <div id="map" style="width:858px;height:400px;text-align: center;"></div>
          <table id="table">
			<tr><th>명칭</th><th>주소</th></tr>
		  </table>
<!-- 		  <div id="table"> -->
<!-- 		  </div> -->
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>




</body>
</html>