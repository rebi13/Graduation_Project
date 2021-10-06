<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script type="text/javascript">
$(document).ready(function() {
<c:choose>
   <c:when test="${empty notice}">
      alert("게시물이 존재하지 않습니다.");
      location.href="/notice/list";
   </c:when>
   <c:otherwise>
   $("#bbsTitle").focus();
   
   $("#btnUpdate").on("click", function() {
      
      $("#btnUpdate").prop("disabled", true);  // 수정 버튼 비활성화
      
      if($.trim($("#bbsTitle").val()).length <= 0)
      {
         alert("제목을 입력하세요.");
         $("#bbsTitle").val("");
         $("#bbsTitle").focus();
         return;
      }
      
      if($.trim($("#bbsContent").val()).length <= 0)
      {
         alert("내용을 입력하세요.");
         $("#bbsContent").val("");
         $("#bbsContent").focus();
         return;
      }
      
      var form = $("#updateForm")[0];
      var formData = new FormData(form);
      
      $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            url: "/notice/updateProc",
            data: formData,
            processData: false,
            contentType: false,
            cache: false,
            timeout: 600000,
            beforeSend: function(xhr)
            {
               xhr.setRequestHeader("AJAX", "true");
            },
            success: function(response)
            {
               if(response.code == 0){
                  alert("게시물이 수정되었습니다.");
                  location.href = "/notice/list";
                  //게시판처음들어갔을때상태
                  /*
                  document.bbsForm.action = "/board/list";
                  document.bbsForm.submit();
                        차이점: 현재폼에 액션태그 넣고 bbsForm을 submit 했기 때문에 서치타입, 서치밸류 들고가게됨 
                  */
               }
               else if(response.code == 400)
               {
                  alert("파라미터 값이 올바르지 않습니다.");
                  $("#btnUpdate").prop("disabled", false); // 버튼 활성화
               }
               else if(response.code == 404)
               {
                  alert("게시물을 찾을 수 없습니다.");
                  location.href = "/notice/list";
               }
               else
               {
                  alert("게시물 수정 중 오류가 발생하였습니다.");
                  $("#btnUpdate").prop("disabled", false);
               }
            },
            error: function(error)
            {
               icia.common.error(error);
               alert("게시물 수정 중 오류가 발생하였습니다.");
               $("#btnUpdate").prop("disabled", false);
            }
      });
   });
   
   $("#btnList").on("click", function() {
      document.bbsForm.action = "/notice/list";
      document.bbsForm.submit();
   });
   
   </c:otherwise>
</c:choose>
});
</script>
</head>
<body>
<c:if test="${!empty notice}">
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<div class="container">
   <h2>게시물 수정</h2>
   <form name="updateForm" id="updateForm" method="post" enctype="multipart/form-data">
      <input type="text" name="userName" id="userName" maxlength="20" value="${user.userName}" style="ime-mode:active;" class="form-control mt-4 mb-2" placeholder="이름을 입력해주세요." readonly />
      <input type="text" name="userEmail" id="userEmail" maxlength="30" value="${user.userEmail}"  style="ime-mode:inactive;" class="form-control mb-2" placeholder="이메일을 입력해주세요." readonly />
      <input type="text" name="bbsTitle" id="bbsTitle" maxlength="100" style="ime-mode:active;" value="${notice.bbsTitle}" class="form-control mb-2" placeholder="제목을 입력해주세요." required />
      <div class="form-group">
         <textarea class="form-control" rows="10" name="bbsContent" id="bbsContent" style="ime-mode:active;" placeholder="내용을 입력해주세요" required>${notice.bbsContent}</textarea>
      </div>
      <input type="file" name="bbsFile" id="bbsFile" class="form-control mb-2" placeholder="파일을 선택하세요." required />
   <c:if test="${!empty notice.noticeFile}">
      <div style="margin-bottom:0.3em;">[첨부파일 : ${notice.noticeFile.fileOrgName}]</div>
   </c:if>
      <input type="hidden" name="bbsSeq" value="${notice.bbsSeq}" />
      <input type="hidden" name="searchType" value="${searchType}" />
      <input type="hidden" name="searchValue" value="${searchValue}" />
      <input type="hidden" name="curPage" value="${curPage}" />
   </form>
   
   <div class="form-group row">
      <div class="col-sm-12">
         <button type="button" id="btnUpdate" class="btn btn-primary" title="수정">수정</button>
         <button type="button" id="btnList" class="btn btn-secondary" title="리스트">리스트</button>
      </div>
   </div>
</div>
<form name="bbsForm" id="bbsForm" method="post">
   <input type="hidden" name="bbsSeq" value="${notice.bbsSeq}" />
   <input type="hidden" name="searchType" value="${searchType}" />
   <input type="hidden" name="searchValue" value="${searchValue}" />
   <input type="hidden" name="curPage" value="${curPage}" />
</form>
</c:if>
</body>
</html>