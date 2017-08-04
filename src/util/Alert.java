package util;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

public class Alert {
	public static String UTF8 = "utf-8";
	public static String GBK = "gbk";
	
	public static void show(String charset,String msg,String url){
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding(charset);
		response.setContentType("text/html; charset="+charset);
		try {
			response.getWriter().print("<script language=javascript>alert('"+msg+"');window.location.href='"+url+"';</script>");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public static void fresh(String charset,String url){
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding(charset);
		response.setContentType("text/html; charset="+charset);
		try {
			response.getWriter().print("<script language=javascript>window.location.href='"+url+"';</script>");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public static void show(String charset,String msg){
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding(charset);
		response.setContentType("text/html; charset="+charset);
		try {
			response.getWriter().print("<script language=javascript>alert('"+msg+"');</script>");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
