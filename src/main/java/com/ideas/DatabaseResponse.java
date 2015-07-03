package com.ideas;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

public class DatabaseResponse {
	public void sendServerResponse(HttpServletResponse response, String content) throws IOException {
		response.setContentType("application/json");
		response.getWriter().append(content);
		response.flushBuffer();
	}
}
