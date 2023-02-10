<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
    <%
    	String id = request.getParameter("id");
    	System.out.println(id);
    	
    	MemberDao dao = MemberDao.getInstance();
    	boolean b = dao.getId(id);
    	
    	int cnt = 0;
    	if(b == true) {
    		
    		out.println("No"); // id가 있으면 사용 불가
    	}else{
    		
    		out.println("Yes"); // id가없으면 사용가능
    		cnt = 1;
    	}
    	
    %>