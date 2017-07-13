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
// 	$('#mapSearch').on('click', function(){
// 		var inputAddr = $('#inputAddr').serialize();
		
// 	 if($('#inputAddr').val() == ""){
//    		 alert('검색하실 주소를 입력하세요');
//    		 //그리고 모달이 안뜨게 해야해!!!!!
//    	 }else{
// //    		 $( "#mapContent" ).slideToggle(1000);
   		
// 		 $.ajax({
// 			type : 'get',
// 			url : 'searchAddr.do',
// 			data : inputAddr,
// 			dataType : 'json',
// 			success : function(data){
// 				alert(data.items[0].address + "를 입력하셨습니다");
		   		
// 				var juso = data.items[0].address;
// 				var destination = data.items[0].title;
				
// 			     var myaddress = juso;// 도로명 주소나 지번 주소만 가능 (건물명 불가!!!!)
// 			      naver.maps.Service.geocode({address: myaddress}, function(status, response) {
// 			          if (status !== naver.maps.Service.Status.OK) {
// 			              return alert(myaddress + '의 검색 결과가 없거나 기타 네트워크 에러');
// 			          }
			          
// 			          var result = response.result;
// 			          // 검색 결과 갯수: result.total
// 			          // 첫번째 결과 결과 주소: result.items[0].address
// 			          // 첫번째 검색 결과 좌표: result.items[0].point.y, result.items[0].point.x
// 			          var myaddr = new naver.maps.Point(result.items[0].point.x, result.items[0].point.y);
// 			          map.setCenter(myaddr); // 검색된 좌표로 지도 이동
			          
// 			          //주소리스트
// 			          $.each(data.items, function(index, value){
// 			        	  $('#table').append("<tr><td>"+value.title+"</td><td>"+value.address+"</td></tr>");
// 			          })
			          
			          
			          
// 			          // 마커 표시
// 			          var marker = new naver.maps.Marker({
// 			            position: myaddr,
// 			            map: map
// 			          });
			          
			          
// 			          // 마커 클릭 이벤트 처리
// 			          naver.maps.Event.addListener(marker, "click", function(e) {
// 			            if (infowindow.getMap()) {
// 			                infowindow.close();
// 			            } else {
// 			                infowindow.open(map, marker);
// 			            }
// 			          });
// 			          // 마크 클릭시 인포윈도우 오픈
// 			          var infowindow = new naver.maps.InfoWindow({
// 			        	  content : "<h5>"+destination+"</h5><br>"
// 			          });
// 			      });
// // 			      $('#myModal').modal();
			      
			      
			      
			      
// // 			      $('#myModal').on('show.bs.modal', function (event) { // myModal 윈도우가 오픈할때 아래의 옵션을 적용
// // 			    	  var button = $(event.relatedTarget) // 모달 윈도우를 오픈하는 버튼
// // 			    	  var titleTxt = button.data('title') // 버튼에서 data-title 값을 titleTxt 변수에 저장
// // 			    	  var modal = $(this)
// // 			    	  modal.find('.modal boddy').text('Title : ' + destination) // 모달위도우에서 .modal-title을 찾아 titleTxt 값을 치환
// // 			    	})
// 			},
// 			error : function(jpXHR, textStatus, errorThrown){
//                 alert(textStatus);
//                 alert(errorThrown);
//             }
// 		 });
   		 

//    	 }
// 	})



var mapOptions = {

    center: new naver.maps.LatLng(37.3595704, 127.105399),

    zoom: 10

}

var map = new naver.maps.Map('map', mapOptions );

})
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
					
					
					
					<div class="row">
					
						<h3>지도 띄울 곳</h3>
						<div id="mapContent">
							 <div id="map" style="width:400px;height:400px;text-align: center;"></div>
							 	<table id="table">
									<tr><th>명칭</th><th>주소</th></tr>
							  	</table>
							 </div>
						</div>
					
					</div>
					
					
					
				</div>
        		
        	</div>
       </div>
<!-- 	</div> -->


<!--   <!-- Modal --> -->
<!--   <div class="modal fade" id="myModal" role="dialog"> -->
<!--     <div class="modal-dialog modal-lg"> -->
<!--       <div class="modal-content"> -->
<!--         <div class="modal-header"> -->
<!--           <button type="button" class="close" data-dismiss="modal">&times;</button> -->
<!--           <h4 class="modal-title">검색 결과에서 알맞은 것을 선택 또는 지도에 찍은 뒤에 완료를 클릭하세요</h4> -->
<!--         </div> -->
<!--         <div class="modal-body"> -->
<!--           <p>This is a large modal.</p> -->
<!--           <div id="map" style="width:400px;height:400px;text-align: center;"></div> -->
<!--           <table id="table"> -->
<!-- 			<tr><th>명칭</th><th>주소</th></tr> -->
<!-- 		  </table> -->
<!--         </div> -->
<!--         <div class="modal-footer"> -->
<!--           <button type="button" class="btn btn-default" data-dismiss="modal">Close</button> -->
<!--         </div> -->
<!--       </div> -->
<!--     </div> -->
<!--   </div> -->

<!-- 	<div id="mapContent"> -->
<!-- 		 <div id="map" style="width:400px;height:400px;text-align: center;"></div> -->
<!-- 		 	<table id="table"> -->
<!-- 				<tr><th>명칭</th><th>주소</th></tr> -->
<!-- 		  	</table> -->
<!-- 		 </div> -->
<!-- 	</div> -->


</body>
</html>