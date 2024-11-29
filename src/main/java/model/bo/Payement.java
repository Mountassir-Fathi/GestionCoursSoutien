package model.bo;

public class Payement {
	
	Integer id;
	String moi;
	Double total;
	
	public Payement(Integer id, String moi, Double total) {
		super();
		this.id = id;
		this.moi = moi;
		this.total = total;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getMoi() {
		return moi;
	}
	public void setMoi(String moi) {
		this.moi = moi;
	}
	public Double getTotal() {
		return total;
	}
	public void setTotal(Double total) {
		this.total = total;
	}
	
	
	

}
