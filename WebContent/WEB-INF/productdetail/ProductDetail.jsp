<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
	String ctxPath = request.getContextPath();
%>

<!DOCTYPE html>
<html>

<head>
<jsp:include page="/WEB-INF/header.jsp" />

<link rel="stylesheet" type="text/css" href="css/style_1.css">
<link rel="stylesheet" type="text/css" href="css/smoothproducts.css">
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>

<style type="text/css">
	
	.line {
		border: 0px solid red;
		border-collapse: collapse;
		margin-top: 20px;
		margin-bottom: 20px; 
	}
	       
	li {margin-bottom: 10px;} 
	
	.customHeight {height: 50px;}
	
	textarea#commentContents {font-size: 12pt;}
	
	div#viewComments {
	  	width: 80%;
   		margin: 3% 0 0 0; 
        text-align: left;
        max-height: 300px;
        overflow: auto;
	}
	
	span.markColor {color: #ff0000; }
	 
	div.customDisplay {
		display: inline-block;
	    margin: 1% 3% 0 0;
	}
	                
	div.commentDel {
		margin-bottom: 5%;
	    font-size: 8pt;
	    font-style: italic;
	    cursor: pointer;
	}	
	      
</style>


<script type="text/javascript">
        $(document).ready(function() {
        	
        	goLikeCnt();	// 좋아요갯수를 보여주도록 하는 것이다.
        	
        	goCommentListView();  // 제품 구매후기를 보여주는 것.
        	
         // **** 제품후기 쓰기 ****//
    
	   $("button[name='btnCommentOK']").click(function(){
		   
		   if(${empty sessionScope.loginuser.userid}) {
			   alert("제품사용 후기를 작성하시려면 먼저 로그인 하셔야 합니다.");
			   return;
		   }
		   
		   var commentContents = $("textarea#commentContents").val().trim();
		   
		   if(commentContents == "") {
			   alert("제품후기 내용을 입력하세요!!");
			   return; 
		   }
		  
		   // 보내야할 데이터를 선정하는 첫번째 방법
			  <%-- 
				   var queryString = {"fk_userid":'${sessionScope.loginuser.userid}', 
						              "fk_pdno" : ${pdvo.pdno},
						              "contents" : $("textarea#commentContents").val()};
			  --%>
		   
		   // 보내야할 데이터를 선정하는 두번째 방법
		   // jQuery에서 사용하는 것으로써,
		   // form태그의 선택자.serialize(); 을 해주면 form 태그내의 모든 값들을 name값을 키값으로 만들어서 보내준다. 
			   <%--
					   var queryString = $("form[name=commentFrm]").serialize();
					   console.log(queryString); // commentContents=Good&pdno=3 
			   --%>
   		   
			   var queryString = {
				   "userid":'${sessionScope.loginuser.userid}', 
	               "pdno" : $("input#pdno").val(),
	               "contents" : $("textarea#commentContents").val()
		       };
		     
			   console.log(queryString);

	   		   $.ajax({
	   			   url:"/TeamMVC/productdetail/commentRegister.neige",
				   type:"POST",
				   data:queryString,
				   //async: false, 
				   dataType:"json",
				   success:function(json){
					   console.log(json.n);

					   	if(json.n==1) {
							
							alert("상품평이 성공적으로 등록되었습니다.");
						  
							// alert("확인용 : 제품후기 글쓰기 성공!!");
						   goCommentListView(); // 제품후기글을 보여주는 함수호출하기 
						   $("textarea#commentContents").val("").focus();

						}else {
							alert("상품평을 등록할 수 없습니다. 관리자에게 문의하세요.");
						}
					  
				   },
				   error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				   }
	   		   });
     		 
     	   });
        }); // end of ready function---------------
        
     	// 특정 제품의 제품후기글들을 보여주는 함수
        function goCommentListView() {
			
        	var pdno = $("input#pdno").val();
        	
        	$.ajax({
     		   url:"/TeamMVC/productdetail/commentList.neige",
     		   type:"GET",
     		   data:{"pdno":pdno},
     		   dataType:"JSON",
     		   success:function(json) {
     			   // [{"contents":"제품후기내용물", "name":"작성자이름", "writeDate":"작성일자"},{"contents":"제품후기내용물2", "name":"작성자이름2", "writeDate":"작성일자2"}] 
     			    var html = "";
     				
     				if (json.length > 0) {    
     					$.each(json, function(index, item){
     						html +=  "<div> <span class='markColor'>▶</span> "+item.contents+"</div>"
					         + "<div class='customDisplay'>"+item.name+"</div>"      
					         + "<div class='customDisplay'>"+item.writeDate+"</div>"
					         + "<div class='customDisplay commentDel' onClick='commentDel()'>후기삭제</div>"
					         + "<input type='hidden' name='review_seq' id='review_seq' value='"+item.review_seq+"'/>"
					         + "<input type='hidden' name='userid_ofcomment' id='userid_ofcmment' value='"+item.fk_userid+"'/>"
					         ;
     					} ); 
     				}// end of if -----------------------
     				
     				else {
    					html += "<div style='text-align:center;'>등록된 상품후기가 없습니다.</div>";
    				}// end of else ---------------------
     				
     				$("div#viewComments").html(html);
     		   },
     		   error: function(request, status, error){
     				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
     		   }
     	   });	   
  	   
     	}
        
        // 제품 후기글을 삭제하는 메서드
        function commentDel(){
        	
        	var review_seq = $("input:hidden[name=review_seq]").val();
        	
        	var session_userid = "${sessionScope.loginuser.userid}";
        	var fk_userid = $("input:hidden[name=userid_ofcomment]").val();
        	
        	if(session_userid!=fk_userid){
        		alert("본인이 작성한 상품평만 삭제가능합니다. 아이디를 확인해주세요!");
        	}
        	else{
	        	$.ajax({
	        		url: "/TeamMVC/productdetail/deleteComent.neige",
	                type:"POST",
	                data: {
	                    "review_seq": review_seq
	                },
	                success: function() {
	                    alert("삭제 성공!!");
			        	goCommentListView();  // 제품 구매후기를 보여주는 것.
	                },
	                error: function(request, status, error) {
	                    alert("삭제 실패!! ==> \n code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
	                }
	        	})
        	}
        	
        }
        
        // **** 특정제품에 대한 좋아요 등록하기 **** // 
        function golike() {
		
        	var pdno = $("input:hidden[name=pdno]").val();
        	
            $.ajax({
                url: "/TeamMVC/productdetail/like.neige",
                type: "POST",
                data: {
                    "pdno": pdno,
                    "userid": "${sessionScope.loginuser.userid}"
                },
                dataType: "JSON",
                success: function(json) {
                    alert(json.msg);
                    //swal(json.msg);
                    //location.href=json.loc;
                    goLikeCnt();
                },
                error: function(request, status, error) {
                    alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
                }
            });
        	
        } // end of golike(pdno)---------------
        
        
        // **** 특정 제품에 대한 좋아요 갯수를 보여주기 **** //
        function goLikeCnt() {
        	var pdno = $("input:hidden[name=pdno]").val();
        	
            $.ajax({
                url: "/TeamMVC/productdetail/likeCnt.neige",
                type:"POST",
                data: {
                    "pdno": pdno
                },
                dataType: "JSON",
                success: function(json) {
                    $("div#likeCnt").html(json.likecnt);
                    $("div#likeCnt").show();
                },
                error: function(request, status, error) {
                    alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
                }
            });
        } // end of function goLikeCnt()-------------------
        
        
        // 장바구니 전송값
        function goAddCart(){
        	
        	// 보내줄 데이터의 변수를 초기화한다
        	 var pcolor = "";
	       	 var size = "";
	       	 var pqty = "";
	       	 
	       	 // 사용자가 입력하는 항목에 빈칸이 있는지 확인하는 유효성검사
        	 if ( $("select[name=productcolor]").val()=="" || $("select[name=productsize]").val()=="" || $("input:text[name=pqty]").val()=="" ){
        		 
        		 // 사용자가 입력하지 않은 항목이 무엇인지 alert을 띄워준다
		       	 alert("필수 항목을 모두 입력해주세요! (선택된 내용 확인) \n" 
		       			 + "* 색상 : " + $("select[name=productcolor]").val() 
		       			 + "  * 사이즈 : " + $("select[name=productsize]").val() 
		       			 + "  * 수량 : " + $("input:text[name=pqty]").val());
        	 	 return;
        	 	 
        	 } else { // 만약 빈칸이 없이 잘 입력했다면
        		 
        		 // 초기화된 변수에 각각의 값을 담아준다.
        		 var pcolor = $("select[name=productcolor]").val();
    	       	 var size = $("select[name=productsize]").val();
    	       	 var pqty =  $("input:text[name=pqty]").val();
    	       	 var pdno = $("input:hidden[name=pdno]").val();
    	       	 
				 // JSON은 속성-값 쌍 또는 "키-값 쌍"으로 이루어진 데이터 오브젝트를 전달하기 위해 인간이 읽을 수 있는 텍스트를 사용하는 개방형 표준 포맷이다.  	       	 
        		 // JSON 형식으로 데이터를 만든다.
				 var para_data = {"pcolor":pcolor, "size":size, "pqty":pqty, "pdno":pdno};
            	 
            	 $.ajax({
            		 url:"/TeamMVC/productdetail/goaddcart.neige",
                     type:"GET",
                     data: para_data,
                     success: function(json) {
                         alert("장바구니에 성공적으로 담겼습니다.");
                     },
                     error: function(request, status, error) {
                         alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
                     }
            	 });
        	 } 
        	 
        }// end of function goAddCart() --------------------------------------------
        
        
        
        function goBuyNow() {
        	
        	
        }// end of function goBuyNow() --------------------------------------------
        
        
    </script>
    
    
    
<meta charset="UTF-8">
<title>:: 상품상세정보 ::</title>
</head>

<body>

	<div class="container">
		<c:if test="${empty pdvo}">
			존재하지 않는 상품입니다.<br>
		</c:if>
		<div class="product-detail">
			<div class="product-summary" style="margin-top:50px;">
			
				<div class="product-detail-left">
		
							<!--  <li data-target="#ProductDetail_info"></li>-->
		
							<div class="product-detail-left">
								<img src="<%= ctxPath%>/images/${pdvo.pdimage1}"
									onmouseover="this.src='<%= ctxPath%>/images/${pdvo.pdimage2}'"
									onmouseout="this.src='<%= ctxPath%>/images/${pdvo.pdimage1}'"
									style="width: 500px; height: 520px;">
								<!-- <img src="<%= ctxPath%>/images/${pdvo.pdimage2 }" style="width: 100px; height: 100px; float: left; padding max-width: inherit;"> -->
		
							</div>
						<br>
				</div>
				<div class="product-detail-right" style="text-align: left; display: flex; flex-direction: column; justify-content: center; margin: 50px">
					<!-- product-detail option -->
						<h3 style="font-weight: bold; font-size: 16pt; color: #353535;">
								<c:out value="${pdvo.pdname}" />
								<input type="hidden" value="${pdvo.pdname}" name="pdname">
							<!-- 제품명 pdname -->
	
							<br> <small style="font-weight: bold;">Product No. 
								${pdvo.pdno}
								<input type="hidden" value="${pdvo.pdno}" name="pdno" id="pdno" />
							</small>
							<!-- 제품번호 pdno -->
						</h3>
						<h5 style="font-weight: bold; font-size: 11.5pt">
							<b style="font-size: 18px; margin-bottom: 20px;">가    격 : </b> &#8361;
							<fmt:formatNumber value="${pdvo.price}" pattern="###,###" />
							<br> <br>
							<b style="font-size: 18px; margin-bottom: 20px;">소    재 : </b>
							<c:out value="${pdvo.texture}" />
						</h5>
	
					<!-- get 방식을 사용해서 데이터 전송 (method="get") -->
					<form name="addcart" action="/productdetail/cartcheck.jsp"
						method="GET">
						<h5 style="font-weight: bold; font-size: 11.5pt">
							<input type="hidden" name="pdno" value='${pdvo.pdno}'> 
							<b style="font-size: 18px; margin-bottom: 20px;">색    상 : </b> 
							<select name="productcolor" class="productData" style="color: gray; font-weight: bold; font-size: 11.5pt">
								<option id="colorbtn" value="" style="color: gray; font-weight: bold; font-size: 11.5pt">필수</option>
								<c:forEach var="pcolor" items="${productColorList}">
									<option id="color" value="${pcolor}" style=" color: gray; font-weight: bold; font-size: 11.5pt"
										style="color: gray;">${pcolor}</option>
								</c:forEach>
							</select>
						</h5>
						<h5 style="font-weight: bold; font-size: 11.5pt">
							<b style="font-size: 18px; margin-bottom: 20px;">사이즈 : </b> 
							<select name="productsize" class="productData" style="color: gray; font-weight: bold; font-size: 11.5pt">
								<option id="sizebtn" value="" style="color: gray; font-weight: bold; font-size: 11.5pt">필수</option>
								<c:forEach var="psize" items="${productSizeList}">
									<option id="size" value="${psize}" style="color: gray; font-weight: bold; font-size: 11.5pt">${psize}</option>
								</c:forEach>
							</select> <br>
						</h5>
						<h5 style="font-weight: bold; font-size: 11.5pt" >
								<b style="font-size: 18px; margin-bottom: 20px;" >수    량 : </b>
								<!-- <input type="number" name= "pqty" min="1" max="1000" value="10" step="1" /> --> 
								<input type="text" name="pqty" size="10" value='' style="width: 30px; height: 30px; color: gray;" />
						</h5>

						<h5 style="font-weight: bold; font-size: 11.5pt">
							<b style="font-weight: bold; font-size: 18px; ">배송비 : </b> FREE
						</h5>

						<div class="addButtons" style="margin-top: 50px">
							<input type="button" name="addCart" onClick="goAddCart()" value="장바구니" class="addtocart" /> 
							<input type="button" name="buynow" value="구매하기" onClick="goBuyNow()" class="addtocart" />
							<input type="hidden" value="${gender}" name="gender" />
						</div>
					</form>
					<!-- get 방식을 사용해서 데이터 전송 (method="get") end -->
				</div>
			</div>
			</div>
			<!-- product-detail option end -->

			<div class="product-detail-feature">
					<h3>상품상세정보</h3>
					<hr>
					<div style="width:80%; margin: 30px;">
						<span>${pdvo.pdcontent}</span>
					</div>
					<a href="<%=ctxPath%>/images/56_3.jpg" > 
					<img src="<%=ctxPath%>/images/56_3.jpg" >
					</a>
					<img src="<%= ctxPath%>/images/${pdvo.pdimage1}" style="width: 80%; margin:20px;">
					<img src="<%= ctxPath%>/images/${pdvo.pdimage2}" style="width: 80%; margin:20px;">
			</div>
	

		<%-- 좋아요 --%>
		<div class="row" style="margin-bottom: 50px;">
			<div class="col-md-2 col-md-offset-5"> 
				<div id="likeCnt" align="center" style="color: #A5907B; font-size: 20pt;"></div>
				<img src="<%=request.getContextPath()%>/images/like.png" style="width:30%; cursor: pointer; margin: 0 auto;" onClick="golike()" />
				<p style="font-weight: bold; font-size: 14pt; color: #353535;">좋아요</p>
			</div>
		</div>
		
		<%-- 제품사용 후기 내용입력 --%>
		<div class="product-comments">
			<h3 style="font-weight: bold; font-size: 12pt; color: #353535;">제품사용 후기</h3>
			<div id="viewComments">
			</div>
			<form name="commentFrm">
				<div>
					<textarea cols="100" class="customHeight" name="contents" id="commentContents" style="margin: 0px; width: 400px; height: 100px;"></textarea>
				</div>
				<div>
					<button type="button" class="customHeight" name="btnCommentOK" style="font-weight: bold; font-size: 11pt">후기등록</button>
				<input type="hidden" name="fk_userid" value="${sessionScope.loginuser.userid}" />
		    	<input type="hidden" name="fk_pdno" value="${pdvo.pdno}" />
				</div>
			</form>
	
		</div>
	</div>
	<!-- product detail -->
	<%-- container  --%>
</body>

</html>

<jsp:include page="/WEB-INF/footer.jsp" />