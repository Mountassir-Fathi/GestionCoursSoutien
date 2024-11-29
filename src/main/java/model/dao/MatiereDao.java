package model.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.bo.Matiere;

public class MatiereDao {
	
	public void ajouterMatiere(String nom, float prix) {
		DBInteraction.connect();
		String sql = "insert into matieres(nom, prix) values('"+nom+"',"+prix+")";
		DBInteraction.Maj(sql);
		DBInteraction.disconnect();
	}

	public List<Matiere> allMatieres() {

		List<Matiere> matieres = new ArrayList<Matiere>();
		DBInteraction.connect();
		String sql = "SELECT * FROM matieres";
		ResultSet rSet = DBInteraction.Select(sql);
		try {
			while (rSet.next()) {
				matieres.add(new Matiere(rSet.getInt(1), rSet.getString(2), rSet.getFloat(3)));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			
			e.printStackTrace();
		}finally {
			DBInteraction.closeStatement(rSet);
		}

		return matieres;
	}

	public Matiere getMatiereById(int id) {
		String sql = "select nom , prix from matieres where id =" + id;
		Matiere matiere = null;
		DBInteraction.connect();

		ResultSet rSet = DBInteraction.Select(sql);
		try {
			if (rSet.next()) {
				matiere = new Matiere(id, rSet.getString(1), rSet.getFloat(2));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			
			e.printStackTrace();
		}finally {
			DBInteraction.closeStatement(rSet);
		}

		DBInteraction.disconnect();

		return matiere;
	}

	public void updateMatiere(Matiere matiere) {

		String sql = "update matieres set nom ='" + matiere.getNom() +"',prix = '"+matiere.getPrix()+"' where id = " + matiere.getId();
		DBInteraction.connect();
		DBInteraction.Maj(sql);
		DBInteraction.disconnect();
	}

	public void deleteMatiereByIdMN(int id_niveau, int id_matiere) {

		DBInteraction.connect();
		DBInteraction.disableAutoCommit();

		String sqldeleteMN = "delete from niveau_matieres where id_niveau = " + id_niveau + " and id_matiere ="
				+ id_matiere;
		DBInteraction.Maj(sqldeleteMN);

		String sqlgetAllE = "select id from etudiants where niveau_id =" + id_niveau;
		ResultSet rSet = DBInteraction.Select(sqlgetAllE);
		try {
			while (rSet.next()) {
				String sqldeleteME = "delete from etudiant_matiere where etudiant_id =" + rSet.getInt(1)
						+ " and matiere_id =" + id_matiere;
				DBInteraction.Maj(sqldeleteME);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			
			e.printStackTrace();

		}finally {
			DBInteraction.closeStatement(rSet);
		}

		String sqldeletePN = "delete from prof_niveau where niveau_id =" + id_matiere;
		DBInteraction.Maj(sqldeletePN);

		DBInteraction.commit();
		DBInteraction.disconnect();
	}

	public List<Matiere> getMatieresByIDN(int id_niveau) {

		DBInteraction.connect();

		List<Matiere> matieres = new ArrayList<Matiere>();
		String sqlMByIdN = "SELECT m.id, m.nom, m.prix" + " FROM niveau_matieres nm" + " INNER JOIN matieres m"
				+ " ON m.id = nm.id_matiere" + " and nm.id_niveau = " + id_niveau;
		ResultSet rSet = DBInteraction.Select(sqlMByIdN);
		try {
			while (rSet.next()) {
				matieres.add(new Matiere(rSet.getInt(1), rSet.getString(2), rSet.getFloat(3)));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBInteraction.closeStatement(rSet);
		}

		DBInteraction.disconnect();
		return matieres;
	}

	public List<Matiere> getMatieresByIDE(int id_etudiant) {

		DBInteraction.connect();

		List<Matiere> matieres = new ArrayList<Matiere>();
		String sqlMByIdN = "SELECT m.id, m.nom, m.prix " + "FROM etudiant_matiere em " + "INNER JOIN matieres m "
				+ "ON m.id = em.matiere_id " + "Where em.etudiant_id =" + id_etudiant;
		ResultSet rSet = DBInteraction.Select(sqlMByIdN);
		try {
			while (rSet.next()) {
				matieres.add(new Matiere(rSet.getInt(1), rSet.getString(2), rSet.getFloat(3)));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			
			e.printStackTrace();
		}finally {
			DBInteraction.closeStatement(rSet);
		}

		DBInteraction.disconnect();
		return matieres;
	}
	
	public void deleteMaitreById(int id_matiere) {

		DBInteraction.connect();
		DBInteraction.disableAutoCommit();

		String sqldeleteME = "delete from etudiant_matiere where matiere_id =" + id_matiere;
		DBInteraction.Maj(sqldeleteME);

		String sqldeleteMN = "delete from niveau_matieres where  id_matiere ="+ id_matiere;
		DBInteraction.Maj(sqldeleteMN);
				

		String selectProfsSql = "select distinct id from profs where matiere_id =" + id_matiere;
		var resultSet = DBInteraction.Select(selectProfsSql);


///////////////////////////////////////////////////////////////////////////////////////////////
		try {
			while (resultSet.next()) {
				String sqldeletePallN = "delete from prof_niveau where prof_id=" + resultSet.getInt(1);
				DBInteraction.Maj(sqldeletePallN);

				String sqldelteprof = "delete from profs where id=" + resultSet.getInt(1);
				DBInteraction.Maj(sqldelteprof);

				String sqldeletuser = "delete from users where id=" + resultSet.getInt(1);
				DBInteraction.Maj(sqldeletuser);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBInteraction.closeStatement(resultSet);
		}
///////////////////////////////////////////////////////////////////////////////////////////////
		
		
		
		
		String sqldeleteM = "delete from matieres where id="+id_matiere;
		DBInteraction.Maj(sqldeleteM);

		DBInteraction.commit();
		
		DBInteraction.disconnect();
		
	}

}
