<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ include file="menu.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
 <link rel="stylesheet" type="text/css" href="css/slideStyle.css" />
		<script type="text/javascript" src="js/modernizr.custom.04022.js"></script>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<style>
#fh5co-board{
position: relative;
left : -200%; 
width: 500%;
height: 50%; 
}
.sp-content{
/* left: 0%; */
/* width: 100%;  */
}
.sp-slideshow{
/* left: 0%; */
/* width: 200%; */
}
.container{
/* left: 0%; */
/* width: 100%; */
}
.fh5co-desc{
color: #444;
}
.animate-box{
height: 350px;
}
</style>
<body>
<div id="fh5co-main">
	<div class="container">
	<div>
		<h3>여기부터 프리미엄</h3>
		<div class="row">
			<div id="fh5co-board" data-columns>
			<div class="sp-slideshow">
			<input id="button-1" type="radio" name="radio-set" class="sp-selector-1" checked="checked" />
				<label for="button-1" class="button-label-1"></label>
				
				<input id="button-2" type="radio" name="radio-set" class="sp-selector-2" />
				<label for="button-2" class="button-label-2"></label>
				
				<input id="button-3" type="radio" name="radio-set" class="sp-selector-3" />
				<label for="button-3" class="button-label-3"></label>
				
				<input id="button-4" type="radio" name="radio-set" class="sp-selector-4" />
				<label for="button-4" class="button-label-4"></label>
				
				<input id="button-5" type="radio" name="radio-set" class="sp-selector-5" />
				<label for="button-5" class="button-label-5"></label>
				
				<label for="button-1" class="sp-arrow sp-a1"></label>
				<label for="button-2" class="sp-arrow sp-a2"></label>
				<label for="button-3" class="sp-arrow sp-a3"></label>
				<label for="button-4" class="sp-arrow sp-a4"></label>
				<label for="button-5" class="sp-arrow sp-a5"></label>
				
				<div class="sp-content">
					<div class="sp-parallax-bg"></div>
					<ul class="sp-slider clearfix">
			
				<c:forEach items="${list}" var="item" varStatus="status">
					<c:if test="${status.count%4 eq 1}">
					<li>
					</c:if>
						<div class="column size-1of4">
							<div class="item">
								<div class="animate-box">
									<a href="detailOneBoard.do?no=${item.no}" 
										title="Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo, eos?"><img
										src="images/img_1.jpg" alt="Free HTML5 Bootstrap template"></a>
								</div>
								<div class="fh5co-desc">${item.title}</div>
							</div>
						</div>
						<c:if test="${status.count%4 eq 0}">
					</li>
					</c:if>
				</c:forEach>
				</ul>
				</div><!-- sp-content -->
				
			</div><!-- sp-slideshow -->
			</div>
				
			</div>
		</div>
			
			
			
			
		
		
		<h3>이 아래로 일반글</h3>
		<div class="row">

        	<div id="fh5co-board" data-columns>

	        	<div class="item">
	        		<div class="animate-box">
		        		<a href="images/img_1.jpg" class="image-popup fh5co-board-img" title="Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo, eos?"><img src="images/img_1.jpg" alt="Free HTML5 Bootstrap template"></a>
	        		</div>
	        		<div class="fh5co-desc">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo, eos?</div>
	        	</div>
	        	<div class="item">
	        		<div class="animate-box">
		        		<a href="images/img_2.jpg" class="image-popup fh5co-board-img"><img src="images/img_2.jpg" alt="Free HTML5 Bootstrap template"></a>
		        		<div class="fh5co-desc">Veniam voluptatum voluptas tempora debitis harum totam vitae hic quos.</div>
	        		</div>
	        	</div>
	        	<div class="item">
	        		<div class="animate-box">
		        		<a href="images/img_3.jpg" class="image-popup fh5co-board-img"><img src="images/img_3.jpg" alt="Free HTML5 Bootstrap template"></a>
		        		<div class="fh5co-desc">Optio commodi quod vitae, vel, officiis similique quaerat odit dicta.</div>
	        		</div>
	        	</div>
	        	<div class="item">
	        		<div class="animate-box">
		        		<a href="images/img_4.jpg" class="image-popup fh5co-board-img"><img src="images/img_4.jpg" alt="Free HTML5 Bootstrap template"></a>
		        		<div class="fh5co-desc">Dolore itaque deserunt sit, at exercitationem delectus, consequuntur quaerat sapiente.</div>
	        		</div>
	        	</div>
	        	<div class="item">
	        		<div class="animate-box">
		        		<a href="images/img_5.jpg" class="image-popup fh5co-board-img"><img src="images/img_5.jpg" alt="Free HTML5 Bootstrap template"></a>
		        		<div class="fh5co-desc">Tempora distinctio inventore, nisi excepturi pariatur tempore sit quasi animi.</div>
	        		</div>
	        	</div>
	        	<div class="item">
	        		<div class="animate-box">
		        		<a href="images/img_6.jpg" class="image-popup fh5co-board-img"><img src="images/img_6.jpg" alt="Free HTML5 Bootstrap template"></a>
		        		<div class="fh5co-desc">Sequi, eaque suscipit accusamus. Necessitatibus libero, unde a nesciunt repellendus!</div>
	        		</div>
	        	</div>
	        	<div class="item">
	        		<div class="animate-box">
		        		<a href="images/img_7.jpg" class="image-popup fh5co-board-img"><img src="images/img_7.jpg" alt="Free HTML5 Bootstrap template"></a>
		        		<div class="fh5co-desc">Necessitatibus distinctio eos ipsam cum hic temporibus assumenda deleniti, soluta.</div>
	        		</div>
	        	</div>
	        	<div class="item">
	        		<div class="animate-box">
		        		<a href="images/img_8.jpg" class="image-popup fh5co-board-img"><img src="images/img_8.jpg" alt="Free HTML5 Bootstrap template"></a>
		        		<div class="fh5co-desc">Debitis voluptatum est error nulla voluptate eum maiores animi quasi?</div>
	        		</div>
	        	</div>
	        	<div class="item">
	        		<div class="animate-box">
		        		<a href="images/img_9.jpg" class="image-popup fh5co-board-img"><img src="images/img_9.jpg" alt="Free HTML5 Bootstrap template"></a>
		        		<div class="fh5co-desc">Maxime qui eius quisquam quidem quos unde consectetur accusamus adipisci!</div>
	        		</div>
	        	</div>
	        	<div class="item">
	        		<div class="animate-box">
		        		<a href="images/img_21.jpg" class="image-popup fh5co-board-img"><img src="images/img_21.jpg" alt="Free HTML5 Bootstrap template"></a>
		        		<div class="fh5co-desc">Deleniti aliquid, accusantium, consectetur harum eligendi vitae quaerat reiciendis sit?</div>
	        		</div>
	        	</div>
	        	<div class="item">
	        		<div class="animate-box">
		        		<a href="images/img_10.jpg" class="image-popup fh5co-board-img"><img src="images/img_10.jpg" alt="Free HTML5 Bootstrap template"></a>
		        		<div class="fh5co-desc">Incidunt, eaque et. Et odio excepturi, eveniet facilis explicabo assumenda.</div>
	        		</div>
	        	</div>
	        	<div class="item">
	        		<div class="animate-box">
		        		<a href="images/img_11.jpg" class="image-popup fh5co-board-img"><img src="images/img_11.jpg" alt="Free HTML5 Bootstrap template"></a>
		        		<div class="fh5co-desc">Laborum dolores nihil voluptates quas alias distinctio fugiat tempora sit.</div>
	        		</div>
	        	</div>
	        	<div class="item">
	        		<div class="animate-box">
		        		<a href="images/img_12.jpg" class="image-popup fh5co-board-img"><img src="images/img_12.jpg" alt="Free HTML5 Bootstrap template"></a>
		        		<div class="fh5co-desc">Sit, quis nulla amet numquam fugit, in reiciendis laboriosam dolor.</div>
	        		</div>
	        	</div>
	        	<div class="item">
	        		<div class="animate-box">
		        		<a href="images/img_13.jpg" class="image-popup fh5co-board-img"><img src="images/img_13.jpg" alt="Free HTML5 Bootstrap template"></a>
		        		<div class="fh5co-desc">Possimus explicabo voluptatem natus nisi similique ipsa repudiandae? Quibusdam, fuga.</div>
	        		</div>
	        	</div>
	        	<div class="item">
	        		<div class="animate-box">
		        		<a href="images/img_14.jpg" class="image-popup fh5co-board-img"><img src="images/img_14.jpg" alt="Free HTML5 Bootstrap template"></a>
		        		<div class="fh5co-desc">Magni repellendus iusto mollitia, quibusdam facilis incidunt. Sunt, repellat, voluptatem.</div>
	        		</div>
	        	</div>
	        	<div class="item">
	        		<div class="animate-box">
		        		<a href="images/img_15.jpg" class="image-popup fh5co-board-img"><img src="images/img_15.jpg" alt="Free HTML5 Bootstrap template"></a>
		        		<div class="fh5co-desc">Unde iure rerum cupiditate explicabo quam aut vel earum numquam.</div>
	        		</div>
	        	</div>
	        	<div class="item">
	        		<div class="animate-box">
		        		<a href="images/img_16.jpg" class="image-popup fh5co-board-img"><img src="images/img_16.jpg" alt="Free HTML5 Bootstrap template"></a>
		        		<div class="fh5co-desc">Qui nisi error dolorum dolor delectus, alias doloremque perspiciatis nemo.</div>
	        		</div>
	        	</div>
	        	<div class="item">
	        		<div class="animate-box">
		        		<a href="images/img_18.jpg" class="image-popup fh5co-board-img"><img src="images/img_18.jpg" alt="Free HTML5 Bootstrap template"></a>
		        		<div class="fh5co-desc">Neque porro vero cumque natus nam voluptatibus, ratione, commodi labore.</div>
	        		</div>
	        	</div>
	        	<div class="item">
	        		<div class="animate-box">
		        		<a href="images/img_17.jpg" class="image-popup fh5co-board-img"><img src="images/img_17.jpg" alt="Free HTML5 Bootstrap template"></a>
		        		<div class="fh5co-desc">Quisquam quia totam, sit ea maxime sint sed excepturi quod.</div>
	        		</div>
	        	</div>
	        	<div class="item">
	        		<div class="animate-box">
		        		<a href="images/img_19.jpg" class="image-popup fh5co-board-img"><img src="images/img_19.jpg" alt="Free HTML5 Bootstrap template"></a>
		        		<div class="fh5co-desc">Nesciunt non iste ex nemo sapiente eum, provident nam corporis.</div>
	        		</div>
	        	</div>
	        	<div class="item">
	        		<div class="animate-box">
		        		<a href="images/img_20.jpg" class="image-popup fh5co-board-img"><img src="images/img_20.jpg" alt="Free HTML5 Bootstrap template"></a>
		        		<div class="fh5co-desc">Harum repellat labore est cum ipsa, nesciunt neque mollitia adipisci?</div>
	        		</div>
	        	</div>
	        	
	        	<div class="item">
	        		<div class="animate-box">
		        		<a href="images/img_22.jpg" class="image-popup fh5co-board-img"><img src="images/img_22.jpg" alt="Free HTML5 Bootstrap template"></a>
		        		<div class="fh5co-desc">Quos repellendus repudiandae debitis reprehenderit cupiditate cumque accusamus exercitationem, harum.</div>
	        		</div>
	        	</div>
	        	<div class="item">
	        		<div class="animate-box">
		        		<a href="images/img_23.jpg" class="image-popup fh5co-board-img"><img src="images/img_23.jpg" alt="Free HTML5 Bootstrap template"></a>
		        		<div class="fh5co-desc">Sunt numquam itaque delectus, dignissimos dolorem obcaecati vel, atque eos.</div>
	        		</div>
	        	</div>
	        	<div class="item">
	        		<div class="animate-box">
		        		<a href="images/img_24.jpg" class="image-popup fh5co-board-img"><img src="images/img_24.jpg" alt="Free HTML5 Bootstrap template"></a>
		        		<div class="fh5co-desc">Adipisci consequuntur ipsa fugit perspiciatis eligendi. Omnis blanditiis, totam placeat.</div>
	        		</div>
	        	</div>
	        	<div class="item">
	        		<div class="animate-box">
		        		<a href="images/img_25.jpg" class="image-popup fh5co-board-img"><img src="images/img_25.jpg" alt="Free HTML5 Bootstrap template"></a>
		        		<div class="fh5co-desc">Quos repellendus repudiandae debitis reprehenderit cupiditate cumque accusamus exercitationem, harum.</div>
	        		</div>
	        	</div>
	        	<div class="item">
	        		<div class="animate-box">
		        		<a href="images/img_26.jpg" class="image-popup fh5co-board-img"><img src="images/img_26.jpg" alt="Free HTML5 Bootstrap template"></a>
		        		<div class="fh5co-desc">Sunt numquam itaque delectus, dignissimos dolorem obcaecati vel, atque eos.</div>
	        		</div>
	        	</div>
	        	<div class="item">
	        		<div class="animate-box">
		        		<a href="images/img_27.jpg" class="image-popup fh5co-board-img"><img src="images/img_27.jpg" alt="Free HTML5 Bootstrap template"></a>
		        		<div class="fh5co-desc">Adipisci consequuntur ipsa fugit perspiciatis eligendi. Omnis blanditiis, totam placeat.</div>
	        		</div>
	        	</div>
	        	<div class="item">
	        		<div class="animate-box">
		        		<a href="images/img_28.jpg" class="image-popup fh5co-board-img"><img src="images/img_28.jpg" alt="Free HTML5 Bootstrap template"></a>
		        		<div class="fh5co-desc">Adipisci consequuntur ipsa fugit perspiciatis eligendi. Omnis blanditiis, totam placeat.</div>
	        		</div>
	        	</div>
	        	<div class="item">
	        		<div class="animate-box">
		        		<a href="images/img_29.jpg" class="image-popup fh5co-board-img"><img src="images/img_29.jpg" alt="Free HTML5 Bootstrap template"></a>
		        		<div class="fh5co-desc">Adipisci consequuntur ipsa fugit perspiciatis eligendi. Omnis blanditiis, totam placeat.</div>
	        		</div>
	        	</div>
	        	<div class="item">
	        		<div class="animate-box">
		        		<a href="images/img_30.jpg" class="image-popup fh5co-board-img"><img src="images/img_30.jpg" alt="Free HTML5 Bootstrap template"></a>
		        		<div class="fh5co-desc">Adipisci consequuntur ipsa fugit perspiciatis eligendi. Omnis blanditiis, totam placeat.</div>
	        		</div>
	        	</div>
			</div>
		</div>
		
	</div>
</div>
	
	


</body>
</html>