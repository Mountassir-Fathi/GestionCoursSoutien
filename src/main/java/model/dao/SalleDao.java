package model.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.bo.Salle;

public class SalleDao {

	public String getsallebyid(int id) {
		DBInteraction.connect();
		String nom = null;

		ResultSet rSet = DBInteraction.Select("select nemuro from salle where id =" + id);
		try {
			if (rSet.next()) {
				nom = rSet.getString(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		DBInteraction.disconnect();
		return nom;
	}

	public void ajouterSalle(String nemuro) {
		DBInteraction.connect();

		String sqlajouS = "insert into salle(nemuro) values('" + nemuro + "')";
		DBInteraction.Maj(sqlajouS);
		DBInteraction.disconnect();

	}

	public void deleteSalleById(int salle_id) {

		DBInteraction.connect();
		String sqldeleteS = "delete from salle where id = " + salle_id;
		DBInteraction.Maj(sqldeleteS);
		DBInteraction.disconnect();

	}

	public void updateSalle(Salle salle) {

		DBInteraction.connect();
		String sqlupdateS = "update salle set nemuro = '" + salle.getNom() + "' where id =" + salle.getId();
		DBInteraction.Maj(sqlupdateS);
		DBInteraction.disconnect();

	}

	public List<Salle> getAllSalles() {
		List<Salle> salles = new ArrayList<Salle>();
		DBInteraction.connect();
		String sqlgetallS = "select * from salle";
		ResultSet rSet = DBInteraction.Select(sqlgetallS);

		try {
			while (rSet.next()) {
				salles.add(new Salle(rSet.getInt(1), rSet.getString(2)));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block

			e.printStackTrace();
		} finally {
			DBInteraction.closeStatement(rSet);
			DBInteraction.disconnect();

		}
		return salles;

	}

}
