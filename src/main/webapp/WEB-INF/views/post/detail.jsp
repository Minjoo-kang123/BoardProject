<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" 
rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" 
integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<meta charset="UTF-8">
<title>게시글 상세보기</title>
<style>
.commentsbox{
	display : flex;
	align-items : center
}
tr{
	border : 1px soild black;
}
</style>
</head>
<body>
<%@ include file="../header.jsp" %>
<div class ="wrapper">
	<div class = "container">
		<ul>
			<c:if test = "${user.auth >= 10}">
				<li><a href="<c:url value='/post/write'></c:url>">글쓰기</a></li>
			</c:if>
			<li><a class="home" href="/">홈</a></li>
			<li><a href="<c:url value='/board?num=1&id=1'></c:url>">메뉴얼</a></li>
			<li><a href="<c:url value='/board?num=1&id=2'></c:url>">EDR 관련 문의</a></li>
			<li><a href="<c:url value='/board?num=1&id=3'></c:url>">보안 및 네트워크 지원</a></li>
			<li><a href="<c:url value='/board?num=1&id=4'></c:url>">그룹웨어 및 메일 지원</a></li>
			<li><a href="<c:url value='/board?num=1&id=5'></c:url>">서명 이미지 신청</a></li>
			<li><a href="<c:url value='/board?num=1&id=6'></c:url>">KIMS 지원 문의</a></li>
			<li><a href="<c:url value='/board?num=1&id=7'></c:url>">IP 신청</a></li>
		</ul>		
		<div class = "context">
		<table class="table">
			<colgroup>
				<col style="width:20%;" />
				<col style="width:auto;" />
			</colgroup>
			<thead class="table-light">
			<tr>
				<td class = "title">글제목</td>
				<td>${post.title}</td>
			</tr>
			<tr>
				<td class = "title">작성자</td>
				<td>${post.userId}</td>
			</tr>
			<tr><td colspan = "2">내용</td></tr>
			</thead>
			<tr><td class = "context" colspan = "2">${post.context}</td></tr>
			<tr>
				<td colspan = "2">
					<c:if test="${empty fileList}" >
						파일이 없습니다.
					</c:if> 
					<c:if test="${!empty fileList}">
						<c:forEach var="file" items="${fileList}">
							<li>${file.originalname}
							<button class="btn btn-outline-secondary"><a href="<c:url value='/post/download'>
									<c:param name='id' value='${file.fileid}'/> </c:url>">다운하기</a></button>
						</c:forEach>
					</c:if>
				</td>
			</tr>
			<c:if test = "${user.auth > 10 || user.userId == post.userId}">
				<tr>
					<td colspan = "2">
					<div class="btn-group" role="group" aria-label="Basic example">
						<button class="btn btn-outline-primary"><a href="<c:url value='/post/update'>
									<c:param name='id' value='${post.postId}'/> </c:url>">수정하기</a></button>
						<button class="btn btn-outline-primary">
						<a href="<c:url value='/post/delete'> <c:param name='id' value='${post.postId}'/> </c:url>">삭제하기</a>
						</button>
						<button onclick="location.href='/'" class="btn btn-outline-primary"> list로 돌아가기 </button>
						</div>
					</td>
				</tr>
			</c:if>	
			<c:if test = "${user.auth == 10 && user.userId != post.userId}">
				<tr>
					<td colspan = '3'>
						<button class="btn btn-outline-primary" onclick="location.href='/'"> list로 돌아가기 </button>
					</td>
				</tr>	
			</c:if>	
		</table>
		<div class="commentbox">
			<div>작성자 : ${user.userId} </div>
	        <div class="commentsbox">
				<textarea id="context" cols="100" rows="2" name="context" maxlength=400></textarea>
				<button id="insertComment" style="margin-left:5px;"> 댓글등록</button>
            </div>
			<div class="commentList" id="commentList" style="border:1px solid gray; margin-top:20px; margin-bottom:200px"> <!-- 댓글이 들어갈 박스 -->
			</div>
		</div>
	</div>
</div>
</div>
<script>
$('#insertComment').click(function() {
		const postId = ${post.postId};
		const context = $('#context').val();
		if(context == "") {
			alert("내용을 입력해주세요");
		}else{
			$.ajax({
				type:'post',
				url:'<c:url value="/comment/insert"/>',
				data: JSON.stringify(
					{
						"postId":postId,
						"context":context
					}		
				),success : function(result) {
					commentList();
					$('#context').val('');
				},
				error : function() {
					commentList();
					$('#context').val('');
				},
				contentType: 'application/json'
			});
		}
});// 댓글등록

function commentList(){
    $.ajax({
         url:"/comment/commentList"
        ,type:"get"
        ,data:{'id':${post.postId}}
        ,success:function(data){
            let comments = "";
            $.each(data, function(key, value){
            	comments += "<table  class='table'>";
            	comments += "	<tr>";
            	comments += "<td style = 'width : 750px; height : 30px;'>작성자 : " + value.userId+"</td>";
            	if("${user.userId}" == value.userId || ${user.auth} == 20 ){
            		comments += "<td style = 'text-align : right'>"+ value.createdate +"</td>";
            		comments += "<td style = 'text-align : right'><a href='javascript:commentDelete(" + value.commentId + ");'>삭제</a></td>";
	            	comments += "	</tr><tr>";
	            	comments += "		<td colspan = '3'>\n내용 : " + value.context + "</td>";
	            	comments += "	</tr>";
            	}else{
            		comments += "<td style = 'text-align : right'>"+ value.createdate +"</td>";
            		comments += "	</tr><tr>";
	            	comments += "		<td colspan = '2'>\n내용 : " + value.context + "</td>";
	            	comments += "	</tr>";
            	}
            	comments += "</table>";
            });
            $(".commentList").html(comments);
        }
    });
}
function commentDelete(commentId){
    $.ajax({
        url:"/comment/delete"
       ,type:"post"
       ,data:{'commentId': commentId}
       ,success:function(data){
    	   commentList();
       }
   });
}
// 페이지 로딩 시 댓글 목록 출력시키기
$(document).ready(function(){
    commentList();
});
</script>
</body>
</html>