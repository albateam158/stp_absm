package com.stp.absm;

import com.google.gson.Gson;
import net.xenix.xcrowdfund.XCrowdfund;
import org.mybatis.spring.boot.autoconfigure.MybatisAutoConfiguration;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.boot.autoconfigure.jdbc.DataSourceTransactionManagerAutoConfiguration;
import org.springframework.boot.autoconfigure.session.SessionAutoConfiguration;
import org.springframework.boot.autoconfigure.web.ErrorMvcAutoConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.web.config.EnableSpringDataWebSupport;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.session.data.redis.config.annotation.web.http.RedisHttpSessionConfiguration;
import org.springframework.transaction.annotation.EnableTransactionManagement;

/**
 * Created by sj on 16. 3. 14..
 */
@ComponentScan(basePackages = {"net.xenix.wicrowd"})
@SpringBootApplication(exclude =
        {       RedisHttpSessionConfiguration.class,
                ErrorMvcAutoConfiguration.class,
                SessionAutoConfiguration.class,
                MybatisAutoConfiguration.class,
                DataSourceTransactionManagerAutoConfiguration.class,
                DataSourceAutoConfiguration.class
        })
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


    @Value(value = "${xcrowdfund.restUrl}")
    private String crowdfundRestUrl;

    @Bean
    public XCrowdfund xCrowdfund(){

        return new XCrowdfund(crowdfundRestUrl);
    }

}