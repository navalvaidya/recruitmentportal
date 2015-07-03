package com.ideas;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.Properties;

import org.apache.commons.fileupload.FileItemStream;

public class ExcelUploadHandle {
	static String rqPath3;
	public static boolean processFile(String path, FileItemStream item){
		try{
			Properties prop = new Properties();
			InputStream input = new FileInputStream("/Recruitment Portal/config.properties");
			prop.load(input);
			String excelpath = prop.getProperty("excelconfig");
			File f=new File(excelpath); 
			File savedFile = new File(f.getPath()+File.separator+item.getName());
			rqPath3=f.getPath()+File.separator+item.getName();
			
			FileOutputStream fos = new FileOutputStream(savedFile);
			InputStream is = item.openStream();
			int x=0;
			byte[] b= new byte[1024];
			while((x=is.read(b))!=-1){
				fos.write(b, 0, x);
			}
			fos.flush();
			fos.close();
			return true;
		}
		catch(Exception e)
		{
			rqPath3=null;
		}
		return false;
	}
}
