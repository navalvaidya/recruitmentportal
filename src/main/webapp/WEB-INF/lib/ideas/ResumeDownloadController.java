package com.ideas;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ResumeDownloadController
 */
public class ResumeDownloadController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ResumeDownloadController() {
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
		String resumelink=null;
		String name=null;
		while(result.next()){
			resumelink=result.getString("resumelink");
			name= result.getString("name");
			System.out.println("resumelink: "+resumelink);
		}
		 File file = new File(resumelink);
		 response.setContentType("application/pdf");
		 response.addHeader("Content-Disposition", "attachment; filename="+name+"resume.pdf");
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
	}catch(Exception e){
		 e.printStackTrace();
	 }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
