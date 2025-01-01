<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java"
    import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Tabela Album</title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<jsp:useBean id="jb" scope="session" class="db.JavaBean" />
<jsp:setProperty name="jb" property="*" />
<body>
    <h1>Tabela Album</h1>
    <p>
        <a href="nou_Album.jsp" class="button">Adaugă un nou album</a> 
        <a href="modifica_Album.jsp" class="button">Modifică Album</a>
    </p>
    <form action="sterge_Album.jsp" method="post">
        <table>
            <tr>
                <th>Mark</th>
                <th>Id Album</th>
                <th>Nume Muzician</th>
                <th>Prenume Muzician</th>
                <th>Instrument</th>
                <th>Titlu Melodie</th>
                <th>Gen Melodie</th>
                <th>An Lansare Melodie</th>
                <th>Rol Muzician</th>
            </tr>
            <%
                jb.connect();
                ResultSet rs = jb.vedeTabelaAlbum();
                while (rs.next()) {
                    long idAlbum = rs.getLong("idalbum");
            %>
            <tr>
                <td><input type="checkbox" name="primarykey" value="<%= idAlbum %>" /></td>
                <td><%= idAlbum %></td>
                <td><%= rs.getString("nume_muzician") %></td>
                <td><%= rs.getString("prenume_muzician") %></td>
                <td><%= rs.getString("instrument") %></td>
                <td><%= rs.getString("titlu_melodie") %></td>
                <td><%= rs.getString("gen_melodie") %></td>
                <td><%= rs.getInt("an_lansare_melodie") %></td>
                <td><%= rs.getString("rol_muzician") %></td>
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
