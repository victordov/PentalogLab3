<%@page import="md.victordov.lab.common.exception.MyDaoException"%>
<%@page import="md.victordov.lab.common.exception.ErrorList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="md.*"%>
<%@ page import="md.victordov.lab.vo.*"%>
<%@ page import="md.victordov.lab.dao.CursDAO"%>
<%@ page import="md.victordov.lab.vo.Universitate"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.List"%>
<%@ page import="md.victordov.lab.dao.*"%>
<%@ page import="md.victordov.lab.common.exception.MyDaoException"%>

<html>
<head>
<link href="<%=request.getContextPath()%>/style.css" rel="stylesheet"
	type="text/css">
<title>Curs</title>
</head>
<body>

	<!-- Header -->
	<%@ include file="/headerJSP.jsp"%>

	<!-- Script pentru Update -->
	<script>
function editRecord(id){
    var f=document.form;
    f.method="post";
    f.action='editCurs.jsp?id='+id;
    f.submit();
}
</script>

	<script>
function deleteRecord(id){
    var f=document.form;
    f.method="post";
    f.action='deleteCurs.jsp?id='+id;
    f.submit();
}
</script>

	<%
		//response.sendRedirect("error.jsp?msg="+ e.message());

		int pageNr = 1;
		int pageSize = 2;
		GenericDAO<Curs> genDao = null;
		try {
			if (request.getParameter("pageNr") != null) {
				pageNr = Integer.parseInt(request.getParameter("pageNr"));
			}
		} catch (Exception e) {
			pageNr = 1;
		}

		genDao = new CursDAO();

		List<Curs> cursList = null;

		cursList = genDao.retrieve(pageNr, pageSize);
	%>
	<br />
	<br />
	<br />
	<form method="post" name="form">
		<table>
			<caption>Curs</caption>
			<thead>
				<tr>
					<th>ID</th>
					<th>Nume Curs</th>
					<th>Universitate Id</th>
					<th>Profesor Id</th>
					<th>Edit</th>
					<th>Delete</th>
					<th>Insert</th>
				</tr>
			</thead>
			<%
				int countID = 0;
				int cursListSize = 0;
				cursListSize = genDao.countSize().intValue();
				int ox = (pageNr * pageSize) - pageSize;
				for (int i = 0; (i < pageSize) && (i < cursList.size()); i++) {
			%>
			<tr>
				<td><%=cursList.get(i).getCursId()%></td>
				<td><%=cursList.get(i).getNumeCurs()%></td>
				<td><%=cursList.get(i).getUniversitateId()%></td>
				<td><%=cursList.get(i).getProfesorId()%></td>
				<td><input type="button" name="edit" value="Edit"
					style="background-color: green; font-weight: bold; color: white;"
					onclick="editRecord(<%=cursList.get(i).getCursId()%>);"></td>
				<td><input type="button" name="delete" value="Delete"
					style="background-color: red; font-weight: bold; color: white;"
					onclick="deleteRecord(<%=cursList.get(i).getCursId()%>);"></td>
			</tr>
			<%
				}
			%>
			<tr>
				<td align="right" colspan="<%=cursList.size()%>">
					<%
						out.print("<td rowspan = \""
								+ cursList.size()
								+ "\"><a href=\"insertCursForm.jsp\"><input type=\"button\" name=\"insert\"");
						out.print(" value=\"Insert\" style=\"background-color:blue;font-weight:bold;color:white;\" ></a></td>");
					%>
				</td>
			</tr>
		</table>
	</form>
	<br />
	<table>
		<tr>
			<%
				int pageFor = (int) Math.ceil((double) cursListSize
						/ (double) pageSize);
				for (int i = 1; i <= pageFor; i++) {
					if (i == pageNr) {
						out.println("<td><b><a href=\"" + request.getContextPath()
								+ "/Curs/CursJSP.jsp?pageNr=" + i + "\">" + i
								+ "</a></b></td>");
					} else {
						out.println("<td><a href=\"" + request.getContextPath()
								+ "/Curs/CursJSP.jsp?pageNr=" + i + "\">" + i
								+ "</a></td>");
					}

				}
			%>
		</tr>
	</table>
	<br />
	<a href="<%=request.getContextPath()%>/cursxmldownloadservlet">Export
		to XML</a>
	<!-- Footer -->
	<%@ include file="/footerJSP.jsp"%>