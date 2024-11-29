package model.bo;

public class Groupe {

	@Override
	public String toString() {
		return "Groupe [id=" + id + ", nom=" + nom + ", niveau=" + niveau + "]";
	}

	private int id;
	private String nom;
	private Niveau niveau;
	private int nombreEtudiantGR;

	public Groupe() {
		super();
	}
	
	public Groupe(int id, String nom, Niveau niveau) {
		super();
		this.id = id;
		this.nom = nom;
		this.niveau = niveau;
		
		
	}

	public Groupe(int id, String nom, Niveau niveau,int nombreEtudiantGR) {
		super();
		this.id = id;
		this.nom = nom;
		this.niveau = niveau;
		this.nombreEtudiantGR = nombreEtudiantGR;
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

	public Niveau getNiveau() {
		return niveau;
	}

	public void setNiveau(Niveau niveau) {
		this.niveau = niveau;
	}

	public int getNombreEtudiantGR() {
		return nombreEtudiantGR;
	}

	public void setNombreEtudiantGR(int nombreEtudiantGR) {
		this.nombreEtudiantGR = nombreEtudiantGR;
	}
	

}
