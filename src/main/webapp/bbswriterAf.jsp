<%@page import="dto.BbsDto"%>
<%@page import="dao.BbsDao"%>
<%@page import="dto.MemberDto"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%
request.setCharacterEncoding("utf-8"); // db에 넣기전 한글 세팅을 해준다 그래야 한글 안깨짐

String id = request.getParameter("id");
String title = request.getParameter("title");
String content = request.getParameter("content");

//System.out.println("wefewfewfewfwefwef" + id);
BbsDao dao = BbsDao.getInstance();

BbsDto dto = new BbsDto(id, title, content); // 인자 3개만 있는 생성자 사용
boolean b = dao.addWrite(dto);

if(b == true){
	%>
	<script type="text/javascript">

	alert("글쓰기 성공!");
	location.href ="bbslist.jsp";
	</script>
	<%
	
	
}else{
	%>
	<script type="text/javascript">
	alert("다시 기입해 주십시요!!");
	location.href = "bbswrite.jsp";

	</script>
	<%
}
%>