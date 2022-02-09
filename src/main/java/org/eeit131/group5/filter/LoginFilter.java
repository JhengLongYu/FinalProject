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

@WebFilter(urlPatterns = { "/consultion/listPage/*", "/consultion/mbcalendar/*", "/findAllShoppingCartItem/*",
		"/consultion/insCalendar/*", "/consultion/mbfavoriteInsPage/*", "/addMemberForm/*",
		"/memberCenter_editPassword/*", "/memberCenter_editInfo/*", "/memberCenter/*" }, filterName = "loginFilter")
public class LoginFilter implements Filter {

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		System.out.println("filter 初始化");
	}

	@Override
	public void destroy() {
		System.out.println("filter 銷毀");
	}

	@Override
	public void doFilter(ServletRequest srequest, ServletResponse sresponse, FilterChain chain)
			throws IOException, ServletException {
		System.out.println("doFilter 請求處理");
		HttpServletRequest request = (HttpServletRequest) srequest;
		HttpServletResponse response = (HttpServletResponse) sresponse;
		if (request.getSession().getAttribute("user") != null) {
			chain.doFilter(request, response);
		} else {
			response.sendRedirect(request.getContextPath() + "/login");
		}

	}

}
