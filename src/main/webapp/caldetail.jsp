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
int seq = Integer.parseInt(request.getParameter("seq"));

CalendarDto dto = dao.getdetail(seq);
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
			<tr>
				<th>작성자</th>
				<td><%=dto.getId()%></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><%=dto.getTitle()%></td>
			</tr>
			<tr>
				<th>스케줄</th>
				<td><%=CalendarUtil.toDates(dto.getRdate())%></td>
			</tr>


			<tr style="width: 1000px; height: 500px;">
				<th>내용</th>
				<td><%=dto.getContent()%></td>
			</tr>


		</table>
	</div>
	<br>
	<br>

	<div align="center">


		<%
		if (dto.getId().equals(login.getId())) {
		%>
		<button type="button"
			onclick="updateCal(<%=dto.getSeq()%>,<%=dto.getRdate()%> )"
			class="btn">수정하기</button>
		<button type="button" onclick="deleteCal(<%=dto.getSeq()%>)"
			class="btn">삭제하기</button>
		<%
		}
		%>

	</div>

	<button type="button" onclick="history.back()" class="btn">목록보기</button>

	<script type="text/javascript">


 
	
 

function updateCal(seq, date){
	
	 let year = String(date).substring(0, 4);
 	let month = String(date).substring(4, 6);
	 let day = String(date).substring(6, 8);
	location.href = "updateCal.jsp?seq=" + seq + "&year=" + year + "&month=" + month + "&day=" + day; 
	
	
}
function deleteCal(seq){
	
	location.href = "deleteCal.jsp?seq=" + seq;
	
}
 

</script>





</body>
</html>