<%@page import="dao.CalendarDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript">

alert("삭제 하시겠습니까?");

</script>


<%

CalendarDao dao = CalendarDao.getInstance();
int seq = Integer.parseInt(request.getParameter("seq"));
boolean b = dao.deleteCal(seq);

if(b){
	%>
	<script type="text/javascript">
	alert("삭제 되었습니다./");
	location.href="calendar.jsp";
	</script>
	<%
	
}else{
	%>
	<script type="text/javascript">
	location.href="bbsdetail.jsp?seq=" + seq;
	</script>
	<%
}
%>



</body>
</html>