<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Șterge Album</title>
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
                    jb.stergeDinTabela("album", "idalbum", Long.parseLong(id));
                }
                jb.disconnect();
        %>
        <p>Albumul / albumele selectate au fost șterse.</p><%
            } else {
        %>
        <p>Nu a fost selectat niciun album.</p><%
            }
        %>
        <br/>
        <a href="tabela_Album.jsp" class="button"><b>Înapoi la tabelă</b></a>
        <br/>
    </body>
</html>
