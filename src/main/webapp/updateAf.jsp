<%@page import="dao.BbsDao"%>
<%@page import="dto.BbsDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("utf-8");
int seq = Integer.parseInt(request.getParameter("seq"));
String id = request.getParameter("id");
String title = request.getParameter("title");
String wdate = request.getParameter("wdate");
String content = request.getParameter("content");

BbsDao dao = BbsDao.getInstance();

boolean b = dao.update(seq, title, content);


if (b) {
%>
<script type="text/javascript">
	alert("수정 성공!");
	location.href = "bbslist.jsp";
</script>
<%
} else {
%>

<script type="text/javascript">
	alert("수정 실패");
	let seq = "<%=seq%>";
	location.href = "update.jsp?seq=" + sep;
</script>


<%
}
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>