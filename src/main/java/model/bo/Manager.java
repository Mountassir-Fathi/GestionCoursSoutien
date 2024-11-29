package model.bo;

public class Manager extends User {

	public Manager() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public String toString() {
		return "Manager [id=" + id + ", nom=" + nom + ", prenom=" + prenom + ", mail=" + mail + ", password=" + password
				+ ", role=" + role + ", getId()=" + getId() + ", getNom()=" + getNom() + ", getPrenom()=" + getPrenom()
				+ ", getMail()=" + getMail() + ", getPassword()=" + getPassword() + ", getRole()=" + getRole()
				+ ", getClass()=" + getClass() + ", hashCode()=" + hashCode() + ", toString()=" + super.toString()
				+ "]";
	}

	public Manager(int id, String nom, String prenom, String mail, String password, String role) {
		super(id, nom, prenom, mail, password, role);
		// TODO Auto-generated constructor stub
	}

}
