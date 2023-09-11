<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>게시글 작성</title>

<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>

<style>
.commentsbox{
	display : flex;
	align-items : center
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
			<form method="post" action="/post/update">
		    	<table class="table table-striped table-hover">
					<colgroup>
						<col style="width:10%;" />
						<col style="width:auto;" />
					</colgroup>
					<thead>
						<tr>
							<td colspan = '2'> 게시글 수정하기 </td>
						</tr>
					    <tr>
					    	<td>제목 :</td>
					    	<td><input name="title" type="text" size=100 value = "${post.title}"></td>
					    </tr>
				    </thead>
				    <tr>
				    	<td colspan = 2>
				    		<textarea id="summernote" name="context">${post.context}</textarea>
				    		<input type="hidden" name="id" value="${post.postId}">
				    	</td>
				    </tr>
				    <tr>
				    <td colspan = 2 style = "text-align : right">
				    		<button type="submit" onclick="goWrite(this.form)" style = "width : 100px">수정하기</button>
				    	</td>
				    </tr>
			    </table>
			</form>
		</div>
	</div>
</div>
</body>

<script type="text/javascript">
$('#summernote').summernote({
		height: 300,
		width : 1000,
		minHeight: null,
		maxHeight: null,
		focus: true,
		lang: "ko-KR",
		callbacks: {
			onImageUpload : function(files){
				for (var i = files.length - 1; i >= 0; i--) {
					sendFile(files[i],this);
                    }
			}
		},
		toolbar: [
		    // [groupName, [list of button]]
		    ['fontname', ['fontname']],
		    ['fontsize', ['fontsize']],
		    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
		    ['color', ['forecolor','color']],
		    ['table', ['table']],
		    ['para', ['ul', 'ol', 'paragraph']],
		    ['height', ['height']],
		    ['insert',['picture','link','video']],
		    ['view', ['fullscreen', 'help']]
		  ],
		fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋움체','바탕체'],
		fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72']
			
	});
//이미지 파일 전송
function sendFile(file, editor){
	var data = new FormData();
	data.append("file", file);
	console.log(file);
	$.ajax({
		data : data,
		type : "POST",
		url : "uploadImage",
		contentType : false,
		processData : false,
		success : function(data){
			console.log(data);
			console.log(editor);
			$(editor).summernote("insertImage",data.url);
		}
	});
}
</script>
</html>