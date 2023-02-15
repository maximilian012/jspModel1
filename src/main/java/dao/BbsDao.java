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

public class BbsDao {

	private static BbsDao dao = null;

	private BbsDao() {
		// inint 안해도됨
		DBConnection.initConnection();
	}

	public static BbsDao getInstance() {

		if (dao == null) {
			dao = new BbsDao();
		}
		return dao;
	}

	public List<BbsDto> getBbsList() {

		String sql = " select * from bbs" + " order by ref desc, step asc";

		Connection conn = null;

		PreparedStatement psmt = null;
		ResultSet rs = null;

		List<BbsDto> list = new ArrayList<BbsDto>();

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 getDbsList success");

			psmt = conn.prepareStatement(sql);

			rs = psmt.executeQuery();

			while (rs.next()) {

				BbsDto dto = new BbsDto(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getInt(4), rs.getInt(5),
						rs.getString(6), rs.getString(7), rs.getString(8), rs.getInt(9), rs.getInt(10));

				list.add(dto);
				System.out.println("4/4 getDbsList success");

			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("getDbsList fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}

		return list;
	}

	public List<BbsDto> getBbsSearchList(String choice, String search) {

		String sql = " select * from bbs";

		String searchSql = "";
		if (choice.equals("title")) {

			searchSql = " where title like '%" + search + "%'"; // 컬럼명이 title인것중에서 검색한 것을 like로 해서 sql문에 붙인다

		} else if (choice.equals("content")) {

			searchSql = " where content like '%" + search + "%'";

		} else if (choice.equals("writer")) {

			searchSql = " where id='" + search + "'";

		}
		sql += searchSql;

		sql += " order by ref desc, step asc";

		Connection conn = null;

		PreparedStatement psmt = null;
		ResultSet rs = null;

		List<BbsDto> list = new ArrayList<BbsDto>();

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 getDbsList success");

			psmt = conn.prepareStatement(sql);

			rs = psmt.executeQuery();

			while (rs.next()) {

				BbsDto dto = new BbsDto(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getInt(4), rs.getInt(5),
						rs.getString(6), rs.getString(7), rs.getString(8), rs.getInt(9), rs.getInt(10));

				list.add(dto);
				System.out.println("4/4 getDbsList success");

			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("getDbsList fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}

		return list;
	}

	// 글의 총수
	public int getAllBbs(String choice, String search) {

		String sql = " select count(*) from bbs"; // 테이블 총개수

		String searchSql = "";
		if (choice.equals("title")) {

			searchSql = " where title like '%" + search + "%'"; // 컬럼명이 title인것중에서 검색한 것을 like로 해서 sql문에 붙인다

		} else if (choice.equals("content")) {

			searchSql = " where content like '%" + search + "%'";

		} else if (choice.equals("writer")) {

			searchSql = " where id='" + search + "'";

		}
		sql += searchSql;

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		int count = 0;

		try {
			conn = DBConnection.getConnection();

			psmt = conn.prepareStatement(sql);

			rs = psmt.executeQuery();

			if (rs.next()) {

				count = rs.getInt(1);

			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}

		return count;
	}

	// ******************************************************pageing***********************************************************
	public List<BbsDto> getBbsPgaeList(String choice, String search, int pageNum) {

		String sql = " select seq, id, ref, step, depth, title, content, wdate, del, readcount " + " from "
				+ " (select row_number()over(order by ref desc, step asc) as rnum,"
				+ "	seq, id, ref, step, depth, title, content, wdate, del, readcount " + " from bbs ";

		String searchSql = "";
		if (choice.equals("title")) {

			searchSql = " where title like '%" + search + "%' "; // 컬럼명이 title인것중에서 검색한 것을 like로 해서 sql문에 붙인다

		} else if (choice.equals("content")) {

			searchSql = " where content like '%" + search + "%' ";

		} else if (choice.equals("writer")) {

			searchSql = " where id='" + search + "' ";

		}
		sql += searchSql;

		sql += " order by ref desc, step asc) a " + " where rnum between ? and ? "; // rnum번호를 보고 어디서부터 어디까지 뿌려줄지 결정

		Connection conn = null;

		PreparedStatement psmt = null;
		ResultSet rs = null;

		// pageNum(0,1,2..)
		int start, end;
		start = 1 + 10 * pageNum; // 1 11 21 31 41.... 처음
		end = 10 + 10 * pageNum; // 10 20 30 40 50 ....과 끝

		List<BbsDto> list = new ArrayList<BbsDto>();

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/4 getBbsPgaeList success");

			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, start);
			psmt.setInt(2, end);

			System.out.println("2/4 getBbsPgaeList success");

			rs = psmt.executeQuery();/////////////////////

			System.out.println("3/4 getBbsPgaeList success");
			while (rs.next()) {

				BbsDto dto = new BbsDto(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getInt(4), rs.getInt(5),
						rs.getString(6), rs.getString(7), rs.getString(8), rs.getInt(9), rs.getInt(10));

				list.add(dto);
				System.out.println("4/4 getBbsPgaeList success");

			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("getDbsList fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}

		return list;
	}

	public boolean addWrite(BbsDto dto) {

		String sql = " insert into bbs(id, ref, step, depth, title, content, wdate, del , readcount)" + "values(?,"
				+ "		(select ifnull(max(ref),0)+1 from bbs b), 0,0, ?, ?, now(), 0, 0) ";

		Connection conn = null;
		PreparedStatement psmt = null;

		int count = 0;

		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 addwrite Success");
			psmt = conn.prepareStatement(sql);

			psmt.setNString(1, dto.getId());
			psmt.setNString(2, dto.getTitle());
			psmt.setNString(3, dto.getContent());
			System.out.println("2/3 addwrite Success");

			count = psmt.executeUpdate(); // 메서드의 반환 값은 sql문 실행에 영향을 받는 행 수를 반환 즉 개행 한줄
			System.out.println("3/3 addwrite Success");

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}
		return count > 0 ? true : false;
	}

	/*
	 * *******************************************디테일 페이지 들어가는 곳********************************************************
	 */
	
	public BbsDto getBbs(int seq) { 

		String sql = " select * from bbs where seq = ?";

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		int count = 0;
		BbsDto dto = null;
		try {
			conn = DBConnection.getConnection();

			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			rs = psmt.executeQuery();

			if (rs.next()) {
				int _seq = rs.getInt(1);
				String _id = rs.getString(2);
				int _ref = rs.getInt(3);
				int _step = rs.getInt(4);
				int _depth = rs.getInt(5);
				String _title = rs.getString(6);
				String _content = rs.getString(7);
				String _wdate = rs.getString(8);
				String _info = rs.getString(9);
				int _readcount = rs.getInt(10);
				_readcount++;
				countUpdate(_readcount, _seq);
				dto = new BbsDto(seq, _id, _ref, _step, _depth, _title, _content, _wdate, seq, _readcount);

			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}

		return dto;

	}
// 조회수 증가*******************************************************************************************************
	private int countUpdate(int _readcount, int _seq) {
		
		String sql = "update bbs set readcount = ? where seq = ?";
		

		Connection conn = null;
		PreparedStatement psmt = null;

		int count = 0;
		
		try {
			conn = DBConnection.getConnection();

			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, _readcount);
			psmt.setInt(2, _seq);
			
			return psmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			
		} finally {
			DBClose.close(conn, psmt, null);
		}
		return -1;
		
	}

	public boolean answer(int seq, BbsDto dto) { // 답글 쓸때 사용

		// update
		String sql1 = " update bbs set step=step+1 "
				+ " where ref=(select ref from (select ref from bbs a where seq=?) A ) "
				+ " 	and step>(select step from(select step from bbs b where seq=?) B )";

		// insert
		String sql2 = " insert into bbs(id, ref, step, depth, title, content, wdate, del, readcount) "
				+ " values(?, (select ref from bbs a where seq=?), (select step from bbs b where seq=?)+1, (select depth from bbs c where seq=?)+1, "
				+ "		?, ?, now(), 0, 0) ";

		Connection conn = null;
		PreparedStatement psmt = null;
		int count1 = 0, count2 = 0; 

		try {
			conn = DBConnection.getConnection();
			// commit을 비활성화 commit(=확정+적용)/ rollback
			conn.setAutoCommit(false); // 성공시 commit 실패시 rollback을 지정하면 결과는 아무런 데이터도 들어가지 않는다.

			
			/*
			 *  setAutoCommit(boolean)
			 *  commit() : 모든 작업을 정상적으로 처리하겠다고 확정하는 명령어이다
			 *  rollback() : 작업 중 문제가 발생했을 때, 트랜젝션의 처리 과정에서 발생한 변경 사항을 취소하고, 트랜젝션 과정을 종료시킨다.
			 * 
			 * 
			 * 장점 : 데이터 무결성 보장, 영구적으로 변경하기 전에 데이터의 변경사항을 확인할 수 있다
			 * 논리적으로 연관된 작업을 그룹화할 수 있다.
			 * 
			 */
			// update
			psmt = conn.prepareStatement(sql1);
			psmt.setInt(1, seq);
			psmt.setInt(2, seq);

			count1 = psmt.executeUpdate();
			// psmt 초기화
			psmt.clearParameters();

			// insert
			psmt = conn.prepareStatement(sql2);
			psmt.setString(1, dto.getId());
			psmt.setInt(2, seq);
			psmt.setInt(3, seq);
			psmt.setInt(4, seq);
			psmt.setString(5, dto.getTitle());
			psmt.setString(6, dto.getContent());

			count2 = psmt.executeUpdate();

			conn.commit();

		} catch (SQLException e) {

			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}

			e.printStackTrace();
		} finally {

			try {
				conn.setAutoCommit(true);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			DBClose.close(conn, psmt, null);
		}

		boolean b = false;

		if (count2 > 0) {

			return true;

		} else {

			return false;
		}

	}

	public boolean delete(int seq) {

		String sql = "  update bbs set del= ? where seq= ?";

		Connection conn = null; // java와 db사이의 연결
		PreparedStatement psmt = null; // 객체를 ?가 포함된 sql문으로 생성하고 이후 ?자리만 바꿔가며 데이터베이스 처리

		int count = 0;

		try {
			conn = DBConnection.getConnection();

			psmt = conn.prepareStatement(sql);

			psmt.setInt(1, 1);
			psmt.setInt(2, seq);

			count = psmt.executeUpdate();

		} catch (SQLException e) {
			System.out.println(" getId fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}

		return count > 0 ? true : false;
	}

	public boolean update(int seq, String title, String content) {

		String sql = "  update bbs set  title= ?, content= ? where seq= ? ";

		Connection conn = null; // java와 db사이의 연결
		PreparedStatement psmt = null; // 객체를 ?가 포함된 sql문으로 생성하고 이후 ?자리만 바꿔가며 데이터베이스 처리

		int count = 0;
		try {
			conn = DBConnection.getConnection();

			psmt = conn.prepareStatement(sql);

			psmt.setNString(1, title);
			psmt.setNString(2, content);
			//psmt.setNString(3, now());
			psmt.setInt(3, seq);

			count = psmt.executeUpdate(); // executeUpdate반환값 : 처리된 레코드(row)의 개수

		} catch (SQLException e) {
			System.out.println(" getId fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}

		return count > 0 ? true : false;

	}

}
