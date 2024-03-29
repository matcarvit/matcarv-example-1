/**
 * 
 */
package com.matcarv.auth.filters;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.GenericFilterBean;

import com.matcarv.auth.services.TokenAuthenticationService;

/**
 * @author weslleymatosdecarvalho
 *
 */
@Component
public class JWTAuthenticationFilter extends GenericFilterBean {
	
	@Autowired
	private TokenAuthenticationService tokenAuthenticationService;

	@Override
	public void doFilter(final ServletRequest request, final ServletResponse response, final FilterChain filterChain)
			throws IOException, ServletException {
		final String token = ((HttpServletRequest) request).getHeader("Authorization");
		
		if(token != null && !token.contains("Basic")) {
			final Authentication authentication = tokenAuthenticationService
					.getAuthentication((HttpServletRequest) request);
			
			SecurityContextHolder.getContext().setAuthentication(authentication);
		}
		
		
		filterChain.doFilter(request, response);
	}
}
