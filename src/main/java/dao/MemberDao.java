package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import db.DBClose;
import db.DBConnection;
import dto.MemberDto;

public class MemberDao {

	private static MemberDao dao = null;

	private MemberDao() { // 생성자를 private으로 선언해 다른 곳에서 생성하지 못하도록 만들고 getinstance()메소드르 통해 받아서 사용하도록 한다.

		DBConnection.initConnection();
	}

	public static MemberDao getInstance() {

		if (dao == null) {
			dao = new MemberDao(); // 한번의 new를 통해 객체를 생성하면 메모리 낭비 방지
		}
		return dao;
	}

	public boolean getId(String id) {

		String sql = " select id " + " from member " + " where id = ?";

		Connection conn = null; //java와 db사이의 연결
		PreparedStatement psmt = null; // 객체를 ?가 포함된 sql문으로 생성하고 이후 ?자리만 바꿔가며 데이터베이스 처리
		ResultSet rs = null; // executeQuery()메소드에서 실행된 select문의 결과값을 가지고 있는 객체

		boolean findId = false;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 getId Success");
			psmt = conn.prepareStatement(sql);

			psmt.setString(1, id);
			System.out.println("2/3 getId Success");

			rs = psmt.executeQuery(); // 쿼리문의 결과값을 rs에 담음
			System.out.println("3/3 getId Success");

			if (rs.next()) { // data 가 있다

				findId = true;
			}

		} catch (SQLException e) {
			System.out.println(" getId fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}

		return findId;
	}

	public boolean addMember(MemberDto dto) {

		String sql = " insert into member(id, pwd, name, email, auth)" + " values(?,?,?,?, 3) ";

		Connection conn = null;
		PreparedStatement psmt = null;

		int count = 0;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 addMember Success");
			psmt = conn.prepareStatement(sql);
			
			psmt.setNString(1, dto.getId());
			psmt.setNString(2, dto.getPwd());
			psmt.setNString(3, dto.getName());
			psmt.setNString(4, dto.getEmail());
			
			count = psmt.executeUpdate(); //메서드의 반환 값은 sql문 실행에 영향을 받는 행 수를 반환 즉 개행 한줄
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}
		return count>0?true:false;
	}
	
	public MemberDto login(String id, String pwd) {
		
		String sql = " select id , name, email, auth"
				+ " from member"
				+" where id = ? and pwd = ?";
		
		Connection conn = null;
		System.out.println("1/3 login Success");
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		MemberDto mem = null;
		
		try {
			conn = DBConnection.getConnection();
			psmt = conn.prepareStatement(sql);
			
			psmt.setString(1, id);
			psmt.setString(2, pwd);
			System.out.println("2/3 login Success");
			
			rs = psmt.executeQuery();
			System.out.println("3/3 login Success");
			
			if (rs.next()) {
				
				String _id = rs.getString(1);
				String _name = rs.getString(2);
				String _email = rs.getString(3);
				int _auth = rs.getInt(4);
				
				mem = new MemberDto(_id, null, _name, _email, _auth);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		
		return mem;
	}
	
	
	
	
	
	
	
	
	
	
	
	

}
