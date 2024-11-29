package model.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.bo.Groupe;

public class GroupeDao {
	MatiereDao matiereDao = new MatiereDao();
	NiveauDao niveauDao = new NiveauDao();
	
	public List<Groupe> getAllGroupes() {
		List<Groupe> groupes = new ArrayList<Groupe>();
		DBInteraction.connect();

		String sqlallGN = "SELECT * FROM groupes where nom != 'sans'";
		ResultSet rSet = DBInteraction.Select(sqlallGN);

		try {
			while (rSet.next()) {
				groupes.add(new Groupe(rSet.getInt(1), rSet.getString(2), niveauDao.getNiveauById(rSet.getInt(3)),
						nombreEtudiantByGroupe(rSet.getInt(1))));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block

			e.printStackTrace();
		} finally {
			DBInteraction.closeStatement(rSet);
			DBInteraction.disconnect();
		}

		return groupes;
	}

	public List<Groupe> getAllGroupeByIDN(int id_niveau) {
		List<Groupe> groupes = new ArrayList<Groupe>();
		DBInteraction.connect();

		String sqlallGN = "select g.id, g.nom, n.nom from groupes g  " + "inner join niveaux n "
				+ "on g.niveau_id = n.id " + "and g.niveau_id =" + id_niveau;
		ResultSet rSet = DBInteraction.Select(sqlallGN);

		try {
			while (rSet.next()) {

				groupes.add(new Groupe(rSet.getInt(1), rSet.getString(2), niveauDao.getNiveauById(id_niveau),
						nombreEtudiantByGroupe(rSet.getInt(1))));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block

			e.printStackTrace();
		} finally {
			DBInteraction.closeStatement(rSet);
			DBInteraction.disconnect();
		}

		return groupes;
	}

	public void deleteGroupeById(int id) {

		DBInteraction.connect();
		DBInteraction.disableAutoCommit();

		String sqlgetAllEG = "select id from etudiants where group_id = " + id;
		ResultSet rSet = DBInteraction.Select(sqlgetAllEG);
		EtudiantDao etudiantDao = new EtudiantDao();
		try {
			while (rSet.next()) {

				etudiantDao.deleteEtudiantById(rSet.getInt(1));

			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block

			e.printStackTrace();
		} finally {
			DBInteraction.closeStatement(rSet);
		}

		String sqldeleteG = "delete from groupes where id = " + id;
		DBInteraction.Maj(sqldeleteG);

		DBInteraction.commit();
		DBInteraction.disconnect();

	}

	public Groupe findGroupeById(int id_groupe) {
		Groupe groupe = null;

		DBInteraction.connect();

		String sqlgetG = "select g.id, g.nom, g.niveau_id, n.nom from groupes g " + "inner join niveaux n"
				+ " on g.niveau_id = n.id" + " and g.id = " + id_groupe;

		ResultSet rSet = DBInteraction.Select(sqlgetG);

		try {

			if (rSet.next()) {
				groupe = new Groupe(rSet.getInt(1), rSet.getString(2), niveauDao.getNiveauById(rSet.getInt(3)),
						nombreEtudiantByGroupe(rSet.getInt(1)));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBInteraction.closeStatement(rSet);
			DBInteraction.disconnect();
		}

		return groupe;
	}

	public void updateGroupe(Groupe groupe) {

		DBInteraction.connect();

		String sqlupdateG = "update  groupes set nom ='" + groupe.getNom() + "' , niveau_id = " + groupe.getNiveau().getId()
				+ " where id =" + groupe.getId();
		
		 
		DBInteraction.Maj(sqlupdateG);

		DBInteraction.disconnect();

	}

	public void ajouterGroupe(String nomG, int id_niveau) {

		DBInteraction.connect();

		String sqlaouterG = "insert into groupes(nom,niveau_id) values('" + nomG + "','" + id_niveau + "')";
		DBInteraction.Maj(sqlaouterG);

		DBInteraction.disconnect();

	}

	private int nombreEtudiantByGroupe(int groupe_id) {
		int n = 0;
		String sqlnombreetudiantgr = "select count(group_id) from etudiants where group_id =" + groupe_id;
		DBInteraction.connect();
		ResultSet rSet = DBInteraction.Select(sqlnombreetudiantgr);
		try {
			if (rSet.next()) {
				n = rSet.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBInteraction.closeStatement(rSet);
			DBInteraction.connect();
		}

		return n;
	}
}
