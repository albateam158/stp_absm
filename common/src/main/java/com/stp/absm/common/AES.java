package com.stp.absm.common;

import org.apache.commons.codec.binary.Base64;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import javax.crypto.*;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.Key;
import java.security.NoSuchAlgorithmException;

@Service(value = "aes")
public class AES {

    private final Logger log = LoggerFactory.getLogger(AES.class);

    @Value(value = "${aeskey}")
    private String aeskey;

    private Key secureKey;

    private String iv;

    @PostConstruct
    public void init(){
        secureKey = new SecretKeySpec(Base64.decodeBase64(aeskey), "AES");
        iv = aeskey.substring(0,16);
    }

    public byte[] encryptByte(byte[] data) throws NoSuchPaddingException, NoSuchAlgorithmException, BadPaddingException, IllegalBlockSizeException, InvalidKeyException, InvalidAlgorithmParameterException {

        Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
        cipher.init(Cipher.ENCRYPT_MODE, secureKey, new IvParameterSpec(iv.getBytes()));
        byte[] encryptedData = cipher.doFinal(data);

        return encryptedData;


    }


    public byte[] decryptByte(byte[] data) throws NoSuchPaddingException, NoSuchAlgorithmException, BadPaddingException, IllegalBlockSizeException, InvalidKeyException, InvalidAlgorithmParameterException {



        Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
        cipher.init(Cipher.DECRYPT_MODE, secureKey, new IvParameterSpec(iv.getBytes()));
        byte[] decrypted = cipher.doFinal(data);

        return decrypted;
    }


    public String encryptString(String data) {


        String temp = "";

        try{
            byte[] encryptedData = encryptByte(data.getBytes());

            temp = Base64.encodeBase64String(encryptedData);
        }catch (Exception e){

            log.error("[AES Error]" + e.getMessage()  );
        }


        return temp;


    }


    public String decryptString(String data) {

        String temp = "";

        try{
            byte[] decrypteddData = decryptByte(Base64.decodeBase64(data));

            temp = new String(decrypteddData);
        }catch (Exception e){

            log.error("[AES Error]" + e.getMessage()  );

        }

        return temp;
    }

    public static void main(String[] args) throws Exception {
        KeyGenerator generator = KeyGenerator.getInstance("AES");
        generator.init(256);

        Key key = generator.generateKey();


        byte[] keyBytes = key.getEncoded();
        String base64EncodedKey = Base64.encodeBase64URLSafeString(keyBytes);
        System.out.println(String.format("Key : %s Length : %d", base64EncodedKey, keyBytes.length));




        Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
        cipher.init(Cipher.ENCRYPT_MODE, key, new IvParameterSpec("".getBytes()));
        byte[] encryptedData = cipher.doFinal("Sadsad".getBytes());


        String base64EncodedKey2 = Base64.encodeBase64URLSafeString(encryptedData);

        System.out.println(String.format("Key : %s Length : %d", base64EncodedKey2, keyBytes.length));



        cipher.init(Cipher.DECRYPT_MODE, key, new IvParameterSpec("".getBytes()));
        byte[] decrypted = cipher.doFinal(Base64.decodeBase64(base64EncodedKey2));


        System.out.println(String.format("Key : %s Le1111111111ngth : %d", decrypted, keyBytes.length));
    }
}
