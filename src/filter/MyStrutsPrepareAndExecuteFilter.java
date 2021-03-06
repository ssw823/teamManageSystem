package filter;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

public class MyStrutsPrepareAndExecuteFilter extends org.apache.struts2.dispatcher.ng.filter.StrutsPrepareAndExecuteFilter{

	@Override
	public void doFilter(ServletRequest req, ServletResponse res,
			FilterChain chain) throws IOException, ServletException {
			HttpServletRequest request = (HttpServletRequest) req;
	        if(request.getServletPath().startsWith("/editor/")){
	            chain.doFilter(req, res);
	        }else{
	            super.doFilter(req, res, chain);
	        }
	       
	}
	
}
