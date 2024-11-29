package model.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.bo.Emploi;
import model.bo.Etudiant;
import model.bo.Groupe;
import model.bo.Matiere;
import model.bo.Niveau;
import model.bo.Prof;

public class EmploiDao {
	private NiveauDao niveauDao = new NiveauDao();
	private MatiereDao matiereDao = new MatiereDao();
	private GroupeDao groupeDao = new GroupeDao();
	private SalleDao salleDao = new SalleDao();
	
	public void deleteseanse(int id) {
		DBInteraction.connect();
		DBInteraction.disableAutoCommit();

		String sql = "delete from presences where seance_id ="+id;
		DBInteraction.Maj(sql);	
		String sql1 = "delete from emplois where id ="+id;
		DBInteraction.Maj(sql1);	

		DBInteraction.commit();
		DBInteraction.disconnect();
		
	}
	
	/*++++++++++++++++++++++++++++++++++*/
	public List<Emploi> getEmploiNow(){
		DBInteraction.connect();
		List<Emploi> emplois = new ArrayList<Emploi>();
		String sql = "SELECT * FROM emplois WHERE DATE(date) = CURDATE() AND CURTIME() BETWEEN timestart AND timeend;";
		ResultSet rSet = DBInteraction.Select(sql);

		try {
			while (rSet.next()) {
				int id = rSet.getInt("id");
				Niveau niveau = niveauDao.getNiveauById(rSet.getInt("niveau_id"));
				Groupe groupe = groupeDao.findGroupeById(rSet.getInt("groupe_id"));
				Matiere matiere = matiereDao.getMatiereById(rSet.getInt("matiere_id"));
				String salle = salleDao.getsallebyid(rSet.getInt("salle_id"));
				String timestart = rSet.getTime("timestart").toString().substring(0, 5);
				String timeend =  rSet.getTime("timeend").toString().substring(0, 5);
				String date = rSet.getDate("date").toString();
				Boolean fait = rSet.getBoolean("fait");

				emplois.add(new Emploi(id, niveau, groupe, matiere, salle, timestart, timeend, date, fait));

			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		DBInteraction.disconnect();
		
		return emplois;
	}

	
	
	
	
	/*++++++++++++++++++++++++++++++++++*/
	
	

	public List<Emploi> getallEmplois() {
		DBInteraction.connect();
		List<Emploi> emplois = new ArrayList<Emploi>();
		String sql = "select * from emplois";
		ResultSet rSet = DBInteraction.Select(sql);

		try {
			while (rSet.next()) {
				int id = rSet.getInt("id");
				Niveau niveau = niveauDao.getNiveauById(rSet.getInt("niveau_id"));
				Groupe groupe = groupeDao.findGroupeById(rSet.getInt("groupe_id"));
				Matiere matiere = matiereDao.getMatiereById(rSet.getInt("matiere_id"));
				String salle = salleDao.getsallebyid(rSet.getInt("salle_id"));
				String timestart = rSet.getTime("timestart").toString().substring(0, 5);
				String timeend =  rSet.getTime("timeend").toString().substring(0, 5);
				String date = rSet.getDate("date").toString();
				Boolean fait = rSet.getBoolean("fait");

				emplois.add(new Emploi(id, niveau, groupe, matiere, salle, timestart, timeend, date, fait));

			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		DBInteraction.disconnect();
		return emplois;
	}

	public void ajouterEmplois(int niveau_id, int groupe_id, int matiere_id, int salle_id, String timestart,
			String timeend, String date) {
		DBInteraction.connect();
		String sql = "insert into emplois(niveau_id, groupe_id, matiere_id, salle_id, timestart, timeend, date ) "
				+ "values(" + niveau_id + "," + groupe_id + "," + matiere_id + "," + salle_id + ",'" + timestart + "','"
				+ timeend + "','" + date + "')";
		DBInteraction.Maj(sql);

		DBInteraction.disconnect();
	}

	public void modifierEmplois(int id, int niveau_id, int groupe_id, int matiere_id, int salle_id, String timestart,
			String timeend, String date) {
		DBInteraction.connect();
		String sql = "UPDATE emplois SET niveau_id =" + niveau_id + ", groupe_id =" + groupe_id + ", matiere_id ="
				+ matiere_id + ", salle_id = " + salle_id + "," + "timestart = '" + timestart + "', timeend = '"
				+ timeend + "', date = '" + date + "' WHERE id =" + id;

		DBInteraction.Maj(sql);

		DBInteraction.disconnect();

	}
	
	public List<Emploi> getallSeansebyprof(Prof prof){
		DBInteraction.connect();
		List<Emploi> emplois = new ArrayList<Emploi>();
		String sql = "select * from emplois where niveau_id in (select niveau_id from prof_niveau where prof_id ="+prof.getId()+") and matiere_id = "+prof.getMatiere().getId();
		ResultSet rSet = DBInteraction.Select(sql);

		try {
			while (rSet.next()) {
				int id = rSet.getInt("id");
				Niveau niveau = niveauDao.getNiveauById(2);
				Groupe groupe = groupeDao.findGroupeById(rSet.getInt("groupe_id"));
				Matiere matiere = prof.getMatiere();
				String salle = salleDao.getsallebyid(rSet.getInt("salle_id"));
				String timestart = rSet.getTime("timestart").toString().substring(0, 5);
				String timeend = rSet.getTime("timeend").toString().substring(0, 5);
				String date = rSet.getDate("date").toString();
				Boolean fait = rSet.getBoolean("fait"); 
				emplois.add(new Emploi(id, niveau, groupe, matiere, salle, timestart, timeend, date, fait));

			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		DBInteraction.disconnect();
		return emplois;
	}
	
	public List<Emploi> getallSeansebyetudiant(Etudiant etudiant){
		DBInteraction.connect();
		List<Emploi> emplois = new ArrayList<Emploi>();
		String sql = "select * from emplois where niveau_id ="+etudiant.getNiveau().getId()+" and groupe_id = "+etudiant.getGroupe().getId()+" and matiere_id in (select matiere_id from etudiant_matiere where etudiant_id ="+etudiant.getId()+")";
		ResultSet rSet = DBInteraction.Select(sql);

		try {
			while (rSet.next()) {
				int id = rSet.getInt("id");
				Niveau niveau = niveauDao.getNiveauById(rSet.getInt("niveau_id"));
				Groupe groupe = etudiant.getGroupe();
				Matiere matiere = matiereDao.getMatiereById(rSet.getInt("matiere_id"));
				String salle = salleDao.getsallebyid(rSet.getInt("salle_id"));
				String timestart = rSet.getString("timestart").toString().substring(0, 5);
				String timeend = rSet.getString("timeend").toString().substring(0, 5);
				String date = rSet.getDate("date").toString();
				Boolean fait = rSet.getBoolean("fait"); 
				
				emplois.add(new Emploi(id, niveau, groupe, matiere, salle, timestart, timeend, date, fait));

			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		DBInteraction.disconnect();
		return emplois;
	}
	
	public Emploi getEmploiById(int seanse_id) {
		DBInteraction.connect();
		Emploi emploi = null;
		String sql = "select * from emplois where id = "+seanse_id;
		ResultSet rSet = DBInteraction.Select(sql);

		try {
			if (rSet.next()) {
				int id = rSet.getInt("id");
				Niveau niveau = niveauDao.getNiveauById(rSet.getInt("niveau_id"));
				Groupe groupe = groupeDao.findGroupeById(rSet.getInt("groupe_id"));
				Matiere matiere = matiereDao.getMatiereById(rSet.getInt("matiere_id"));
				String salle = salleDao.getsallebyid(rSet.getInt("salle_id"));
				String timestart = rSet.getTime("timestart").toString().substring(0, 5);
				String timeend =  rSet.getTime("timeend").toString().substring(0, 5);
				String date = rSet.getDate("date").toString();
				Boolean fait = rSet.getBoolean("fait");

				emploi = new Emploi(id, niveau, groupe, matiere, salle, timestart, timeend, date, fait);

			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		DBInteraction.disconnect();
		return emploi;
	}

	public void present(int seanse_id, int etudiant_id, boolean etat) {
		DBInteraction.connect();
		DBInteraction.Maj("UPDATE `centre_cours`.`presences` SET `pesence` = "+etat+" WHERE (`seance_id` = '"+seanse_id+"') and (`etudiant_id` = '"+etudiant_id+"')");
		DBInteraction.disconnect();
		
	}

	public void updateFait(boolean fait, int seanse_id) {
		DBInteraction.connect();
		DBInteraction.Maj("UPDATE `centre_cours`.`emplois` SET `fait` = " + fait + " where id = " + seanse_id);
		DBInteraction.disconnect();
	}

}
