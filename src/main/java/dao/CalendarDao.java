package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import dto.BbsDto;
import dto.CalendarDto;

public class CalendarDao {

	private static CalendarDao dao = null;

	public CalendarDao() {
		
		DBConnection.initConnection();
	}

	public static CalendarDao getInstance() {

		if (dao == null) {
			dao = new CalendarDao();
		}
		return dao;

	}

	public List<CalendarDto> getCalendarList(String id, String yyyyMM) {

		String sql = "select seq, id, title, content, rdate, wdate " + "   from"
				+ "	     (select row_number()over(partition by substr(rdate, 1, 8) order by rdate asc) as rnum, "
				+ "		        seq, id, title, content, rdate, wdate " + "	     from calendar"
				+ "	      where id= ? and substr(rdate, 1, 6)=?) a " + "     where rnum between 1 and 5 ";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		List<CalendarDto> list = new ArrayList<CalendarDto>();

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 getCalendarList success");
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setString(2, yyyyMM);
			System.out.println("2/3 getCalendarList success");
			
			rs = psmt.executeQuery();
			System.out.println("3/3 getCalendarList success");
			
			while(rs.next()) {
				
				CalendarDto dto = new CalendarDto(rs.getInt(1), rs.getString(2),
						rs.getString(3), rs.getString(4), rs.getString(5),rs.getString(6));
				
				list.add(dto);
			}
			
			
		} catch (SQLException e) {
			System.out.println("getCalendarList fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		return list;
	}
	
	public boolean addCalendar(CalendarDto dto) {
		
		String sql =  " insert into calendar(id, title, content, rdate, wdate) "
					+ " values(?, ?, ?, ?, now()) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 addCalendar success");
			psmt = conn.prepareStatement(sql);
			System.out.println("2/3 addCalendar success");
			
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getRdate());
			
			count = psmt.executeUpdate();
			System.out.println("3/3 addCalendar success");
			
		} catch (SQLException e) {
			System.out.println("addCalendar fail");
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}
				
		return count>0?true:false;
	}
	
	public CalendarDto getdetail(int seq) {
		
		String sql = " select * from calendar where seq = ?";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		int count = 0;
		
		CalendarDto dto = null;

		
		try {
			conn = DBConnection.getConnection();

			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			rs = psmt.executeQuery();

			if (rs.next()) {
				int seqs = rs.getInt(1);
				String id = rs.getString(2);
				String title = rs.getString(3);
				String content = rs.getString(4);
				String rdate = rs.getString(5);
				String wdate = rs.getString(6);
				
				dto = new CalendarDto(seqs, id, title, content, rdate, wdate);

			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		
		return dto;
		
	}
	
	public boolean updateCal(int seq, String title, String content, String rdate) {

		String sql = "  update calendar set  title= ?, content= ?, rdate= ? where seq= ? ";

		Connection conn = null; // java와 db사이의 연결
		PreparedStatement psmt = null; // 객체를 ?가 포함된 sql문으로 생성하고 이후 ?자리만 바꿔가며 데이터베이스 처리

		int count = 0;
		try {
			conn = DBConnection.getConnection();

			psmt = conn.prepareStatement(sql);

			psmt.setNString(1, title);
			psmt.setNString(2, content);
			psmt.setNString(3, rdate);
			psmt.setInt(4, seq);

			count = psmt.executeUpdate(); // executeUpdate반환값 : 처리된 레코드(row)의 개수

		} catch (SQLException e) {
			System.out.println(" getId fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}

		return count > 0 ? true : false;

	}
	
	public boolean deleteCal(int seq) {

		String sql = "  delete from calendar where seq= ?";

		Connection conn = null; // java와 db사이의 연결
		PreparedStatement psmt = null; // 객체를 ?가 포함된 sql문으로 생성하고 이후 ?자리만 바꿔가며 데이터베이스 처리

		int count = 0;

		try {
			conn = DBConnection.getConnection();

			psmt = conn.prepareStatement(sql);

			psmt.setInt(1, seq);

			count = psmt.executeUpdate();

		} catch (SQLException e) {
			System.out.println(" getId fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}

		return count > 0 ? true : false;
	}
	
	
	public List<CalendarDto> getCallist(String date, String id){
		
		String sql = "select * from calendar where substr(rdate, 1, 8) = ? and id = ? ";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		List<CalendarDto> list = new ArrayList<CalendarDto>();
		
		try {
			conn = DBConnection.getConnection();

			psmt = conn.prepareStatement(sql);
			psmt.setString(1, date);
			psmt.setString(2, id);
			
			rs = psmt.executeQuery();
			while (rs.next()) {

				CalendarDto dto = new CalendarDto(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5),
						rs.getString(6));

				list.add(dto);
				System.out.println("4/4 getCallist success");

			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		return list;
	}
	

}
