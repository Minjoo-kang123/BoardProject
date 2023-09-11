<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<style>
.join_ta{
	border : 1px solid;
	border-collapse:collapse;
	width : 100%
}
td, th{
		padding-left : 10px;
		padding-right : 10px;
		height : 50px;
	}
.wrapper{
	width : 70%;
	margin : 0 auto;
	padding-top : 50px;
	}
</style>
</head>
<body>
<div class="wrapper">
	${error}
	<form id="join_form" method="post">
	<table class="join_ta">
		<tr>
			<td colspan = "3">회원가입</td>
		</tr>
		<tr>
			<td>아이디</td>
			<td colspan = "2"><input class="id_input" name="userId"></td>
		</tr>
		<tr class = "id_error" style="display:none;">
			<td colspan = "3" class = "id_error" style="display:none;">아이디를 8자 이상 입력해주세요</td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td colspan = "2"><input type = "password" class="pw_input" name="password"></td>
		</tr>
		<tr class = "pw_error" style="display:none;">
			<td colspan = "3" class = "pw_error" style="display:none;">비밀번호를 8자 이상 입력해주세요</td>
		</tr>
		<tr>
			<td>비밀번호 확인</td>
			<td colspan = "2"><input type = "password" class="repw_input"></td>
		</tr>
		<tr class = "repw_error" style="display:none;">
			<td colspan = "3" class = "repw_error" style="display:none;">비밀번호를 동일하게 입력해주세요</td>
		</tr>
		<tr>
			<td>이름</td>
			<td colspan = "2"><input class="name_input" name="username"></td>
		</tr>
		<tr>
			<td>이메일</td>
			<td colspan = "2"><input class="email_input" name="email"></td>
		</tr>
		<tr class = "email_error" style="display:none;">
			<td colspan = "3" class = "email_error" style="display:none;">올바른 이메일을 입력해주세요</td>
		</tr>
		<tr>
			<td>전화번호</td>
			<td colspan = "2">
				<select name="phone1">
					<option value="010">010</option>
					<option value="011">011</option>
					<option value="070">070</option>
				</select>
				- <input type="number" name = "phone2" maxlength = 4 size = 5 oninput="handleInputLength(this, 4)">
				- <input type="number" name = "phone3" maxlength = 4 size = 5 oninput="handleInputLength(this, 4)">
			</td>
		</tr>
		<tr>
			<td>부서</td>
			<td colspan = "2"><input id = "department_input" class="department_input" name="department"></td>
		</tr>
		<tr>
			<td colspan = "3">
    			<button class = "join" disabled>회원가입</button>
    		</td>
		</tr>
	</table>
	</form>
</div>
<script>

const joinButton = document.querySelector('.join');
const id_input = document.querySelector('.id_input');
const pw_input = document.querySelector('.pw_input');
const repw_input = document.querySelector('.repw_input');
const name_input = document.querySelector('.name_input');
const email_input = document.querySelector('.email_input');
const department_input = document.querySelector('.department_input');

id_input.addEventListener('keyup', activeEvent);
id_input.addEventListener('keyup', id_activeEvent);
pw_input.addEventListener('keyup', activeEvent);
pw_input.addEventListener('keyup', pw_activeEvent);
repw_input.addEventListener('keyup', repw_activeEvent);
name_input.addEventListener('keyup', activeEvent);
email_input.addEventListener('keyup', activeEvent);
email_input.addEventListener('keyup', email_activeEvent);
phone_input.addEventListener('keyup', activeEvent);
phone_input2.addEventListener('keyup', activeEvent);
department_input.addEventListener('keyup', activeEvent);

var id1 = $('.id_input').val();
var pw = $('.pw_input').val();
var email = $('.email_input').val();

var id_ok = false;
var pw_ok = false;
var email_ok = false;

function id_activeEvent() {
	var id = $('.id_input').val();
	
	//아이디 유효성 검사
	if(id.length >= 8){
		id_ok = true;
		$('.id_error').hide();
	}else{
		id_ok = false;
		$('.id_error').show();
	}
}
function pw_activeEvent() {
	var pw = $('.pw_input').val();
	
	//비밀번호 유효성 검사
	if(pw.length >= 8){
		pw_ok = true;
		$('.pw_error').hide();
	}else{
		pw_ok = false;
		$('.pw_error').show();
	}
}function repw_activeEvent() {
	var pw = $('.pw_input').val();
	var repw = $('.repw_input').val();
	
	//비밀번호 유효성 검사
	if(pw == repw){
		repw_ok = true;
		$('.repw_error').hide();
	}else{
		pw_ok = false;
		$('.repw_error').show();
	}
}
function email_activeEvent() {
	var email = $('.email_input').val();
	
	//이메일 유효성 검사
	if(email.search('@')>0){
		email_ok = true;
		$('.email_error').hide();
	}else{
		email_ok = false;
		$('.email_error').show();
	}
}
function activeEvent() {
  switch(!(id_input.value && pw_input.value && name_input.value && email_input.value && department_input.value&&email_ok&&id_ok&&pw_ok)){
    case true : joinButton.disabled = true; break;
    case false : joinButton.disabled = false; break;
  }
}
function handleInputLength(el, max) {
	if(el.value.length > max) {
		el.value = el.value.substr(0, max);
	}
}
</script>

</body>
</html>