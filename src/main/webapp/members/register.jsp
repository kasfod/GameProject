<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Sign up</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<style>
* {
	box-sizing: border-box;
}

.signup_container {
	border: 1px solid black;
	border-radius: 10px;
}

.row {
	margin-top: 5px;
	margin-bottom: 5px;
}

.row-alert {
	margin-top: 0px;
	margin-bottom: 0px;
	display: none;
}

.row-alert>div {
	font-size: small;
	padding: 0px;
	display: flex;
}

.signup_title {
	font-size: 40px;
	font-weight: bold;
}

.sign-header {
	text-align: center;
	display: flex;
	align-items: center;
	justify-content: center;
}

.form-control {
	width: 268px;
}

input[type="number"]::-webkit-outer-spin-button, input[type="number"]::-webkit-inner-spin-button
	{
	-webkit-appearance: none;
	margin: 0;
}
</style>
</head>

<body>
	<div class="container g-0">
		<div class="signup_container mt-4 mb-4">
			<form action="/insert.members" id="sign-form" method="post">
				<div class="row g-0">
					<div
						class="col-12 d-flex justify-content-center align-items-center">
						<div class="signup_title mt-5 mb-5">환영합니다.</div>
					</div>
				</div>

				<div class="row g-0">
					<div class="col-4"></div>
					<div class="col-2 sign-header">아이디</div>
					<div class="col-6 sign-body d-flex">
						<input type="text" class="form-control me-2" placeholder="아이디"
							id="input-id" name="id"> <input type="button"
							class="btn btn-outline-primary" value="중복확인"
							id="btn-id-duplicate" disabled>
					</div>
				</div>
				<div class="row g-0 row-alert">
					<div class="col-6 sign-header"></div>
					<div
						class="col-6 sign-body id-alert alert mb-0 d-flex align-items-center"></div>
				</div>

				<div class="row g-0">
					<div class="col-4"></div>
					<div class="col-2 sign-header">비밀번호</div>
					<div class="col-6 sign-body">
						<input type="password" class="form-control" id="input-pw"
							placeholder="비밀번호" name="password">
					</div>
				</div>

				<div class="row g-0 row-alert">
					<div class="col-6 sign-header"></div>
					<div class="col-6 sign-body pw-alert alert"></div>
				</div>

				<div class="row g-0">
					<div class="col-4"></div>
					<div class="col-2 sign-header">비밀번호 확인</div>
					<div class="col-6 sign-body">
						<input type="password" class="form-control" id="input-pw-confirm"
							placeholder="비밀번호 확인">
					</div>
				</div>

				<div class="row g-0 row-alert">
					<div class="col-6 sign-header"></div>
					<div class="col-6 sign-body pw-confirm-alert alert"></div>
				</div>

				<div class="row g-0">
					<div class="col-4"></div>
					<div class="col-2 sign-header">이름</div>
					<div class="col-6 sign-body">
						<input type="text" class="form-control" placeholder="이름"
							id="input-name" name="name">
					</div>
				</div>

				<div class="row g-0 row-alert">
					<div class="col-6 sign-header"></div>
					<div class="col-6 sign-body name-alert alert"></div>
				</div>

				<div class="row g-0">
					<div class="col-4"></div>
					<div class="col-2 sign-header">전화번호</div>
					<div class="col-6 sign-body d-flex">
						<input type="number" class="form-control me-1"
							id="input-phone-head" name="phone_head" style="width: 60px;"
							oninput="inputNum(this.id)"> <input type="number"
							class="form-control me-1" id="input-phone-body" name="phone_body"
							style="width: 70px;" oninput="inputNum(this.id)"> <input
							type="number" class="form-control" id="input-phone-tail"
							name="phone_tail" style="width: 70px;"
							oninput="inputNum(this.id)">
					</div>
				</div>

				<div class="row g-0 row-alert">
					<div class="col-6 sign-header"></div>
					<div class="col-6 sign-body phone-alert alert"></div>
				</div>

				<div class="row g-0">
					<div class="col-4"></div>
					<div class="col-2 sign-header">이메일</div>
					<div class="col-6 sign-body d-flex align-items-center">
						<input type="text" class="form-control update_list" id="email1"
							name="email1" style="width: 125px;">@ <input type="text"
							class="form-control" id="email2" name="email2"
							style="width: 125px; background-color: #D5D5D5;" readonly="true">
					</div>
				</div>
				<div class="row g-0">
					<div class="col-6"></div>
					<div class="col-6 sign-body">

						<select class="form-select" id="email2_dropdown"
							style="width: 268px">
							<option value="선택하세요" selected>선택하세요</option>
							<option value="naver.com">naver.com</option>
							<option value="gmail.com">gmail.com</option>
							<option value="hanmail.com">hanmail.com</option>
							<option value="직접입력">직접입력</option>
						</select> <input type="button" class="btn btn-outline-primary"
							value="인증코드 발송" id="btn-send-verification">
					</div>

				</div>

				<div class="row g-0 row-alert">
					<div class="col-6 sign-header"></div>
					<div class="col-6 sign-body email-alert alert"></div>
				</div>

				<!-- 인증 코드 입력 폼 -->
				<div class="row g-0">
					<div class="col-4"></div>
					<div class="col-2 sign-header">인증 코드</div>
					<div class="col-6 sign-body">
						<input type="text" class="form-control" placeholder="인증 코드 입력"
							id="input-verification-code"> <input type="button"
							class="btn btn-outline-primary" value="인증확인" id="btn-verify-code">
					</div>
				</div>

				<!-- 인증 결과 메시지 -->
				<div class="row g-0">
					<div class="col-6 sign-header"></div>
					<div class="col-6 sign-body verification-alert alert"></div>
				</div>


				<div class="row g-0">
					<div class="col-4"></div>
					<div class="col-2 sign-header">우편번호</div>
					<div class="col-6 sign-body d-flex">
						<input type="text" class="form-control me-2" placeholder="우편번호"
							id="input-post" name="zipcode" readonly> <input
							type="button" class="btn btn-outline-primary" value="찾기"
							id="btn-post-api">
					</div>
				</div>

				<div class="row g-0">
					<div class="col-4"></div>
					<div class="col-2 sign-header">주소1</div>
					<div class="col-6 sign-body">
						<input type="text" class="form-control" placeholder="주소1"
							id="input-addr-1" name="address1" readonly>
					</div>
				</div>

				<div class="row g-0">
					<div class="col-4"></div>
					<div class="col-2 sign-header">주소2</div>
					<div class="col-6 sign-body">
						<input type="text" class="form-control" placeholder="주소2"
							id="input-addr-2" name="address2">
					</div>
				</div>

				<div class="row g-0 mb-5">
					<div
						class="col-12 d-flex justify-content-center align-items-center mt-5">
						<input type="submit" class="btn btn-outline-primary me-2"
							value="회원가입" id="submit-signup"> <input type="button"
							class="btn btn-outline-danger" value="다시 입력" id="btn-reset">
					</div>
				</div>
			</form>
		</div>
	</div>

	<div id="footer_container"></div>

	<script>
		$(document).ready(function() {
			$("#footer_container").load("../commons/footer.html")
		});

		function inputNum(id) {
			let element = document.getElementById(id);
			element.value = element.value.replace(/[^0-9]/gi, "");
		}

		var duplCheck = false;
		$("#input-id").on("input", function() {
			duplCheck = false;
		})
		$("#input-phone-head").on("input", function() {
			if ($("#input-phone-head").val().length == 3) {
				$("#input-phone-body").focus();
			}

		})
		$("#input-phone-body").on("input", function() {
			if ($("#input-phone-body").val().length == 4) {
				$("#input-phone-tail").focus();
			}
		})
		$("#input-phone-tail").on("input", function() {
			if ($("#input-phone-tail").val().length == 4) {
				$("#email1").focus();
			}
		})

		let inputID = document.getElementById("input-id");
		let inputPW = document.getElementById("input-pw");
		let inputPWC = document.getElementById("input-pw-confirm");
		let inputName = document.getElementById("input-name");
		let inputPhoneHead = document.getElementById("input-phone-head");
		let inputPhoneBody = document.getElementById("input-phone-body");
		let inputPhoneTail = document.getElementById("input-phone-tail");
		let inputEmail = document.getElementById("email1");
		let inputEmail2 = document.getElementById("email2");
		let inputPost = document.getElementById("input-post")
		let inputAddr1 = document.getElementById("input-addr-1");
		let inputAddr2 = document.getElementById("input-addr-2");
		let btnPost = document.getElementById("btn-post-api");
		let btnSubmit = document.getElementById("btn-submit");
		let btnReset = document.getElementById("btn-reset");

		// rowAlert 배열
		let rowAlert = document.getElementsByClassName("row-alert");
		
		// 비밀번호 일치 여부
		let ispwcPassed = false;

		// id 입력 시 유효성 검사
		let idAlert = document.getElementsByClassName("id-alert")[0];
		inputID.onkeyup = function(e) {
			let idRegExr = /^[A-Za-z0-9_]{8,14}$/;
			if (inputID.value == "") {
				rowAlert[0].setAttribute("style", "display:none");
				idAlert.innerHTML = "";
			} else {
				rowAlert[0].setAttribute("style", "display: flex")
				if (!idRegExr.test(inputID.value)) {
					idAlert.setAttribute("style", "color: red;");
					idAlert.innerHTML = "올바르지 않은 아이디 형식입니다.";
					$("#btn-id-duplicate").attr("disabled", true);
				} else {
					idAlert.setAttribute("style", "color: blue;");
					idAlert.innerHTML = "올바른 아이디 형식입니다.";
					$("#btn-id-duplicate").attr("disabled", false);
				}
			}
		}

		// pw 입력 시 유효성 검사
		let pwAlert = document.getElementsByClassName("pw-alert")[0];
		inputPW.onkeyup = function(e) {
			let pwRegExr = /^[!@A-Za-z0-9_]{8,}$/;
			let pwRegExr2 = /[0-9]+/;
			let pwRegExr3 = /[A-Za-z]+/;
			if (inputPW.value == "") {
				rowAlert[1].setAttribute("style", "display:none");
				pwAlert.innerHTML = "";
			} else {
				rowAlert[1].setAttribute("style", "display: flex")
				if (!(pwRegExr.test(inputPW.value) && pwRegExr2
						.test(inputPW.value) && pwRegExr3.test(inputPW.value))) {
					pwAlert.setAttribute("style", "color: red;");
					pwAlert.innerHTML = "올바르지 않은 비밀번호 형식입니다.";
				} else {
					pwAlert.setAttribute("style", "color: blue;");
					pwAlert.innerHTML = "올바른 비밀번호 형식입니다.";
				}
			} 
			// 비밀번호 확인칸과 비교 및 알림창 바꾸기
			if (inputPW.value != inputPWC.value && $(rowAlert[1]).attr("style") == "display: flex") {
                pwcAlert.setAttribute("style", "color: red;");
                pwcAlert.innerHTML = "비밀번호가 다릅니다.";
                ispwcPassed = false;
            } else if (inputPW.value == inputPWC.value && $(rowAlert[1]).attr("style") == "display: flex") {
                pwcAlert.setAttribute("style", "color: blue;");
                pwcAlert.innerHTML = "비밀번호와 일치합니다.";
                ispwcPassed = true;
            }
		}

		// pw 확인 입력 시 유효성 검사
		let pwcAlert = document.getElementsByClassName("pw-confirm-alert")[0];
		
		inputPWC.onkeyup = function(e) {
			if (inputPWC.value == "") {
				rowAlert[2].setAttribute("style", "display:none");
				pwcAlert.innerHTML = "";
				ispwcPassed = false;
			} else {
				rowAlert[2].setAttribute("style", "display: flex")
				if (inputPW.value != inputPWC.value) {
					pwcAlert.setAttribute("style", "color: red;");
					pwcAlert.innerHTML = "비밀번호가 다릅니다.";
					ispwcPassed = false;
				} else {
					pwcAlert.setAttribute("style", "color: blue;");
					pwcAlert.innerHTML = "비밀번호와 일치합니다.";
					ispwcPassed = true;
				}
			}
		}

		// 이름 입력 시 유효성 검사
		let nameAlert = document.getElementsByClassName("name-alert")[0];
		inputName.onkeyup = function(e) {
			let nameRegExr = /^[가-힣]{2,5}$/;
			if (inputName.value == "") {
				rowAlert[3].setAttribute("style", "display:none");
				nameAlert.innerHTML = "";
			} else {
				rowAlert[3].setAttribute("style", "display: flex")
				if (!nameRegExr.test(inputName.value)) {
					nameAlert.setAttribute("style", "color: red;");
					nameAlert.innerHTML = "올바르지 않은 이름 형식입니다.";
				} else {
					nameAlert.setAttribute("style", "color: blue;");
					nameAlert.innerHTML = "올바른 이름 형식입니다.";
				}
			}
		}

		// 이메일 입력 시 유효성 검사
		let emailAlert = document.getElementsByClassName("email-alert")[0];
		inputEmail.onkeyup = function(e) {
			let mailValue = inputEmail.value + "@" + inputEmail2.value;
			let emailRegExr = /^[A-Za-z0-9_].+@[A-Za-z0-9].+\.[a-z].+$/;
			if (mailValue == "") {
				rowAlert[5].setAttribute("style", "display:none");
				emailAlert.innerHTML = "";
			} else {
				rowAlert[5].setAttribute("style", "display: flex")
				if (!emailRegExr.test(mailValue)) {
					emailAlert.setAttribute("style", "color: red;");
					emailAlert.innerHTML = "올바르지 않은 이메일 형식입니다.";
				} else {
					emailAlert.setAttribute("style", "color: blue;");
					emailAlert.innerHTML = "올바른 이메일 형식입니다.";
				}
			}
		}

		inputEmail2.onkeyup = function(e) {
			let mailValue = inputEmail.value + "@" + inputEmail2.value;
			let emailRegExr = /^[A-Za-z0-9_].+@[A-Za-z0-9].+\.[a-z].+$/;
			if (mailValue == "") {
				rowAlert[5].setAttribute("style", "display:none");
				emailAlert.innerHTML = "";
			} else {
				rowAlert[5].setAttribute("style", "display: flex")
				if (!emailRegExr.test(mailValue)) {
					emailAlert.setAttribute("style", "color: red;");
					emailAlert.innerHTML = "올바르지 않은 이메일 형식입니다.";
				} else {
					emailAlert.setAttribute("style", "color: blue;");
					emailAlert.innerHTML = "올바른 이메일 형식입니다.";
				}
			}
		}

		$("#email2_dropdown")
				.on(
						"change",
						function() {
							if ($("#email2_dropdown option:selected").val() == "직접입력") {
								$("#email2").val("").css("backgroundColor",
										"white").attr("readonly", false);
							} else if ($("#email2_dropdown option:selected")
									.val() == "선택하세요") {
								$("#email2").val("").css("backgroundColor",
										"#D5D5D5").attr("readonly", true);
							} else {
								$("#email2").val(
										$("#email2_dropdown option:selected")
												.val()).css("backgroundColor",
										"#D5D5D5").attr("readonly", true);
							}
							let mailValue = inputEmail.value + "@"
									+ inputEmail2.value;
							let emailRegExr = /^[A-Za-z0-9_].+@[A-Za-z0-9].+\.[a-z].+$/;
							if (mailValue == "") {
								rowAlert[5].setAttribute("style",
										"display:none");
								emailAlert.innerHTML = "";
							} else {
								rowAlert[5].setAttribute("style",
										"display: flex")
								if (!emailRegExr.test(mailValue)) {
									emailAlert.setAttribute("style",
											"color: red;");
									emailAlert.innerHTML = "올바르지 않은 이메일 형식입니다.";
								} else {
									emailAlert.setAttribute("style",
											"color: blue;");
									emailAlert.innerHTML = "올바른 이메일 형식입니다.";
								}
							}
						})

		//        let verificationCode = ""; // 이메일 인증 코드를 저장할 변수

		// 이메일 인증 코드 발송 버튼 클릭 이벤트 핸들러
		$("#btn-send-verification").on("click", function() {
			let email = inputEmail.value + "@" + inputEmail2.value;
			
			// Email 중복 검사
			$.ajax({
		        url: "/emailDupleCheck.members",
		        data: {
		            email: email
		        },
		        type: "post"
		    })
		    .done(function(resp) {
		        if (resp === "true") {
		        //	console.log("이메일 존재");
		            // 이메일 존재시
		            alert("이미 사용 중인 이메일입니다. 다른 이메일을 사용해주세요.");
		            $("#email1").val("");
		            $("#email2").val("");
		            $("#email2_dropdown").val("선택하세요").prop("selected",true); 
		            $("#email1").focus(); 
		            
		        }else{
		        //	console.log("이메일 없지롱");
		        	// 이메일 존재하지 않을 시
		        	// 이메일 주소가 유효한지 확인 (예: 정규식 사용)
					let emailRegExr = /^[A-Za-z0-9_].+@[A-Za-z0-9].+\.[a-z].+$/;
					if (!emailRegExr.test(email)) {
						$(".verification-alert").text("올바른 이메일 형식이 아닙니다.");
						return;
					}
					
					// 서버에 이메일 주소를 전송하고 인증 코드를 요청
					$.ajax({
						url : "/sendVerificationCode.members", // 서버의 인증 코드 발송 API 엔드포인트
						method : "POST",
						data : {
							email : email
						},
						success : function(data) {
							if (data === "success") {
								// 인증 코드 발송 성공
								$(".verification-alert").text("인증 코드가 이메일로 발송되었습니다.");
							} else if (data === "email_error") {
								// 이메일 주소 오류
								$(".verification-alert").text("올바르지 않은 이메일 주소입니다.");
							} else if (data === "send_error") {
								// 이메일 발송 오류
								$(".verification-alert").text("인증 코드 발송에 실패했습니다.");
							}
						},
						error : function() {
							$(".verification-alert").text("서버와의 통신 중 오류가 발생했습니다.");
						}
					});
		        }
		        
		    })
		    .fail(function() {
		        alert("서버와의 통신 중 오류가 발생했습니다.");
		    });
		});

		let isEmailVerified = false;

		// 인증 코드 확인 버튼 클릭 이벤트 핸들러
		$("#btn-verify-code").on("click", function() {
			let enteredCode = $("#input-verification-code").val();

			// 서버에 인증 코드를 전송하고 검증
			$.ajax({
				url : "/verifyCode.members", // 서버의 인증 코드 검증 API 엔드포인트
				method : "POST",
				data : {
					code : enteredCode
				},
				success : function(data) {
					if (data === "success") {
						// 인증 코드 일치
						$(".verification-alert").text("인증되었습니다.");
						isEmailVerified = true;
					} else {
						// 인증 코드 불일치
						$(".verification-alert").text("인증 코드가 일치하지 않습니다.");
						isEmailVerified = false;
					}
				},
				error : function() {
					$(".verification-alert").text("서버와의 통신 중 오류가 발생했습니다.");
					isEmailVerified = false;
				}
			});
		});

		// 다음 주소 API
		btnPost.onclick = function sample6_execDaumPostcode() {
			new daum.Postcode({
				oncomplete : function(data) {

					var addr = ''; // 주소 변수
					var extraAddr = ''; // 참고항목 변수

					//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
					if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
						addr = data.roadAddress;
					} else { // 사용자가 지번 주소를 선택했을 경우(J)
						addr = data.jibunAddress;
					}

					// 우편번호와 주소 정보를 해당 필드에 넣는다.
					inputPost.value = data.zonecode;
					inputAddr1.value = addr;
					// 커서를 상세주소 필드로 이동한다.
					inputAddr2.focus();
				}
			}).open();
		};

		// submit 버튼 클릭시
		let frm = document.getElementById("sign-form");
		frm.onsubmit = function() {
			let idRegExr = /^[A-Za-z0-9_]{8,14}$/;
			let pwRegExr = /^[!@A-Za-z0-9_]{8,}$/;
			let pwRegExr2 = /[0-9]+/;
			let pwRegExr3 = /[A-Za-z]+/;
			let nameRegExr = /^[가-힣]{2,5}$/;
			let phoneHeadRegExr = /[0-9]{3}$/;
			let phoneRegExr = /[0-9]{4}$/;
			let emailRegExr = /^[A-Za-z0-9_].+@[A-Za-z0-9].+\.[a-z].+$/;

			if (!idRegExr.test(inputID.value)) {
				alert("ID를 확인 해주십시오.");
				return false;
			} else if (!duplCheck) {
				alert("ID 중복 검사를 해주십시오.");
				return false;
			} else if (!(pwRegExr.test(inputPW.value) && pwRegExr2
					.test(inputPW.value) && pwRegExr3.test(inputPW.value))) {
				alert("비밀번호를 확인 해주십시오.");
				return false;
			} else if (!ispwcPassed) {
				alert("비밀번호 재입력 칸을 확인 해주십시오.");
				return false;
			} else if (!nameRegExr.test(inputName.value)) {
				alert("이름을 확인 해주십시오.");
				return false;
			} else if (!phoneHeadRegExr.test(inputPhoneHead.value)
					&& !phoneRegExr.test(inputPhoneBody.value)
					&& !phoneRegExr.test(inputPhoneTail.value)) {
				alert("전화번호를 확인 해주십시오.");
				return false;
			} else if (!emailRegExr.test(inputEmail.value + "@"
					+ inputEmail2.value)) {
				alert("이메일 주소를 확인 해주십시오.");
				return false;
			} else if ($("#input-post").val() == ""
					|| $("#input-addr-1").val() == "") {
				alert("주소를 확인 해주십시오.");
				return false;
			} else if (!isEmailVerified) {
				alert("이메일 인증이 필요합니다."); // Email verification check
				return false;
			} else {
				return true; // Allow form submission if all checks pass
			}
		};

		// RESET 버튼 클릭 시
		btnReset.onclick = function() {
			inputID.value = "";
			inputPW.value = "";
			inputPWC.value = "";
			inputName.value = "";
			inputPhoneHead.value = "";
			inputPhoneBody.value = "";
			inputPhoneTail.value = "";
			inputEmail.value = "";
			inputPost.value = "";
			inputAddr1.value = "";
			inputAddr2.value = "";
			for (let i = 0; i < rowAlert.length; i++) {
				rowAlert[i].setAttribute("style", "display:none");
			}
		}

		// 중복확인 검사 버튼 이벤트
		$("#btn-id-duplicate")
				.on(
						"click",
						function() {
							if ($("#input-id").val() == "") {
								alert("아이디를 먼저 입력하세요.");
								return;
							}

							// 창 띄우기 명령어. ("원하는 링크", "새 창의 이름", ,"크기 지정시 새창으로 뜸, 기본은 새 탭") 
							// window.open("/idCheck.members?id=" + $("#input-id").val(), "", "width=300, height=500");
							$
									.ajax({
										url : "/idDupleCheck.members",
										data : {
											id : $("#input-id").val()
										},
										type : "post"
									})
									.done(
											function(resp) {
											//	console.log(resp)
											//	console.log(typeof resp)
												if (resp == "true") {
													idAlert.setAttribute(
															"style",
															"color: red;");
													idAlert.innerHTML = "이미 사용중인 아이디 입니다.";
													duplCheck = false;
												} else {
													idAlert.setAttribute(
															"style",
															"color: blue;");
													idAlert.innerHTML = "사용 가능한 아이디 입니다.";
													duplCheck = true;
													$("#input-id")
															.attr("readonly",
																	"true")
															.css(
																	"background-color",
																	"#D5D5D5");

												}
											})
						});
	</script>
</body>

</html>