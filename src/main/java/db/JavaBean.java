package db;

import java.sql.*;

public class JavaBean {

    String error;
    Connection con;

    public JavaBean() {
    }

    public void connect() throws ClassNotFoundException, SQLException, Exception {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/muzicadb?useSSL=false", "root", "andrey11");
        } catch (ClassNotFoundException cnfe) {
            error = "ClassNotFoundException: Nu s-a găsit driverul bazei de date.";
            throw new ClassNotFoundException(error);
        } catch (SQLException sqle) {
            error = "SQLException: Nu se poate conecta la baza de date.";
            throw new SQLException(error);
        } catch (Exception e) {
            error = "Exception: O excepție neprevăzută a apărut.";
            throw new Exception(error);
        }
    }

    public void disconnect() throws SQLException {
        if (con != null) {
            con.close();
        }
    }

    // Adaugă o melodie
    public void adaugaMelodie(String titlu, String gen, int an_lansare) throws SQLException {
        if (con != null) {
            String query = "INSERT INTO melodii (titlu, gen, an_lansare) VALUES (?, ?, ?)";
            try (PreparedStatement stmt = con.prepareStatement(query)) {
                stmt.setString(1, titlu);
                stmt.setString(2, gen);
                stmt.setInt(3, an_lansare);
                stmt.executeUpdate();
            }
        }
    }

    // Adaugă un muzician
    public void adaugaMuzician(String nume, String prenume, Date data_nasterii, String instrument) throws SQLException {
        if (con != null) {
            String query = "INSERT INTO muzicieni (nume, prenume, data_nasterii, instrument) VALUES (?, ?, ?, ?)";
            try (PreparedStatement stmt = con.prepareStatement(query)) {
                stmt.setString(1, nume);
                stmt.setString(2, prenume);
                stmt.setDate(3, data_nasterii);
                stmt.setString(4, instrument);
                stmt.executeUpdate();
            }
        }
    }

    // Adaugă un album
    public void adaugaAlbum(long idMuzician, long idMelodie, String rol_muzician) throws SQLException {
        if (con != null) {
            String query = "INSERT INTO album (id_muzician, id_melodie, rol_muzician) VALUES (?, ?, ?)";
            try (PreparedStatement stmt = con.prepareStatement(query)) {
                stmt.setLong(1, idMuzician);
                stmt.setLong(2, idMelodie);
                stmt.setString(3, rol_muzician);
                stmt.executeUpdate();
            }
        }
    }

    // Vizualizare date dintr-o tabelă
    public ResultSet vedeTabela(String tabel) throws SQLException {
        if (con != null) {
            String query = "SELECT * FROM " + tabel;
            Statement stmt = con.createStatement();
            return stmt.executeQuery(query);
        }
        return null;
    }
    
    // Vizualizare date din tabela album cu INNER JOIN
    public ResultSet vedeTabelaAlbum() throws SQLException {
        if (con != null) {
            String query = """
                SELECT 
                    a.idalbum,
                    m.nume AS nume_muzician,
                    m.prenume AS prenume_muzician,
                    m.instrument,
                    me.titlu AS titlu_melodie,
                    me.gen AS gen_melodie,
                    me.an_lansare AS an_lansare_melodie,
                    a.rol_muzician
                FROM 
                    album a
                INNER JOIN muzicieni m ON a.id_muzician = m.id_muzician
                INNER JOIN melodii me ON a.id_melodie = me.id_melodie
            """;
            Statement stmt = con.createStatement();
            return stmt.executeQuery(query);
        }
        return null;
    }
    
    // Obține lista de muzicieni
    public ResultSet obtineMuzicieni() throws SQLException {
        if (con != null) {
            String query = "SELECT id_muzician, nume, prenume, instrument FROM muzicieni";
            Statement stmt = con.createStatement();
            return stmt.executeQuery(query);
        }
        return null;
    }

    // Obține lista de melodii
    public ResultSet obtineMelodii() throws SQLException {
        if (con != null) {
            String query = "SELECT id_melodie, titlu, gen, an_lansare FROM melodii";
            Statement stmt = con.createStatement();
            return stmt.executeQuery(query);
        }
        return null;
    }
    


    // Șterge date dintr-o tabelă după ID
    public void stergeDinTabela(String tabel, String idColoana, long id) throws SQLException {
        if (con != null) {
            String query = "DELETE FROM " + tabel + " WHERE " + idColoana + " = ?";
            try (PreparedStatement stmt = con.prepareStatement(query)) {
                stmt.setLong(1, id);
                stmt.executeUpdate();
            }
        }
    }
    
 // Modifică date în tabela
    public void modificaTabela(String tabela, String IDTabela, int ID, String[] campuri, String[] valori) throws SQLException, Exception {
		String update = "update " + tabela + " set ";
		String temp = "";
		if (con != null) {
			try {
				for (int i = 0; i < campuri.length; i++) {
					if (i != (campuri.length - 1)) {
						temp = temp + campuri[i] + "='" + valori[i] + "', ";
					} else {
						temp = temp + campuri[i] + "='" + valori[i] + "' where " + IDTabela + " = '" + ID + "';";
					}
				}
				update = update + temp;
				// create a prepared SQL statement
				Statement stmt;
				stmt = con.createStatement();
				stmt.executeUpdate(update);
			} catch (SQLException sqle) {
				error = "ExceptieSQL: Reactualizare nereusita; este posibil sa existe duplicate.";
				throw new SQLException(error);
			}
		} else {
			error = "Exceptie: Conexiunea cu baza de date a fost pierduta.";
			throw new Exception(error);
		}
	} // end of modificaTabela()
    
    
    public ResultSet intoarceLinie(String tabela, int ID) throws SQLException, Exception {
		ResultSet rs = null;
		try {
			// Execute query
			String queryString = ("SELECT * FROM " + tabela + " where id_muzician=" + ID + ";");
			Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(queryString); //sql exception
		} catch (SQLException sqle) {
			error = "SQLException: Interogarea nu a fost posibila.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "A aparut o exceptie in timp ce se extrageau datele.";
			throw new Exception(error);
		}
		return rs;
	} // end of intoarceLinie()

	public ResultSet intoarceLinieDupaId(String tabela, String denumireId, int ID) throws SQLException, Exception {
		ResultSet rs = null;
		try {
			// Execute query
			String queryString = ("SELECT * FROM " + tabela + " where " + denumireId + "=" + ID + ";");
			Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(queryString); //sql exception
		} catch (SQLException sqle) {
			error = "SQLException: Interogarea nu a fost posibila.";
			throw new SQLException(error);
		} catch (Exception e) {
			error = "A aparut o exceptie in timp ce se extrageau datele.";
			throw new Exception(error);
		}
		return rs;
	} // end of intoarceLinieDupaId()

	public ResultSet intoarceAlbumId(int ID) throws SQLException, Exception {
	    ResultSet rs = null;
	    try {
	    	String queryString = "SELECT " +
	    		    "a.idalbum, " +
	    		    "a.id_muzician, " +
	    		    "a.id_melodie, " +
	    		    "m.nume AS nume_muzician, " +
	    		    "m.prenume AS prenume_muzician, " +
	    		    "m.instrument, " +
	    		    "me.titlu AS titlu_melodie, " + 
	    		    "me.gen AS gen_melodie, " + 
	    		    "me.an_lansare AS an_lansare_melodie, " +
	    		    "a.rol_muzician " +
	    		    "FROM album a " +
	    		    "INNER JOIN muzicieni m ON a.id_muzician = m.id_muzician " +
	    		    "INNER JOIN melodii me ON a.id_melodie = me.id_melodie " +
	    		    "WHERE a.idalbum = ?";

	        // Folosirea PreparedStatement pentru siguranță și parametrizare
	        PreparedStatement pstmt = con.prepareStatement(queryString, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
	        pstmt.setInt(1, ID); // Transmiterea parametrului ID
	        rs = pstmt.executeQuery();
	    } catch (SQLException sqle) {
	        error = "SQLException: Interogarea nu a fost posibila. Detalii: " + sqle.getMessage();
	        throw new SQLException(error);
	    } catch (Exception e) {
	        error = "A aparut o exceptie in timp ce se extrageau datele. Detalii: " + e.getMessage();
	        throw new Exception(error);
	    }
	    return rs;
	}



    
    
}   
