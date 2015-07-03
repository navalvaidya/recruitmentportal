package com.ideas;
import com.ideas.fileupload;

import java.io.IOException;
import java.io.InputStream;
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

		//Boolean updateResponse=false;
		
		boolean isMultiPart=ServletFileUpload.isMultipartContent(request);
		if(isMultiPart)
		{
			System.out.println("Inside upload file servlet ");
			ServletFileUpload upload = new ServletFileUpload();
			try
			{
				String [] temp=new String[10];
				int i=0;
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
						//response.getWriter().println(fieldName+":"+value+"<br/>");
						//System.out.println(fieldName);
						//System.out.println(value);
					}
					else
					{
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
				Class.forName("com.mysql.jdbc.Driver").newInstance();
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test","root","root");
				PreparedStatement stat2=con.prepareStatement("INSERT INTO `test`.`employee` (department,name, designation, experience,comments,resumelink) VALUES (?,?,?,?,?,?)");
				//stat2.setString(1, fieldName);
				for(i=0;i<5;i++)
				{
				stat2.setString(i+1, temp[i]);
				}
				String resume=fileupload.rqPath;
				stat2.setString(6, resume);
				stat2.executeUpdate();
			
				stat2.close();
				con.close();
			   // updateResponse=true;
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
			response.setContentType("application/jason");
			response.getWriter().print("true");
			response.flushBuffer();
			 
		}
		
		
	}

}
