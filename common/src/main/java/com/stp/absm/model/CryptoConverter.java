package com.stp.absm.model;

import com.stp.absm.common.AES;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Service;

import javax.persistence.AttributeConverter;
import javax.persistence.Converter;

@Converter
@Service
public class CryptoConverter implements AttributeConverter<String, String> , ApplicationContextAware{

//    @Value(value = "${aeskey}")
//    private String aeskey;
//
//    private String ALGORITHM = "AES/ECB/PKCS5Padding";
//    private byte[] KEY = "CsZI7RLfhyuKL_CSBYyh4D3vXFr77bnTMvu9tWKF07Q".getBytes();

    private static AES aes;

    @Override
    public String convertToDatabaseColumn(String data) {

        if(StringUtils.isEmpty(data) == false){

            return CryptoConverter.aes.encryptString(data);
        }

        return data;
    }

    @Override
    public String convertToEntityAttribute(String dbData) {

//        return dbData;
        return CryptoConverter.aes.decryptString(dbData);
    }

    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        CryptoConverter.aes = (AES) applicationContext.getBean("aes");
    }
}