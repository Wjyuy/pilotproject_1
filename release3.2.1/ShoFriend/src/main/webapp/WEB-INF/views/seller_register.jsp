<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-SgOJa3DmI69IUzQ2PVdRZhwQ+dy64/BUtbMJw1MZ8t5HZApcHrRKUc4W0kG879m7" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js" integrity="sha384-k6d4wzSIapyDyv1kpU366/PK5hCdSbCRGRCMv+eplOQJWyd1fbcAu9OCUj5zNLiq" crossorigin="anonymous"></script>
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.rtl.css "> --%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/register.css ">
<script src="${pageContext.request.contextPath}/resources/js/script.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/jquery.js"></script>
	<script type="text/javascript">
	function fn_submit2() {
		var formData = $("#frm2").serialize();//form 요소 자체
		
		$.ajax({
			type:"post"
			,data:formData
			,url:"seller_registerOk"
			,success: function(data) {
				alert("가입이 완료되었습니다")
				location.href="login";
			}
			,error: function(){
				alert("중복된 이메일입니다. 다시 입력해주세요")
				location.href="seller_register";
			}
		});
	}
	
	
	</script>
</head>
<body>

<div class ="container">
<div class = "form-box">
  <fieldset>
    <h1>판매자 회원가입</h1>
<form name="reg_frm2" id="frm2" method="post" action="seller_registerOk">

    <div>
      <label  class="form-label mt-4">이름</label>
      <input type="text" class="form-control" size="20" name="name" placeholder="이름">
    </div>
    <div>
      <label  class="form-label mt-4">Email</label>
      <input type="text" class="form-control"  size="20" name="email" placeholder="Enter email">
    </div>
    <div>
      <label  class="form-label mt-4">비밀번호</label>
      <input type="text" class="form-control"  size="20" name="password" placeholder="비밀번호" autocomplete="off">
    </div>
        <div>
      <label  class="form-label mt-4">비밀번호 확인</label>
      <input type="text" class="form-control"  size="20" name="password_check" placeholder="비밀번호 확인" autocomplete="off">
    </div>
        <div>
      <label class="form-label mt-4">연락처</label>
      <input type="text" class="form-control" size="20" name="phone" placeholder="연락처" autocomplete="off">
    </div>
				<div class="text-center mt-4">
					<input type="button" onclick="check_ok2()"  class="btn btn-primary" value="등록">
				</div>
		</form>
  </fieldset>
  </div>
  </div>
</body>
</html>