<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.lang.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Modifică Album</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
    <h1>Modifică Album</h1>
    <jsp:useBean id="jb" scope="session" class="db.JavaBean" />
    <jsp:setProperty name="jb" property="*" />

    <%
        jb.connect();
        int aux = Integer.parseInt(request.getParameter("primarykey"));
        ResultSet rs = jb.intoarceAlbumId(aux);
        rs.first();
        int id1 = rs.getInt("id_muzician");
        int id2 = rs.getInt("id_melodie");
        String rolMuzician = rs.getString("rol_muzician");

        ResultSet rs1 = jb.vedeTabela("muzicieni");
        ResultSet rs2 = jb.vedeTabela("melodii");
    %>

    <form action="m2_Album.jsp" method="post" class="form-container">
        <table>
            <tr>
                <td><label for="idalbum">Id Album:</label></td>
                <td><input type="text" name="idalbum" id="idalbum" value="<%= aux %>" readonly /></td>
            </tr>
            <tr>
                <td><label for="id_muzician">Muzician:</label></td>
                <td>
                    <select name="id_muzician" id="id_muzician">
                        <%
                            while (rs1.next()) {
                                int id_muzician = rs1.getInt("id_muzician");
                                String nume = rs1.getString("nume");
                                String prenume = rs1.getString("prenume");
                                String instrument = rs1.getString("instrument");
                        %>
                        <option value="<%= id_muzician %>" <%= (id_muzician == id1) ? "selected" : "" %>>
                            <%= id_muzician %> - <%= nume %> <%= prenume %> (Instrument: <%= instrument %>)
                        </option>
                        <% } %>
                    </select>
                </td>
            </tr>
            <tr>
                <td><label for="id_melodie">Melodie:</label></td>
                <td>
                    <select name="id_melodie" id="id_melodie">
                        <%
                            while (rs2.next()) {
                                int id_melodie = rs2.getInt("id_melodie");
                                String titlu = rs2.getString("titlu");
                                String gen = rs2.getString("gen");
                                int anLansare = rs2.getInt("an_lansare");
                        %>
                        <option value="<%= id_melodie %>" <%= (id_melodie == id2) ? "selected" : "" %>>
                            <%= id_melodie %> - <%= titlu %> (Gen: <%= gen %>, An: <%= anLansare %>)
                        </option>
                        <% } %>
                    </select>
                </td>
            </tr>
            <tr>
                <td><label for="rol_muzician">Rol Muzician:</label></td>
                <td><input type="text" name="rol_muzician" id="rol_muzician" value="<%= rolMuzician %>" /></td>
            </tr>
        </table>
        <input type="submit" value="Modifică Albumul" class="button" />
    </form>

    <div style="text-align: center;">
        <a href="tabela_Album.jsp" class="button">Înapoi la tabelă</a>
    </div>

    <%
        rs.close();
        rs1.close();
        rs2.close();
        jb.disconnect();
    %>
</body>
</html>
