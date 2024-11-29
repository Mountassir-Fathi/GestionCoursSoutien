package model.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import model.bo.Etudiant;
import model.bo.Manager;
import model.bo.Prof;
import model.bo.User;

public class AuthentifierDao {
	
	private EtudiantDao etudiantDao = new EtudiantDao();
	private ProfDao profDao = new ProfDao();
	
	public User Authentifier(String email, String password) {
		User user = getUserByEmail(email);
		if (user != null) {
			DBInteraction.connect();
			ResultSet rSet = DBInteraction.Select("select id, nom, prenom, role from users where email = '" + email + "' and password = '" + password + "'");
			try {
				if (rSet.next())
					return user;
			} catch (SQLException e) {
				e.printStackTrace();
			}
			DBInteraction.disconnect();
			
		}
		return null;
	}
	public User getUserByEmail(String email) {
		DBInteraction.connect();
		ResultSet rSet = DBInteraction.Select("select id, nom, prenom, role from users where email = '" + email + "'");
		User user = null;
		try {
			if(rSet.next()) {
				var id = rSet.getInt(1);
				var nom = rSet.getString(2);
				var prenom = rSet.getString(3);
				var role = rSet.getString(4);
				switch (role) {
					case "ETUDIANT": 
						user = etudiantDao.getEtudiantById(id);
						break;
					case "PROF": 
						user = profDao.getProfById(id);
						break;
					case "MANAGER": 
						user = new Manager(id, nom, prenom, email, null, role);
						break;
				}
				user.setPassword("");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return user;
	}
	public void changePassword(String newPassword, int id) {
		DBInteraction.connect();
		DBInteraction.Maj("update users set password = '"+newPassword+"' where id ="+id);
		
		DBInteraction.disconnect();
	}
}
