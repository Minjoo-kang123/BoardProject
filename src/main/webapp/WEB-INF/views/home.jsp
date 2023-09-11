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
<title>게시판별 목록</title>
</head>
<body>
<%@ include file="header.jsp" %>
<div class ="wrapper">
	<div class = "container">
		<ul>
			<c:if test = "${user.auth >= 10}">
				<li><a href="<c:url value='/post/write'></c:url>">글쓰기</a></li>
			</c:if>
			<li><a href="/">홈</a></li>
			<li><a href="<c:url value='/board?num=1&id=1'></c:url>">메뉴얼</a></li>
		</ul>		
		<div class = "context">
			<table class="table table-striped table-hover">
				<colgroup>
					<col style="width:7%;" />
					<col style="width:auto;" />
					<col style="width:15%;" />
					<col style="width:10%;" />
					<col style="width:10%;" />
				</colgroup>
				<thead>
					<tr>
						<th>NO</th>
						<th>글제목</th>
						<th>게시판</th>
						<th>작성자</th>
						<th>작성일</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${empty postList}" >
							<tr><td colspan="4" align="center">등록된 게시글이 없습니다.</td></tr>
						</c:when> 
						<c:when test="${!empty postList}">
							<c:forEach var="list" items="${postList}">
								<tr>
									<td><c:out value="${list.postId}" /></td>
									<td>
									<a style = " display : block; " href="<c:url value='/post/detail'>
											<c:param name='id' value='${list.postId}'/> </c:url>"><c:out value="${list.title}"/></a></td>
									<td>
									<c:set var="data" value="${list.boardId}" />
									<c:out value="${boardList[data]}" /></td>
									<td><c:out value="${list.userId}"/></td>
									<td><c:out value="${list.createdate}"/></td>
								</tr>
							</c:forEach>
						</c:when>
					</c:choose>
				</tbody>
			</table>
			<div>
				<c:if test="${prev}">
					<span>[ <a href="?num=${startPageNum - 1}">이전</a> ]</span>
				</c:if>
				
				<c:forEach begin="${startPageNum}" end="${endPageNum}" var="num">
			  		<span>
						<a href="?num=${num}">${num}</a>
					</span>
				</c:forEach>
				
				<c:if test="${next}">
					<span>[ <a href="?num=${endPageNum + 1}">다음</a> ]</span>
				</c:if>
			</div>
			<br><br>
			<div>
				 <c:forEach begin="1" end="${pageNum}" var="num">
				    <span>
				     <a href="?num=${num}">${num}</a>
				  </span>
				 </c:forEach>
			</div>
		</div>
	</div>
</div>
</body>
</html>