<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
   String ctxPath = request.getContextPath();
   //         /TeamMVC
%>

<jsp:include page="../header.jsp" />

<style>
   div#Menu_Items{
      visibility:hidden;
   }
   div#searchArea{
      color: gray;
   }
   div.titleArea{
      margin: 50px 0 50px;
      color: #526B8E;
       width: 180px;
       padding: 15px font-size: 17pt;
       margin: 30px;
       height: 30px;
       border-bottom: solid 3px #e3e3e3;
       letter-spacing: 4px;
   }
   div.searchBox{
      width: 50%;
      margin: 40px;
      padding: 40px;
      border: 1px solid #e5e5e5;
      color: #353535;
      font-size: 11pt;
   }
   fieldset{
       width: 60%;
       margin: 0 auto;
       padding: 0 47px;
   }

   div.genderRadio > div{
      display: inline;
      margin: 30px 0;
   }
   div.genderRadio > span {
      font-weight: bold; 
      text-align: left;
   }
   div.genderRadio  > div > label{
      text-align: left;      
      margin: 10px;
      font-weight: normal;
   }
   div.item > label{
      float: left;
        clear: left;
       padding: 5px 10px 0 0;
       text-align: left;
      margin: 0 0 10px 0;
   }
   label#category{
      letter-spacing: 3px;
   }
   label#keyword{
      letter-spacing: 2px;
   }
   select#category{
      width: 70%;
      margin: 0 0 10px 0;
      float: right;      
   }
   input#keyword{
      width: 70%;
      margin: 0 0 10px 0;
      float: right;
   }
   button#search{
      background-color: gray;
      margin: 10px 0;
      color: white; 
   }
   div.container{
      width: 1380px;   
      font-size: 11pt;
   }
   ul.orderBy{
      font-size: 10pt;
      text-align: right;
      padding: 10px;
      margin: 30px 60px;
   }
   ul.orderBy>li{
      padding: 0 ;
      display: inline;
   }
   ul{
      padding-inline-start: 0px;
       list-style-type: none;
   }
   ul.productList>li#box{
       display: block;
       font-size:13px;
       line-height: 150%;
   }
   div.col-md-3{
       margin: 0 0 50px 0;
   }
   div.item{
      margin: 8px 0 0;
       color: #353535;
       line-height: 20px;
   }
   img{
      width: 280px;
      height: 350px;
       position: relative;
       margin: 0 0 15px;
       text-align: center;
       overflow: hidden;
   }   
   div.pname{
      font-weight: bolder;
   }
   .dot {
     height: 12px;
     width: 12px;
     border: 1px solid #DCDCDC;
     border-radius: 50%;
     display: inline-block;
   }
   button#showMore{
      background-color: #F5F5F5;
      color: gray; 
      margin: 0 auto;
   }
   li.sort > span {
   		margin: 0 5px; 
   }


</style>

