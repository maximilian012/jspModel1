<%@page import="dto.MemberDto"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
    <%
    	request.setCharacterEncoding("utf-8"); // db에 넣기전 한글 세팅을 해준다 그래야 한글 안깨짐
    
    	String id = request.getParameter("id");
    	String pwd = request.getParameter("pwd");
    	String name = request.getParameter("name");
    	String email = request.getParameter("email");
    	
    	
    	// back-end db에 넣어야
    	MemberDao dao = MemberDao.getInstance(); //dao는 db의 data에 접근하기위한 객체
    	
    	MemberDto dto = new MemberDto(id, pwd, name, email, 0); // dto 계층간 데이터 교환을 하기위해 사용하는 객체로 순수한 데이터 객체 getter,setter를 가진 클래스
    	boolean isS = dao.addMember(dto);
    	
    	if(isS == true){
    		%>
    		<script type="text/javascript">

			alert("성공적으로 가입!");
			location.href ="login2.jsp";
    		</script>
    		<%
    		
    		
    	}else{
    		%>
    		<script type="text/javascript">
			alert("다시 기입해 주십시요!!");
			location.href = "regi.jsp";

    		</script>
    		<%
    	}
    %>


