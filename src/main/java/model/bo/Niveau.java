package model.bo;

import java.util.List;

public class Niveau {

	private int id;
	private String nom;
	private List<Matiere> matieres;
	private int nbretudiants = 0;
	
	public Niveau(int id, String nom, List<Matiere> matieres, int nbretudiants) {
		super();
		this.id = id;
		this.nom = nom;
		this.matieres = matieres;
		this.nbretudiants = nbretudiants;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getNom() {
		return nom;
	}

	public void setNom(String nom) {
		this.nom = nom;
	}

	public List<Matiere> getMatieres() {
		return matieres;
	}

	public void setMatieres(List<Matiere> matieres) {
		this.matieres = matieres;
	}

	public int getNbretudiants() {
		return nbretudiants;
	}

	public void setNbretudiants(int nbretudiants) {
		this.nbretudiants = nbretudiants;
	}

	@Override
	public String toString() {
		return "Niveau [id=" + id + ", nom=" + nom + ", matieres=" + matieres + ", nbretudiants=" + nbretudiants + "]";
	}
	
	
	
	
}
