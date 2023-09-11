<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport"  content="width=device-width, height=device-height,  minimum-scale=1.0, maximum-scale=1.0, initial-scale=1.0">
    <title>Insert title here</title>
    <style>
    div #main{
        width: 100%;
        height: 100vh;
    }
    div.left {
        width: 50%;
        float: left;
        height: 100vh;
        box-sizing: border-box;
        background:black;
    }
    div.right {
        width: 50%;
        height: 100vh;
        float: right;
        box-sizing: border-box;
        background: white;
	display: flex;
	justify-content: center;
	align-items: center;
    }
    table .loginForm{
    	height : 200px;
    }
    </style>
</head>
 
<body>
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>

    <div id = "main">
        <div class="left">
        </div>
        <div class="right">
        	<form id="login_form" method="post">
				<table class = "loginForm">
					<tr>
						<td>
							아이디 : 
						</td>
						<td colspan ="2">
							<input class="id_input" name="userId">
						</td>
					</tr>
					<tr>
						<td>
							비밀번호 : 
						</td>
						<td colspan ="2">
							<input class="pw_iput" type = "password" name="password">
						</td>
					</tr>
					<c:if test = "${result == 0 }">
						<tr>
							<td  colspan ="3">
								<div class = "login_warn">사용자 ID 또는 비밀번호를 잘못 입력하셨습니다.</div>
							</td>
						</tr>
					</c:if>
					<tr>
						<td  colspan ="3">
							<input type="button" class="login_button" value="로그인">
							<input type="button" class="join_button" value="회원가입">
						</td>
					</tr>
				</table>
			</form>
        </div>
    </div>
<script>
	$(".login_button").click(function(){
		$("#login_form").attr("action", "/user/login");
		$("#login_form").submit();
	});
	$(".join_button").click(function(){
		location.href="/user/join"
		});
</script>
</body>
</html>