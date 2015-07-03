package com.ideas;
import com.ideas.FileUploadClass;
import com.ideas.LoadConfigFile;

import java.util.Date;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

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
		int Uniqueid = 0;
		Boolean updateResponse=false;
		LoadConfigFile config=new LoadConfigFile();
	    String DBUrl=config.DBUrl();
	    String DBPasswd=config.DBPasswd();
	    String DBUser=config.DBUser();
	    try
		{
	    Connection con1 = DriverManager.getConnection(DBUrl,DBUser,DBPasswd);
	    Statement stat1 = con1.createStatement();
	    ResultSet resultid = stat1.executeQuery("SELECT MAX(id) FROM employee");
	    while(resultid.next()){
	    	Uniqueid= resultid.getInt("MAX(id)");
	    }
	    ++Uniqueid;
	    System.out.println(Uniqueid);
		boolean isMultiPart=ServletFileUpload.isMultipartContent(request);
		if(isMultiPart)
		{
			System.out.println("Inside upload file servlet ");
			ServletFileUpload upload = new ServletFileUpload();
			
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
						
						String path = getServletContext().getRealPath("/"); 
						String item1=item.getName();
						
						if(!item1.equals("")){
						SecondFileUpload.processFile(path, item, Uniqueid);
						}
						else
						{
							SecondFileUpload.rqPath2=null;
						}
						
							
						}
						else{
							String path = getServletContext().getRealPath("/"); 
							String item2=item.getName();
							
							if(!item2.equals("")){
								FileUploadClass.processFile(path, item,Uniqueid);
							}
							else
							{
								FileUploadClass.rqPath=null;
							}
						}
					}
				}
				Class.forName("com.mysql.jdbc.Driver").newInstance();
				Connection con = DriverManager.getConnection(DBUrl,DBUser,DBPasswd);
				PreparedStatement stat2=con.prepareStatement("INSERT INTO employee (department,name, designation, experience,cctc,ectc,prevorg,comments,resumelink,otherfile,createdon,lastmodified) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)");
				Date date=new Date();
				for(i=0;i<8;i++)
				{
				stat2.setString(i+1, temp[i]);
				}
				resume=FileUploadClass.rqPath;
				other=SecondFileUpload.rqPath2;
				stat2.setString(9, resume);
				stat2.setString(10, other);
				stat2.setString(11, date.toString());
				stat2.setString(12, date.toString());
				stat2.executeUpdate();
			
				stat2.close();
				con.close();
				stat1.close();
				con1.close();
			    updateResponse=true;

			}
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
			response.getWriter().print(updateResponse);
			response.flushBuffer();		
	}

}
