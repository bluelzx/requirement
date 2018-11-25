package rtx;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AccessConnection {

	/**
	 * @param args
	 * @throws SQLException 
	 * @throws ClassNotFoundException 
	 */
	public static void main(String[] args) throws SQLException, ClassNotFoundException {
		// TODO Auto-generated method stub
		
		Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
		Connection connectin = DriverManager.getConnection("jdbc:odbc:rtx","","");
		PreparedStatement stmt = connectin.prepareStatement("delete from SYS_User where AccountState=1");
		stmt.execute();
		stmt.close();
		connectin.close();
	}

}
