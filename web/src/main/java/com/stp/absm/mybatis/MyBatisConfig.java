/**
 * 
 */
package com.stp.absm.mybatis;

import java.io.IOException;

import javax.persistence.EntityManagerFactory;
import javax.sql.DataSource;

import com.stp.absm.common.AES;
import com.stp.absm.config.JdbcConnectionSettings;
import org.apache.commons.dbcp.BasicDataSource;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.transaction.PlatformTransactionManager;

@Configuration
public class MyBatisConfig {

	public static AES aes;

	@Autowired
	public void setAes(AES injectionAes) {
		aes = injectionAes;
	}


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


		//absm mapper
		Resource page001Mapper = new ClassPathResource("mapper/page001-mapper.xml");
		Resource page002Mapper = new ClassPathResource("mapper/page002-mapper.xml");
		Resource page003Mapper = new ClassPathResource("mapper/page003-mapper.xml");
		Resource page004Mapper = new ClassPathResource("mapper/page004-mapper.xml");
		Resource page005Mapper = new ClassPathResource("mapper/page005-mapper.xml");
		Resource page006Mapper = new ClassPathResource("mapper/page006-mapper.xml");

		sqlSessionFactory.setMapperLocations(new Resource[]{
				page001Mapper, page002Mapper, page003Mapper, page004Mapper, page005Mapper, page006Mapper});

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