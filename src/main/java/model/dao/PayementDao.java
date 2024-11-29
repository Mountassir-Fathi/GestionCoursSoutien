package model.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import model.bo.Etudiant;
import model.bo.Payement;

public class PayementDao {

	private EtudiantDao etudiantDao = new EtudiantDao();

	public Map<Etudiant, Boolean> getPaymentList(int moi) {
		DBInteraction.connect();

		Map<Etudiant, Boolean> paymentList = new HashMap<Etudiant, Boolean>();
		String sql = "select etudiant_id, payer from payement_etudiant where payement_id = " + moi;
		var rs = DBInteraction.Select(sql);

		try {
			while (rs.next()) {
				var etudiant = etudiantDao.getEtudiantById(rs.getInt(1));
				var payer = rs.getBoolean(2);
				paymentList.put(etudiant, payer);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		DBInteraction.disconnect();
		return paymentList;
	}

	public void changeretatpayement(int id, Boolean payer) {
		DBInteraction.connect();

		DBInteraction.Maj("update  payement_etudiant set payer =" + payer + " where etudiant_id =" + id);
		DBInteraction.disconnect();
	}

	public Payement getPayementById(int moi) {
		String sql = "select * from payements where id = " + moi;
		DBInteraction.connect();
		ResultSet rs = DBInteraction.Select(sql);
		Payement payement = null;

		try {
			while (rs.next()) {
				payement = new Payement(rs.getInt(1), rs.getString(2), rs.getDouble(3));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		DBInteraction.disconnect();
		return payement;
	}
	
	public boolean statuePayementMoi(int etudiant_id , int moi) {
		boolean payer = false;
		DBInteraction.connect();
		ResultSet rSet = DBInteraction.Select("SELECT payer FROM centre_cours.payement_etudiant where payement_id ="+moi+" and etudiant_id = " +etudiant_id);
		try {
			if (rSet.next()) {
				payer = rSet.getBoolean(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		DBInteraction.disconnect();
		
		return payer;
	}
}
