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
body {
	background-color: rgb(254, 239, 236);
}

.sen {
	font-family: Verdana, Geneva, Arial, sans-serif;
}

.main {
	width: 250px;
	height: 40px;
	border: 1px;
	justify-content: space-between;
}

.id {
	background-color: rgb(254, 239, 236);
	width: 250px;
	height: 40px;
	border-radius: 5px;
	border-color: gray;
}

.pw {
	background-color: rgb(254, 239, 236);
	width: 250px;
	height: 40px;
	margin-top: 10px;
	border-color: gray;
	border-radius: 5px;
}

.btn {
	background-color: rgb(217, 88, 142);
	margin-top: 10px;
	width: 256px;
	height: 40px;
	color: white;
	border-radius: 5px;
	border: none;
}

p {
	line-height: 0.5em;
}
</style>
</head>
<body>
	<div align="center" style="margin-top: 10%">
		<form action="loginAf.jsp" method="post">
			<div class="main">

				<div class="sen" align="left">
					<p>반갑습니다.</p>
					<p>
						<strong>achilless의 브런치</strong> 입니다.
					</p>


				</div>
				<div>
					<input type="text" class="id" name="id" id="id"
						placeholder="아이디를 입력해주세요">


				</div>

				<div>
					<input type="password" class="pw" name="pwd"
						placeholder="비밀번호를 입력해주세요">

				</div>
				<div>

					<input type="submit" value="Sign in" class="btn" style="font-size: 17px">

				</div>
				<div style="text-align: justify">
					<tr>

						<td>New to Here? <a href="regi.jsp">create an account</a></td>
					</tr>

				</div>
				<br>
				<br>
				<br>
				<br>
				<div  style="text-align: justify">
					<tr>
						<td><input type="checkbox" id="chk_save_id">id
							save?</td>
					</tr>
				</div>

			</div>
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

		$("#chk_save_id").click(function() {
			// is() 선택한 요소에서 주어진 선택자가 있는지 판별
			// id요소가 #chk_save_id인 것에서 checked가 되어있다면 true를 반환
			if ($("#chk_save_id").is(":checked") == true) { // 클릭했을때
				//alert('true');
				if ($("#id").val().trim() == "") { // 아이디 기입 안했을때
					//alert('put it id');
					$("#chk_save_id").prop("checked", false); // 체크 안해줌 ********수정된 요소의 값을 가져오는데는 prop()사용해라
				} else {

					//cookie를 저장
					$.cookie("user_id", $("#id").val().trim(), {expireds : 7, path : './'});
				}

			} else { // 클릭해제
				//alert('false');
				$.removeCookie("user_id", {
					path : './'
				}); // 클릭해제하면 쿠키 삭제됨
			}

		});
	</script>


</body>
</html>