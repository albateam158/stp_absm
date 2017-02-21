package com.stp.absm.controller;

import com.stp.absm.model.KInRuleFile;
import org.junit.Test;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URL;

/**
 * Created by shpark on 2016-10-25.
 */
public class CommonControllerTest {



    public static final int BUFF_SIZE = 2048;
    @Test
    public void ruleFile() throws Exception {


        KInRuleFile files = new KInRuleFile();

        files.setUrl("http://kams.kasset.co.kr/files/attached/20161014/a87d77cf050f0e4a1602d39b57576292.sql");
        files.setFileName("test.sql");


        // 서버에 실제 저장된 파일명
        String filename = files.getUrl() ;

        String filename2 [] = filename.split("http://kams.kasset.co.kr") ;
        System.out.println("filename2 : " + filename2[1].toString() );

        // 실제 내보낼 파일명
        String orgfilename = files.getFileName();


        URL url = new URL(filename);
        URI uri = url.toURI();


        String downFileName = filename2[1].toString();
        String orgFileName = orgfilename;


        File file = new File(filename);

        if (!file.exists()) {
            throw new FileNotFoundException(filename);
        }

        if (!file.isFile()) {
            throw new FileNotFoundException(filename);
        }


    }

    @Test
    public void ruleFile2() throws Exception {


        KInRuleFile files = new KInRuleFile();

        files.setUrl("http://kams.kasset.co.kr/files/attached/20161014/a87d77cf050f0e4a1602d39b57576292.sql");
        files.setFileName("test.sql");

        String filename = files.getUrl() ;
        URL url = new URL(filename);

        String fileURL = filename;

        HttpURLConnection httpConn = (HttpURLConnection) url.openConnection();
        int responseCode = httpConn.getResponseCode();

        // always check HTTP response code first
        if (responseCode == HttpURLConnection.HTTP_OK) {
            String fileName = "";
            String disposition = httpConn.getHeaderField("Content-Disposition");
            String contentType = httpConn.getContentType();
            int contentLength = httpConn.getContentLength();

            if (disposition != null) {
                // extracts file name from header field
                int index = disposition.indexOf("filename=");
                if (index > 0) {
                    fileName = disposition.substring(index + 10,
                            disposition.length() - 1);
                }
            } else {
                // extracts file name from URL
                fileName = fileURL.substring(fileURL.lastIndexOf("/") + 1,
                        fileURL.length());
            }

            System.out.println("Content-Type = " + contentType);
            System.out.println("Content-Disposition = " + disposition);
            System.out.println("Content-Length = " + contentLength);
            System.out.println("fileName = " + fileName);

            // opens input stream from the HTTP connection
//            InputStream inputStream = httpConn.getInputStream();
            BufferedInputStream fin = new BufferedInputStream(httpConn.getInputStream());


//            inputStream.close();

            System.out.println("File downloaded");
        } else {
            System.out.println("No file to download. Server replied HTTP code: " + responseCode);
        }
        httpConn.disconnect();
    }

}