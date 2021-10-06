<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<meta charset="utf-8">
<script>
$(document).ready(function() {	
	$("#withdrawal").on("click", function() {
		fn_withdrawal();
	});
});

function fn_withdrawal(){
	
	$.ajax({
		type: "POST",
		url: "/user/withdrawal",
		data: {
			 userId: $("#userId").val(),
		},
		datatype: "JSON",
		beforeSend: function(xhr){
			xhr.setRequestHeader("AJAX", "true");
		},
		success: function(response){
			if(response.code == 0){
				alert("탈퇴가 정상적으로 처리되었습니다. 이용해주셔서 감사합니다.");
				location.href = "/index";
			}
			else if(response.code == 400){
				alert("파라미터 값이 올바르지 않습니다.");
			}
			else if(response.code == 404){
				alert("회원정보가 존재하지 않습니다.");
			}
			else if(response.code == 500){
				alert("회원탈퇴 중 오류가 발생했습니다.");
			}
			else{
				alert("회원탈퇴 중 오류가 발생했습니다.");
			}
		},
		complete: function(data){
			//응답이 종료되면 실행
			icia.common.log(data);
		},
		error: function(xhr, status, error){
			icia.common.error(error);
		}
		
	});
}
</script>
</head>

<body id="body">
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<!-- Modal -->
<div class="modal product-modal fade" id="product-modal">
	<button type="button" class="close" data-dismiss="modal" aria-label="Close">
		<i class="tf-ion-close"></i>
	</button>
  	<div class="modal-dialog " role="document">
    	<div class="modal-content">
	      	<div class="modal-body">
	        	<div class="row">
	        		<div class="col-md-8 col-sm-6 col-xs-12">
	        			<div class="modal-image">
		        			<img class="img-responsive" src="resources/images/shop/products/modal-product.jpg" alt="product-img" />
	        			</div>
	        		</div>
	        		<div class="col-md-4 col-sm-6 col-xs-12">
	        			<div class="product-short-details">
	        				<h2 class="product-title">GM Pendant, Basalt Grey</h2>
	        				<p class="product-price">$200</p>
	        				<p class="product-short-description">
	        					Lorem ipsum dolor sit amet, consectetur adipisicing elit. Rem iusto nihil cum. Illo laborum numquam rem aut officia dicta cumque.
	        				</p>
	        				<a href="cart.html" class="btn btn-main">Add To Cart</a>
	        				<a href="product-single.html" class="btn btn-transparent">View Product Details</a>
	        			</div>
	        		</div>
	        	</div>
	        </div>
    	</div>
  	</div>
</div><!-- /.modal -->

<body id="body">

<!--상단-->
<section class="page-header">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="content">
					<ol class="breadcrumb">
						<li><a href="index.html">Home</a></li>
						<li class="active">My Account</li>
					</ol>
				</div>
			</div>
		</div>
	</div>
</section>

<!-- 본문 -->
<section class="user-dashboard page-wrapper" style="padding-top: 0px;">
  <div class="container">
    <div class="row">
      <div class="col-md-12">
        <ul class="list-inline dashboard-menu text-center">
          <li><a class="active"  href="userProfile">Profile</a></li>	
          <li><a href="userPost">My Post</a></li>
          <li><a href="userPayment">Payment Statement</a></li>
        </ul>
        <div class="dashboard-wrapper dashboard-user-profile">
            <div class="media-body">
              <ul class="user-profile-list">
            <form>
                <div class="form-group">
                    <label for="username">이름 : </label>
                    ${user.userName}
                </div>
                <div class="form-group">
                    <label for="username">성별 : </label>
                    <c:if test="${user.userGender eq 'M'}">남</c:if>
                    <c:if test="${user.userGender eq 'F'}">여</c:if>
                </div>
                <div class="form-group">
                    <label for="username">지역 : </label>
                    ${user.areaName}
                    ${user.subAreaName}
                </div>
                <div class="form-group">
                    <label for="username">이메일 : </label>
                    ${user.userEmail}
                </div>
                <div class="form-group">
                    <label for="username">마일리지 : </label>
					${user.totalPoint}
                </div>
                <input type="hidden" id="userId" name="userId" value="${user.userId}" />
                <input type="hidden" id="userPwd" name="userPwd" value="" />
            </form>
              </ul>
            </div>
             
           <ul class="list-inline dashboard-menu text-right">
                    <a href="/user/updateInfo" class="btn btn-primary">회원정보 수정</a> 
           			<input type="button" id="withdrawal" name="withdrawal" value="회원탈퇴" class="btn btn-primary"/>
      	   </ul>
        </div>
      </div>
    </div>
  </div>
</section>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>