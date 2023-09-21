<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
	rel="stylesheet">
<script
	src="
https://cdn.jsdelivr.net/npm/js-cookie@3.0.5/dist/js.cookie.min.js
"></script>
<style>
.container {
	width: 400px;
}

#title {
	padding: 30px;
	font-size: 4rem;
	display: flex;
	justify-content: center;
	align-content: center;
}

#body {
	border: 1px solid gray; /* 테두리 스타일 및 색상 설정 */
	padding: 20px; /* 테두리 주위의 여백 설정 */
	background-color: #D2DAFF;
}
</style>
</head>
<body>
	<div class="container">
		<div id="body">
			<div id="title">Login</div>
			<form action="/login.members" method="post"
				onsubmit="return validateForm();">
				
				<div class="row mb-3">
					<label for="inputId" class="col-sm-4 col-form-label"><img
						src="/UI_img/user.svg" alt="userImg"> 아이디</label>
					<div class="col-sm-8 p-0">
						<input type="text" class="form-control" id="inputId" name="id">
					</div>
				</div>
				<div class="row mb-3">
					<label for="inputPassword" class="col-sm-4 col-form-label"><img
						src="/UI_img/lock.svg" alt="lockImg"> 비밀번호</label>
					<div class="col-sm-8 p-0">
						<input type="password" class="form-control" id="inputPassword"
							name="pw">
					</div>
				</div>

				<div class="row mb-3">
					<div class="col-sm-12">
						<div class="form-check">
							<input class="form-check-input" type="checkbox" id="remID">
							<label class="form-check-label" for="remID"> 아이디 기억하기 </label>
						</div>
					</div>
				</div>
				<div class="row mb-3 px-2">
					<button type="submit" class="btn"
						style="background-color: #B1B2FF;">로그인</button>
				</div>
			</form>
			<div class="row mb-3">
				<ul class="nav justify-content-center">
					<li class="nav-item"><a class="nav-link active px-0"
						aria-current="page" href="/goToPwSearch.members"
						style="font-size: medium;">비밀번호 찾기 |&nbsp;</a></li>
					<li class="nav-item"><a class="nav-link px-0"
						href="/goToIdSearch.members"> 아이디 찾기 |&nbsp;</a></li>
					<li class="nav-item"><a class="nav-link px-0"
						href="/goToSignUp.members"> 회원가입</a></li>
				</ul>
			</div>
			<div id="footer" style="text-align: center;">
				<img src="/UI_img/marvlestudio.jpg" width="150" height="auto">
			</div>
		</div>
	</div>
	<script>
		function validateForm() {
			var idField = document.getElementById("inputId");
			var pwField = document.getElementById("inputPassword");

			if (idField.value.trim() === "") {
				alert("아이디를 입력하세요.");
				idField.focus();
				return false;
			}

			if (pwField.value.trim() === "") {
				alert("비밀번호를 입력하세요.");
				pwField.focus();
				return false;
			}

			return true;
		}
	</script>
	<script>
		$(document).ready(function() {
			let inputID = document.getElementById("inputId");
			let remID = document.getElementById("remID");

			let userID = Cookies.get("remid");
			if (userID) {
				inputID.value = userID;
				remID.checked = true;
			}
			inputID.oninput = function() {
				remID.checked = false;
			};
			remID.onchange = function() {
				if (remID.checked) {
					let id = inputID.value;
					Cookies.set("remid", id, {
						expires : 7
					});
				} else {
					Cookies.remove("remid")
				}
			}
		});
	</script>
</body>
</html>