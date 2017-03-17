package com.stp.absm.common;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * Created by sj on 16. 2. 26..
 */
public class CommonUtil {

    private final static Logger logger = LoggerFactory.getLogger(CommonUtil.class);

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

    public static String removeDot(String cellData) {
        return cellData.substring(0, cellData.length()-2);
    }

    public static String fileTransferTo(MultipartFile file, String uploadPath) {

        String filePath = "";
        String fileName = "";

        /* check upload file path */
        File saveFolder = new File(uploadPath);
        if (!saveFolder.exists() || saveFolder.isFile()) {
            saveFolder.mkdirs();
        }

        fileName = file.getOriginalFilename();

        logger.info("file name " + fileName);

        if(!fileName.trim().equals("")) {

            filePath = uploadPath + "\\" + fileName;

            logger.info("filePath " + filePath);

            File saveFile = new File(filePath);

            /*if (saveFile.exists()) {
                saveFile.delete();
            }*/

            /*try {
                file.transferTo(new File(filePath));
            }
            catch (IOException ie) {
                ie.printStackTrace();
            }
*/
        }

        return filePath;
    }
}
