package com.ideas;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class LoadConfigFile {

	public String  DBUrl(){
		String dburl=null;
		Properties prop = new Properties();
		InputStream input = null;
	 
		try {
	 
			input = new FileInputStream("/Recruitment Portal/config.properties");
	 
			// load a properties file
			prop.load(input);
	 
			// get the property value and print it out
			dburl = prop.getProperty("database");
			
	 
		} catch (IOException ex) {
			ex.printStackTrace();
		} finally {
			if (input != null) {
				try {
					input.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return dburl;

	}
	
	
	
	public String  DBPasswd(){
		
		String passwd=null;
		Properties prop = new Properties();
		InputStream input = null;
	 
		try {
	 
			input = new FileInputStream("/Recruitment Portal/config.properties");
	 
			// load a properties file
			prop.load(input);
	 
			// get the property value and print it out
			passwd = prop.getProperty("dbpassword");
	 
		} catch (IOException ex) {
			ex.printStackTrace();
		} finally {
			if (input != null) {
				try {
					input.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return passwd;

	}

	
	
	public String  DBUser(){
		
		String user=null;
		
		Properties prop = new Properties();
		InputStream input = null;
	 
		try {
	 
			input = new FileInputStream("/Recruitment Portal/config.properties");
	 
			// load a properties file
			prop.load(input);
	 
			// get the property value and print it out
			
			user = prop.getProperty("dbuser");
			
	 
		} catch (IOException ex) {
			ex.printStackTrace();
		} finally {
			if (input != null) {
				try {
					input.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return user;

	}


}
