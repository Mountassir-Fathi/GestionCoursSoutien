package utils;

import java.awt.Color; 
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import com.lowagie.text.Chunk;
import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.FontFactory;
import com.lowagie.text.Paragraph;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import model.bo.Emploi;
import model.bo.Etudiant;
import model.bo.Groupe;
import model.bo.Matiere;
import model.bo.Niveau;

public class GeneratePDF {
	private final Color BORDER_COLOR = new Color(80, 80, 80);
	private final String font = FontFactory.HELVETICA;
	private final Document document;
	private int NumberOfColumns = 0;

	public GeneratePDF(Document document) {
		this.document = document;
	}
	
	
public void sessionInfo(Emploi emploi) {
	
	var niveau = emploi.getNiveau().getNom().toUpperCase();
	var groupe = emploi.getGroupe().getNom().toUpperCase();
	var matiere = emploi.getMatiere().getNom().toUpperCase();
	var salle = emploi.getSalle().toUpperCase();
	var date = emploi.getDate();
	var time = emploi.getTimestart() +"  >>>>>>  " + emploi.getTimestart();


		
		PdfPTable  table = new PdfPTable(5);
		table.setWidthPercentage(100);

		PdfPCell _time = createSessionInfoCell("Durée de Séance", Font.BOLDITALIC, 2, Element.ALIGN_CENTER);
		PdfPCell timeValue = createSessionInfoCell(time, Font.NORMAL, 3, Element.ALIGN_CENTER);

		PdfPCell _date = createSessionInfoCell("Date", Font.BOLDITALIC, 1, Element.ALIGN_CENTER);
		PdfPCell dateValue = createSessionInfoCell(date, Font.NORMAL, 1, Element.ALIGN_CENTER);

		PdfPCell _salle = createSessionInfoCell("Salle", Font.BOLDITALIC, 1, Element.ALIGN_CENTER);
		PdfPCell salleValue = createSessionInfoCell(salle, Font.NORMAL, 1, Element.ALIGN_CENTER);
		
		PdfPCell _matiere = createSessionInfoCell("Matière", Font.BOLDITALIC, 1, Element.ALIGN_CENTER);
		PdfPCell matiereValue = createSessionInfoCell(matiere, Font.NORMAL, 1, Element.ALIGN_CENTER);

		PdfPCell _groupe = createSessionInfoCell("Groupe", Font.BOLDITALIC, 1, Element.ALIGN_CENTER);
		PdfPCell groupeValue = createSessionInfoCell(groupe, Font.NORMAL, 1, Element.ALIGN_CENTER);

		PdfPCell _niveau = createSessionInfoCell("Niveau", Font.BOLDITALIC, 1, Element.ALIGN_CENTER);
		PdfPCell niveauValue = createSessionInfoCell(niveau, Font.NORMAL, 1, Element.ALIGN_CENTER);
		
		table.addCell(_time);
		table.addCell(timeValue);
		

		table.addCell(_date);
		table.addCell(_salle);
		table.addCell(_matiere);
		table.addCell(_groupe);
		table.addCell(_niveau);
		
		table.addCell(dateValue);
		table.addCell(salleValue);
		table.addCell(matiereValue);
		table.addCell(groupeValue);
		table.addCell(niveauValue);
		

        document.add(table);
        document.add(new Paragraph("\n"));
	}
	
	public void addTableTitle(String title) {
		PdfPTable  table = new PdfPTable(1);
		table.setWidthPercentage(100);

		Font black = FontFactory.getFont(font, 25, Font.UNDERLINE, Color.BLACK);
		black.setStyle(Font.ITALIC | Font.UNDERLINE);

		Paragraph paragraph  = new Paragraph(new Chunk(title,  black));

		PdfPCell cell = new PdfPCell(paragraph);
		cell.setPadding(25);
		cell.setHorizontalAlignment(1);
		cell.setBorderColor(Color.WHITE);
		table.addCell(cell);

		
        document.add(table);
	}
	
	public void createTableHeader(String ...args) {
		NumberOfColumns = args.length;
		PdfPTable  table = new PdfPTable(NumberOfColumns);
		table.setWidthPercentage(100);
		Arrays.stream(args).forEach(columnHead -> {
            Font white = FontFactory.getFont(font, Font.DEFAULTSIZE, Font.BOLD, Color.BLACK);

			Paragraph paragraph = new Paragraph(new Chunk(columnHead, white));
			PdfPCell cell = new PdfPCell(paragraph);

			cell.setBorderColor(BORDER_COLOR);
			cell.setBorderWidth(1.5f);
			cell.setHorizontalAlignment(1);
			cell.setPadding(12);
			
			table.addCell(cell);
		});
        document.add(table);
	}

	public void createTableBody(Map<Etudiant, Boolean> map) {
		PdfPTable table = new PdfPTable(NumberOfColumns);
		table.setWidthPercentage(100);
		map.forEach((etudiant, status)-> {
				PdfPCell cell1 = createCell(etudiant.getNom());
				PdfPCell cell2 = createCell(etudiant.getPrenom());
				PdfPCell cell3 = createCell(etudiant.getTel());
				PdfPCell cell4 = createStatusCell(status);				

				table.addCell(cell1);
				table.addCell(cell2);
				table.addCell(cell3);
				table.addCell(cell4);
		});
        document.add(table);
	}
	
	private PdfPCell createCell(String para) {
		Font black = FontFactory.getFont(font, Font.DEFAULTSIZE, Font.ITALIC, Color.BLACK);
		Paragraph paragraph  = new Paragraph(new Chunk(para,  black));
		PdfPCell cell = new PdfPCell(paragraph);
		
		cell.setBorderColor(BORDER_COLOR);
		cell.setHorizontalAlignment(1);
		cell.setBorderWidth(1.5f);
		cell.setPadding(12);
		
		return cell;
	}
	
	private PdfPCell createStatusCell(Boolean field) {
		String status = !field? "4": " ";
		Font black = FontFactory.getFont(FontFactory.ZAPFDINGBATS, Font.DEFAULTSIZE, Font.BOLDITALIC, Color.BLACK);
		Paragraph paragraph  = new Paragraph(new Chunk(status,  black));
		PdfPCell cell = new PdfPCell(paragraph);

		cell.setBorderColor(BORDER_COLOR);
		cell.setHorizontalAlignment(1);
		cell.setBorderWidth(1.5f);
		cell.setPadding(12);
		return cell;
	}
	
	private PdfPCell createSessionInfoCell(String phrase, int fontStyle, int colspan, int horizontalAlignment) {
		Font font = FontFactory.getFont(FontFactory.HELVETICA, Font.DEFAULTSIZE, fontStyle, Color.BLACK);
		Paragraph paragraph = new Paragraph(phrase, font);
		PdfPCell cell = new PdfPCell(paragraph);
		cell.setBorderColor(BORDER_COLOR);
		cell.setHorizontalAlignment(horizontalAlignment);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setPadding(12);
		cell.setBorderWidth(1.5f);
		cell.setColspan(colspan);
		return cell;
	}
}
