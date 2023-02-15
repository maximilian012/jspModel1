<%@page import="dto.BbsDto"%>
<%@page import="dao.BbsDao"%>
<%@page import="java.util.List"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%!// 답글의 화살표 함수
	public String arrow(int depth) {

		String img = "<img src='./images/arrow.png' width='20px' height='20px'/>";
		String nbsp = "&nbsp;&nbsp;&nbsp;&nbsp;";

		String ts = "";
		for (int i = 0; i < depth; i++) {

			ts += nbsp;
		}
		return depth == 0 ? "" : ts + img;

	}%>



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
	width: 80px;
	height: 20px;
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



	<%
	// ***********************************************************검색*******************************************************************
	String choice = request.getParameter("choice");
	String search = request.getParameter("search");

	if (choice == null) {

		choice = "";
	}
	if (search == null) {

		search = "";

	}

	BbsDao dao = BbsDao.getInstance();

	// ***************************************************페이지 넘버***************************************************************
	String sPageNum = request.getParameter("pageNum"); // pageBbs : 페이지 개수, pageNum : 현재페이지
	// getParameter : String type 으로 반환
	System.out.println("로그인하고 들어온후의 pageNum의 값은????????? : " + sPageNum);
	int pageNum = 0; // 로그인하고 들어올때는 아무것도 누른것이 없으니 default값을 넣어준다. 그게 바로 0 pageNum의 값이 null이라 if문 안탐
	if (sPageNum != null && !sPageNum.equals("")) {
		pageNum = Integer.parseInt(sPageNum);
	}

	//List<BbsDto> list = dao.getBbsList();
	//List<BbsDto> list = dao.getBbsSearchList(choice, search);
	List<BbsDto> list = dao.getBbsPgaeList(choice, search, pageNum);
	// 글의 총수
	int count = dao.getAllBbs(choice, search);

	// 페이지의 총수
	int pageBbs = count / 10; // 10개씩 자른다 글을
	if ((count % 10) > 0) {

		pageBbs = pageBbs + 1;
	}
	%>


	<!-- 페이지 뿌려주는곳!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
	<h1>게시판</h1>

	<div align="center">

		<table border="1">
			<col width="70">
			<col width="600">
			<col width="100">
			<col width="150">

			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>조회수</th>
					<th>작성자</th>

				</tr>
			</thead>
			<tbody>
				<%
				if (list == null || list.size() == 0) {
				%>
				<tr>
					<td colspan="4">작성된 글이 없습니다.</td>
				</tr>

				<%
				} else {

				for (int i = 0; i < list.size(); i++) {

					BbsDto dto = list.get(i);
					if (list.get(i).getDel() == 1) {
				%>
				<td>*****************이 글은 관리자에 의해 삭제되었습니다.</td>
				<%
				continue;
				}
				%>
				<tr>
					<th><%=i + 1%></th>



					<!--********************* 화살표 모양 나오는곳 ********************************************************************-->
					<td><%=arrow(dto.getDepth())%><a
						href="bbsdetail.jsp?seq=<%=dto.getSeq()%>"><%=dto.getTitle()%></a>

					</td>
					<td><%=dto.getReadcount()%></td>

					<td><%=dto.getId()%></td>
				</tr>
				<%
				}
				}
				%>

			</tbody>

		</table>
		<br> <br>
		<%
		for (int i = 0; i < pageBbs; i++) { // pageBbs : 10으로 나눈 몫 + 나머지
			if (pageNum == i) { // 현재 page 첨엔 무조건 1페이지 바라보기
		%>
		<span
			style="font-size: 15pt; color: rgb(217, 88, 142); font-weight: bold">
			<%=i + 1%>

		</span>
		<%
		} else { // 현재 페이지 말고
		%>
		<a href="#none" title="<%=i + 1%>페이지" onclick="goPage(<%=i%>)"
			style="font-size: 15pt; color: black; font-weight: bold; text-decoration: none;">[<%=i + 1%>]
		</a>
		<%
		}

		}
		%>



		<br> <select id="choice">

			<option>검색</option>
			<option value="title">제목</option>
			<option value="content">내용</option>
			<option value="writer">작성자</option>
		</select> <input type="text" id="search" value="<%=search%>">
		<button type="button" onclick="searchBtn()" class="btn">검색</button>


		<br> <br> <a href="bbswrite.jsp">글쓰기</a>

	</div>


	<script type="text/javascript">

let search = "<%=search%>";
console.log("search=" + search);
if (search != "") {
	let obj = document.getElementById("choice");
	obj.value = "<%=choice%>";
	obj.setAttribute("selected", "selected"); // <select>를 obj.value값으로 리셋해준다. selected = selected
}

function searchBtn(){
	
	let choice = document.getElementById('choice').value;
	let search = document.getElementById('search').value;
	
/* 	if (choice == "") {
		alert("카테고리를 선택해라!");
		return; // return 되면서 다시 보여줌
	}
	if (search.trim() == "") {
		alert('검색어를 선택해라');
		return;
	} */
	
	location.href = "bbslist.jsp?choice=" + choice + "&search=" + search;
}

function goPage( pageNum ){
	
	let choice = document.getElementById('choice').value;
	let search = document.getElementById('search').value;
	
	location.href = "bbslist.jsp?choice=" + choice + "&search=" + search + "&pageNum=" + pageNum;
	
}


</script>


</body>
</html>