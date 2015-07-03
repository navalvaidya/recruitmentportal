package com.ideas;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class FileDownloadController
 */
public class FileDownloadController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       final String[][] contentTypes={{"pdf" , "application/pdf"}, {"docx", "application/vnd.ms-word"},{"xls","application/vnd.ms-excel"} };
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FileDownloadController() {
        super();
        
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Starting Download..............");
		LoadConfigFile config=new LoadConfigFile();
	    String DBUrl=config.DBUrl();
	    String DBPasswd=config.DBPasswd();
	    String DBUser=config.DBUser();
		try{
			String id =request.getParameter("id");
			System.out.println("id: "+id);
		Class.forName("com.mysql.jdbc.Driver");
	
		Connection con = DriverManager.getConnection( DBUrl,DBUser,DBPasswd);
		PreparedStatement stat1=con.prepareStatement("SELECT * FROM employee WHERE id=?"); 
		stat1.setString(1, id);
		ResultSet result = stat1.executeQuery();
		String otherfile=null;
		String name=null;
		
		while(result.next()){
			otherfile=result.getString("otherfile");
			name=result.getString("name");
			System.out.println("otherfile: "+otherfile);
		}
		 File file = new File(otherfile);
		 String contentType = getContentType(otherfile.split("\\.")[1]);
		 response.setContentType(contentType);
		 response.addHeader("Content-Disposition", "attachment; filename="+name+"other."+otherfile.split("\\.")[1]);
		 response.setContentLength((int) file.length());
		 ServletOutputStream servletOutputStream = response.getOutputStream();
		 BufferedInputStream bufferedInputStream = new BufferedInputStream(new FileInputStream(file));
		 int byteRead = bufferedInputStream.read();
		 while(byteRead !=-1){
			 servletOutputStream.write(byteRead);
			 byteRead = bufferedInputStream.read();			
		 }
		 if(servletOutputStream != null) servletOutputStream.close();
		 if(bufferedInputStream != null) bufferedInputStream.close();
		 con.close();
	}catch(Exception e){
		RequestDispatcher rd=request.getRequestDispatcher("/jsp/SearchResult.jsp");  
        rd.forward(request, response); 	
	 }
	}
	
	private String getContentType(String fileType){
		String returnType = null;
		for(int i=0; i<contentTypes.length; i++){
			if(fileType.equals(contentTypes[i][0])) returnType = contentTypes[i][1];
		}
		
		return returnType;
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}
}
