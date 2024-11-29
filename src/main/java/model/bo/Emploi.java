package model.bo;

public class Emploi {

	private int id;
	private Niveau niveau;
	private Groupe groupe;
	private Matiere matiere;
	private String salle;
	private String timestart;
	private String timeend;
	private String date;
	private boolean fait;

	public Emploi(int id, Niveau niveau, Groupe groupe, Matiere matiere, String salle, String timestart, String timeend,
			String date, boolean fait) {
		super();
		this.id = id;
		this.niveau = niveau;
		this.groupe = groupe;
		this.matiere = matiere;
		this.salle = salle;
		this.timestart = timestart;
		this.timeend = timeend;
		this.date = date;
		this.fait = fait;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
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

	public Matiere getMatiere() {
		return matiere;
	}

	public void setMatiere(Matiere matiere) {
		this.matiere = matiere;
	}

	public String getTimestart() {
		return timestart;
	}

	public void setTimestart(String timestart) {
		this.timestart = timestart;
	}

	public String getTimeend() {
		return timeend;
	}

	public void setTimeend(String timeend) {
		this.timeend = timeend;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	@Override
	public String toString() {
		return "Emploi [id=" + id + ", niveau=" + niveau + ", groupe=" + groupe + ", matiere=" + matiere
				+ ", timestart=" + timestart + ", timeend=" + timeend + ", date=" + date + "]";
	}

	public String getSalle() {
		return salle;
	}

	public void setSalle(String salle) {
		this.salle = salle;
	}

	public boolean isFait() {
		return fait;
	}

	public void setFait(boolean fait) {
		this.fait = fait;
	}

}
