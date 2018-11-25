package com.lanzx.rmmsys.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lanzx.rmmsys.utils.LogMonitor;

public class LogCheckFilter implements Filter {

	 private static String[] excludePrefix = null;
	 
	 private boolean isFilt(String name) {
	        boolean flag = true;
	        String trueName = name.toLowerCase();
	        if (trueName.endsWith(".js") || trueName.endsWith(".css")|| trueName.endsWith(".jpg")
	                || trueName.endsWith(".gif") || trueName.endsWith(".png") 
	                || trueName.endsWith("include.jsp")) {
	            flag = false;
	        }
	        return flag;
	    }
	 
	public void destroy() {
		
		
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        String path = req.getContextPath();
        String failPage = request.getScheme() + "://"
                + req.getServerName() + ":" + req.getServerPort()
                + path;
        String webapps = req.getRequestURI();
        HttpSession session = req.getSession();
        boolean  flag = true;
        if (excludePrefix != null) {
            for (int i = 0; i < excludePrefix.length; i++) {
                if (webapps.startsWith(path + excludePrefix[i])) {
                    flag = false;
                    break;
                }
            }
        }
        
        if ((session == null || session.getAttribute("userInfo") == null )&& flag &&isFilt(webapps)) { // 用户未登录
        	resp.sendRedirect(failPage + "/toLogin.do");
            return;
        } else {
        	
        }
        chain.doFilter(request, response);

	}

	public void init(FilterConfig config) throws ServletException {
		 String exclude = config.getInitParameter("excludePrefix");
	        if (exclude != null) {
	            excludePrefix = exclude.split("\\|");
	        }  
		
	        LogMonitor.getInstance().start();
	        
	}

}
