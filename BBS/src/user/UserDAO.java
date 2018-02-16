package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() {	//생성자, 실제로 mysql에 접속을 하게해주는 부분
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS";	//jdbc드라이버를 이용하여 mysql에 주소 localhost, 포트 3306, 데이터베이스 BBS에 접속
			String dbID = "root";
			String dbPassword = "nlcfjb";
			Class.forName("com.mysql.jdbc.Driver");	//jdbc드라이버(데이터베이스에 연결하게 할 수 있도록 매개체 역할을 해주는 일종의 라이브러리)를 찾기
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			//데이터베이스에 연결. 주소, 아이디, 패쓰워드 전달. 
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	
	public int login(String userID, String userPassword) {	//실제로 로그인을 할 수 있게해주는 함수. 
	
		String SQL = "SELECT userPassword from user where userID=?";
		//전달 받은 유저아이디로 데이터베이스 유저테이블에서 패쓰워드를 가져오는 SQL
		try {
			pstmt = conn.prepareStatement(SQL);	//데이터베이스에 미리 준비해놓은 SQL주고 인자를 전달받음
			pstmt.setString(1, userID);	//SQL 문의 해당 ?부분에 userID를 전달, 1에는 해당 결과로 들어오는 userPassword 값을 받는다. 
			rs = pstmt.executeQuery();	//실행한 결과를 넣어준다. 
			if(rs.next()) {	//결과값이 존재한다면, 
				if(rs.getString(1).equals(userPassword)) {	//전달받은 패스워드 값과, 데이터베이스로부터 받은 패스워드 값이 같다면
					return 1;	//로그인 성공
				}
				else
					return 0;	//비밀번호 불일치
			}
			return -1; //아이디가 없음
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -2;//데이터베이스 오류
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
			return pstmt.executeUpdate();	//정상적으로 작동했다면 값이 무조건 나오게 되있음. 
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	//가입 실패
	}
	
	
}
