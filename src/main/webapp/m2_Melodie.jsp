<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tabela Melodie</title>
        <link rel="stylesheet" type="text/css" href="style.css">
    </head>
    <jsp:useBean id="jb" scope="session" class="db.JavaBean" />
    <jsp:setProperty name="jb" property="*" />
    <body>
        <br/>
        <p align="center"><a href="tabela_Melodii.jsp" class="button"><b>Revino la tabelă.</b></a> </p>
        <%
            jb.connect();
            int aux = java.lang.Integer.parseInt(request.getParameter("id_melodie"));
            String Titlu = request.getParameter("titlu");
            String Gen = request.getParameter("gen");
            String An_lansare = request.getParameter("an_lansare");

            String[] valori = {Titlu, Gen, An_lansare};
            String[] campuri = {"titlu", "gen", "an_lansare"};
            jb.modificaTabela("melodii", "id_melodie", aux, campuri, valori);
            jb.disconnect();
        %>
        <h1 align="center">Modificarile au fost efectuate cu <span style="color:#22ba4a">succes</span>!</h1>
        <p align="center">
            <a href="index.html" class="button"><b>Home</b></a>
            <br/>
    </body>
</html>