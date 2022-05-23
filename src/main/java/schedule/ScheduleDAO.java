package schedule;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import conn.GetConn;

public class ScheduleDAO {
	GetConn getConn = GetConn.getInstance();
	private Connection conn = getConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	
	ScheduleVO vo = null;

	// 해당 '년-월'의 자료를 모두 검색한다.
	public ArrayList<ScheduleVO> getScheduleList(String mid, String ym) {
		ArrayList<ScheduleVO> vos = new ArrayList();
		try {
			sql = "select * from schedule where mid=? and date_format(sDate,'%Y-%m')=? order by sDate,part";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.setString(2, ym);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new ScheduleVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setPart(rs.getString("part"));
				vo.setsDate(rs.getString("sDate"));
				vo.setContent(rs.getString("content"));
				//vo.setPartCnt(rs.getInt("partCnt"));
				vo.setYm(ym);
				
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL Error : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vos;
	}

	// 개별 날짜에 따른 일정목록 가져오기
	public ArrayList<ScheduleVO> getScMenu(String mid, String ymd) {
		ArrayList<ScheduleVO> vos = new ArrayList<ScheduleVO>();
		try {
			sql = "select * from schedule where mid=? and date_format(sDate,'%Y-%m-%d')=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.setString(2, ymd);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new ScheduleVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setPart(rs.getString("part"));
				vo.setsDate(rs.getString("sDate"));
				vo.setContent(rs.getString("content"));
				//vo.setPartCnt(rs.getInt("partCnt"));
				vo.setYmd(ymd);
				
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL Error : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vos;
	}

}
