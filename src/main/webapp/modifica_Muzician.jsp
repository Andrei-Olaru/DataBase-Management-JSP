<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tabela Muzician</title>
        <link rel="stylesheet" type="text/css" href="style.css">
    </head>
    <jsp:useBean id="jb" scope="session" class="db.JavaBean" />
    <jsp:setProperty name="jb" property="*" />
    <body>
        <h1>Tabela Muzician</h1>
        <p><a href="nou_Muzician.jsp" class="button">Adaugă un muzician nou</a> <a href="index.html" class="button">Home</a></p>
        <form action="m1_Muzician.jsp" method="post" class="form-container">
            <table>
                <tr>
                    <th>Mark</th>
                    <th>IdMuzician</th>
                    <th>Nume</th>
                    <th>Prenume</th>
                    <th>Data Nașterii</th>
                    <th>Instrument</th>
                </tr>
                <%
                    jb.connect();
                    ResultSet rs = jb.vedeTabela("muzicieni");
                    while (rs.next()) {
                        long x = rs.getLong("id_muzician");
                %>
                <tr>
                    <td><input type="checkbox" name="primarykey" value="<%= x %>" /></td>
                    <td><%= x %></td>
                    <td><%= rs.getString("nume") %></td>
                    <td><%= rs.getString("prenume") %></td>
                    <td><%= rs.getDate("data_nasterii") %></td>
                    <td><%= rs.getString("instrument") %></td>
                </tr>
                <%
                    }
                    jb.disconnect();
                %>
            </table>
            <button type="submit">Modifică linia</button>
        </form>
        <a href="index.html" class="button">Home</a>
    </body>
</html>
