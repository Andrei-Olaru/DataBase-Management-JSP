<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.lang.*, java.math.*, db.*, java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tabela Melodie</title>
        <link rel="stylesheet" type="text/css" href="style.css">
    </head>
    <jsp:useBean id="jb" scope="session" class="db.JavaBean" />
    <jsp:setProperty name="jb" property="*" />
    <body>
        <h1 align="center">Tabela Melodie</h1>
        <br/>
        <p align="center">
            <a href="nou_Melodie.jsp" class="button"><b>Adaugă o nouă melodie</b></a>
        </p>
        <%
            jb.connect();
            int aux = Integer.parseInt(request.getParameter("primarykey"));
            ResultSet rs = jb.intoarceLinieDupaId("melodii", "id_melodie", aux);
            rs.first();
            String Titlu = rs.getString("titlu");
            String Gen = rs.getString("gen");
            String An_lansare = rs.getString("an_lansare");
            rs.close();
            jb.disconnect();
        %>
        <form action="m2_Melodie.jsp" method="post" class="form-container">
            <table>
                <tr>
                    <td align="right"><label for="id_melodie">ID Melodie:</label></td>
                    <td><input type="text" name="id_melodie" id="id_melodie" size="30" value="<%= aux %>" readonly /></td>
                </tr>
                <tr>
                    <td align="right"><label for="titlu">Titlu:</label></td>
                    <td><input type="text" name="titlu" id="titlu" size="30" value="<%= Titlu %>" /></td>
                </tr>
                <tr>
                    <td align="right"><label for="gen">Gen:</label></td>
                    <td><input type="text" name="gen" id="gen" size="30" value="<%= Gen %>" /></td>
                </tr>
                <tr>
                    <td align="right"><label for="an_lansare">An Lansare:</label></td>
                    <td><input type="number" name="an_lansare" id="an_lansare" size="30" value="<%= An_lansare %>" /></td>
                </tr>
            </table>
            <p align="center">
                <input type="submit" value="Modifică linia" class="button" />
            </p>
        </form>
        <p align="center">
            <a href="index.html" class="button"><b>Home</b></a>
        </p>
    </body>
</html>
