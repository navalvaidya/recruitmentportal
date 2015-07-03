package com.ideas;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItemIterator;
import org.apache.commons.fileupload.FileItemStream;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 * Servlet implementation class ExcelExtractorInitialize1
 */
public class ExcelExtractorInitialize1 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ExcelExtractorInitialize1() {
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
Boolean updateResponse=false;
		
	    
		boolean isMultiPart=ServletFileUpload.isMultipartContent(request);
		if(isMultiPart)
		{
			System.out.println("Inside upload ");
			ServletFileUpload upload = new ServletFileUpload();
			try
			{
				
				FileItemIterator itr = upload.getItemIterator(request);
				while(itr.hasNext())
				{
					FileItemStream item = itr.next();
					if(!item.isFormField())
					{
						System.out.println("Starting upload.....");
						String path = getServletContext().getRealPath("/"); 
						ExcelUploadHandle.processFile(path, item);					
						System.out.println("other upload successful");
					}
					
				}
				
				
				
				String ExcelPath=ExcelUploadHandle.rqPath3;
				System.out.println("epath"+ExcelPath);
				
				ExcelExtractorClass exc = new ExcelExtractorClass();
				
					exc.ExcelExtract(ExcelPath);
					updateResponse=true;
				
	 
			}catch(FileUploadException fe)
			{
			fe.printStackTrace();	
			}
			
			 
		}
		
		response.setContentType("application/jason");
		response.getWriter().print(updateResponse);
		response.flushBuffer();
	}

}
