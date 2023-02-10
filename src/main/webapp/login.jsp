<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script src="http://lab.alexcican.com/set_cookies/cookie.js"
	type="text/javascript"></script>

<style type="text/css">
.center {
	margin: auto;
	width: 60%;
	border: 3px solid pink;
	padding: 10px;
}
</style>
</head>
<body>

	<h2>login page</h2>
	<div class="center">

		<form action="loginAf.jsp" method="post">
			<table border="1">
				<tr>
					<th>id</th>
					<td><input type="text" id="id" name="id" size="20"><br>
						<input type="checkbox" id="chk_save_id">id save(cookie)</td>
				</tr>

				<tr>
					<th>pw</th>
					<td><input type="password" name="pw" size="20"><br>
				</tr>
				<tr>
					<td colspan="2"><input type="submit" value="login"> <a
						href="regi.jsp">sign in</a></td>
				</tr>
			</table>
		</form>
	</div>
<script type="text/javascript">
	/*  
	    cookie : id저장 (다시 화면 띄워도 아이디 존재) == String     client
	    session : login한 정보 ==Object                       server
		
	*/

	let user_id = $.cookie("user_id");
	
	if (user_id != null) { // 저장한 id 가 있음
		$("#id").val(user_id); // 아이디 넣기
		$("#chk_save_id").prop("checked", true); // checkbox 켜두기
		
	}

	$("#chk_save_id").click(function(){
		
		if ($("#chk_save_id").is(":checked") == true) { // 클릭했을때
			//alert('true');
			if ($("#id").val().trim() == "") { // 아이디 기입 안했을때
				alert('put it id');
				$("#chk_save_id").prop("checked", false); // 체크 안해줌
			}else{
				
				//cookie를 저장
				$.cookie("user_id", $("#id").val().trim(), {expireds:7, path:'./'});
			}
			
		}else{ // 클릭해제
			//alert('false');
			$.removeCookie("user_id",{pth:'./'}); // 클릭해제하면 쿠키 삭제됨
		}
		
	});


</script>
</body>
</html>