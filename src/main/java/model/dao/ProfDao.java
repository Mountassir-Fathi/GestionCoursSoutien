package model.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import model.bo.Matiere;
import model.bo.Niveau;
import model.bo.Prof;

public class ProfDao {
	private MatiereDao dMatiereDao = new MatiereDao();
	private NiveauDao niveauDao = new NiveauDao();

	public void insertProfN(String nom, String prenom, String email, String password, String role, String tel,
			Matiere matiere, String[] niveaux) {
		
		/// p
		String sql = "insert into users(nom,prenom,email,password,role)" + " values('" + nom + "','" + prenom + "','"
				+ email + "','" + password + "','PROF')";

		DBInteraction.connect();
		DBInteraction.disableAutoCommit();

		int key = DBInteraction.Maj(sql);

		LocalDate date = LocalDate.now();

		String sql1 = "insert into profs values(" + key + ",'" + date + "','" + matiere.getId() + "','" + tel + "')";
		DBInteraction.Maj(sql1);
		String sql2;
		for (String idniveau : niveaux) {
			sql2 = "insert into prof_niveau values('" + key + "','" + idniveau + "')";
			DBInteraction.Maj(sql2);
		}

		DBInteraction.commit();
		DBInteraction.disconnect();
	}

	public void updateProfById(Prof prof) {

		DBInteraction.connect();
		DBInteraction.disableAutoCommit();
		
		String sql = null;
		if (prof.getPassword() == null || prof.getPassword().equals("")) {

			sql = "update users set nom='" + prof.getNom() + "',prenom='" + prof.getPrenom() + "',email='"
					+ prof.getMail() + "' where id = "+prof.getId();
		} else {

			sql = "update users set nom='" + prof.getNom() + "',prenom='" + prof.getPrenom() + "',email='"
					+ prof.getMail() + "',password='" + prof.getPassword()+"' where id = "+prof.getId();
		}

		DBInteraction.Maj(sql);

		String sqlupdatetel = "update profs set tel='"+prof.getTel() + "' where id = "+prof.getId();
		DBInteraction.Maj(sqlupdatetel);

		DBInteraction.Maj("delete from prof_niveau where prof_id="+prof.getId());
		
		
		for (Niveau niveau : prof.getNiveaux()) {
			DBInteraction.Maj("insert into prof_niveau values('" + prof.getId() + "','" + niveau.getId() + "')");
		}
		DBInteraction.commit();
		DBInteraction.disconnect();

	}

	public void deleteProfN(int prof_id, int niveau_id) {

		DBInteraction.connect();

		String sqldeltePN = "delete from prof_niveau where prof_id=" + prof_id + " and niveau_id=" + niveau_id;
		DBInteraction.Maj(sqldeltePN);

		DBInteraction.disconnect();
	}

	public void deleteProf(int prof_id) {

		DBInteraction.connect();
		DBInteraction.disableAutoCommit();

		String sqldeletePallN = "delete from prof_niveau where prof_id=" + prof_id;
		DBInteraction.Maj(sqldeletePallN);

		String sqldelteprof = "delete from profs where id=" + prof_id;
		DBInteraction.Maj(sqldelteprof);

		String sqldeletuser = "delete from users where id=" + prof_id;
		DBInteraction.Maj(sqldeletuser);

		DBInteraction.commit();
		DBInteraction.disconnect();
	}

	
	public List<Prof> getAllProfs() {
		List<Prof> profs = new ArrayList<Prof>();

		DBInteraction.connect();

		String sql = "select * from users u" + " inner join profs p" + " on u.id = p.id where role = 'PROF'";
		ResultSet rSet = DBInteraction.Select(sql);

		try {
			while (rSet.next()) {
				int id = rSet.getInt(1);
				String nom = rSet.getString(2);
				String prenom = rSet.getString(3);
				String mail = rSet.getString(4);
				String password = rSet.getString(5);
				String role = rSet.getString(6);
				LocalDate date_debut = rSet.getDate(8).toLocalDate();

				int matiere_id = rSet.getInt(9);

				String tel = rSet.getString(10);

				profs.add(new Prof(id, nom, prenom, mail, password, role, tel, dMatiereDao.getMatiereById(matiere_id),
						date_debut, niveauDao.getNiveauByIdP(id)));

			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block

			e.printStackTrace();
		} finally {
			DBInteraction.closeStatement(rSet);
		}

		DBInteraction.disconnect();

		return profs;
	}

	public Prof getProfById(int prof_id) {
		Prof prof = null;

		DBInteraction.connect();
		String sql = "select * from users u inner join profs p  on u.id = p.id where p.id =" + prof_id;

		DBInteraction.connect();
		ResultSet rSet = DBInteraction.Select(sql);

		try {
			if (rSet.next()) {
				String nom = rSet.getString(2);
				String prenom = rSet.getString(3);
				String mail = rSet.getString(4);
				String password = rSet.getString(5);
				String role = rSet.getString(6);
				LocalDate date_debut = rSet.getDate(8).toLocalDate();

				int matiere_id = rSet.getInt(9);

				String tel = rSet.getString(10);

				prof = new Prof(prof_id, nom, prenom, mail, password, role, tel, dMatiereDao.getMatiereById(matiere_id),
						date_debut, niveauDao.getNiveauByIdP(prof_id));

			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block

			e.printStackTrace();
		} finally {
			DBInteraction.closeStatement(rSet);
		}

		DBInteraction.disconnect();

		return prof;

	}

	public List<Prof> getProfsByIdN(int niveau_id) {
		List<Prof> profs = new ArrayList<Prof>();

		DBInteraction.connect();
		String sqlPN = "select prof_id from prof_niveau where niveau_id =" + niveau_id;

		ResultSet rSet = DBInteraction.Select(sqlPN);

		try {
			while (rSet.next()) {
				profs.add(getProfById(rSet.getInt(1)));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block

			e.printStackTrace();
		} finally {
			DBInteraction.closeStatement(rSet);
		}

		DBInteraction.disconnect();

		return profs;
	}
	
	
	public Prof getProfByIdNM(int niveau_id, int matiere_id) {
		Prof prof = null;

		DBInteraction.connect();
		String sql = "select p.id from profs p inner join prof_niveau pn on p.id = pn.prof_id where pn.niveau_id="+ niveau_id+" and p.matiere_id ="
				+matiere_id;
		ResultSet rSet = DBInteraction.Select(sql);
		try {
			if(rSet.next()) {
				prof = this.getProfById(rSet.getInt("id"));
				System.out.println(prof +"ppppp");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			
		DBInteraction.disconnect();

		return prof;

	}

	

}
