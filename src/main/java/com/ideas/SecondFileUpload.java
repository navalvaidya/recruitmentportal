package com.ideas;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.Properties;

import org.apache.commons.fileupload.FileItemStream;

public class SecondFileUpload {
	static String rqPath2;
	public static boolean processFile(String path, FileItemStream item, int Uniqueid){
		try{
			Properties prop = new Properties();
			InputStream input = new FileInputStream("/Recruitment Portal/config.properties");
			prop.load(input);
			String otherpath = prop.getProperty("otherconfig");
			File f=new File(otherpath); 
			File savedFile = new File(f.getPath()+File.separator+Uniqueid+item.getName());
			rqPath2=f.getPath()+File.separator+Uniqueid+item.getName();
			
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
			rqPath2=null;
		}
		return false;
	}
}
