package com.stp.absm;

import com.google.gson.Gson;
import org.mybatis.spring.boot.autoconfigure.MybatisAutoConfiguration;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.boot.autoconfigure.jdbc.DataSourceTransactionManagerAutoConfiguration;
import org.springframework.boot.autoconfigure.orm.jpa.HibernateJpaAutoConfiguration;
import org.springframework.boot.autoconfigure.session.SessionAutoConfiguration;
import org.springframework.boot.autoconfigure.web.ErrorMvcAutoConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.web.config.EnableSpringDataWebSupport;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.session.data.redis.config.annotation.web.http.RedisHttpSessionConfiguration;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@ComponentScan(basePackages = {"com.stp.absm"})
@SpringBootApplication(exclude =
        {       RedisHttpSessionConfiguration.class,
                ErrorMvcAutoConfiguration.class,
                DataSourceTransactionManagerAutoConfiguration.class,
                DataSourceAutoConfiguration.class,
                SessionAutoConfiguration.class})
@EnableTransactionManagement
@EnableSpringDataWebSupport
@EnableScheduling
public class Application {

    public static void main(String[] args) {


        SpringApplication app = new SpringApplication(Application.class);
        app.setWebEnvironment(false);

        app.run(args);

    }

    @Bean
    public Gson gson(){

        return new Gson();
    }

}