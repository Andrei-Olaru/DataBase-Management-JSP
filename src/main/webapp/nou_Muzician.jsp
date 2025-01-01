<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<%@ page import="java.sql.Date" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Adaugă Muzician</title>
        <link rel="stylesheet" type="text/css" href="style.css">
    </head>
    <jsp:useBean id="jb" scope="session" class="db.JavaBean" />
    <jsp:setProperty name="jb" property="*" />
    <body>
        <%
            String nume = request.getParameter("nume");
            String prenume = request.getParameter("prenume");
            String data_nasteriiStr = request.getParameter("data_nasterii");
            String instrument = request.getParameter("instrument");
            if (nume != null && prenume != null && data_nasteriiStr != null && instrument != null) {
                Date data_nasterii = Date.valueOf(data_nasteriiStr);
                jb.connect();
                jb.adaugaMuzician(nume, prenume, data_nasterii, instrument);
                jb.disconnect();
        %>
        <p>Datele au fost adăugate cu succes.</p>
        <%
            } else {
        %>
        <h1>Adaugă un nou muzician</h1>
        <form action="nou_Muzician.jsp" method="post" class="form-container">
            <table>
                <tr>
                    <td align="right"><label for="nume">Nume:</label></td>
                    <td><input type="text" name="nume" id="nume" size="40" required /></td>
                </tr>
                <tr>
                    <td align="right"><label for="prenume">Prenume:</label></td>
                    <td><input type="text" name="prenume" id="prenume" size="30" required /></td>
                </tr>
                <tr>
                    <td align="right"><label for="data_nasterii">Data Nașterii:</label></td>
                    <td><input type="date" name="data_nasterii" id="data_nasterii" required /></td>
                </tr>
                <tr>
                    <td align="right"><label for="instrument">Instrument:</label></td>
                    <td><input type="text" name="instrument" id="instrument" size="30" required /></td>
                </tr>
            </table>
            <button type="submit" class="button">Adaugă Muzicianul</button>
        </form>
        <%
            }
        %>
        <br />
        <a href="tabela_Muzicieni.jsp" class="button">Înapoi la tabelă</a>
    </body>
</html>
