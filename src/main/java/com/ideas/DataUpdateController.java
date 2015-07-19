package com.ideas;

import java.util.Date;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class DataUpdateController
 */
public class DataUpdateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DataUpdateController() {
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
		Date date=new Date();
		String stageid=null;
		String id=request.getParameter("id");
		String department=request.getParameter("department");
		String name=request.getParameter("name");
		String designation=request.getParameter("designation");
		String experience=request.getParameter("experience");
		String cctc=request.getParameter("cctc");
		String ectc=request.getParameter("ectc");
		String prevorg=request.getParameter("prevorg");
		String comments=request.getParameter("comments");
		String stage=request.getParameter("stage");
		System.out.println(designation);
		System.out.println(stage);
		boolean param = false;
		try {
		
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			Connection con = DriverManager.getConnection(DBUrl,DBUser,DBPasswd);
			PreparedStatement stat3=con.prepareStatement("SELECT stageid FROM stage WHERE stage=?");
			stat3.setString(1, stage);
			ResultSet result3 = stat3.executeQuery();
			while(result3.next()){
				stageid=result3.getString("stageid");
			}
			System.out.println(stageid);
			System.out.println("Inside post method");
			PreparedStatement stat2=con.prepareStatement("UPDATE employee SET department=?, name=?, designation=?, experience=?, cctc=?, ectc=?, prevorg=?,comments=?,lastmodified=?,stageid=? WHERE id=?");
			stat2.setString(1, department);
			stat2.setString(2, name);
			stat2.setString(3, designation );
			stat2.setString(4, experience);
			stat2.setString(5, cctc);
			stat2.setString(6, ectc);
			stat2.setString(7, prevorg);
			stat2.setString(8, comments);
			stat2.setString(9, date.toString());
			stat2.setString(10, stageid);
			stat2.setString(11,id);
			stat2.executeUpdate();
			System.out.println("Update Successful!!!");
			param=true;
			
			stat2.close();
			con.close();
			
		} catch (SQLException e) {
			
			e.printStackTrace();
			
		} catch (Exception e) {
			
		e.printStackTrace();
		}
		response.setContentType("application/json");
		response.getWriter().print(param);
		response.flushBuffer();
	}

}
