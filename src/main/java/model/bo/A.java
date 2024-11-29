package model.bo;

public class A {
	private Etudiant etudiant;
	private boolean payer;
	public boolean isPayer() {
		return payer;
	}
	public void setPayer(boolean payer) {
		this.payer = payer;
	}
	public Etudiant getEtudiant() {
		return etudiant;
	}
	public void setEtudiant(Etudiant etudiant) {
		this.etudiant = etudiant;
	}
	public A(Etudiant etudiant, boolean payer) {
		super();
		this.etudiant = etudiant;
		this.payer = payer;
	}
	
}


