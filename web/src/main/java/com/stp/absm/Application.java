package com.stp.absm;

import com.google.gson.Gson;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.boot.autoconfigure.jdbc.DataSourceTransactionManagerAutoConfiguration;
import org.springframework.boot.autoconfigure.session.SessionAutoConfiguration;
import org.springframework.boot.autoconfigure.web.ErrorMvcAutoConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.web.config.EnableSpringDataWebSupport;
import org.springframework.session.data.redis.config.annotation.web.http.RedisHttpSessionConfiguration;
import org.springframework.transaction.annotation.EnableTransactionManagement;

/**
 * Created by sj on 16. 3. 2..
 */
@SpringBootApplication(exclude =
        {       RedisHttpSessionConfiguration.class,
                ErrorMvcAutoConfiguration.class,
                DataSourceTransactionManagerAutoConfiguration.class,
                DataSourceAutoConfiguration.class,
                SessionAutoConfiguration.class})
@EnableTransactionManagement
@EnableSpringDataWebSupport
@ComponentScan(basePackages = {"com.stp.absm" })
public class Application {
    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }

    @Bean
    public Gson gson(){

        return new Gson();
    }

}
