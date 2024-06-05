package free;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import common.GetConn;

public class FreeDAO {
	private Connection conn = GetConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	private FreeVO vo = null;
	
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

//	게시글 등록하기
		public int setFreeInput(FreeVO vo) {
			int res= 0;
			try {
				sql = "insert into Free values (default,?,?,?,?,?,default,default,default,default)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, vo.getMasterId());
				pstmt.setString(2, vo.getGuestId());
				pstmt.setString(3, vo.getNickName());
				pstmt.setString(4, vo.getTitle());
				pstmt.setString(5, vo.getContent());
				res = pstmt.executeUpdate();
			} catch (SQLException e) {
				System.out.println("SQL 오류 : " + e.getMessage());
			} finally {
				pstmtClose();			
			}
			return res;
		}
	
	//	게시글 내용보기
		public FreeVO getFreeContent(int idx) {
			FreeVO vo = new FreeVO();
			try {
				sql = "select * from free where idx = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, idx);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					vo.setIdx(rs.getInt("idx"));
					vo.setMasterId(rs.getString("masterId"));
					vo.setGuestId(rs.getString("guestId"));
					vo.setNickName(rs.getString("nickName"));
					vo.setTitle(rs.getString("title"));
					vo.setContent(rs.getString("content"));
					vo.setReadNum(rs.getInt("readNum"));
					vo.setwDate(rs.getString("wDate"));
					vo.setGood(rs.getInt("good"));
					vo.setComplaint(rs.getString("complaint"));
				}
			} catch (SQLException e) {
				System.out.println("SQL 오류 : " + e.getMessage());
			} finally {
				rsClose();			
			}
			return vo;
		}
	
		
	//	게시글 수정하기
		public int setFreeUpdateOk(FreeVO vo) {
			int res = 0;
			try {
				sql = "update Free set title=?, content=?, wDate=now() where idx = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, vo.getTitle());
				pstmt.setString(2, vo.getContent());
				pstmt.setInt(3, vo.getIdx());
				res = pstmt.executeUpdate();
			} catch (SQLException e) {
				System.out.println("SQL 오류 : " + e.getMessage());
			} finally {
				pstmtClose();			
			}
			return res;
		}
	
	//	게시글 삭제하기
		public int setFreeDelete(int idx) {
			int res = 0;
			try {
				sql = "delete from free where idx=?";
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
		
		// 좋아요수 증가처리
		public int setFreeGoodCheck(int idx) {
			int res = 0;
			try {
				sql = "update free set good = good + 1 where idx = ?";
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
		
		// 좋아요수 증가/감소 처리
		public void setFreeGoodCheckPlusMinus(int idx, int goodCnt) {
			try {
				sql = "update Free set good = good + ? where idx = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, goodCnt);
				pstmt.setInt(2, idx);
				pstmt.executeUpdate();
			} catch (SQLException e) {
				System.out.println("SQL 오류 : " + e.getMessage());
			} finally {
				pstmtClose();			
			}
		}
	// 댓글 저장하기 
		public int setReplyInput(FreeReplyVO vo) {
			int res = 0;
			try {
				sql = "insert into freeReply values (default, ?, ?, ?,default, ?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, vo.getFreeidx());
				pstmt.setString(2, vo.getMid());
				pstmt.setString(3, vo.getNickName());
				pstmt.setString(4, vo.getContent());
				res = pstmt.executeUpdate();
			} catch (SQLException e) {
				System.out.println("SQL 오류 : " + e.getMessage());
			} finally {
				pstmtClose();			
			}
			return res;
		}

//		댓글 삭제 처리
		public int setFreeReplyDelete(int idx) {
			int res = 0;
			try {
				sql = "delete from freeReply where idx = ?";
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

//		조회수 증가 처리
		public void setFreeReadNumPlus(int idx) {
			try {
				sql = "update free set readNum = readNum + 1 where idx = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, idx);
				pstmt.executeUpdate();
			} catch (SQLException e) {
				System.out.println("SQL 오류 : " + e.getMessage());
			} finally {
				pstmtClose();			
			}
		}

//		이전글,다음글 idx,title 가져오기
		public FreeVO getPreNextSearch(int idx, String str, String friend) {
			FreeVO vo = new FreeVO();
			try {
				if(str.equals("preVo")) sql = "select idx, title from free where idx < ? and masterId=? order by idx desc limit 1";
				else sql = "select idx, title from free where idx > ? and masterId=? order by idx limit 1";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, idx);
				pstmt.setString(2, friend);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					vo.setIdx(rs.getInt("idx"));
					vo.setTitle(rs.getString("title"));
				}
			} catch (SQLException e) {
				System.out.println("SQL 오류 : " + e.getMessage());
			} finally {
				rsClose();			
			}
			return vo;
		}
	// 댓글 처리
		public ArrayList<FreeReplyVO> getFreeReply(int idx) {
			ArrayList<FreeReplyVO> replyVos = new ArrayList<FreeReplyVO>();
			try {
				sql = "select * from freeReply where freeIdx = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, idx);
				rs = pstmt.executeQuery();
				
				FreeReplyVO vo = null;
				while(rs.next()) {
					vo = new FreeReplyVO();
					vo.setIdx(rs.getInt("idx"));
					vo.setFreeidx(rs.getInt("freeidx"));
					vo.setMid(rs.getString("mid"));
					vo.setNickName(rs.getString("nickName"));
					vo.setwDate(rs.getString("wDate"));
					vo.setContent(rs.getString("content"));
					
					replyVos.add(vo);
				}
			} catch (SQLException e) {
				System.out.println("SQL 오류 : " + e.getMessage());
			} finally {
				rsClose();			
			}
			return replyVos;
		}

//		게시물 총 레코드 건수
		public int getTotRecCnt(String contentsShow,String search ,String searchString, String friendId) {
			int totRecCnt = 0;
			try {
				if(search == null || search.equals("")) {
					if(contentsShow.equals("adminOK")) {
						sql = "select count(*) as cnt from free where masterId=?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, friendId);
					}
					else {
						sql = "select sum(a.cnt) as cnt from (select count(*) as cnt from free where complaint = 'NO' and masterId=? union all select count(*) as cnt from free where masterId = ? and complaint = 'OK' and masterId=?) as a";
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, friendId);
						pstmt.setString(2, contentsShow);
						pstmt.setString(3, friendId);
					}
				}
				else {
					if(contentsShow.equals("adminOK")) {
						sql = "select count(*) as cnt from free where masterId=? and friendId=? "+search+" like ?";
						pstmt =conn.prepareStatement(sql);
						pstmt.setString(1, friendId);
						pstmt.setString(2, "%"+searchString+"%");
					}
					else {
						sql = "select sum(a.cnt) as cnt from (select count(*) as cnt from free where masterId=? and complaint = 'NO' and "+search+" like ? union all select count(*) as cnt from free where masterId = ? and complaint = 'OK' and "+search+" like ?) as a";
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, friendId);
						pstmt.setString(2, "%"+searchString+"%");
						pstmt.setString(3, contentsShow);
						pstmt.setString(4, "%"+searchString+"%");
					}
				}
				rs = pstmt.executeQuery();
				rs.next();
				totRecCnt = rs.getInt("cnt");
			} catch (SQLException e) {
				System.out.println("SQL 오류!! : " + e.getMessage());
			} finally {
				rsClose();			
			}
			return totRecCnt;
		}

//		전체 게시글 보기
		public List<FreeVO> getfreeList(int startIndexNo, int pageSize, String contentsShow, String search,String searchString, String friendId) {
			ArrayList<FreeVO> vos = new ArrayList<FreeVO>();
			try {
				if(search == null || search.equals("")) {
					  sql = "select *, datediff(wDate, now()) as date_diff, "
					  		+ "timestampdiff(hour, wDate, now()) as hour_diff,  "
					  		+ "(select count(*) from freeReply where freeIdx = b.idx) as replyCnt "
					  		+ "from free b where masterId=? order by idx desc limit ?,?";
					  pstmt = conn.prepareStatement(sql);
					  pstmt.setString(1, friendId);
					  pstmt.setInt(2, startIndexNo);
					  pstmt.setInt(3, pageSize);
				}
				else {
						 sql = "select *, datediff(wDate, now()) as date_diff, timestampdiff(hour, wDate, now()) as hour_diff, "
						  		+ "(select count(*) from freeReply where freeIdx = b.idx) as replyCnt "
						  		+ "from free b where masterId=? and "+search+" like ? order by idx desc limit ?,?";
						 pstmt = conn.prepareStatement(sql);
						 pstmt.setString(1, friendId);
						 pstmt.setString(2, "%"+searchString+"%");
						 pstmt.setInt(3, startIndexNo);
						 pstmt.setInt(4, pageSize);
				}
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					vo = new FreeVO();
					vo.setIdx(rs.getInt("idx"));
					vo.setMasterId(rs.getString("masterId"));
					vo.setGuestId(rs.getString("guestId"));
					vo.setNickName(rs.getString("nickName"));
					vo.setTitle(rs.getString("title"));
					vo.setContent(rs.getString("content"));
					vo.setReadNum(rs.getInt("readNum"));
					vo.setwDate(rs.getString("wDate"));
					vo.setGood(rs.getInt("good"));
					vo.setComplaint(rs.getString("complaint"));
					vo.setHour_diff(rs.getInt("hour_diff"));
					vo.setDate_diff(rs.getInt("date_diff"));
					vo.setReplyCnt(rs.getInt("replyCnt"));
					
					vos.add(vo);
				}
			} catch (SQLException e) {
				System.out.println("SQL 오류 : " + e.getMessage());
			} finally {
				rsClose();			
			}
			return vos;
		}

//		게시판 총건수 구하기 (관리자)
		public int getTotRecCnt(String friendId) {
			int totRecCnt = 0;
			try {
				if(friendId.equals("all")) {
					sql = "select count(*) as cnt from free";
					pstmt = conn.prepareStatement(sql);
				}
				else {
					sql = "select count(*) as cnt from free where masterId = ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, friendId);
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

		public ArrayList<FreeVO> getFreeList(int startIndexNo, int pageSize) {
			ArrayList<FreeVO> vos = new ArrayList<FreeVO>();
			try {
				sql = "select * from free order by idx desc limit ?,?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, startIndexNo);
				pstmt.setInt(2, pageSize);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					vo = new FreeVO();
					vo.setIdx(rs.getInt("idx"));
					vo.setMasterId(rs.getString("masterId"));
					vo.setGuestId(rs.getString("guestId"));
					vo.setNickName(rs.getString("nickName"));
					vo.setTitle(rs.getString("title"));
					vo.setContent(rs.getString("content"));
					vo.setReadNum(rs.getInt("readNum"));
					vo.setwDate(rs.getString("wDate"));
					vo.setGood(rs.getInt("good"));
					vo.setComplaint(rs.getString("complaint"));
					vo.setHour_diff(rs.getInt("hour_diff"));
					vo.setDate_diff(rs.getInt("date_diff"));
					vo.setReplyCnt(rs.getInt("replyCnt"));
					
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
