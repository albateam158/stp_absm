package com.stp.absm.mybatis;

import com.stp.absm.common.AES;
import com.stp.absm.config.JdbcConnectionSettings;
import org.apache.commons.dbcp.BasicDataSource;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.transaction.PlatformTransactionManager;

import javax.persistence.EntityManagerFactory;
import javax.sql.DataSource;

/**
 * Created by bridge on 15. 4. 3..
 */
//@Configuration
public class MybatisConfig_bak {

    public static AES aes;

    @Autowired
    public void setAes(AES injectionAes) {
        aes = injectionAes;
    }


//    private final Logger log = LoggerFactory.getLogger(MybatisConfig.class);
//    @Autowired
//    private DataSource dataSource;

//    @Bean
//    public SqlSessionFactoryBean sqlSessionFactoryBean() {
//        SqlSessionFactoryBean factoryBean = new SqlSessionFactoryBean();
//        factoryBean.setDataSource(dataSource);
//        //factoryBean.setConfigurationProperties(mybatisProperties());
//
//        return factoryBean;
//    }

//    private Properties mybatisProperties() {
//        Properties properties = new Properties();
//        properties.put("lazyLoadingEnabled", "true");
//
//        return properties;
//    }

//    @Bean
//    public SqlSessionTemplate sqlSessionTemplate(SqlSessionFactory sqlSessionFactory) throws Exception {
//        return new SqlSessionTemplate(sqlSessionFactory);
//    }

//    @Autowired
//    private ApplicationContext applicationContext;

//    @Bean
//    public SqlSessionFactory sqlSessionFactory(DataSource dataSource) throws Exception {
//        final SqlSessionFactoryBean sessionFactory = new SqlSessionFactoryBean();
//        sessionFactory.setDataSource(dataSource);
//        return sessionFactory.getObject();
//    }



//    @Bean
//    public SqlSessionFactory sqlSessionFactory() throws Exception {
//        SqlSessionFactoryBean sessionFactoryBean = new SqlSessionFactoryBean();
//        sessionFactoryBean.setDataSource(dataSource);
//        //sessionFactoryBean.setTypeAliasesPackage("com.stunstun.spring.repository.entity");
//        sessionFactoryBean.setConfigLocation(applicationContext.getResource("classpath:/config/mybatis-config.xml"));
//        sessionFactoryBean.setMapperLocations(applicationContext.getResources("classpath:/mapper/*.xml"));
//        return sessionFactoryBean.getObject();
//    }

    @Autowired
    private JdbcConnectionSettings jdbcConnectionSettings;


    @Autowired
    private DataSource dataSource;

    @Bean
    public DataSource dataSource() {

        BasicDataSource ds = new BasicDataSource();


        ds.setDriverClassName(jdbcConnectionSettings.getDataSourceClassName());
        ds.setUsername(jdbcConnectionSettings.getUsername());
        ds.setPassword(jdbcConnectionSettings.getPassword());
        ds.setUrl(jdbcConnectionSettings.getUrl());
        ds.setValidationQuery("/* ping */ select 1");


        return ds;
    }



    @Bean
    public SqlSessionFactory sqlSessionFactory() throws Exception {


        final SqlSessionFactoryBean sqlSessionFactory = new SqlSessionFactoryBean();
        sqlSessionFactory.setDataSource(dataSource());
        sqlSessionFactory.setConfigLocation(new ClassPathResource("mapper/mybatis-config.xml"));
        sqlSessionFactory.setFailFast(true);



        Resource categoryMapper                         = new ClassPathResource("mapper/category-mapper.xml");
        Resource noticeMapper                           = new ClassPathResource("mapper/notice-mapper.xml");
        Resource userMapper                           = new ClassPathResource("mapper/user-mapper.xml");

        //sqlSessionFactory.setMapperLocations(resources);



        sqlSessionFactory.setMapperLocations(new Resource[]{  categoryMapper, noticeMapper, userMapper });

        return sqlSessionFactory.getObject();
    }

    @Autowired
    EntityManagerFactory emf;

    @Bean(name = "transactionManager")
    public PlatformTransactionManager transactionManager() {
        JpaTransactionManager tm =
                new JpaTransactionManager();
        tm.setEntityManagerFactory(emf);
        tm.setDataSource(dataSource);
        return tm;
    }
}