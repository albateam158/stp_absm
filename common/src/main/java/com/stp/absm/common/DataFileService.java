package com.stp.absm.common;

/**
 * Created by thomas on 2017-03-10.
 * File Data DB 입력을 처리하는 interface
 */
public interface DataFileService {

    /* 데이터 파싱 후 DB입력 처리 */
    int doParse();

    void setFileInfo(FileUploadInfo fileUploadInfo);


}

