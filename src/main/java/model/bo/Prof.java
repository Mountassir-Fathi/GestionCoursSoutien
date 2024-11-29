package model.bo;

import java.time.LocalDate;
import java.util.List;

public class Prof extends User {

	private LocalDate date_debut;
	private String tel;
	private Matiere matiere;
	private List<Niveau> niveaux ;

	public Prof() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Prof(int id, String nom, String prenom, String mail, String password, String role, String tel,
			Matiere matiere, LocalDate date, List<Niveau> niveaux) {
		super(id, nom, prenom, mail, password, role);

		this.matiere = matiere;
		this.tel = tel;
		this.date_debut = date;
		this.niveaux = niveaux;
		// TODO Auto-generated constructor stub
	}

	@Override
	public String toString() {
		return "Prof [date_debut=" + date_debut + ", tel=" + tel + ", matiere=" + matiere + ", id=" + id + ", nom="
				+ nom + ", prenom=" + prenom + ", mail=" + mail + ", password=" + password + ", role=" + role + ", niveaux=" + niveaux + "]";
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public LocalDate getDate_debut() {
		return date_debut;
	}

	public void setDate_debut(LocalDate date_debut) {
		this.date_debut = date_debut;
	}

	public Matiere getMatiere() {
		return matiere;
	}

	public void setMatiere(Matiere matiere) {
		this.matiere = matiere;
	}

	public List<Niveau> getNiveaux() {
		return niveaux;
	}

	public void setNiveaux(List<Niveau> niveaux) {
		this.niveaux = niveaux;
	}

}
