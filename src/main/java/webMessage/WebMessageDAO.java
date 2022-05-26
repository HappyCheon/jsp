package webMessage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import conn.GetConn;
import conn.TimeDiff;

public class WebMessageDAO {
	GetConn getConn = GetConn.getInstance();
	private Connection conn = getConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	
	WebMessageVO vo = null;

	// 메세지 리스트(전체메세지(받은메세지(신규/읽은메세지포함))/새메세지/보낸메세지/휴지통)
	public ArrayList<WebMessageVO> getWmMessageList(String mid, int mSw) {
		ArrayList<WebMessageVO> vos = new ArrayList<WebMessageVO>();
		try {
			if(mSw == 1) {	// 받은 메세지(전체메세지처리(새메세지+읽은메세지)
				sql = "select * from webMessage where receiveId=? and (receiveSw='n' or receiveSw='r') order by idx desc";
			}
			else if(mSw == 2) {	// 새메세지
				sql = "select * from webMessage where receiveId=? and receiveSw='n' order by idx desc";
			}
			else if(mSw == 3) {	// 보낸 메세지
				sql = "select * from webMessage where sendId=? and sendSw='s' order by idx desc";
			}
			else if(mSw == 4) {	// 수신확인
				sql = "select * from webMessage where sendId=? and receiveSw='n' order by idx desc";
			}
			else if(mSw == 5) {	// 휴지통
				sql = "select * from webMessage where (receiveId=? and receiveSw='g') or (sendId=? and sendSw='g') order by idx desc";
			}
			else {	// mSw가 0일때는 새메세지 작성 처리이기에 그냥 리턴한다.
				return vos;
			}
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			if(mSw == 5) {
				pstmt.setString(2, mid);
			}
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new WebMessageVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setTitle(rs.getString("title"));
				vo.setContent(rs.getString("content"));
				vo.setSendId(rs.getString("sendId"));
				vo.setSendSw(rs.getString("sendSw"));
				vo.setSendDate(rs.getString("sendDate"));
				vo.setReceiveId(rs.getString("receiveId"));
				vo.setReceiveSw(rs.getString("receiveSw"));
				
				vo.setReceiveDate(rs.getString("receiveDate"));
				vo.setcReceiveDate(rs.getString("receiveDate"));
				TimeDiff timeDiff = new TimeDiff();
				vo.setnReceiveDate(timeDiff.timeDiff(vo.getcReceiveDate()));
				
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vos;
	}

	// 메세지 저장하기(메세지 전송하기)
	public int setWmInputOk(WebMessageVO vo) {
		int res = 0;
		try {
			sql = "insert into webMessage values (default,?,?,?,'s',default,?,'n',default)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getTitle());
			pstmt.setString(2, vo.getContent());
			pstmt.setString(3, vo.getSendId());
			pstmt.setString(4, vo.getReceiveId());
			pstmt.executeUpdate();
			res = 1;
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}

	// 한건의 메세지만 처리(읽어온다)한다.
	public WebMessageVO getWmMessageOne(int idx, int mFlag) {
		vo = new WebMessageVO();
		try {
			if(mFlag != 13) {	// 휴지통에서 내용보기가 아닐경우에만(즉, 받은메세지에서 내용볼때임) receiveSw의 'n'를 'r'로 바꾸고, 읽은날짜를 현재 날짜로 바꿔준다.
				sql = "update webMessage set receiveSw='r', receiveDate=now() where idx=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, idx);
				pstmt.executeUpdate();
				getConn.pstmtClose();
			}
			
			sql = "select * from webMessage where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			rs.next();
			
			vo = new WebMessageVO();
			vo.setIdx(rs.getInt("idx"));
			vo.setTitle(rs.getString("title"));
			vo.setContent(rs.getString("content"));
			vo.setSendId(rs.getString("sendId"));
			vo.setSendSw(rs.getString("sendSw"));
			vo.setSendDate(rs.getString("sendDate"));
			vo.setReceiveId(rs.getString("receiveId"));
			vo.setReceiveSw(rs.getString("receiveSw"));
			vo.setReceiveDate(rs.getString("receiveDate"));
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vo;
	}

	// 휴지통으로 메세지 보내기
	public int wmDeleteCheck(int idx, int mSw) {
		int res = 0;
		try {
			if(mSw == 11) {  // 받은 메세지에서 휴지통으로 보낼때 처리
				sql = "update webMessage set receiveSw = 'g' where idx = ?";
			}
			else {
				sql = "update webMessage set sendSw = 'x' where idx = ?";
			}
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			res = 1;
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}

	// 휴지통에 들어있는 모든 자료를 다 삭제한다. 이때 receiveSw와 sendSw가 모두 'x'이면 실제로 삭제시켜준다.
	public int wmDeleteAll(String mid) {
		int res = 0;
		try {
			sql = "update webMessage set receiveSw = 'x' where receiveId = ? and receiveSw = 'g'";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.executeUpdate();
			getConn.pstmtClose();
			
			sql = "update webMessage set sendSw = 'x' where sendId = ? and sendSw = 'g'";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.executeUpdate();
			getConn.pstmtClose();
			
			sql = "delete from webMessage where sendSw = 'x' and receiveSw = 'x'";
			pstmt = conn.prepareStatement(sql);
			pstmt.executeUpdate();
			
			res = 1;
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}

}
