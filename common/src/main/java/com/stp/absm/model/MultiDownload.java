package com.stp.absm.model;

import lombok.Data;

import java.io.Serializable;
import java.util.List;

@Data
public class MultiDownload implements Serializable{

    private List<DownloadFile> files;
}