<script type="text/javascript">

   $(document).ready(function(){
       
      /* ?????? ????????? ???????????? */
       $("button#search").click(function(){
          var gender = $("input[name='gender']:checked").val();
          var category = $("select#category").val();
          var searchname = $("input#keyword").val();

          location.href="<%= ctxPath%>/search/SearchPage.neige?pdgender="+gender+"&pdcategory_fk="+category+"&searchname="+searchname;
       });
       
      // ????????? ????????? ????????? ???????????????
      if( ${requestScope.pdgender != null || requestScope.pdgender != "0"} ){
          $("input:radio[name='gender']:radio[value='${requestScope.pdgender}']").prop('checked', true);
       }
       
       if( ${requestScope.pdcategory_fk != null} ) {
          $("select#category").val("${requestScope.pdcategory_fk}");
       } 
      
      if( ${requestScope.searchname != null} ) {
         $("input#keyword").val("${requestScope.searchname}");
      } 
      
      if ( ${requestScope.searchCount != null} ) {
         $("span#searchno").html("${requestScope.searchCount}");
      }
      
      
      /* ?????? ????????? ????????? ???????????? */
      $("li.sort").click(function(){
          var gender = $("input[name='gender']:checked").val();
          var category = $("select#category").val();
          var searchname = $("input#keyword").val();
          // ????????? ?????? ???????????? ???????????? ??????
          var sort = $(this).attr("id");
          location.href="<%= ctxPath%>/search/SearchPage.neige?pdgender="+gender+"&pdcategory_fk="+category+"&searchname="+searchname+"&sort="+sort;         
       });
      
      
       // ?????? ????????? ??? bold???????????? 
	       if( ${requestScope.sort != null} ) {
	    	   var sort = "${requestScope.sort}"; 
	            
	    	    if(sort == "sortNewProduct") {
	 				$("li#sortNewProduct").css('font-weight','bold');
			 	}
			 	else if(sort == "sortLowPrice") {
			 		 $("li#sortLowPrice").css('font-weight','bold');
			 	}
			 	else if(sort == "sortHighPrice") {
			 		 $("li#sortHighPrice").css('font-weight','bold');
			 	}
			 	else if(sort == "sortBestProduct") {
			 		 $("li#sortBestProduct").css('font-weight','bold');
			 	}
       }
       
       
    	// *** select ????????? ?????? ????????????  click ??? ????????? change ??????. *** // 
		$("select#sizePerPage").bind("change", function(){
			goSearch();
		});
		
		if("${sizePerPage}" != "" ) {
			$("select#sizePerPage").val("${sizePerPage}");
		}
    
   }); // end of $(document).ready()------------------------
   
   function goSearch() {
		var frm = document.memberFrm;
		frm.action = "search/SearchPage.neige";
		frm.method = "GET";
		frm.submit();
	}

	 

</script>


<%-- ?????? ??????????????? --%>
<div id="searchArea">
   <div class="titleArea">SEARCH ITEMS</div>
   <div class="searchBox">
   <fieldset>
      <div class="genderRadio">
         <span id="gender" style="margin: 0 30px 0 0 ">???  ???</span>
	         <div id="all" ><label for="0">??????</label><input name="gender" type="radio" id="0" value="0" checked="checked"></div>
	         <div id="women"><label for="2">??????</label><input name="gender" type="radio" id="2" value="2"></div>
	         <div id="men"><label for="1">??????</label><input name="gender" type="radio" id="1" value="1"></div>
      </div>
      <div class="item">
         <div class="category">
            <div class="form-group">
               <label for="category">????????????</label>
               <select id="category" name="category">
                  <option value="0">??????</option>
                  <option value="1">??????</option>
                  <option value="2">??????</option>
                  <option value="3">??????</option>
                  <option value="4">?????????</option>
                  <option value="5">?????????</option>
               </select>
            </div>
         </div>
      </div>
      <div class="item">
         <div class="keyword">
            <div class="form-group">
               <label for="keyword">?????? ?????????</label>
               <input id="keyword" name="keyword" type="text">   
            </div>
         </div>
      </div>
      <div>
         <button type="button" class="btn btn-block" id="search">??????</button>
      </div>
   </fieldset>
   </div>
   
