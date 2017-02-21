package com.stp.absm.model;

import lombok.Data;

import java.io.File;
import java.io.Serializable;

@Data
public class DownloadFile implements Serializable{

    private String name;
    private String download_url;

}
