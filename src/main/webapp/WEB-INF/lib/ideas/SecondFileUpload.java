package com.ideas;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;

import org.apache.commons.fileupload.FileItemStream;

public class SecondFileUpload {
	static String rqPath2;
	public static boolean processFile(String path, FileItemStream item){
		try{
			File f=new File("/Recruitment Portal/FileUploads/Other"); 
			File savedFile = new File(f.getPath()+File.separator+item.getName());
			rqPath2=f.getPath()+File.separator+item.getName();
			
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
			e.printStackTrace();
		}
		return false;
	}
}
