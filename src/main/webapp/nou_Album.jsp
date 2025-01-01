<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Adaugă Album</title>
        <link rel="stylesheet" type="text/css" href="style.css">
    </head>
    <jsp:useBean id="jb" scope="session" class="db.JavaBean" />
    <jsp:setProperty name="jb" property="*" />
    <body>
        <%
            String idMuzicianStr = request.getParameter("id_muzician");
            String idMelodieStr = request.getParameter("id_melodie");
            String rolMuzician = request.getParameter("rol_muzician");

            if (idMuzicianStr != null && idMelodieStr != null && rolMuzician != null) {
                long idMuzician = Long.parseLong(idMuzicianStr);
                long idMelodie = Long.parseLong(idMelodieStr);

                jb.connect();
                jb.adaugaAlbum(idMuzician, idMelodie, rolMuzician);
                jb.disconnect();
        %>
        <p>Albumul a fost adăugat cu succes.</p>
        <%
            } else {
                jb.connect();
                ResultSet muzicieni = jb.obtineMuzicieni();
                ResultSet melodii = jb.obtineMelodii();
        %>
        <h1>Adaugă un nou album:</h1>
        <form action="nou_Album.jsp" method="post" class="form-container">
            <table>
                <tr>
                    <td align="right"><label for="id_muzician">Alegeți Muzicianul:</label></td>
                    <td>
                        <select name="id_muzician" id="id_muzician">
                            <% 
                                while (muzicieni.next()) { 
                                    long idMuzician = muzicieni.getLong("id_muzician");
                                    String nume = muzicieni.getString("nume");
                                    String prenume = muzicieni.getString("prenume");
                                    String instrument = muzicieni.getString("instrument");
                            %>
                            <option value="<%= idMuzician %>">
                                <%= idMuzician %> - <%= nume %> <%= prenume %> (Instrument: <%= instrument %>)
                            </option>
                            <% } %>
                        </select>
                    </td>
                </tr>
                <tr>
	                <td align="right"><label for="id_melodie">Alegeți Melodia:</label></td>
	                    <td>
	                    	<select name="id_melodie" id="id_melodie">
	                            <% 
	                                while (melodii.next()) { 
	                                    long idMelodie = melodii.getLong("id_melodie");
	                                    String titlu = melodii.getString("titlu");
	                                    String gen = melodii.getString("gen");
	                                    int an_lansare = melodii.getInt("an_lansare");
	                            %>
	                            <option value="<%= idMelodie %>">
	                                <%= idMelodie %> - <%= titlu %> <%= gen %> (an_lansare: <%= an_lansare %>)
	                            </option>
	                            <% } %>
	                        </select>
	                    </td>
                </tr>
                <tr>
                    <td align="right"><label for="rol_muzical">Rol Muzician:</label></td>
                    <td><input type="text" name="rol_muzician" id="rol_muzical" size="30" /></td>
                </tr>
            </table>
            <input type="submit" value="Adaugă Albumul" class="button"/>
        </form>
        <%
                muzicieni.close();
                jb.disconnect();
            }
        %>
        <br/>
        <a href="tabela_Album.jsp" class="button"><b>Înapoi la tabelă</b></a>
        <br/>
    </body>
</html>
