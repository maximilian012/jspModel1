<%@page import="dto.CalendarDto"%>
<%@page import="dao.CalendarDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("utf-8");
String id = request.getParameter("id");
String title = request.getParameter("title");
String content = request.getParameter("content");
String date = request.getParameter("date");
String time = request.getParameter("time");

CalendarDao dao = CalendarDao.getInstance();
int seq = Integer.parseInt(request.getParameter("seq"));

String datesplit[] = date.split("-");
String year = datesplit[0];
String month = datesplit[1];
String day = datesplit[2];

String timesplit[] = time.split(":");
String hour = timesplit[0];
String min = timesplit[1];

String rdate = year + month + day + hour + min;

boolean b = dao.updateCal(seq, title, content, rdate);


if (b) {
%>
<script type="text/javascript">
	alert("수정 성공!");
	location.href = "calendar.jsp";
</script>
<%
} else {
%>

<script type="text/javascript">
	alert("수정 실패");
	let seq = "<%=seq%>";
	location.href = "updateCal.jsp?seq=" + sep;
</script>


<%
}
%>

