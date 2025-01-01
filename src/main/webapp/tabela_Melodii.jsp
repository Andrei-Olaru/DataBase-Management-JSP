<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java"
    import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Tabela Melodii</title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<jsp:useBean id="jb" scope="session" class="db.JavaBean" />
<jsp:setProperty name="jb" property="*" />
<body>
    <h1>Tabela Melodii</h1>
    <p>
        <a href="nou_Melodie.jsp" class="button">Adaugă o nouă melodie</a>
        <a href="modifica_Melodie.jsp" class="button">Modifică Melodie</a>
    </p>
    <form action="sterge_Melodie.jsp" method="post">
        <table>
            <tr>
                <th>Mark</th>
                <th>Id Melodie</th>
                <th>Titlu</th>
                <th>Gen</th>
                <th>An Lansare</th>
            </tr>
            <%
                jb.connect();
                ResultSet rs = jb.vedeTabela("melodii");
                long x;
                while (rs.next()) {
                    x = rs.getInt("id_melodie");
            %>
            <tr>
                <td><input type="checkbox" name="primarykey" value="<%= x%>" /></td>
                <td><%= x%></td>
                <td><%= rs.getString("titlu")%></td>
                <td><%= rs.getString("gen")%></td>  
                <td><%= rs.getInt("an_lansare")%></td> 
            </tr>
            <%
                }
                rs.close();
                jb.disconnect();
            %>
        </table>
        <button type="submit" class="button" style="width: auto">Șterge liniile marcate</button>
    </form>
    <p>
        <a href="index.html" class="button">Home</a>
    </p>
</body>
</html>
