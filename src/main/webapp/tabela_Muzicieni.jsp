<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java"
    import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Tabela Muzicieni</title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<jsp:useBean id="jb" scope="session" class="db.JavaBean" />
<jsp:setProperty name="jb" property="*" />
<body>
    <h1>Tabela Muzicieni</h1>
    <p>
        <a href="nou_Muzician.jsp" class="button">Adaugă un nou muzician</a>
        <a href="modifica_Muzician.jsp" class="button">Modifică Muzician</a>
    </p>
    <form action="sterge_Muzician.jsp" method="post">
        <table>
            <tr>
                <th>Mark</th>
                <th>Id Muzician</th>
                <th>Nume</th>
                <th>Prenume</th>
                <th>Data Nașterii</th>
                <th>Instrument</th>
            </tr>
            <%
                jb.connect();
                ResultSet rs = jb.vedeTabela("muzicieni");
                long x;
                while (rs.next()) {
                    x = rs.getInt("id_muzician");
            %>
            <tr>
                <td><input type="checkbox" name="primarykey" value="<%= x%>" /></td>
                <td><%= x%></td>
                <td><%= rs.getString("nume")%></td>
                <td><%= rs.getString("prenume")%></td>  
                <td><%= rs.getDate("data_nasterii")%></td> 
                <td><%= rs.getString("instrument")%></td>
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
