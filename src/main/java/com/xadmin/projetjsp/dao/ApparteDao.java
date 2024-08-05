package com.xadmin.projetjsp.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.eclipse.jdt.internal.compiler.ast.Statement;

import com.xadmin.projetjsp.bean.Apparte;

public class ApparteDao {
	
	private String jdbcURL = "jdbc:mysql://localhost:3306/projetjsp?useSSL=false&serverTimezone=UTC";
	private String jdbcUsername = "root";
	private String jdbcPassword = "";
	private String jdbcDriver = "com.mysql.cj.jdbc.Driver";
	
	private static final String INSERT_APP_SQL = "INSERT INTO appartement (numApp, design, loyer) VALUES (?,?,?)";
	private static final String SELECT_ALL_SQL = "SELECT * FROM appartement";
	private static final String SELECT_APP_ID = "SELECT * FROM appartement where id = ?;";
	private static final String DELETE_APP_SQL = "DELETE FROM appartement WHERE id = ?;";
	private static final String UPTADE_APP_SQL = "UPDATE appartement SET numApp = ? , design = ? , loyer = ? WHERE id = ?;";
	
	public ApparteDao() {		
	}
	
	protected Connection getConnection() {
		Connection connection = null;
		try {
			Class.forName(jdbcDriver);
			connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
		} catch(SQLException e) {
			e.printStackTrace();
		} catch(ClassNotFoundException e) {
			e.printStackTrace();
		}
		return connection;
	}



//INSERT APP
	public void insertApparte(Apparte Apparte) throws SQLException {
		System.out.println(INSERT_APP_SQL);
		try (Connection connection = getConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(INSERT_APP_SQL)) {
			preparedStatement.setInt(1, Apparte.getNumApp());
			preparedStatement.setString(2, Apparte.getDesign());
			preparedStatement.setFloat(3, Apparte.getLoyer());
			System.out.println(preparedStatement);
			preparedStatement.executeUpdate();
		} catch (SQLException e) {
			printSQLException(e);
		}
	}
	
	//SELECT APP BY ID
	public Apparte selectApparte(int id) throws SQLException {
		Apparte apparte = null;
		try (Connection connection = getConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(SELECT_APP_ID)){
			preparedStatement.setInt(1, id);
			System.out.println(preparedStatement);
			ResultSet rs = preparedStatement.executeQuery();
			
			while(rs.next()) {
				int numApp = rs.getInt("numApp");
				String design = rs.getString("design");
				float loyer = rs.getFloat("loyer");
				apparte = new Apparte(id,numApp,design,loyer);
			}
		} catch (SQLException e) {
			printSQLException(e);
		}
		return apparte;
	}


//SELECT * APP
	public List<Apparte> selectAllApparte() {
		List<Apparte> apps = new ArrayList<>();
		try (Connection connection = getConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_SQL);) {
			System.out.println(preparedStatement);
			ResultSet rs = preparedStatement.executeQuery();
			
			while(rs.next()) {
				int id = rs.getInt("id");
				int numApp = rs.getInt("numApp");
				String design = rs.getString("design");
				float loyer = rs.getFloat("loyer");
				apps.add(new Apparte(id,numApp,design,loyer));
			}
		} catch (SQLException e) {
			printSQLException(e);
		}
		return apps;
	}

//UPDATE APP
	public boolean updateApparte(Apparte Apparte) throws SQLException {
		boolean rowUpdated;
		try (Connection connection = getConnection();
				PreparedStatement statement = connection.prepareStatement(UPTADE_APP_SQL);) {
			System.out.println("Updated Apparte:" + statement);
			statement.setInt(1, Apparte.getNumApp());
			statement.setString(2, Apparte.getDesign());
			statement.setFloat(3, Apparte.getLoyer());
			statement.setInt(4, Apparte.getId());
			
			rowUpdated = statement.executeUpdate() > 0;
		}
		return rowUpdated;
	}

//DELETE APP
	public boolean deleteApparte(int id) throws SQLException {
		boolean rowDeleted;
		try (Connection connection = getConnection();
				PreparedStatement statement = connection.prepareStatement(DELETE_APP_SQL);) {
			statement.setInt(1, id);
			
			rowDeleted = statement.executeUpdate() > 0;
		}
		return rowDeleted;
	}
	
	

	private void printSQLException(SQLException ex) {
		for (Throwable e : ex) {
			if(e instanceof SQLException) {
				e.printStackTrace(System.err);
				System.err.println("SQLState: " + ((SQLException) e).getSQLState());
				System.err.println("Error Code: " + ((SQLException) e).getErrorCode());
				System.err.println("Message: " +  e.getMessage());
				Throwable t = ex.getCause();
				while (t != null) {
					System.out.println("Cause :" + t);
					t = t.getCause();
				}
			}
		}
		
	}



}
