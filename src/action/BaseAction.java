package action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts2.ServletActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class BaseAction extends ActionSupport {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private HttpServletRequest req = ServletActionContext.getRequest();
	private HttpServletResponse resp = ServletActionContext.getResponse();
	private int numPerPage = 20;
	private int pageNum = 1;
	private String url;
	
	public String getParameter(String param){
		try {
			if (req.getParameter(param) == null
					&& req.getParameter(param).equals("")) {
				return "";
			}
		} catch (Exception e) {
			return "";
		}
		return req.getParameter(param);
	}
	
	/**
	 * 获取url地址栏所有参数
	 * @return
	 */
	public String getUrlParameters(){
		StringBuffer sb = new StringBuffer();
		Enumeration<?> en = req.getParameterNames();
		while(en.hasMoreElements()){
			String name = (String)en.nextElement();
			if(name.equals("_")){
				continue;
			}
			sb.append("&");
			sb.append(name);
			sb.append("=");
			sb.append(getParameter(name));
		}
		return sb.toString();
	}
	
	public void setAttribute(String key,Object value){
		req.setAttribute(key, value);
	}
	
	public Object getSession(String name){
		return req.getSession().getAttribute(name);
	}
	
	public void setSession(String key,Object value){
		req.getSession().setAttribute(key, value);
	}
	
	public PrintWriter getWriter() throws IOException{
		HttpServletResponse resp = ServletActionContext.getResponse();
		resp.setContentType("text/html;charset=UTF-8");
		resp.setCharacterEncoding("utf-8");
		return resp.getWriter();
	}
	
	/**
	 * 创建参数数组
	 * @param str 属性名称
	 * @return
	 */
	public Object[] createNames(Object... str){
		Object[] names = new Object[str.length];
		for(int i=0;i<str.length;i++){
			names[i] = str[i];
		}
		return names;
	}
	
	/**
	 * 添加参数
	 * @param names 原参数数组
	 * @param str 属性名称
	 * @return
	 */
	public Object[] addNames(Object[] names,Object... str){
		Object[] tmp = new Object[names.length+str.length];
		System.arraycopy(names, 0, tmp, 0, names.length);
		System.arraycopy(str,0,tmp,names.length,str.length);
		return tmp;
	}
	
	public HttpServletRequest getReq() {
		return req;
	}
	public void setReq(HttpServletRequest req) {
		this.req = req;
	}
	public HttpServletResponse getResp() {
		return resp;
	}
	public void setResp(HttpServletResponse resp) {
		this.resp = resp;
	}
	public int getNumPerPage() {
		return numPerPage;
	}
	public void setNumPerPage(int numPerPage) {
		this.numPerPage = numPerPage;
	}
	public int getPageNum() {
		return pageNum;
	}
	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	
}
