<%@page import="util.CalendarUtil"%>
<%@page import="dto.CalendarDto"%>
<%@page import="dao.CalendarDao"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!-- 

*************************** ref 그룹번호  step 행번호 depth : 깊이번호
															

 -->




<%
MemberDto login = (MemberDto) session.getAttribute("login");
System.out.println("wffffwfffefewew" + login); /////////
if (login == null) { // session 만료됐을때
%>
<script>
		alert('로그인 해주십쇼');
		location.href="login2.jsp";
		
		</script>
<%
}
%>


<%
CalendarDao dao = CalendarDao.getInstance();
int seq = Integer.parseInt(request.getParameter("seq"));
CalendarDto dto = dao.getdetail(seq);



%>
<%

String year = request.getParameter("year");
String month = request.getParameter("month");
String day = request.getParameter("day");

System.out.println("fwieofjweoifewfweofjwe : " + year);


month = CalendarUtil.two(month);
day = CalendarUtil.two(day);



%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
body {
	background-color: rgb(254, 239, 236);
}

table {
	border-collapse: collapse;
	border-color: gray;
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
	<form action="updateCalAf.jsp">
	<div align="center">
		<table border="1" width="800">
			<tr>
				<th>작성자</th>
				<td><%=dto.getId()%><input type="hidden" name="id">
				<input type="hidden" name="seq" value="<%=dto.getSeq()%>">
				</td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" value="<%=dto.getTitle()%>" name="title"></td>
			</tr>
			<tr>
				<th>스케줄</th>
				<td><input type="hidden" name="rdate">  <input type="date" name="date" id="date">&nbsp;
				<input type="time" name="time" id="time"></td>
				
			</tr>
			
			
			<tr style="width: 1000px; height: 500px;">
				<th>내용</th>
				<td><textarea style="width: 100%; height: 100%" name="content" id="content"><%=dto.getContent()%></textarea></td>
			</tr>


		</table>
	</div>
	<br>
	<br>

	<div align="center">


		<%
		if (dto.getId().equals(login.getId())) {
		%>
		<input type="submit" class="btn" value="수정하기">
		<% 
		}
		%>

	</div>
</form>
	<button type="button" onclick="history.back()" class="btn">목록보기</button>

<script type="text/javascript">

let year = "<%=year%>";
let month = "<%=month%>";
let day = "<%=day%>";
document.getElementById("date").value = year + "-" + month + "-" + day; 
</script>


</body>
</html>