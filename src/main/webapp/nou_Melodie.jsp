<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html>
<html>
	<head>
	    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	    <title>Adaugă Melodie</title>
	    <link rel="stylesheet" type="text/css" href="style.css">
	</head>
	<jsp:useBean id="jb" scope="session" class="db.JavaBean" />
	<jsp:setProperty name="jb" property="*" />
	<body>
	    <%
	        String titlu = request.getParameter("titlu");
	        String gen = request.getParameter("gen");
	        String an_lansareStr = request.getParameter("an_lansare");
	        if (titlu != null && gen != null && an_lansareStr != null) {
	            int an_lansare = Integer.parseInt(an_lansareStr);
	            jb.connect();
	            jb.adaugaMelodie(titlu, gen, an_lansare);
	            jb.disconnect();
	    %>
	    <p>Datele au fost adăugate cu succes.</p>
	    <%
	        } else {
	    %>
	    <h1>Adaugă o nouă melodie</h1>
	    <form action="nou_Melodie.jsp" method="post" class="form-container">
	        <table>
	            <tr>
	                <td align="right"><label for="titlu">Titlu:</label></td>
	                <td><input type="text" name="titlu" id="titlu" size="40" required /></td>
	            </tr>
	            <tr>
	                <td align="right"><label for="gen">Gen:</label></td>
	                <td><input type="text" name="gen" id="gen" size="30" required /></td>
	            </tr>
	            <tr>
	                <td align="right"><label for="an_lansare">An Lansare:</label></td>
	                <td><input type="number" name="an_lansare" id="an_lansare" size="10" required /></td>
	            </tr>
	        </table>
	        <button type="submit" class="button">Adaugă Melodia</button>
	    </form>
	    <%
	        }
	    %>
	    <br />
	    <a href="tabela_Melodii.jsp" class="button">Înapoi la tabelă</a>
	</body>
</html>
