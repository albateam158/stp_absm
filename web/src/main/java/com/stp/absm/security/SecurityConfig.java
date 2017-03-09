package com.stp.absm.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.access.ExceptionTranslationFilter;

@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
@Configuration
public class SecurityConfig extends WebSecurityConfigurerAdapter {

	@Autowired
	private XAdminDetailService xAdminDetailsService;

//	@Autowired
//	private PasswordEncoder passwordEncoder;
//    @Override
//    public void configure(WebSecurity web) throws Exception {
//        web
//                .ignoring()
//                .antMatchers("/**/*.js", "/**/**/*.js", "/**/*.css", "/font-awesome/**", "/**/**/*.css", "/**/*.png", "/**/*.gif", "/**/*.jpg", "/**/*.jpeg", "/**/*.ico");
//    }

	@Override
	protected void configure(HttpSecurity http) throws Exception {

//		http
//				.csrf().disable()
//				.anonymous()
//				.and()
//				.formLogin()
//				.loginPage("/login")
//				.defaultSuccessUrl("/", true)
//				.loginProcessingUrl("/auth")
//				.failureHandler(new CustomLoginFailureHandler())
//				//.failureUrl("/login")
//			.and()
//				.logout()
//				.deleteCookies("remember-me")
//				.logoutUrl("/logout")
//				.logoutSuccessUrl("/login")
//			.and()
//				.rememberMe().and()
//				.authorizeRequests()
//				.antMatchers(
//						"/auth/**",
//						"/login",
//						"/error",
//						"/signup",
//						"/assets/**",
//						"/projectdownload/**",
//						"/pages/**",
//						"/admin/form",
//						"/user/form_pre",
//						"/user/form",
//						"/emp/listV",
//                        "/emp/phone_form",
//						"/emp/list_div",
//						"/emp/phoneV",
//						"/emp/phone_div",
//						"/inter_rule/listV",
//						"/inter_rule/list_div",
//						"/ruleFile2",
//						"/ruleFile",
//                        "/getByteImage1/**"
//				).permitAll()
//				.antMatchers("/**").hasRole("SUPERVISOR").and()
//				.addFilterAfter(new AjaxSessionTimeoutFilter(), ExceptionTranslationFilter.class);
	}

	@Bean
	@Override
	public AuthenticationManager authenticationManagerBean() throws Exception {
		return super.authenticationManagerBean();
	}

	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}

	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {

		auth.userDetailsService(xAdminDetailsService).passwordEncoder(passwordEncoder());
	}


	@Override
	protected UserDetailsService userDetailsService() {
		return xAdminDetailsService;
	}


	public static void main(String[] args){

		PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

		System.out.println("======>" + passwordEncoder.encode("test1234"));
	}
}
