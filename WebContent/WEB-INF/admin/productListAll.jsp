<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<%
    String ctxPath = request.getContextPath();
    //    /TeamMVC
%>    

<style type="text/css">
	a, a:hover {
		color: #000000;
		text-decoration:none;
	}
	div.productListBoard {
		width: 100%;
		margin: 30px -150px 50px 0;
	}
	
	h3#title {
		margin-bottom: 25px;
		text-align: center; 
		font-size: 14pt; 
		font-family:Times New Roman;
		font-weight: bold;
		
	}
	
	thead#tableHead > tr {
		background-color: #F8ECDE;
	}
		
	thead#tableHead > tr > th  {
		text-align: center;
		color: #7B5232;
	}
				
	
	tbody#tableBody > tr > td {
		/*border-top:hidden;*/
		border-bottom: solid 1px #ddd;
		border-right: solid 1px #ddd;
		
	}
	
	ul#prodSearch {
		list-style-type: none;
	}
	ul#ProdRegilists {
		display:inline-block;
		list-style-type: none;
		padding: 0px;

	}	
	ul#ProdRegilists > li {
		display:inline-block;
		list-style-type: none;
		text-align: center;
		padding-top: 4px;
		cursor:pointer;
	}	
	li.searchlist {
		margin-bottom: 20px;
		color: #7B5232;
		font-weight: bold;
	}
	li#search > span, li#search > select, li#productRegisterDay > span , li#productRegisterDay > button { /*li#productRegisterDay > ul > li  */
		margin-right: 15px;
	}
	li#searchAndClear, li#genderType, li#search, li#productRegisterDay{
		text-align: left;
		padding-left: 15px;	 
	}
    div.genderRadio > div{
        display: inline;
        margin-left: 20px;
    }
    div.genderRadio > div > label {
    	font-weight: lighter;
    }
    span.type {
    	display: inline-block;
    	width: 100px;
    }
    div.genderRadio > div > input {
    	margin-left: 10px;
    }
    select#searchType {
    	width:13%;
    }
    input#searchWord {
      width: 240px;
      height: 30px;
      margin: 0 0 10px 0;
      
    }
    button.btnGroup{
    	width: 247px;
    	margin-right: 20px;
    	border-radius: 2px;
    	background-color: #BCA897;
    	border: hidden;
    	height: 30px;
    	color: white;
    	font-weight: bold;
    }
    select#sizePerPage {
		width: 60px;
	}
	li#productRegisterDay > button { /*  li#productRegisterDay > ul > li*/
		background-color: #BCA897;
		border: hidden;
		border-radius: 2px;
		color: white;
		width: 50px; 
		height: 30px; 	
	}
	div.btnCUD > a {
		margin-left: 15px;
		background-color: #BCA897;
		border: hidden;
		font-weight: bold;
	}
		
</style>

<jsp:include page="adminMain.jsp" />

