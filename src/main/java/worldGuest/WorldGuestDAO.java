package worldGuest;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import common.GetConn;

public class WorldGuestDAO {
	private Connection conn = GetConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	private WorldGuestVO vo = null;
	
	public void pstmtClose() {
		if(pstmt != null) {
			try {
				pstmt.close();
			} catch (Exception e) {}
		}
	}
	
	public void rsClose() {
		if(rs != null) {
			try {
				rs.close();
			} catch (Exception e) {} 
			finally {
				pstmtClose();
			}
		}
	}

	// 방명록 전체 자료 리스트 처리
	public ArrayList<WorldGuestVO> getWorldGuestList(int startIndexNo, int pageSize, String sFriendId) {
		ArrayList<WorldGuestVO> vos = new ArrayList<WorldGuestVO>();
		try {
			sql = "select * from worldGuest where masterId = ? order by idx desc limit ?,?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sFriendId);
			pstmt.setInt(2, startIndexNo);
			pstmt.setInt(3, pageSize);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new WorldGuestVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setMasterId(rs.getString("masterId"));
				vo.setGuestId(rs.getString("guestId"));
				vo.setNickName(rs.getString("nickName"));
				vo.setContent(rs.getString("content"));
				vo.setEmail(rs.getString("email"));
				vo.setVisitDate(rs.getString("visitDate"));
				
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return vos;
	}

	// 방명록글의 총 건수구하기
	public int getTotRecCnt(String sFriendId) {
		int totRecCnt = 0;
		try {
			if(sFriendId.equals("all")) {
				sql = "select count(*) as cnt from worldGuest";
				pstmt = conn.prepareStatement(sql);
			}
			else {
				sql = "select count(*) as cnt from worldGuest where masterId = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, sFriendId);
			}
				rs = pstmt.executeQuery();
				rs.next();
				totRecCnt = rs.getInt("cnt");	
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return totRecCnt;
	}

	// 방명록 글 삭제하기
	public int setWorldGuestDelete(int idx) {
		int res = 0;
		try {
			sql = "delete from worldGuest where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}

	
	public int setWorldGuestInput(WorldGuestVO vo) {
		int res = 0;
		try {
			sql = "insert into worldGuest values (default,?,?,?, ?, ?, default)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getMasterId());
			pstmt.setString(2, vo.getGuestId());
			pstmt.setString(3, vo.getNickName());
			pstmt.setString(4, vo.getContent());
			pstmt.setString(5, vo.getEmail());
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}

	public ArrayList<WorldGuestVO> getWdgAllList(int startIndexNo, int pageSize) {
		ArrayList<WorldGuestVO> vos = new ArrayList<WorldGuestVO>();
		try {
			sql = "select * from worldGuest order by idx desc limit ?,?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startIndexNo);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new WorldGuestVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setMasterId(rs.getString("masterId"));
				vo.setGuestId(rs.getString("guestId"));
				vo.setNickName(rs.getString("nickName"));
				vo.setContent(rs.getString("content"));
				vo.setEmail(rs.getString("email"));
				vo.setVisitDate(rs.getString("visitDate"));
				
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return vos;
	}

}
