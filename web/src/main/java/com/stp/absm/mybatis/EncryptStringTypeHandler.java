package com.stp.absm.mybatis;

import org.apache.ibatis.type.StringTypeHandler;

import java.sql.ResultSet;
import java.sql.SQLException;

public class EncryptStringTypeHandler extends StringTypeHandler {



    @Override
    public String getResult(ResultSet rs, String columnName)
            throws SQLException {

        String data = rs.getString(columnName);

        data = MyBatisConfig.aes.decryptString(data);

        return data;
    }


}