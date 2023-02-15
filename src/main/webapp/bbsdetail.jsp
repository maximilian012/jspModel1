<%@page import="dto.MemberDto"%>
<%@page import="dao.BbsDao"%>
<%@page import="dto.BbsDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!-- 

*************************** ref 그룹번호  step 행번호 depth : 깊이번호
															

 -->




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
BbsDao dao = BbsDao.getInstance();
int seq = Integer.parseInt(request.getParameter("seq"));
BbsDto dto = dao.getBbs(seq);
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
				<th>작성일</th>
				<td><%=dto.getWdate()%></td>
			</tr>
			<tr>
				<th>조회수</th>
				<td><%=dto.getReadcount()%></td>
			</tr>
			<tr>
				<th>답글정보</th>
				<td><%=dto.getRef()%>-<%=dto.getStep()%>-<%=dto.getDepth()%></td>
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
		<button type="button" onclick="updateBbs(<%=dto.getSeq()%>)"
			class="btn">수정하기</button>
		<button type="button" onclick="deleteBbs(<%=dto.getSeq()%>)"
			class="btn">삭제하기</button>
		<%
		}
		%>
		<button type="button" onclick="answerBbs(<%=dto.getSeq()%>)"
			class="btn">댓글</button>

	</div>

	<button type="button" onclick="history.back()" class="btn">목록보기</button>

<script type="text/javascript">

function answerBbs(seq){
	
	location.href = "answer.jsp?seq=" + seq;
}
function deleteBbs(seq){
	
	location.href = "delete.jsp?seq=" + seq; // update시켜서 del을 1로 만들고 투명화
	
}
function updateBbs(seq){
	
	location.href = "update.jsp?seq=" + seq;
	
}

// readcount 증가
/* function readcount(seq){
	
	location.href = "update.jsp?seq=" + seq;
	
}
 */


</script>





</body>
</html>