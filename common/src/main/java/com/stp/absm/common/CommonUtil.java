package com.stp.absm.common;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
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

        /**
         * multipart file의 getOriginalFilename은 로컬 파일 Full Path를 리턴하므로
         * back slash를 구분자로 마지막 최종 파일 명만 얻어온다
         * 그 후에 로컬파일 Full Path로 임시 MultipartFile을 생성하여 그 파일을 Upload 경로로
         * 이동시킨다
         */
        String[] multiFileArr = file.getOriginalFilename().split("\\\\");
        fileName  = multiFileArr[multiFileArr.length-1];
        logger.info("CommonUtil >>> fileName " + fileName);


        byte[] content = null;

        try {
            // MulitpartFile의 Content Byte
            content = file.getBytes();
        }
        catch (IOException ie) {
            ie.printStackTrace();
        }

        // 임시 MultipartFile 생성
        MultipartFile mFile = new MockMultipartFile(fileName, file.getOriginalFilename(), file.getContentType(), content);
        logger.info("CommonUtil >>> mFile " + mFile.getOriginalFilename());

        if(!fileName.trim().equals("")) {

            filePath = uploadPath + "\\" + fileName;

            logger.info("CommonUtil >>> Upload File Path " + filePath);

            File saveFile = new File(filePath);

            // 기존 파일이 있으면 삭제
            if (saveFile.exists()) {
                saveFile.delete();
            }

            // 해당 파일 업로드 경로로 이동
            try {
                mFile.transferTo(new File(filePath));
            }
            catch (IOException ie) {
                ie.printStackTrace();
            }

        }

        return filePath;
    }
}
