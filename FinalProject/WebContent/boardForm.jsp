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
    var juso = "";
    var destination = "";
    
    $('#mapSearch').on('click', function(){
  	  var inputAddr = $('#inputAddr').serialize();	
  	  alert(inputAddr);
  	  
  	  if($('#inputAddr').val() == ""){
  		 alert('검색하실 주소를 입력하세요');
  	 }else{
  		 $.ajax({
  			type : 'get',
  			url : 'searchAddr.do',
  			data : inputAddr,
  			dataType : 'json',
  			success : function(data){
  			//주소리스트
		          $.each(data.items, function(index, value){
//			        	  $('#table').append("<tr><td>"+value.title+"</td><td>"+value.address+"</td></tr>");
		          	$('#table').append('<input type="radio" name="address" value="'+index+'">' + value.title + value.address + '<br>');
		          });
  			
  			
  			
  			//일단 item[0]기준으로 마커 찍고
  				var myaddress = data.items[0].address;// 도로명 주소나 지번 주소만 가능 (건물명 불가!!!!)
  			    naver.maps.Service.geocode({address: myaddress}, function(status, response) {
  			    	if (status !== naver.maps.Service.Status.OK) {
  			    		return alert(myaddress + '의 검색 결과가 없거나 기타 네트워크 에러');
  			        }
  			        var result = response.result;
  			        // 검색 결과 갯수: result.total
  			        // 첫번째 결과 결과 주소: result.items[0].address
  			        // 첫번째 검색 결과 좌표: result.items[0].point.y, result.items[0].point.x
  			        console.log(result);
  			        for(var i=0;i<result.items.length;i++){
  			        	console.log(result.items[i]);
  			        }
  			        
  			        var myaddr = new naver.maps.Point(result.items[0].point.x, result.items[0].point.y);
  			        map.setCenter(myaddr); // 검색된 좌표로 지도 이동
  			          
  			          
  			        // 마커 표시
  			        var marker = new naver.maps.Marker({
  			        	position: myaddr,
  			            map: map
  			        });



  			
  			
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
  			        	  content : "<h5>"+"맵의 좌표에 해당하는 주소에서 정보 가져와야해 그리고 인포윈도우는 마커를 따라다녀야해 하하핳하하하하"+"</h5><br>"
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
  	  
    });
    
    
		//라디오 선택한 곳으로 마커이동
		$('input[name=address]').on('click', function(){
			alert($('input[name=address]:checked').val());
//			var mapx = $('input[name=address]:checked');
//			var mapy = ;
//			var latlng = naver.maps.Point(mapx, mapy);
//			marker.setPosition(latlng);

		var mapx = data.items[$('input[name=address]:checked').val()].mapx;
		var mapy = data.items[$('input[name=address]:checked').val()].mapy;
		
		console.log(mapx + mapy);
		var point = new naver.maps.Point(mapx, mapy);
		
		map.setCenter(point);
		
//	        var map = new naver.maps.Map('map', {
//	        	center: new naver.maps.Point(mapx, mapy),
//	        	zoom: 11
////   			        	position: $('input[name=address]:checked').val(),
	            
//	        });
		
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
								<table class="table">
									<tr><th>카테고리</th><th>
									<select><option>대분류</option><option>카테고리2</option><option>카테고리3</option> </select> 
									<select><option>소분류</option><option>카테고리2</option><option>카테고리3</option> </select>
									</th></tr>
									<tr><th>글제목</th><th> <input type="text"> </th></tr>
									<tr><th>등록 마감일</th><th> <input type="text"> </th></tr>
									<tr><th>인원 또는 건수</th><th> <input type="text"> </th></tr>
									<tr><th>장소 또는 지역</th><th> <input type="text" id="inputAddr" name="inputAddr"> 
									<button type="button" class="btn btn-info btn-sm"  id="mapSearch">검색</button> </th></tr>
									<tr><th>기본가격</th><th> <input type="text"> </th></tr>
									<tr><th>옵션가격</th><th> <input type="text"> </th></tr>
									<tr><th>썸네일</th><th> <input type="file"> </th></tr>
									<tr><th>상세내용</th><th> <textarea rows="10" cols="10"></textarea> </th></tr>
									<tr><th>상세 이미지 또는 동영상</th><th> <input type="file"> </th></tr>
								</table>
							
								<div class="fh5co-spacer fh5co-spacer-sm"></div>
								<a href="#" class="btn btn-sm btn-primary" >GO!</a>
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
          <p>This is a large modal.</p>
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