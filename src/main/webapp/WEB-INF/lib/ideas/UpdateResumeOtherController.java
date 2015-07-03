package com.ideas;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
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
@MultipartConfig
public class UpdateResumeOtherController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateResumeOtherController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
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
		boolean isMultiPart=ServletFileUpload.isMultipartContent(request);
		if(isMultiPart)
		{
			System.out.println("Inside upload file servlet ");
			ServletFileUpload upload = new ServletFileUpload();
			try
			{
				int j=0;
				FileItemIterator itr = upload.getItemIterator(request);
				while(itr.hasNext())
				{
					FileItemStream item = itr.next();
					if(!item.isFormField())
					{
						if(j==0){
							j++;
						System.out.println("Starting upload.....");
						String path = getServletContext().getRealPath("/"); 
						if(SecondFileUpload.processFile(path, item))
						{
							response.getWriter().println("file upload successful");
						System.out.println("other upload successful");
						}
						else
							response.getWriter().println("file upload failed");
						}
						else{
							String path = getServletContext().getRealPath("/"); 
							if(fileupload.processFile(path, item))
							{
								response.getWriter().println("file upload successful");
							System.out.println("resume upload successful");
							}
							else
								response.getWriter().println("file upload failed");
						}
					}
					
				}
				Class.forName("com.mysql.jdbc.Driver").newInstance();
				Connection con = DriverManager.getConnection(DBUrl,DBUser,DBPasswd);
				PreparedStatement stat2=con.prepareStatement("UPDATE employee SET resumelink=?, otherfile=? WHERE id=?");
				//stat2.setString(1, fieldName);
				String id = request.getParameter("id");
				String resume=fileupload.rqPath;
				String other=SecondFileUpload.rqPath2;
				stat2.setString(1, resume);
				stat2.setString(2, other);
				stat2.setString(3, id);
				stat2.executeUpdate();
			
				stat2.close();
				con.close();
			    updateResponse=true;
				RequestDispatcher rd=request.getRequestDispatcher("/Bootstrap/bootstrap-3.3.5-dist/main.html");  
		        rd.forward(request, response); 
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
		
		
	}
}


