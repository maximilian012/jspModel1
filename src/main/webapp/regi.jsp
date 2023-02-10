<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>


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

	<h2>Sign In</h2>
	<p>Welcome to achillesss</p>

	<div class="center">
		<form action="regiAf.jsp" method="post">
			<table border="1">
				<tr>
					<td>id</td>
					<td><input type="text" name="id" id="id" size="20">
						<p id="idcheck" style="font-size: 8px"></p> 
						<input type="button" id="idChkBtn" value="id confirm"></td>
				</tr>
				<tr>
					<td>pw</td>
					<td><input type="text" name="pwd" id="pwd" size="20">
					</td>
				</tr>
				<tr>
					<td>name</td>
					<td><input type="text" name="name" size="20"></td>
				</tr>
				<tr>
					<td>E-mail</td>
					<td><input type="email" name="email" size="20"></td>
				</tr>
				<tr>
					<td colspan="2" align="center"><input type="submit" value="sign-in">
					</td>

				</tr>

			</table>
		</form>
	</div>
	
	<script type="text/javascript">
	
	$(document).ready(function(){
		$("#idChkBtn").click(function(){
			
			// id 빈칸조사하기
			
			$.ajax({
				
				type:"post",
				url:"idcheck.jsp",
				data:{ "id": $("#id").val() },
				success:function(msg){
					//alert('success');
					//alert(msg.trim());
					
					if (msg.trim()== "Yes") {
						$("#idcheck").css("color", "blue");
						$("#idcheck").text("you can use this id");
					}else {
						
						$("#idcheck").css("color", "red");
						$("#idcheck").text("you can't use this id");
						$("#id").val("");
					}
				},
				error:function(){
					alert('error');
					
				}
			});
		});
	});
	
	
	</script>
	
</body>
</html>