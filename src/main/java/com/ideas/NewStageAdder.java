package com.ideas;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class NewStageAdder
 */
public class NewStageAdder extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NewStageAdder() {
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
		LoadConfigFile config=new LoadConfigFile();
	    String DBUrl=config.DBUrl();
	    String DBPasswd=config.DBPasswd();
	    String DBUser=config.DBUser();
	    String stage=request.getParameter("newstage");
	    System.out.println(stage);
	    try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			Connection con = DriverManager.getConnection(DBUrl,DBUser,DBPasswd);
			PreparedStatement stat2=con.prepareStatement("INSERT INTO stage (stage) VALUES (?)");
			stat2.setString(1, stage);
			stat2.executeUpdate();
			con.close();
			RequestDispatcher rd=request.getRequestDispatcher("/jsp/UpdateEntries.jsp");  
	        rd.forward(request, response); 
	        
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
