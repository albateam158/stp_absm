package com.stp.absm.common;

import org.springframework.util.Base64Utils;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * Created by sj on 16. 2. 26..
 */
public class CommonUtil {

//    public static String sha256(String realnmno) throws NoSuchAlgorithmException {
//
//        MessageDigest md = MessageDigest.getInstance("SHA-256");
//        byte[] mdResult = md.digest(realnmno.getBytes());
//        String encryptedPass = new String(Base64Utils.encode(mdResult));
//        return encryptedPass;
//    }


    //SHA-256
    public static String sha256(String str) {

        String rtnSHA = "";

        try{
            MessageDigest sh = MessageDigest.getInstance("SHA-256");
            sh.update(str.getBytes());
            byte byteData[] = sh.digest();
            StringBuffer sb = new StringBuffer();

            for(int i = 0 ; i < byteData.length ; i++){
                sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));
            }
            rtnSHA = sb.toString();

        }catch(NoSuchAlgorithmException e){
            e.printStackTrace();
            rtnSHA = null;
        }
        return rtnSHA;
    }
}
