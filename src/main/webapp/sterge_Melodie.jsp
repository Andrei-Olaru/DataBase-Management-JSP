<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Șterge Melodie</title>
        <link rel="stylesheet" type="text/css" href="style.css">
    </head>
    <jsp:useBean id="jb" scope="session" class="db.JavaBean" />
    <jsp:setProperty name="jb" property="*" />
    <body>
        <%
            String[] ids = request.getParameterValues("primarykey");
            if (ids != null) {
                jb.connect();
                for (String id : ids) {
                    jb.stergeDinTabela("melodii", "id_melodie", Long.parseLong(id));
                }
                jb.disconnect();
        %>
        <p>Melodia / melodiile selectate au fost șterse.</p><%
            } else {
        %>
        <p>Nu a fost selectată nicio melodie.</p><%
            }
        %>
        <br/>
        <a href="tabela_Melodii.jsp" class="button"><b>Înapoi la tabelă</b></a>
        <br/>
    </body>
</html>
