package com.stp.absm.common;

import lombok.Data;

/**
 * Created by thomas on 2017-03-13.
 */
@Data
public class FileUploadInfo {
    private String fileName;
    private String fileType;
    private long fileSize;
    private int caId;
    private int prId;

}
