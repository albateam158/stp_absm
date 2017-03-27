package com.stp.absm.controller;

import com.stp.absm.common.DurationFromNow;
import freemarker.template.TemplateModel;
import kr.pe.kwonnam.freemarker.inheritance.BlockDirective;
import kr.pe.kwonnam.freemarker.inheritance.ExtendsDirective;
import kr.pe.kwonnam.freemarker.inheritance.PutDirective;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;
import org.springframework.web.servlet.view.freemarker.FreeMarkerViewResolver;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by sj on 16. 3. 2..
 */
@Configuration
public class WebMvcConfig extends WebMvcConfigurerAdapter {

    private final Logger log = LoggerFactory.getLogger(WebMvcConfig.class);

    @Value(value = "${upload.fileLocation")
    private  String fileLocation;



    @Autowired
    protected DurationFromNow durationFromNow;

//    @Override
//    public void addResourceHandlers(ResourceHandlerRegistry registry){
//        registry.addResourceHandler("/file/**").addResourceLocations("file:///"+fileLocation);
//    }

    @Bean
    public Map<String, TemplateModel> freemarkerLayoutDirectives() {
        Map<String, TemplateModel> freemarkerLayoutDirectives = new HashMap<String, TemplateModel>();
        freemarkerLayoutDirectives.put("extends", new ExtendsDirective());
        freemarkerLayoutDirectives.put("block", new BlockDirective());
        freemarkerLayoutDirectives.put("put", new PutDirective());
        return freemarkerLayoutDirectives;
    }

    @Bean
    public FreeMarkerConfigurer freemarkerConfig() {
        FreeMarkerConfigurer freemarkerConfig = new FreeMarkerConfigurer();
        freemarkerConfig.setTemplateLoaderPath("classpath:/templates");
        freemarkerConfig.setDefaultEncoding("utf-8");


        Map<String, Object> freemarkerVariables = new HashMap<String, Object>();
        freemarkerVariables.put("layout"    , freemarkerLayoutDirectives());
        freemarkerVariables.put("duration"  , durationFromNow );


        freemarkerConfig.setFreemarkerVariables(freemarkerVariables);
        return freemarkerConfig;
    }

    @Bean
    public ViewResolver viewResolver() {
        FreeMarkerViewResolver viewResolver = new FreeMarkerViewResolver();
        viewResolver.setCache(false);
        viewResolver.setPrefix("");
        viewResolver.setSuffix(".ftl");
        viewResolver.setContentType("text/html; charset=utf-8");
        return viewResolver;
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        /**
         * 이부분의 addResourceLocations 경로를 설정에서 읽어오는 데이터 바인딩 하는게
         * 문제가 있어서 설정과 동일한 경로로 직접 하드코딩 입력
         */
        registry.addResourceHandler("/file/**").addResourceLocations("file:///C:\\workspace\\absm\\upload\\");
//        registry.addResourceHandler("/file/**").addResourceLocations("file:///"+fileLocation);

    }


    @Override
    public void addInterceptors(InterceptorRegistry registry) {

        registry.addInterceptor(new HandlerInterceptor() {
            @Override
            public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

                log.info(request.getRequestURI() + " ===============================================> start ");


                Enumeration<String> e = request.getHeaderNames();

                while (e.hasMoreElements()){

                    String headrName = e.nextElement();

                    log.debug( "     hearders ====> " + headrName + "=====>" + request.getHeader(headrName) );
                }




                Enumeration<String> params = request.getParameterNames();

                while (params.hasMoreElements()) {

                    String name = params.nextElement();

                    log.debug("     parameter ====> " + name + " ====>" + request.getParameter(name));
                }


                log.debug("     request.getRequestURI() ===>" + request.getRequestURI());
                log.debug("     request.getRequestURL() ===>" + request.getRequestURL());



                return true;
            }

            @Override
            public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {



            }

            @Override
            public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {




                log.info(request.getRequestURI() + " ===============================================> end ");

            }
        });

    }
}
