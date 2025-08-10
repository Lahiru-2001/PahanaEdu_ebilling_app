package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.entity.Help;

public class HelpDAOImpl implements HelpDAO {

	private Connection conn;

	public HelpDAOImpl(Connection conn) {
		this.conn = conn;
	}

	@Override
	public boolean addHelp(Help help) {
		boolean f = false;
		try {
			String sql = "INSERT INTO help (customer_id, title, content) VALUES (?, ?, ?)";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, help.getCustomer_id());
			ps.setString(2, help.getTitle());
			ps.setString(3, help.getContent());

			int i = ps.executeUpdate();
			if (i == 1) {
				f = true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}

}
