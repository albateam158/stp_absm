package com.stp.absm.model;

import lombok.Data;

import javax.persistence.*;
import java.io.Serializable;

@Data
@Entity
@Table(name = "kams_board_attached")
public class KamsBoardAttached implements Serializable {


    private static final long serialVersionUID = -2565451500618009275L;

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public Integer getContentUid() {
        return contentUid;
    }

    public void setContentUid(Integer contentUid) {
        this.contentUid = contentUid;
    }

    public String getFileKey() {
        return fileKey;
    }

    public void setFileKey(String fileKey) {
        this.fileKey = fileKey;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Double getFileSize() {
        return fileSize;
    }

    public void setFileSize(Double fileSize) {
        this.fileSize = fileSize;
    }

    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Integer uid;
    private Integer contentUid;
    private String fileKey;
    private String date;
    private String filePath;
    private String fileName;
    @Transient
    private String url;
    private Double fileSize;
}
