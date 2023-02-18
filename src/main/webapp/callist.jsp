<%@page import="java.util.List"%>
<%@page import="util.CalendarUtil"%>
<%@page import="dto.CalendarDto"%>
<%@page import="dao.CalendarDao"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
String year = request.getParameter("year");
String month = request.getParameter("month");
String day = request.getParameter("day");
 
month = CalendarUtil.two(month);
day = CalendarUtil.two(day);

String date = year + month + day;

System.out.println(date);

List<CalendarDto> list = dao.getCallist(date, login.getId()); // member dto 에서 id값을 가져 온다
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
	<span></span>
	<div align="center">
		<table border="1" width="800">
		
		
				<%
				for (int i = 0; i < list.size(); i++) {

					CalendarDto dto = list.get(i);
				%>
				<tr>
					<th colspan="2"><%=i + 1%></th></tr>
				
			<tr>
				<th>작성자</th>
				<td><%=dto.getId() %></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><%=dto.getTitle() %></td>
			</tr>
			<tr>
				<th>스케줄</th>
				<td><%=CalendarUtil.toDates(dto.getRdate()) %></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><%=dto.getContent() %></td>
			</tr>
				<%
				}
					%>
		</table>
	</div>
	<br>
	<br>
	<button type="button" onclick="history.back()" class="btn">목록보기</button>

	<script type="text/javascript">
</script>

</body>
</html>