<script type="text/javascript">

	$(document).ready(function(){
		
		// $("button#btnDefault").addClass('btnDate');
		
		$("button#btnDefault").css({"font-weight":"bold", "background-color":"#8A6C4F"});
		
		// ?????? ???????????? ??????/?????? ??? ?????? ???????????? ??????/?????? ????????? ?????? 
		$("input:checkbox[name=allCheckBox]").click(function(){
			
			
			if( $(this).prop("checked") == true ) {
				 $("input[type=checkbox]").prop("checked",true);
			}
			else{
				 $("input[type=checkbox]").prop("checked",false);
			}
			
		});
		
		// alert("gender?????? ?? ==> " + $("input:radio[name='pdgender']").val()); // ?????? ?????? ???????????? ?????? : ?????? 0
		// alert("???????????? ?????? ?? ==> " + $("select[name='searchType']").val());    // ?????? ?????? ???????????? ?????? : ?????? 0
		// alert("????????? ?????? ?? ==> " + $("input[name='searchWord']").val());    // ?????? ?????? ???????????? ?????? : ?????? 0
		
		// ????????? ????????? ????????? ???????????????
		// ??????
		if( "${requestScope.pdgender}" != ""){
			 // alert("pdgender~~ => " + "${requestScope.pdgender}");
			$("input:radio[name='pdgender']:radio[value='${requestScope.pdgender}']").prop("checked", true);
		}
		
		// ????????????
		if( "${requestScope.searchType}" == "" ) {
			$("select").find('option:first').attr('selected', 'selected');
		}
		else {
			$("select#searchType").val("${requestScope.searchType}");
		}
		
		// ?????????
		if( "${requestScope.searchWord}" != "" ) {
			
			$("input#searchWord").val("${requestScope.searchWord}");
		}
		
		// ???????????????
		if( "${requestScope.prodRegType}" != "" ) {
			
			var prodRegType =  "${requestScope.prodRegType}";
			
			if(prodRegType == "week") {
				 $("button#btnDefault").css({"font-weight":"lighter", "background-color":"#BCA897"});
				 $("button#btnWeek").css({"font-weight":"bold", "background-color":"#8A6C4F"});
			}
			else if(prodRegType == "oneM") {
				 $("button#btnDefault").css({"font-weight":"lighter", "background-color":"#BCA897"});
				 $("button#btnOneMonth").css({"font-weight":"bold", "background-color":"#8A6C4F"});
			}
			else if(prodRegType == "thrM") {
				 $("button#btnDefault").css({"font-weight":"lighter", "background-color":"#BCA897"});
				 $("button#btnThreeMonth").css({"font-weight":"bold", "background-color":"#8A6C4F"});
			}
			else if(prodRegType == "sixM") {
				 $("button#btnDefault").css({"font-weight":"lighter", "background-color":"#BCA897"});
				 $("button#btnSixMonth").css({"font-weight":"bold", "background-color":"#8A6C4F"});
			}
			else if(prodRegType == "year") {
				 $("button#btnDefault").css({"font-weight":"lighter", "background-color":"#BCA897"});
				 $("button#btnYear").css({"font-weight":"bold", "background-color":"#8A6C4F"});
			}
			
		}
		
		
		// ?????? ????????? input????????? value??? ????????? form??? ????????? 
		$("button.btnDate").on('click', function(event){
			
			var registerTypeVal = $(this).attr('value');
			
			var btnProdRegType = $("input:hidden[name='prodRegType']").attr('value', registerTypeVal);
			
		});
		
		$("button#btnDefault").click(function(){
			$(this).css({"font-weight":"bold", "background-color":"#8A6C4F"});
			$("li#productRegisterDay").find('button').not($(this)).css({"font-weight":"lighter", "background-color":"#BCA897"});
		});
		
		// 7???
		$("button#btnWeek").click(function(){
			// ?????? ?????? ????????? css???????????? ?????? ?????????
			
			$("button#btnDefault").css({"font-weight":"lighter", "background-color":"#BCA897"});
			
			// id??? productRegisterDay??? li?????? ????????? button???????????? ?????????. ??? ????????? ?????? ???????????? ???????????? css ??????
			$("li#productRegisterDay").find('button').not($(this)).css({"font-weight":"lighter", "background-color":"#BCA897"});
			
			// ?????? ????????? css ??????
			$(this).css({"font-weight":"bold", "background-color":"#8A6C4F"});
			
		});
		
		// 1??????
		$("button#btnOneMonth").click(function(){
			// ?????? ?????? ????????? css???????????? ?????? ?????????
			$("button#btnDefault").css({"font-weight":"lighter", "background-color":"#BCA897"});
			$("li#productRegisterDay").find('button').not($(this)).css({"font-weight":"lighter", "background-color":"#BCA897"});
			
			$(this).css({"font-weight":"bold", "background-color":"#8A6C4F"});
			
		});
		
		// 3??????
		$("button#btnThreeMonth").click(function(){
			// ?????? ?????? ????????? css???????????? ?????? ?????????
			$("button#btnDefault").css({"font-weight":"lighter", "background-color":"#BCA897"});
			$("li#productRegisterDay").find('button').not($(this)).css({"font-weight":"lighter", "background-color":"#BCA897"});
			
			$(this).css({"font-weight":"bold", "background-color":"#8A6C4F"});
			
		});
		
		// 6??????
		$("button#btnSixMonth").click(function(){
			// ?????? ?????? ????????? css???????????? ?????? ?????????
			$("button#btnDefault").css({"font-weight":"lighter", "background-color":"#BCA897"});
			$("li#productRegisterDay").find('button').not($(this)).css({"font-weight":"lighter", "background-color":"#BCA897"});
			
			$(this).css({"font-weight":"bold", "background-color":"#8A6C4F"});
			
		});
		
		// 1???
		$("button#btnYear").click(function(){
			// ?????? ?????? ????????? css???????????? ?????? ?????????
			$("button#btnDefault").css({"font-weight":"lighter", "background-color":"#BCA897"});
			$("li#productRegisterDay").find('button').not($(this)).css({"font-weight":"lighter", "background-color":"#BCA897"});
			
			$(this).css({"font-weight":"bold", "background-color":"#8A6C4F"});
			
		});
		
		// ????????? ??? ?????? ?????? ??? ?????????(???????????? ???????????? ???????????? ????????? ????????????)
		$("tr.productInfo").click(function(){
			
			// ???????????? :  this , ??????????????? ???????????? pdno??? ?????? ?????? ??????
			var pdno = $(this).children(".pdno").text();
			alert("test pdno" + pdno);
			
			// pdno ??? ?????? ????????? ?????????(???????????? ?????? ?????? ????????? ???????????? ???????????? ??????)
			// location.href = "/TeamMVC/admin/productUpdate.neige?pdno="+pdno; // userid+"&goBackURL=${goBackURL}";
			location.href = "/TeamMVC/admin/productOneView.neige?pdno="+pdno; // userid+"&goBackURL=${goBackURL}";
		});
		
		
		$("div#btnDelete").children().click(function(){
			alert("??????");
			
			location.href = "<%= ctxPath %>/admin/productDelete.neige";
			
		});
		
	}); // end of $(document).ready(function(){})-------------------------------
	
	// ?????? ?????? ????????? ????????? ??????
	function goBtnSearch() {
		var frm = document.ProductListFrm
		frm.method = "GET";
		frm.action = "<%=ctxPath%>/admin/productListAll.neige";
		frm.submit();
	}
	
	// ?????? ????????? ????????? ????????? ?????? 
	function goBtnClear() {
		
		// ?????????
		$("input:radio[name='gender']").removeAttr('checked');
		$("input:radio[name='gender']")[0].checked = true; // ????????? ?????? ?????????  true
		
		$('input').val("");
		
		// select????????? ????????? option????????? ???????????? ????????? selected ?????? ???????????????. 
		$("select").find('option:first').attr('selected', 'selected');
	}
	

