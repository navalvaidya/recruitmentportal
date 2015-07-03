package com.ideas;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import java.util.Date;

//import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItemIterator;
import org.apache.commons.fileupload.FileItemStream;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 * Servlet implementation class UpdateResumeOtherController
 */

public class UpdateResumeOtherController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateResumeOtherController() {
        super();
  
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Boolean updateResponse=false;
		LoadConfigFile config=new LoadConfigFile();
	    String DBUrl=config.DBUrl();
	    String DBPasswd=config.DBPasswd();
	    String DBUser=config.DBUser();
	    String id = request.getParameter("id");
	    int Uniqueid=Integer.parseInt(id);
		boolean isMultiPart=ServletFileUpload.isMultipartContent(request);
		if(isMultiPart)
		{
			System.out.println("Inside upload file servlet ");
			ServletFileUpload upload = new ServletFileUpload();
			try
			{
				
				FileItemIterator itr = upload.getItemIterator(request);
				while(itr.hasNext())
				{
					FileItemStream item = itr.next();
					if(!item.isFormField())
					{
						System.out.println("Starting upload.....");
						String path = getServletContext().getRealPath("/"); 
						FileUploadClass.processFile(path, item, Uniqueid);					
						System.out.println("resume upload successful");
					}
					
				}
				Class.forName("com.mysql.jdbc.Driver").newInstance();
				Connection con = DriverManager.getConnection(DBUrl,DBUser,DBPasswd);
				PreparedStatement stat2=con.prepareStatement("UPDATE employee SET resumelink=?,lastmodified=? WHERE id=?");
				
				
				
				String resume=FileUploadClass.rqPath;
				Date date=new Date();
				stat2.setString(1, resume);
				stat2.setString(2, date.toString());
				stat2.setString(3, id);
				stat2.executeUpdate();
				updateResponse=true;
				stat2.close();
				con.close();
//				RequestDispatcher rd=request.getRequestDispatcher("/main.html");  
//		        rd.forward(request, response); 
			}catch(FileUploadException fe)
			{
			fe.printStackTrace();	
			} catch (InstantiationException e) {
				
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				
				e.printStackTrace();
			} catch (ClassNotFoundException e) {
				
				e.printStackTrace();
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
			
			 
		}
		
		response.setContentType("application/jason");
		response.getWriter().print(updateResponse);
		response.flushBuffer();
}
}

