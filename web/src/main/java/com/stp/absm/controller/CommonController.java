package com.stp.absm.controller;

import com.stp.absm.model.XFile;
import com.stp.absm.model.KInRuleFile;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.*;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.*;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

@RestController
public class CommonController extends RootController{

    public static final int BUFF_SIZE = 2048;
    private static final int BUFFER_SIZE = 4096;

    @RequestMapping(value = "/file/{fileId}", method = RequestMethod.GET)
    public void investor(
            @PathVariable(value = "fileId") Integer fileId,
            HttpServletResponse response,
            HttpServletRequest request
    ) throws IOException, IllegalBlockSizeException, InvalidKeyException, BadPaddingException, NoSuchAlgorithmException, NoSuchPaddingException, InvalidAlgorithmParameterException {

        XFile file = xFileRepository.findOne(fileId);

        String header =request.getHeader("User-Agent");
        String headerName = null;
        String fileName = null;

        if (header.contains("MSIE")) {
            headerName = "MSIE";
        } else if(header.contains("Chrome")) {
            headerName = "Chrome";
        } else if(header.contains("Opera")) {
            headerName = "Opera";
        }
        else {
            headerName = "Firefox";
        }

        if (headerName.contains("MSIE")) {
            fileName = URLEncoder.encode(file.getFilename(), "UTF-8").replaceAll("\\+", "%20");
        } else if (header.contains("Firefox")) {
            fileName = new String(file.getFilename().getBytes("UTF-8"), "ISO-8859-1");
        } else if (header.contains("Opera")) {
            fileName = new String(file.getFilename().getBytes("UTF-8"), "ISO-8859-1");
        } else if (header.contains("Chrome")) {
            fileName = new String(file.getFilename().getBytes("UTF-8"), "ISO-8859-1");
        }

        response.setContentType("application/vnd.ms-excel");
        response.setHeader("Content-Disposition", "attachment; filename="+fileName);


        response.getOutputStream().write(aes.decryptByte(file.getFile()));
        response.getOutputStream().flush();
    }

    @RequestMapping(value = "/ruleFile/{fileId}", method = RequestMethod.GET)
    public void ruleFile(
            @PathVariable(value = "fileId") Integer fileId,
            HttpServletResponse response,
            HttpServletRequest request
    ) throws IOException, IllegalBlockSizeException, InvalidKeyException, BadPaddingException, NoSuchAlgorithmException, NoSuchPaddingException, InvalidAlgorithmParameterException, URISyntaxException {


        KInRuleFile files = kInRuleFileRepository.findOne(fileId);
        request.setCharacterEncoding("UTF-8");

        // 서버에 실제 저장된 파일명
        String filename = files.getUrl();

        String filename2[] = filename.split("http://kams.kasset.co.kr");
        System.out.println("filename2 : " + filename2[1].toString());

        // 실제 내보낼 파일명

        String downFileName = "/data" + filename2[1].toString();
        String orgFileName = files.getFileName();


        File uFile = new File(downFileName);

        if (!uFile.exists()) {
            throw new FileNotFoundException(downFileName);
        }

        if (!uFile.isFile()) {
            throw new FileNotFoundException(downFileName);
        }

        int fSize = (int) uFile.length();

        if (uFile.exists()) {
            BufferedInputStream in = new BufferedInputStream(new FileInputStream(uFile));
            String userAgent = request.getHeader("User-Agent");
            response.setBufferSize(fSize);
            response.setContentType("application/octet-stream");

            if (userAgent.indexOf("MSIE") > -1) { // MS IE
                response.setHeader("Content-Disposition", "attachment; filename=\""
                        + URLEncoder.encode(orgFileName, "UTF8") + "\"");
            } else {
                response.setHeader("Content-Disposition", "attachment; filename=\""
                        + new String(orgFileName.getBytes("euc-kr"), "latin1")
                        + "\";");
            }
            response.setHeader("Content-Transfer-Encoding", "binary");
            response.setContentLength(fSize);
            try {
                int result = FileCopyUtils.copy(in, response.getOutputStream());
                in.close();
                response.getOutputStream().flush();
                response.getOutputStream().close();
            } catch (Exception e) {
                in.close();
                response.getOutputStream().close();
            }

        }
    }
    @RequestMapping(value = "/ruleFile2/{fileId}", method = RequestMethod.GET)
    public void ruleFile2(
            @PathVariable(value = "fileId") Integer fileId,
            HttpServletResponse response,
            HttpServletRequest request
    ) throws IOException, IllegalBlockSizeException, InvalidKeyException, BadPaddingException, NoSuchAlgorithmException, NoSuchPaddingException, InvalidAlgorithmParameterException, URISyntaxException {
        KInRuleFile files = kInRuleFileRepository.findOne(fileId);
        request.setCharacterEncoding("UTF-8");


        // 서버에 실제 저장된 파일명
        String filename = files.getUrl() ;

//        String filename2 [] = filename.split("http://kams.kasset.co.kr") ;
//        System.out.println("filename2 : " + filename2[1].toString() );
//
//        // 실제 내보낼 파일명
//        String orgfilename = files.getFileName();
//        filename  = filename2[1].toString();

        String fileURL = filename;


        URL url = new URL(filename);
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
//                fileName = fileURL.substring(fileURL.lastIndexOf("/") + 1,
//                        fileURL.length());
                fileName = files.getFileName();
            }

            System.out.println("Content-Type = " + contentType);
            System.out.println("Content-Disposition = " + disposition);
            System.out.println("Content-Length = " + contentLength);
            System.out.println("fileName = " + fileName);

            // opens input stream from the HTTP connection
//            InputStream inputStream = httpConn.getInputStream();
            BufferedInputStream fin = new BufferedInputStream(httpConn.getInputStream());

//            String saveFilePath = saveDir + File.separator + fileName;
//
//            // opens an output stream to save into file
//            FileOutputStream outputStream = new FileOutputStream(saveFilePath);
//
//            int bytesRead = -1;
//            byte[] buffer = new byte[BUFFER_SIZE];
//            while ((bytesRead = inputStream.read(buffer)) != -1) {
//                outputStream.write(buffer, 0, bytesRead);
//            }
//
//            outputStream.close();

            byte[] b = new byte[BUFF_SIZE]; //buffer size 2K.

            BufferedOutputStream outs = new BufferedOutputStream(response.getOutputStream());
            int read = 0;

            while ((read = fin.read(b)) != -1) {
                outs.write(b, 0, read);
            }

            outs.close();
            fin.close();

//            inputStream.close();

            System.out.println("File downloaded");
        } else {
            System.out.println("No file to download. Server replied HTTP code: " + responseCode);
        }
        httpConn.disconnect();
    }
}
