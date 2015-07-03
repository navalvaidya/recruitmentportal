package com.ideas;

import java.io.File;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.Date;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class ExcelExtractorClass {
	public void ExcelExtract(String ExcelPath){
		LoadConfigFile config=new LoadConfigFile();
	    String DBUrl=config.DBUrl();
	    String DBPasswd=config.DBPasswd();
	    String DBUser=config.DBUser();
	    String temp[] = new String[30];
	    try{
	File excel = new File(ExcelPath);
	FileInputStream fis = new FileInputStream(excel);
	Workbook wb = new XSSFWorkbook(fis);
	Sheet ws = wb.getSheet("Sheet1");

	int rowNum = ws.getLastRowNum();
	int colNum = ws.getRow(0).getLastCellNum();
	String[][] data = new String[rowNum][colNum];
	
	for(int i=0;i<rowNum;i++){
		String value = null;
		Row row = ws.getRow(i+1);
	
		for(int j=0;j<colNum;j++){
			Cell cell = row.getCell(j);
			if(Cell.CELL_TYPE_STRING==cell.getCellType()){
			 value = cell.getStringCellValue();
			}
			else if(Cell.CELL_TYPE_NUMERIC==cell.getCellType()){
				value = Double.toString(cell.getNumericCellValue()) ;
			}
			data[i][j] = value;
			temp[j]=value;
				
		}
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(DBUrl,DBUser,DBPasswd);
		PreparedStatement stat2=con.prepareStatement("INSERT INTO employee (department,name, designation,experience,cctc,ectc,prevorg,comments,createdon,lastmodified) VALUES (?,?,?,?,?,?,?,?,?,?)");
		for(int k=0;k<8;k++)
		{
		stat2.setString(k+1, temp[k]);
		}
		Date date = new Date();
		stat2.setString(9, date.toString());
		stat2.setString(10, date.toString());
		stat2.executeUpdate();
		
	}
	wb.close();
	excel.delete();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}
