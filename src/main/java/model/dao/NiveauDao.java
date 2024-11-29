package model.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.bo.Niveau;

public class NiveauDao {
	MatiereDao matiereDao = new MatiereDao();

	public List<Niveau> getAllNiveau() {

		List<Niveau> nivaux = new ArrayList<Niveau>();

		DBInteraction.connect();

		String sql = "select * from niveaux where id != 1";
		ResultSet rSet = null;

		try {
			rSet = DBInteraction.Select(sql);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		try {

			while (rSet.next()) {
				Niveau niveau = new Niveau(rSet.getInt(1), rSet.getString(2),
						matiereDao.getMatieresByIDN(rSet.getInt(1)), this.getnombreEtudiantIdN(rSet.getInt(1)));
				nivaux.add(niveau);

			}
		} catch (Exception e) {
			// TODO Auto-generated catch block

			e.printStackTrace();
		} finally {
			DBInteraction.closeStatement(rSet);
			DBInteraction.disconnect();
		}

		return nivaux;
	}

	public Niveau getNiveauById(int id) {

		String sql = "select * from niveaux where id =" + id;

		DBInteraction.connect();

		ResultSet rSet = null;
		rSet = DBInteraction.Select(sql);
		Niveau niveau = null;
		try {
			if (rSet.next()) {
				niveau = new Niveau(id, rSet.getString(2), matiereDao.getMatieresByIDN(id),
						this.getnombreEtudiantIdN(id));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			DBInteraction.closeStatement(rSet);
			DBInteraction.disconnect();
			e.printStackTrace();
		}

		return niveau;
	}

	public void addNiveau(String nom) {

		String sql = "insert into niveaux(nom) values('" + nom + "')";

		DBInteraction.connect();

		DBInteraction.Maj(sql);

		DBInteraction.disconnect();

	}

	public void modifyNiveau(int niveau_id,String nomNiveau) {

		String sql = "update niveaux set nom='" + nomNiveau + "' where id=" + niveau_id;

		DBInteraction.connect();

		DBInteraction.Maj(sql);

		DBInteraction.disconnect();
		System.out.println("salam");

	}

	public void deleteNiveauById(int id) {

		DBInteraction.connect();
		DBInteraction.disableAutoCommit();

		String sqlDeleteMN = "delete from niveau_matieres where id_niveau = " + id;
		DBInteraction.Maj(sqlDeleteMN);

		String sqlDeletePN = "delete from prof_niveau where niveau_id = " + id;
		DBInteraction.Maj(sqlDeletePN);

		GroupeDao groupeDao = new GroupeDao();
		String sqlgetallg = "select id from groupes where niveau_id = " + id;
		ResultSet rSet = DBInteraction.Select(sqlgetallg);
		try {
			while (rSet.next()) {
				groupeDao.deleteGroupeById(rSet.getInt(1));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block

			e.printStackTrace();
		} finally {
			DBInteraction.closeStatement(rSet);

		}

		String sqldeleteN = "delete from niveaux where id = " + id;
		DBInteraction.Maj(sqldeleteN);

		DBInteraction.commit();
		DBInteraction.disconnect();

	}

	public List<Niveau> getNiveauByIdP(int prof_id) {

		List<Niveau> niveaus = new ArrayList<Niveau>();

		DBInteraction.connect();

		String sqlNP = "SELECT n.id , n.nom " + "FROM niveaux n " + "INNER JOIN prof_niveau pn ON pn.niveau_id = n.id "
				+ "WHERE pn.prof_id =" + prof_id;
		ResultSet rSet = DBInteraction.Select(sqlNP);

		try {
			while (rSet.next()) {
				niveaus.add(new Niveau(rSet.getInt(1), rSet.getString(2), matiereDao.getMatieresByIDN(rSet.getInt(1)),
						this.getnombreEtudiantIdN(rSet.getInt(1))));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block

			e.printStackTrace();
		} finally {
			DBInteraction.closeStatement(rSet);
			DBInteraction.disconnect();
		}

		return niveaus;
	}

	public int getnombreGrbyIdN(int niveau_id) {
		int nbr = 0;
		DBInteraction.connect();
		String sql = "select count(id) from groupes where niveau_id =" + niveau_id;
		ResultSet rSet = DBInteraction.Select(sql);
		try {
			if (rSet.next()) {
				nbr = rSet.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		DBInteraction.disconnect();
		return nbr;

	}

	public int getnombreEtudiantIdN(int niveau_id) {
		int nbr = 0;
		DBInteraction.connect();
		String sql = "select count(niveau_id) from etudiants where niveau_id =" + niveau_id;
		ResultSet rSet = DBInteraction.Select(sql);
		try {
			if (rSet.next()) {
				nbr = rSet.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		DBInteraction.disconnect();
		return nbr;

	}
	
	

}
