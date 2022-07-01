<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

  <!-- Basic Page Needs
  ================================================== -->
  <meta charset="utf-8">
  <title>밀슐랭 회원가입</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>

<body id="body">

<%@ include file="../include/header.jspf"%>
<section class="signin-page account">
  <div class="container">
    <div class="row">
      <div class="col-md-6 col-md-offset-3">
        <div class="block text-center">
          <a class="logo" href="index.html">
            <img src="resource/images/logo.png" alt="">
          </a>
          <h2 class="text-center">계정을 만드세요</h2>
          <form class="text-left clearfix" id="submitSignUp" name="submitSignUp" action="submitSignUp.do" method="post">
            <div class="form-group">
              <input type="text" name="mId" id="mId" class="form-control"  placeholder="ID(닉네임)">
              <button type="button" onclick="checkUniqueId();">중복 확인</button>
            </div>
            <div class="form-group">
              <input type="password" name="pw" id="pw" class="form-control"  placeholder="비밀번호">
            </div>
            <div class="form-group">
              <input type="password" id="pw2" class="form-control"  placeholder="비밀번호 확인">
            </div>
            <div class="form-group">
              <input type="text" name="mName" class="form-control"  placeholder="이름">
            </div>
            <div class="form-group">
              <input type="email" name="email" class="form-control"  placeholder="이메일">
            </div>
            <div class="form-group">
              <input type="tel" name="phone" class="form-control"  placeholder="연락처">
            </div>
            <div class="form-group">
              <input type="text" name="address" class="form-control"  placeholder="주소">
            </div>
            <input type="hidden" name="isUniqueId" value="false">
            <div class="text-center">
              <button type="button" class="btn btn-main text-center" onclick="checkSignupForm();">회원가입</button>
            </div>
          </form>
          <p class="mt-20">이미 계정이 있으신가요☞<a href="login.do"> 로그인</a></p>
          <p><a href="forgetPwd.do"> 비밀번호를 잊으셨나요? </a></p>
        </div>
      </div>
    </div>
  </div>
</section>

<script type="text/javascript">

	let submitSignUpForm = document.getElementById("submitSignUp");	
	
	function checkUniqueId() {		// 다음 프로젝트 때 제이쿼리+ajax로 수정예정			
		var mId = document.getElementById("mId");
		if (mId.value == "") {
			alert("ID를 입력하세요!!");
			mId.focus();
			return false;
		}
		window.open('checkUniqueId.do?mId=' + mId.value, '중벅확인', 'width=300, height=120');
	}

	function checkSignupForm() {
			
		if (submitSignUpForm.mId.value == "") {
			alert("ID를 입력하세요!!");
			submitSignUpForm.mId.focus();
			return false;
		}
		if (submitSignUpForm.pw.value == "") {
			alert("비밀번호를 입력하세요!!");
			submitSignUpForm.pw.focus();
			return false;
		}
		if (submitSignUpForm.pw2.value == "") {
			alert("비밀번호 확인도 입력하세요!!");
			submitSignUpForm.pw2.focus();
			return false;
		}
		if (submitSignUpForm.pw.value != pw2.value) {
			alert("비밀번호 재입력까지 일치해야합니다.");
			submitSignUpForm.pw.focus();
			return false;
		}
		if (submitSignUpForm.mName.value == "") {
			alert("이름을 입력하세요!!");
			submitSignUpForm.mName.focus();
			return false;
		}
		if (submitSignUpForm.isUniqueId.value != 'true') { 			
			alert("아이디 중복확인 통과해야 합니다~~");
			submitSignUpForm.mId.focus();
			return false;
		}		
		submitSignUpForm.submit();
	}


/* 
	// jquery + ajax 사용 (제이쿼리 cdn 사용)
	$('btnCheckId').click(function () {	
		
		alert("ajax버튼 테스트");
		
	    if ($('#mId').val() != '') {	        
	        $.ajax({	   					
	            type: 'GET',
	            url: '/checkUniqueId.do',
	            data: 'id=' + $('#mId').val(),
	            dataType: 'json',
	            success: function(result) {
	                if (result == '1') {
	                    $('#result').text('사용 가능한 아이디입니다.');
	                } else {
	                    $('#result').text('이미 사용중인 아이디입니다.');
	                }
	            },
	            error: function(a, b, c) {
	                console.log(a, b, c);
	            }	
	        });
	   				
	    } else {
	        alert('먼저 아이디를 입력하세요!!!');
	        $('#mId').focus();
	    }	   			
	}); */
</script>

<%@ include file="../include/footer.jspf"%>