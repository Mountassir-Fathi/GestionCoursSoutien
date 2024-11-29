package model.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import model.bo.Etudiant;
import model.bo.Groupe;
import model.bo.Matiere;
import model.bo.Niveau;
import model.bo.User;

public class EtudiantDao {
	private NiveauDao niveauDao = new NiveauDao();
	private GroupeDao groupeDao = new GroupeDao();
	private MatiereDao matiereDao = new MatiereDao();

	public User Authentificat(String log, String pass) {
		User user = null;
		// TODO Auto-generated method stub
		DBInteraction.connect();
		String sql = "select * from users where email ='" + log + "' and password = '" + pass + "'";

		ResultSet rs = DBInteraction.Select(sql);
		try {
			if (rs.next()) {
				user = new User();
				user.setId(rs.getInt(1));
				user.setNom(rs.getString(2));
				user.setPrenom(rs.getString(3));
				user.setMail(rs.getString(4));
				user.setPassword(rs.getString(5));
				user.setRole(rs.getString(6));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block

			e.printStackTrace();
		} finally {
			DBInteraction.closeStatement(rs);
		}
		DBInteraction.disconnect();
		return user;
	}

	// public Boolean existEtudiant(String log,String pass);
	public List<Etudiant> allEtudiants() {
		List<Etudiant> etudiants = new ArrayList<Etudiant>();
		String sql = "select * from users u" + " inner join etudiants e" + " on u.id = e.id";

		DBInteraction.connect();
		ResultSet rSet = DBInteraction.Select(sql);

		try {
			while (rSet.next()) {
				int id = rSet.getInt(1);
				String nom = rSet.getString(2);
				String prenom = rSet.getString(3);
				String mail = rSet.getString(4);
				String password = rSet.getString(5);
				String role = rSet.getString(6);
				String tel = rSet.getString(8);

				int niveau_id = rSet.getInt(9);
				Niveau niveau = niveauDao.getNiveauById(niveau_id);

				int group_id = rSet.getInt(10);
				Groupe groupe = groupeDao.findGroupeById(group_id);

				LocalDate date_incri = rSet.getDate(11).toLocalDate();
				Boolean compte_statue = rSet.getBoolean(12);

				List<Matiere> matieres = matiereDao.getMatieresByIDE(id);

				etudiants.add(new Etudiant(id, nom, prenom, mail, password, role, tel, niveau, groupe, compte_statue,
						date_incri, matieres));
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBInteraction.closeStatement(rSet);
		}

		DBInteraction.disconnect();

		return etudiants;

	}

	public void inscriEtudiant(String nom, String prenom, String email, String password, int niveau_id, String tel) {
//		password = "sdfsddfdfs";
		insert(nom, prenom, email, password, 1, 1, tel, false, null);
	}

	public void insertEtudiant(String nom, String prenom, String email, String password, int niveau_id, int group_id,
			String tel, String[] matieres) {
		insert(nom, prenom, email, password, niveau_id, group_id, tel, true, matieres);
	}

	private void insert(String nom, String prenom, String email, String password, int niveau_id, int group_id,
			String tel, boolean statue_compt, String[] matieres) {
		String sql = "insert into users(nom,prenom,email,password,role)" + " values('" + nom + "','" + prenom + "','"
				+ email + "','" + password + "','ETUDIANT')";

		DBInteraction.connect();
		DBInteraction.disableAutoCommit();
		int key = DBInteraction.Maj(sql);

		LocalDate date = LocalDate.now();

		String sql1 = "insert into etudiants values(" + key + ",'" + tel + "'," + niveau_id + "," + group_id + ",'"
				+ date + "'," + statue_compt + ")";

		DBInteraction.Maj(sql1);

		if (matieres != null && matieres.length != 0) {
			for (var matiere : matieres) {
				String sql2 = "insert into etudiant_matiere values(" + key + ", " + matiere + ")";
				DBInteraction.Maj(sql2);
			}

		}

		DBInteraction.commit();
		DBInteraction.disconnect();
	}

	public Etudiant getEtudiantById(int id) {
		Etudiant etudiant = null;
		String sql = "select * from users u" + " inner join etudiants e" + " on u.id = e.id and u.id = " + id;
		DBInteraction.connect();
		ResultSet rSet = DBInteraction.Select(sql);

		try {
			if (rSet.next()) {

				String nom = rSet.getString(2);
				String prenom = rSet.getString(3);
				String mail = rSet.getString(4);
				String password = rSet.getString(5);
				String role = rSet.getString(6);
				String tel = rSet.getString(8);

				int niveau_id = rSet.getInt(9);
				Niveau niveau = niveauDao.getNiveauById(niveau_id);

				int group_id = rSet.getInt(10);
				Groupe groupe = groupeDao.findGroupeById(group_id);

				LocalDate date_incri = rSet.getDate(11).toLocalDate();
				Boolean compte_statue = rSet.getBoolean(12);

				List<Matiere> matieres = matiereDao.getMatieresByIDE(id);

				etudiant = new Etudiant(id, nom, prenom, mail, password, role, tel, niveau, groupe, compte_statue,
						date_incri, matieres);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		DBInteraction.disconnect();

		return etudiant;

	}

	public void deleteEtudiantById(int id) {

		DBInteraction.connect();
		DBInteraction.disableAutoCommit();

		String sqldeletePE = "delete from payement_etudiant where etudiant_id = " + id;
		String sqldeletEM = "delete from etudiant_matiere where etudiant_id = " + id;
		String sqldeleteE = "delete from etudiants where id =" + id;
		String sqldelectU = "delete from users where id =" + id;
		DBInteraction.Maj(sqldeletePE);
		DBInteraction.Maj(sqldeletEM);
		DBInteraction.Maj(sqldeleteE);
		DBInteraction.Maj(sqldelectU);

		DBInteraction.commit();
		DBInteraction.disconnect();

	}

	// test password
	public void updateEtudiantById(Etudiant etudiant) {

//		password = "sdfsddfdfs";
		DBInteraction.connect();
		DBInteraction.disableAutoCommit();
		String sql;

		if (etudiant.getPassword() == null || etudiant.getPassword().equals("")) {

			sql = "update users set " + "nom='" + etudiant.getNom() + "',prenom='" + etudiant.getPrenom() + "',email='"
					+ etudiant.getMail() + "' where id = " + etudiant.getId();
		} else {
			sql = "update users set " + "nom='" + etudiant.getNom() + "',prenom='" + etudiant.getPrenom() + "',email='"
					+ etudiant.getMail() + "',password='" + etudiant.getPassword() + "' where id = " + etudiant.getId();
		}

		DBInteraction.Maj(sql);

		String sql1 = "update etudiants set " + "tel='" + etudiant.getTel() + "',niveau_id="
				+ etudiant.getNiveau().getId() + ",group_id=" + etudiant.getGroupe().getId() + ",compte_statue="
				+ etudiant.getStatu_compt() + " where id = " + etudiant.getId();
		DBInteraction.Maj(sql1);

		String sql2 = "delete from etudiant_matiere where etudiant_id = " + etudiant.getId();
		DBInteraction.Maj(sql2);

		etudiant.getMatieres().forEach(matiere -> {
			DBInteraction.Maj("insert into etudiant_matiere values (" + etudiant.getId() + "," + matiere.getId() + ")");
		});

		DBInteraction.commit();
		DBInteraction.disconnect();

	}

	public void activerCompte(int etudiant_id) {

		DBInteraction.connect();

		String sqlavtivecompt = "update etudiants set compte_statue = true where id =" + etudiant_id;
		DBInteraction.Maj(sqlavtivecompt);
		
		String sql = "insert into payement_etudiant  values("+LocalDate.now().getMonthValue()+","+etudiant_id+",1)";
		DBInteraction.Maj(sql);

		DBInteraction.disconnect();

	}

	public void desactiverCompte(int etudiant_id) {

		DBInteraction.connect();

		String sqlavtivecompt = "update etudiants set compte_statue = false where id =" + etudiant_id;
		DBInteraction.Maj(sqlavtivecompt);

		DBInteraction.disconnect();

	}

	public List<Etudiant> allEtudiantsInscri(Boolean inscri) {
		List<Etudiant> etudiants = new ArrayList<Etudiant>();

		String sql = "select * from users u" + " inner join etudiants e" + " on u.id = e.id and e.compte_statue ="+ inscri;
				

		DBInteraction.connect();
		ResultSet rSet = DBInteraction.Select(sql);

		try {
			while (rSet.next()) {
				int id = rSet.getInt(1);
				String nom = rSet.getString(2);
				String prenom = rSet.getString(3);
				String mail = rSet.getString(4);
				String password = rSet.getString(5);
				String role = rSet.getString(6);
				String tel = rSet.getString(8);

				int niveau_id = rSet.getInt(9);
				Niveau niveau = niveauDao.getNiveauById(niveau_id);

				int group_id = rSet.getInt(10);
				Groupe groupe = groupeDao.findGroupeById(group_id);

				LocalDate date_incri = rSet.getDate(11).toLocalDate();
				Boolean compte_statue = rSet.getBoolean(12);

				List<Matiere> matieres = matiereDao.getMatieresByIDE(id);

				etudiants.add(new Etudiant(id, nom, prenom, mail, password, role, tel, niveau, groupe, compte_statue,
						date_incri, matieres));
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block

			e.printStackTrace();
		} finally {
			DBInteraction.closeStatement(rSet);
		}

		DBInteraction.disconnect();

		return etudiants;

	}

	public void supprimertousetudiant() {
		DBInteraction.connect();

		this.allEtudiantsInscri(false).forEach(etudiant -> {
			this.deleteEtudiantById(etudiant.getId());
		});

		DBInteraction.disconnect();
	}

	public Map<Etudiant, Boolean> getapsensesByIdseanse(int seanse_id) {
		Map<Etudiant, Boolean> etudiantpresenseMap = new HashMap<Etudiant, Boolean>();
		DBInteraction.connect();
		ResultSet rSet = DBInteraction.Select("select * from presences where seance_id ="+seanse_id);
		try {
			while(rSet.next()) {
				etudiantpresenseMap.put(this.getEtudiantById(rSet.getInt(2)),rSet.getBoolean(3));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		DBInteraction.disconnect();
		
		return etudiantpresenseMap;
	}

	public List<Etudiant> getEtudiantByNiveauId(int id) {
		List<Etudiant> etudiants = new ArrayList<Etudiant>();
		DBInteraction.connect();
		ResultSet rSet = DBInteraction.Select("select * from etudiants where niveau_id = " + id);
		
		try {
			while (rSet.next()) {
				var etudiantId = rSet.getInt(1);
				var etudiant = new Etudiant();
				etudiant.setMatieres(matiereDao.getMatieresByIDE(etudiantId));
				etudiants.add(etudiant);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		DBInteraction.disconnect();
		return etudiants;
	}

}