<%-- ????????? ?????? ??? ??????????????? --%>
<div id="cateProductList">
   
   <%-- ?????? ?????? ?????? --%>
   <div class="searchResult" >
      <p class="record">??? <span id="searchno" style="font-weight: bold;"></span>?????? ????????? ?????????????????????.</p>
   </div>
   
   <%-- ?????? ?????? --%>
   <div class="orderBy">
      <ul class="orderBy">
         <li class="sort" value="sortNewProduct" id="sortNewProduct">
            <a href="javascript:void(0);" style="color: black;">????????????</a><span class="delimiter">&#124;</span> 
         </li>
         <li class="sort" value="sortLowPrice" id="sortLowPrice">
            <a href="javascript:void(0);" style="color: black;">???????????????</a><span class="delimiter">&#124;</span> 
         </li>
         <li class="sort" value="sortHighPrice" id="sortHighPrice">
            <a href="javascript:void(0);" style="color: black;">???????????????</a><span class="delimiter">&#124;</span> 
         </li>
         <li class="sort" value="sortBestProduct" id="sortBestProduct">
            <a href="javascript:void(0);" style="color: black;">???????????????</a> 
         </li>
      </ul>
   </div>
   <%-- ??????????????? ???????????? ?????? --%>
   <div class="container">
      <ul class="productList"> 
      		  <%-- ????????? ?????????????????? ?????? ???????????? ????????? ?????? ?????????????????? ??????????????? ??????. --%>
              <c:forEach var="pvo" items="${searchProductList}" varStatus="status" >
               <li id="box">
                  <div class = "col-md-3">
                     <%-- ????????? onmouseover onmouseout --%>
                     <div class="slideshow-container">
                        <div class="productImg" style="cursor:pointer">
                        <%-- <img src="?????? ????????? ??????" onmouseover="this.src='????????? ?????? ????????? ????????? ??????'" onmouseout="this.src='?????? ????????? ??????'"> --%>
                          <img style="cursor:pointer" onclick="javascript:window.open('<%= ctxPath%>/ProductDetail.neige?pdno=${pvo.pdno}', '_self')" 
                          		src="<%= ctxPath%>/images/${pvo.pdimage1}" onmouseover="this.src='<%= ctxPath%>/images/${pvo.pdimage2}'" 
                          													onmouseout="this.src='<%= ctxPath%>/images/${pvo.pdimage1}'">
                        </div>
                 	 </div>
                     <div class = "discription">
                     <%-- ???????????? --%>
                     <div style="cursor:pointer; font-weight: bold;" onclick="javascript:window.open('<%= ctxPath%>/ProductDetail.neige?pdno=${pvo.pdno}', '_self')" 
                     		id="pname" style="color:#333; font-size:11.5pt; font-weight:bold ; line-height:170%">
                         ${pvo.pdname}        
                     </div>
                     <div>
                        <%-- ?????? ????????? ?????? ?????? (?????????) --%>
                        <span style="font-weight: bold;">COLOR : </span> 
                        <c:forTokens var="item" items="${pvo.colores}" delims=",">
                            <span><%-- ${item} --%></span>
                            <span class="dot" style="background-color:${item}"></span>
                        </c:forTokens>
                        <%-- ????????? ????????? ?????? ?????? (?????????) --%>
                        <%-- ????????? ?????? :  --%>
                        <span style="font-weight: bold;"> &nbsp;&nbsp;SIZE : </span> 
                        <c:forTokens var="item" items="${pvo.sizes}" delims=",">
                            ${item}
                        </c:forTokens>
                      </div>
                              <span style="font-weight: bold;">????????? :  </span><c:if test="${pvo.price ne pvo.saleprice}"><span style="font-size:11px; text-decoration:line-through;">
                              		<fmt:formatNumber value="${pvo.price}" pattern="###,###" /> </span></c:if><span>&nbsp;&nbsp;<fmt:formatNumber value="${pvo.saleprice}" pattern="###,###" />???</span>
                              <c:if test="${pvo.price ne pvo.saleprice}"><span class="badge badge-pill badge-warning" style="font-size: 8pt; background-color:lightcoral">SALE</span></c:if>
                              <c:if test="${pvo.price eq pvo.saleprice}"><span class="badge badge-pill badge-warning" style="font-size: 8pt; background-color:lightblue">NEW</span></c:if>
                       </div>
                  </div>
               </li>
              </c:forEach>
	      </ul>
	   </div>
	<div>
    	${pageBar}
    </div>    
</div>
</div>

<jsp:include page="../footer.jsp" />