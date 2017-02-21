package com.stp.absm.common;

import com.stp.absm.model.XFile;
import com.stp.absm.repository.XFileRepository;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Service;
import org.springframework.util.DigestUtils;
import org.springframework.web.multipart.MultipartFile;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.Date;

@Configuration
@Service
public class FileService {

    @Value(value = "${upload.fileLocation}")
    private String fileLocation;

    @Autowired
    private AES aes;

    @Autowired
    private XFileRepository xFileRepository;

    public String upload(MultipartFile file) throws IOException {

        String filename = null;

        if( file != null && file.isEmpty() == false ){

            Date now = new Date();

            String md5 = DigestUtils.md5DigestAsHex((file.getOriginalFilename() + now.getTime()).getBytes());
            filename = "/" + DateFormatUtils.format(now, "yyyyMMdd") + "/" + md5 + "." + FilenameUtils.getExtension(file.getOriginalFilename());


            File directory = new File(fileLocation + "/" + DateFormatUtils.format(now, "yyyyMMdd"));

            if( directory.exists() == false ){

                directory.mkdirs();
            }

            byte[] bytes = file.getBytes();
            BufferedOutputStream stream =
                    new BufferedOutputStream(new FileOutputStream(new File(fileLocation  + filename)));
            stream.write(bytes);
            stream.close();


//            //File destFile = new File(fileLocation  + filename);
//            File destFile = new File("/Users/bridge/Documents/develop/upload/crowdfund/20160118/test.jpeg");
//            file.transferTo(destFile);
        }

        return filename;
    }

    public String getFileName(MultipartFile file) throws IOException {
        String filename = null;

        if( file != null && file.isEmpty() == false ) {
            filename = file.getOriginalFilename();
        }

        return filename;
    }

    public XFile saveBlobfile(MultipartFile mfile) throws IOException, IllegalBlockSizeException, InvalidKeyException, BadPaddingException, NoSuchAlgorithmException, NoSuchPaddingException, InvalidAlgorithmParameterException {


        if( mfile != null && mfile.isEmpty() == false ){

            XFile file = new XFile();
            file.setFile(aes.encryptByte(mfile.getBytes()));
            file.setFilename(getFileName(mfile));
            file.setRegDate(new Date());
            xFileRepository.save(file);

            return file;
        }

        return null;
    }
}