</script>

<div class="productListBoard col-ms-12" >
  <h3 id = "title">?????? ?????????</h3>
  
  	<div>
		<form name="ProductListFrm">
			<ul id="prodSearch">
				<li id="genderType" class = "searchlist">
			      <div class="genderRadio">
			         <span id="gender" class = "type">??????</span>
			         <div id="all" ><label for="0">??????</label><input name="pdgender" type="radio" id="0" value="0" checked="checked"></div>
			         <div id="women"><label for="2">??????</label><input name="pdgender" type="radio" id="2" value="2"></div>
			         <div id="men"><label for="1">??????</label><input name="pdgender" type="radio" id="1" value="1"></div>
			      </div>					
				</li>
				<li id = "search" class = "searchlist">
					
					<span class = "type">????????????</span>
					<select id="searchType" name="searchType">
						<option value="0" selected="selected">??????</option>
						<option value="pdname">?????????</option>
						<option value="cgname">???????????????</option>
						
					</select>
					<input type="text" id="searchWord" name="searchWord" />
					
				</li>
				<li id="productRegisterDay" class = "searchlist">
					<span class = "type">???????????????</span>
					<%--
					<ul id="ProdRegilists">
						<li id="all" value="0" >??????</li>
						<li value="week">??????</li>
						<li value="oneM">1???</li>
						<li value="threeM">3???</li>
						<li value="sixM">6???</li>
						<li value="year">1???</li>
					</ul>
					 --%>
					<button type="button" name="prodRegType" id= "btnDefault" value="0">?????? </button>
					<button type="button" name="prodRegType" id= "btnWeek" class="btnDate" value="week">??????</button>
					<button type="button" name="prodRegType" id= "btnOneMonth" class="btnDate" value="oneM">1???</button>
					<button type="button" name="prodRegType" id= "btnThreeMonth" class="btnDate" value="thrM">3???</button>
					<button type="button" name="prodRegType" id= "btnSixMonth" class="btnDate" value="sixM">6???</button>
					<button type="button" name="prodRegType" id= "btnYear" class="btnDate" value="year">1???</button>
					<input type="hidden" name="prodRegType"/>
				</li>	
				<li id="searchAndClear"  class = "searchlist">
					<button type="button" id="btnSearch" class="btnGroup" onClick="goBtnSearch();">??????</button>
					<button type="button" id="btnClear" class="btnGroup" onClick="goBtnClear();">?????????</button>
				</li>
				<li style="margin-left: 1000px;" class = "searchlist">
					<select id="sizePerPage" name="sizePerPage">
						<option value="10">10</option>
						<option value="5">5</option>
					</select>
				</li>
			</ul>
	    </form>
  	</div>
  	
  	<br>
  	
  	<div id = "prodLists">
		<table id = "prodListTable" class="table " style="text-align: center; border: solid 0px white;"> <%-- table-striped --%>
			<thead id = "tableHead">
				<tr>
					<!--  
					<th>
						<input type="checkbox" name="allCheckBox" />
					</th>
					-->
					<th>????????????</th>
					<th>???????????????</th>
					<th>?????????</th>
					<th>??????</th>
					<th>??????</th>
					<th>??????</th>
					<th>??????</th>
				</tr>
			</thead>
			<tbody id = "tableBody">	
				<%--			
				<c:forEach var="adminProdvo" items="${adminProdList}" varStatus="status">
					<tr class="memberInfo" style="cursor:pointer" >
						<td>
							<input type= "checkbox" name="productList${status.index}" />
						</td>
						<td>${adminProdvo.pdno}</td>
						<td>${adminProdvo.catevo.cgname}</td>
						<td>${adminProdvo.pdname}</td>
						<td>${adminProdvo.pdqty}</td>
						<td><fmt:formatNumber value="${adminProdvo.price}" pattern="###,###" />???</td>
						<c:if test="${adminProdvo.pdgender eq '1'}">
							<td style = "border-right: hidden;">??????</td>
						</c:if>
						
						<c:if test="${adminProdvo.pdgender eq '2'}">
							<td style = "border-right: hidden;">??????</td>
						</c:if>
					</tr>
				</c:forEach> 
				--%>
				<c:forEach var="adminProdvo" items="${adminprodList}" varStatus="status">
					<tr class="productInfo" style="cursor:pointer" >
						<!-- 
						<td>
							<input type= "checkbox" name="productList${status.index}" />
						</td>
						 -->
						<td class="pdno pdInfoList">${adminProdvo.pdno}</td>
						<td class="pdInfoList">${adminProdvo.catevo.cgname}</td>
						<td class="pdInfoList">${adminProdvo.pdname}</td>
						<td class="pdInfoList">${adminProdvo.pdqty}</td>
						<td class="pdInfoList"><fmt:formatNumber value="${adminProdvo.price}" pattern="###,###" />???</td>
						<td class="pdInfoList">${adminProdvo.pdinputdate}</td>	
						<c:if test="${adminProdvo.pdgender eq '1'}">
							<td class="pdInfoList" style = "border-right: hidden;">??????</td>
						</c:if>
						
						<c:if test="${adminProdvo.pdgender eq '2'}">
							<td class="pdInfoList" style = "border-right: hidden;">??????</td>
						</c:if> 
					</tr>
				</c:forEach> 				
			</tbody>
		</table>
	</div>
	
	<div>
    	${pageBar}
    </div>   
	
	<br>
	
	<div id="btnList">
		<div class ="btnCUD">
			<a href="<%= ctxPath %>/product/productRegister.neige" class="btn btn-primary pull-right">??????</a>
		</div>
		<!-- 
		<div class ="btnCUD" id = "btnDelete">
			<a href="javascript:void(0);" class="btn btn-primary pull-right">??????</a>
		</div>
		 -->
	</div>
</div>


<jsp:include page="../footer.jsp" />

