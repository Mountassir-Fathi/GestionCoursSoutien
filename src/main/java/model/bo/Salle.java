package model.bo;

public class Salle {
	
	private int id;
	private String nom;
	
	public Salle(int id, String nomString) {
		super();
		this.id = id;
		this.nom = nomString;
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
	
	

	
	
	

}
