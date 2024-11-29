package model.bo;

import java.time.LocalDate;

import java.util.List;

public class Etudiant extends User {
	
	private String tel;
	private Niveau niveau;
	private Groupe groupe;
	private Boolean statu_compt;
	private LocalDate date_debut;
	private List<Matiere> matieres;

	public Etudiant() {
		super()
;		// TODO Auto-generated constructor stub
	}

	public Etudiant(int id, String nom, String prenom,
			String mail, String password, String role,
			String tel,Niveau niveau, Groupe groupe, Boolean statu_compt,  LocalDate date_debut,List<Matiere> matieres ) {
		super(id, nom, prenom, mail, password, role);

		this.tel = tel;
		this.niveau = niveau;
		this.groupe = groupe;
		this.statu_compt = statu_compt;
		this.date_debut = date_debut;
		this.matieres=matieres;
	}

	public List<Matiere> getMatieres() {
		return matieres;
	}

	public void setMatieres(List<Matiere> matieres) {
		this.matieres = matieres;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public Niveau getNiveau() {
		return niveau;
	}

	public void setNiveau(Niveau niveau) {
		this.niveau = niveau;
	}

	public Groupe getGroupe() {
		return groupe;
	}

	public void setGroupe(Groupe groupe) {
		this.groupe = groupe;
	}

	public Boolean getStatu_compt() {
		return statu_compt;
	}

	public void setStatu_compt(Boolean statu_compt) {
		this.statu_compt = statu_compt;
	}

	public LocalDate getDate_debut() {
		return date_debut;
	}

	public void setDate_debut(LocalDate date_debut) {
		this.date_debut = date_debut;
	}

	

	
	public float getCotisationAnnuelle() {
		
		float som = 0;
		for (Matiere matiere : matieres) {
			som+=matiere.getPrix();		
		}
		
		return som;
		
	}

	@Override
	public String toString() {
		return "Etudiant [tel=" + tel + ", niveau=" + niveau + ", groupe=" + groupe + ", statu_compt=" + statu_compt
				+ ", date_debut=" + date_debut + ", matieres=" + matieres + ", id=" + id + ", nom=" + nom + ", prenom="
				+ prenom + ", mail=" + mail + ", password=" + password + ", role=" + role + "]";
	}
}
