package com.stp.absm.common;

import com.stp.absm.model.AbsmBatch;
import com.stp.absm.model.AbsmFile;
import com.stp.absm.repository.AbsmBatchRepository;
import com.stp.absm.repository.AbsmFileRepository;
import com.stp.absm.repository.AbsmMeasureRepository;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;

/**
 * Created by thomas on 2017-03-13.
 */
@Service
public class MeasureFileService implements DataFileService {

    public static Logger logger = Logger.getLogger(MeasureFileService.class);

    FileUploadInfo fileUploadInfo = new FileUploadInfo();

    @Autowired
    protected AbsmMeasureRepository absmMeasureRepository;

    @Autowired
    protected AbsmFileRepository absmFileRepository;

    @Autowired
    protected AbsmBatchRepository absmBatchRepository;

    public MeasureFileService() {}

    @Override
    public void setFileInfo(FileUploadInfo fileUploadInfo) {
        this.fileUploadInfo = fileUploadInfo;
    }

    @Override
    public int doParse() {
        Date now        = new Date();

        String fileType = fileUploadInfo.getFileType();
        String fileName = fileUploadInfo.getFileName();
        String url      = fileUploadInfo.getUrl();
        int caId        = fileUploadInfo.getCaId();
        int prId        = fileUploadInfo.getPrId();
        long fileSize   = fileUploadInfo.getFileSize();

        // File Table Insert
        AbsmFile absmFile = new AbsmFile();
        absmFile.setCaId(caId);
        absmFile.setPrId(prId);

        if ("ECG".equals(fileType)) {
            absmFile.setFileCd("03");
        }
        else if ("GSR".equals(fileType)) {
            absmFile.setFileCd("04");
        }

        absmFile.setFileName(fileName);
        absmFile.setFileSize(fileSize);
        absmFile.setUrl(url);
        absmFile.setRegDate(now);
        absmFileRepository.save(absmFile);

        // AbsmBatch Table Insert
        AbsmBatch absmBatch = new AbsmBatch();
        absmBatch.setCaId(caId);
        absmBatch.setPrId(prId);

        absmBatch.setViId(absmFile.getViId());

        if ("ECG".equals(fileType)) {
            absmBatch.setFileCd("03");
        }
        else if ("GSR".equals(fileType)) {
            absmBatch.setFileCd("04");
        }

        absmBatch.setFileName(fileName);
        absmBatch.setFileSize(fileSize);
        absmBatch.setStatus("0");
        absmBatchRepository.save(absmBatch);

        return 0;
    }
}
