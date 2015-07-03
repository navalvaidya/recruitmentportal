package com.ideas;
import com.ideas.fileupload;
import com.ideas.LoadConfigFile;
import java.io.IOException;
import java.io.InputStream;
import java.io.FileNotFoundException;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItemIterator;
import org.apache.commons.fileupload.FileItemStream;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 * Servlet implementation class UploadFileServlet
 */

public class UploadFileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UploadFileServlet() {
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
		String resume;
		String other;
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
				String [] temp=new String[20];
				int i=0,j=0;
				FileItemIterator itr = upload.getItemIterator(request);
				while(itr.hasNext())
				{
					FileItemStream item = itr.next();
					if(item.isFormField())
					{
						
						//String fieldName =item.getFieldName();
						
						InputStream is =item.openStream();
						byte [] b = new byte[is.available()];
						is.read(b);
						temp[i] = new String(b);
						
						i++;
//						response.getWriter().println(fieldName+":"+value+"<br/>");
//						System.out.println(fieldName);
//						System.out.println(value);
					}
					else
					{
						if(j==0){
							j++;
						System.out.println("Starting upload.....");
						String path = getServletContext().getRealPath("/"); 
						if(SecondFileUpload.processFile(path, item))
						{
							response.getWriter().println("file upload successful");
						System.out.println("upload successful");
						}
						else
							response.getWriter().println("file upload failed");
						}
						else{
							String path = getServletContext().getRealPath("/"); 
							if(fileupload.processFile(path, item))
							{
								response.getWriter().println("file upload successful");
							System.out.println("upload successful");
							}
							else
								response.getWriter().println("file upload failed");
						}
					}
				}
				Class.forName("com.mysql.jdbc.Driver").newInstance();
				Connection con = DriverManager.getConnection(DBUrl,DBUser,DBPasswd);
				PreparedStatement stat2=con.prepareStatement("INSERT INTO `test`.`employee` (department,name, designation, experience,cctc,ectc,prevorg,comments,resumelink,otherfile) VALUES (?,?,?,?,?,?,?,?,?,?)");
				//stat2.setString(1, fieldName);
				for(i=0;i<8;i++)
				{
				stat2.setString(i+1, temp[i]);
				}
				try{resume=fileupload.rqPath;
				throw new FileNotFoundException();
				}
				catch (FileNotFoundException e){
					resume="";
				}
				try{other=SecondFileUpload.rqPath2;
				throw new FileNotFoundException();
				}catch (FileNotFoundException e){
					other="";
				}
				stat2.setString(9, resume);
				stat2.setString(10, other);
				stat2.executeUpdate();
			
				stat2.close();
				con.close();
			    updateResponse=true;
//				RequestDispatcher rd=request.getRequestDispatcher("/UploadToDatabase");  
//		        rd.forward(request, response); 
			}catch(FileUploadException fe)
			{
			fe.printStackTrace();	
			} 
			catch (InstantiationException e)
			{				
				e.printStackTrace();
			}
			catch (IllegalAccessException e) 
			{	
				e.printStackTrace();
			} 
			catch (ClassNotFoundException e) 
			{	
				e.printStackTrace();
			} 
			catch (SQLException e) 
			{	
				e.printStackTrace();
			}
			
			response.setContentType("application/jason");
			response.getWriter().print("true");
			response.flushBuffer();
			 
		}
		
		
	}

}
