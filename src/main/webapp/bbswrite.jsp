<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

</head>

<%
MemberDto login = (MemberDto)session.getAttribute("login");

	if(login == null){ // session 만료됐을때
		%>
		<script>
		alert('로그인 해주십쇼');
		location.href="login2.jsp";
		
		</script>
		<%
		
	}


%>   

<body>
<h2>글쓰기</h2>
	<div align="center">
	<form action="bbswriterAf.jsp">
	 <table border="1" width=500>
        <tr>
            <th colspan="1">
                id
            </th>
            <td>
             <input type="hidden" name="id" value="<%=login.getId() %>">
           <span><%=login.getId() %></span> 
            </td>
        </tr>
        <tr>
            <td width=50>
               제목
            </td>
            <td >
                <input type="text" placeholder="제목을 입력하세요."
                maxlength=20
                style="width:100%" name="title" id="title" >
            </td>
        </tr>
        <tr>
            <td colspan="2" height=400>
                <textarea placeholder="내용을 입력하세요." style="width: 100%; height: 100%" name="content" id="content"></textarea>
            </td>
        </tr>
        <tr>
            <td colspan="2" align=right>
                <input type="submit" value="글쓰기">
                <input type="button" value="목록으로">
            </td>
        </tr>
    </table>
    </form>
	</div>

</body>
</html>