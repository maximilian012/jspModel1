<%@page import="dto.CalendarDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.CalendarDao"%>
<%@page import="util.CalendarUtil"%>
<%@page import="java.util.Calendar"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
MemberDto login = (MemberDto) session.getAttribute("login");
System.out.println("wffffwfffefewew" + login);
if (login == null) { // session 만료됐을때
%>
<script>
		alert('로그인 해주십쇼');
		location.href="login2.jsp";
		
		</script>
<%
}
%>
    
    
    
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">

a{

text-decoration: none;

}

table {
	border-collapse: collapse;
	border-color: gray;
}

.btn {
	background-color: rgb(217, 88, 142);
	margin-top: 10px;
	width: 80px;
	height: 20px;
	color: white;
	border-radius: 5px;
	border: none;
}

</style>

</head>
<body>
<h1>일정관리</h1>
<div align="right">
<button onclick="logout()" class="btn">logout</button>
</div>
<%
	// 달력 나오는 곳
	Calendar cal = Calendar.getInstance();
	cal.set(Calendar.DATE, 1); // 1일 로 설정
	
	String syear = request.getParameter("year");
	String smonth = request.getParameter("month");
	
	int year = cal.get(Calendar.YEAR);
	if(CalendarUtil.nvl(syear) == false){ // 넘어온 파라미터가 있다
		
		year = Integer.parseInt(syear);
	
	}
	
	
	int month = cal.get(Calendar.MONTH) + 1;
	if(CalendarUtil.nvl(smonth) == false){
		
		month = Integer.parseInt(smonth);
	}
	
	if(month < 1){ // 왼쪽을 누르면
		
		month = 12;
		year--;
	}
	if(month > 12){ // 오른쪽을 누르면
		
		month = 1;
		year++;
	}

	cal.set(year, month-1, 1);
	// 요일
	int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK); 
	
	// << year--
	String pp = String.format("<a href='calendar.jsp?year=%d&month=%d'>"
				 + "<img src='images/left.gif' width='30px' height='30px'>"
				 + "</a>",  year-1, month);
	// < month--전달
	String p = String.format("<a href='calendar.jsp?year=%d&month=%d'>"
				 + "<img src='images/prec.gif' width='30px' height='30px'>"
				 + "</a>",  year, month-1);
	// > month++
	String n = String.format("<a href='calendar.jsp?year=%d&month=%d'>"
				 + "<img src='images/next.gif' width='30px' height='30px'>"
				 + "</a>",  year, month+1);
	// >> year++
	String nn = String.format("<a href='calendar.jsp?year=%d&month=%d'>"
			 + "<img src='images/last.gif' width='30px' height='30px'>"
			 + "</a>",  year+1, month);
	
	//DB
	
	CalendarDao dao = CalendarDao.getInstance();
	
	List<CalendarDto> list = dao.getCalendarList(login.getId(), year + CalendarUtil.two(month + ""));
	
%>

<div align="center">
<table border="1">
<col width="100"><col width="100"><col width="100"><col width="100"><col width="100"><col width="100"><col width="100">


<tr>
<td colspan="7" align="center" style="color: pink">
	<%=pp %>&nbsp;&nbsp;<%=p %>&nbsp;&nbsp;&nbsp;&nbsp;
	<font color="black" style="font-size: 50px; font-family: fantasy">
		<%=String.format("%d년&nbsp;&nbsp;%2d월", year, month) %>
	
	</font>
	&nbsp;&nbsp;&nbsp;&nbsp;<%=n %>&nbsp;&nbsp;<%=nn %>
</td>

</tr>

<tr height="50" style="background-color:  rgb(217, 88, 142); color: black;">
<th>Sun</th>
<th>Mon</th>
<th>Tue</th>
<th>Wen</th>
<th>Thr</th>
<th>Fri</th>
<th>Sat</th>

</tr>

<tr height="100" align="left" valign="top">
<%
// 위쪽 빈칸 
for(int i = 1;i < dayOfWeek; i++){
	
	%>
	<td style="background-color: pink">&nbsp</td>
	<%
	
}

// 날짜
int lastday = cal.getActualMaximum(Calendar.DAY_OF_MONTH); // getActualMaximum : 해당월의 마지막 날짜
for(int i = 1; i <= lastday; i++){
	
	%>
	<td style="background-color: rgb(254, 239, 236)">
	<%=CalendarUtil.callist(year, month, i) %>&nbsp;&nbsp;<%=CalendarUtil.calwrite(year, month, i) %>
	<%=CalendarUtil.makeTable(year, month, i, list) %>

	</td>
	<%
	if((i + dayOfWeek -1)% 7 == 0 && i != lastday){
		%>
		
		</tr><tr height="100" align="left" valign="top">
		<%
		
	}
}



// 아래쪽 빈칸
cal.set(Calendar.DATE, lastday);
int weekday = cal.get(Calendar.DAY_OF_WEEK);
for(int i = 0; i < 7 - weekday; i++){
	
	%>
	<td style="background-color: pink">&nbsp</td>
	<%
}

%>


</tr>

</table>

<br> <select id="choice">

			<option>검색</option>
			<option value="title">제목</option>
			<option value="content">내용</option>
		</select> <input type="text" id="search" value="">
		<button type="button" onclick="searchBtn()" class="btn">검색</button>


</div>
<button type="button" onclick="location.href = '/bbslist.jsp?login=' + 'login'" class="btn">목록보기</button>
</body>
</html>

<script type="text/javascript">
function logout(){
	
	alert('정말 로그아웃 하시겠습니까?');
	location.href = "logout.jsp";
	
	
}
</script>