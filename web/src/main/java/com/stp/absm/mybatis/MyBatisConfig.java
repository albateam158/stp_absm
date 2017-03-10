/**
 * 
 */
package com.stp.absm.mybatis;

import java.io.IOException;

import javax.sql.DataSource;

import com.stp.absm.common.AES;
import com.stp.absm.repository.support.Master;
import com.stp.absm.repository.support.Slave;
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

/**
 * @author stunstun(minhyuck.jung@nhnent.com)
 *
 */
public abstract class MyBatisConfig {
	
	public static final String BASE_PACKAGE = "com.stp.absm";
	public static final String TYPE_ALIASES_PACKAGE = "com.stp.absm";
	public static final String CONFIG_LOCATION_PATH = "mapper/mybatis-config.xml";
	public static final String MAPPER_LOCATIONS_PATH = "mapper/**/*.xml";
	public static AES aes;

	@Autowired
	public void setAes(AES injectionAes) {
		aes = injectionAes;
	}


	protected void configureSqlSessionFactory(SqlSessionFactoryBean sessionFactoryBean, DataSource dataSource) throws IOException {
		PathMatchingResourcePatternResolver pathResolver = new PathMatchingResourcePatternResolver();
		sessionFactoryBean.setDataSource(dataSource);
		sessionFactoryBean.setTypeAliasesPackage(TYPE_ALIASES_PACKAGE);
		sessionFactoryBean.setConfigLocation(new ClassPathResource("mapper/mybatis-config.xml"));
		Resource categoryMapper                         = new ClassPathResource("mapper/category-mapper.xml");
		Resource noticeMapper                           = new ClassPathResource("mapper/notice-mapper.xml");
		Resource userMapper                           = new ClassPathResource("mapper/user-mapper.xml");
		Resource empMapper                           = new ClassPathResource("mapper/emp-mapper.xml");
		Resource recordMapper                           = new ClassPathResource("mapper/record-mapper.xml");
		Resource inRuleMapper                           = new ClassPathResource("mapper/inrule-mapper.xml");
		Resource boardMapper                           = new ClassPathResource("mapper/board-mapper.xml");

		sessionFactoryBean.setMapperLocations(new Resource[]{  categoryMapper, noticeMapper, userMapper, empMapper, recordMapper, inRuleMapper, boardMapper });
		//sessionFactoryBean.setMapperLocations(pathResolver.getResources(MAPPER_LOCATIONS_PATH));
	}
}

@Configuration
@MapperScan(basePackages = MyBatisConfig.BASE_PACKAGE, annotationClass = Master.class, sqlSessionFactoryRef = "masterSqlSessionFactory")
class MasterMyBatisConfig extends MyBatisConfig {

	@Bean(name = "masterSqlSessionFactory")
	public SqlSessionFactory masterSqlSessionFactory(@Qualifier("masterDataSource") DataSource masterDataSource) throws Exception {
		SqlSessionFactoryBean sessionFactoryBean = new SqlSessionFactoryBean();
		configureSqlSessionFactory(sessionFactoryBean, masterDataSource);
		return sessionFactoryBean.getObject();
	}
	@Bean(name = "masterSqlSessionTemplate")
    public SqlSessionTemplate masterSqlSessionTemplate(@Qualifier("masterSqlSessionFactory") SqlSessionFactory masterSqlSessionFactory) throws Exception {
        return new SqlSessionTemplate(masterSqlSessionFactory);
    }
}

//@Configuration
//@MapperScan(basePackages = MyBatisConfig.BASE_PACKAGE, annotationClass = Slave.class, sqlSessionFactoryRef = "slaveSqlSessionFactory")
//class SlaveMyBatisConfig extends MyBatisConfig {
//
//	@Bean(name = "slaveSqlSessionFactory")
//	public SqlSessionFactory slaveSqlSessionFactory(@Qualifier("slaveDataSource") DataSource slaveDataSource) throws Exception {
//		SqlSessionFactoryBean sessionFactoryBean = new SqlSessionFactoryBean();
//		configureSqlSessionFactory(sessionFactoryBean, slaveDataSource);
//		return sessionFactoryBean.getObject();
//	}
//	@Bean(name = "slaveSqlSessionTemplate")
//	public SqlSessionTemplate slaveSqlSessionTemplate(@Qualifier("slaveSqlSessionFactory") SqlSessionFactory slaveSqlSessionFactory) throws Exception {
//		return new SqlSessionTemplate(slaveSqlSessionFactory);
//	}
//}