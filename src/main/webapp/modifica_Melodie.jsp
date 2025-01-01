<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
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
        <p><a href="nou_Melodie.jsp" class="button">Adaugă o melodie nouă</a> <a href="index.html" class="button">Home</a></p>
        <form action="m1_Melodie.jsp" method="post" class="form-container">
            <table>
                <tr>
                    <th>Mark</th>
                    <th>IdMelodie</th>
                    <th>Titlu</th>
                    <th>Gen</th>
                    <th>An Lansare</th>
                </tr>
                <%
                    jb.connect();
                    ResultSet rs = jb.vedeTabela("melodii");
                    while (rs.next()) {
                        long x = rs.getLong("id_melodie");
                %>
                <tr>
                    <td><input type="checkbox" name="primarykey" value="<%= x %>" /></td>
                    <td><%= x %></td>
                    <td><%= rs.getString("titlu") %></td>
                    <td><%= rs.getString("gen") %></td>
                    <td><%= rs.getInt("an_lansare") %></td>
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
