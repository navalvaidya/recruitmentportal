package com.ideas;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Properties;

public class CreateConfigFile {

	public static void main(String[] args) {
		Properties prop = new Properties();
		OutputStream output = null;
	 
		try {
	 
			output = new FileOutputStream("config.properties");
	 
			// set the properties value
			prop.setProperty("database", "jdbc:mysql://localhost:3306/test");
			prop.setProperty("dbuser", "root");
			prop.setProperty("dbpassword", "root");
			
			// save properties to project root folder
			prop.store(output, null);
			System.out.println("File Created");
		} catch (IOException io) {
			io.printStackTrace();
		} finally {
			if (output != null) {
				try {
					output.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
	 
		}

	}

}
