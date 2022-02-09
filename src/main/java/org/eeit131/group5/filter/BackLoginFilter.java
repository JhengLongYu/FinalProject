package org.eeit131.group5.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//@Slf4j
@WebFilter(urlPatterns = { "/management/*", "/memberManagement/*", "/ordersManagement/*", "/findproductForm/*",
		"/_01/showAllMembers/*", "/_01/CenterBack/Allsports/*", "/article/articleManagement/*", "/tag/tagmanagement/*",
		"/consultion/allinstructors/*", "/consultion/mglistPage/*" }, filterName = "backLoginFilter")

public class BackLoginFilter implements Filter {

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// log.info("filter 初始化");
	}

	@Override
	public void destroy() {
		// log.info("filter 銷毀");
	}

	@Override
	public void doFilter(ServletRequest srequest, ServletResponse sresponse, FilterChain chain)
			throws IOException, ServletException {
		// log.info("doFilter 請求處理");
		HttpServletRequest request = (HttpServletRequest) srequest;
		HttpServletResponse response = (HttpServletResponse) sresponse;
		if (request.getSession().getAttribute("manager") != null) {
			chain.doFilter(request, response);
		} else {
			response.sendRedirect(request.getContextPath() + "/backindex");
		}

	}

}
