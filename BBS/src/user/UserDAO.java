package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() {	//������, ������ mysql�� ������ �ϰ����ִ� �κ�
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS";	//jdbc����̹��� �̿��Ͽ� mysql�� �ּ� localhost, ��Ʈ 3306, �����ͺ��̽� BBS�� ����
			String dbID = "root";
			String dbPassword = "nlcfjb";
			Class.forName("com.mysql.jdbc.Driver");	//jdbc����̹�(�����ͺ��̽��� �����ϰ� �� �� �ֵ��� �Ű�ü ������ ���ִ� ������ ���̺귯��)�� ã��
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			//�����ͺ��̽��� ����. �ּ�, ���̵�, �о����� ����. 
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	
	public int login(String userID, String userPassword) {	//������ �α����� �� �� �ְ����ִ� �Լ�. 
	
		String SQL = "SELECT userPassword from user where userID=?";
		//���� ���� �������̵�� �����ͺ��̽� �������̺��� �о����带 �������� SQL
		try {
			pstmt = conn.prepareStatement(SQL);	//�����ͺ��̽��� �̸� �غ��س��� SQL�ְ� ���ڸ� ���޹���
			pstmt.setString(1, userID);	//SQL ���� �ش� ?�κп� userID�� ����, 1���� �ش� ����� ������ userPassword ���� �޴´�. 
			rs = pstmt.executeQuery();	//������ ����� �־��ش�. 
			if(rs.next()) {	//������� �����Ѵٸ�, 
				if(rs.getString(1).equals(userPassword)) {	//���޹��� �н����� ����, �����ͺ��̽��κ��� ���� �н����� ���� ���ٸ�
					return 1;	//�α��� ����
				}
				else
					return 0;	//��й�ȣ ����ġ
			}
			return -1; //���̵� ����
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -2;//�����ͺ��̽� ����
	}
	
	public int join(User user) {
		String SQL="insert into user values(?,?,?,?,?)";
		try {
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			return pstmt.executeUpdate();	//���������� �۵��ߴٸ� ���� ������ ������ ������. 
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	//���� ����
	}
	
	
}
