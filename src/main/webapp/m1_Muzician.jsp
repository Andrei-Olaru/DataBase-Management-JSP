<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.lang.*, java.math.*, db.*, java.sql.*, java.util.*, java.sql.Date" %>
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
        <h1 align="center">Tabela Muzician</h1>
        <br/>
        <p align="center">
            <a href="nou_Muzician.jsp" class="button"><b>Adaugă un nou muzician</b></a>
        </p>
        <%
            jb.connect();
            int aux = Integer.parseInt(request.getParameter("primarykey"));
            ResultSet rs = jb.intoarceLinieDupaId("muzicieni", "id_muzician", aux);
            rs.first();
            String Nume = rs.getString("nume");
            String Prenume = rs.getString("prenume");
            Date Data_nasterii = rs.getDate("data_nasterii");
            String Instrument = rs.getString("instrument");
            rs.close();
            jb.disconnect();
        %>
        <form action="m2_Muzician.jsp" method="post" class="form-container">
            <table>
                <tr>
                    <td align="right"><label for="id_muzician">ID Muzician:</label></td>
                    <td><input type="text" name="id_muzician" id="id_muzician" size="30" value="<%= aux %>" readonly /></td>
                </tr>
                <tr>
                    <td align="right"><label for="nume">Nume:</label></td>
                    <td><input type="text" name="nume" id="nume" size="30" value="<%= Nume %>" /></td>
                </tr>
                <tr>
                    <td align="right"><label for="prenume">Prenume:</label></td>
                    <td><input type="text" name="prenume" id="prenume" size="30" value="<%= Prenume %>" /></td>
                </tr>
                <tr>
                    <td align="right"><label for="data_nasterii">Data Nașterii:</label></td>
                    <td><input type="date" name="data_nasterii" id="data_nasterii" size="30" value="<%= Data_nasterii %>" /></td>
                </tr>
                <tr>
                    <td align="right"><label for="instrument">Instrument:</label></td>
                    <td><input type="text" name="instrument" id="instrument" size="30" value="<%= Instrument %>" /></td>
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
