package model.bo;

public class Matiere {

	@Override
	public String toString() {
		return "Matiere [id=" + id + ", nom=" + nom + ", prix=" + prix + "]";
	}
	private int id;
	private  String nom;
	private float prix;
	public Matiere(int id, String nom) {
		super();
		this.id = id;
		this.nom = nom;
	
	}
	public Matiere(int id, String nom, float prix) {
		super();
		this.id = id;
		this.nom = nom;
		this.prix = prix;
	}
	public Matiere() {
		super();
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
	public float getPrix() {
		return prix;
	}
	public void setPrix(float prix) {
		this.prix = prix;
	}
	
	
}
