package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dto.BoardDTO;
import dto.FilesDTO;

public class FilesDAO {
	
	private static FilesDAO instance; 

	public static FilesDAO getInstance() {
		if(instance == null) {
			instance = new FilesDAO();
		}
		return instance;
	}

	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/mysql");
		return ds.getConnection();

	}
	
	
	// file 테이블 작성 
	public int insert(FilesDTO dto) throws Exception {
		String sql = "insert into file (ori_name, sys_name, parent_seq) values (?, ?, ?)";
		try (
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				) {
			pstat.setString(1, dto.getOri_name());
			pstat.setString(2, dto.getSys_name());
			pstat.setInt(3, dto.getParent_seq());
			return pstat.executeUpdate();
		
		}
	}
	
	
	// file 불러오기
	public List<FilesDTO> selectFile(FilesDTO dto) throws Exception {
		String sql = "select * from file where parent_seq like ?";
		try (
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				) {
			
			List<FilesDTO> result = new ArrayList<>();
			pstat.setInt(1, dto.getSeq());
			
			ResultSet rs = pstat.executeQuery();
			while (rs.next()) {
				int seq = rs.getInt("seq");
				String ori_name = rs.getString("ori_name");
				String sys_name = rs.getString("sys_name");
				int parent_seq = rs.getInt("parent_seq");
				result.add(new FilesDTO(seq, ori_name, sys_name, parent_seq));
			}
			return result;
		}
	}
}
