package com.stp.absm.properties;

/**
 * @author stunstun(minhyuck.jung@nhnent.com)
 *
 */
public interface DatabaseProperties {

	public String getDataSourceClassName();
	public String getUrl();
	public String getUsername();
	public String getPassword();
	public int getMaxActive();
	public int getMinIdle();
	public int getMaxIdle();
	public int getMaxWait();
	public String getValidationQuery();
	public Boolean isTestOnBorrow();
	public Boolean isTestOnReturn ();
	public Boolean isTestWhileIdle();
	public long getTimeBetweenEvictionRunsMillis();
	public int getNumTestsPerEvictionRun();
	public long getMinEvictableIdleTimeMillis();
}
