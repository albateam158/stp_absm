package com.stp.absm.security;

import org.springframework.boot.autoconfigure.web.ServerProperties;
import org.springframework.boot.context.embedded.ConfigurableEmbeddedServletContainer;
import org.springframework.boot.context.embedded.ErrorPage;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpStatus;

/**
 * Created by shpark on 2017-03-30.
 */
@Configuration
public class ErrorConfiguration extends ServerProperties {
    @Override
    public void customize(ConfigurableEmbeddedServletContainer container){
        super.customize(container);
        container.addErrorPages(new ErrorPage(HttpStatus.NOT_FOUND, "/error"));
        container.addErrorPages(new ErrorPage(HttpStatus.INTERNAL_SERVER_ERROR, "/error"));
        container.addErrorPages(new ErrorPage("/error"));
    }
}