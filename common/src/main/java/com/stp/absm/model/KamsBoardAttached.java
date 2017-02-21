package com.stp.absm.model;

import java.io.Serializable;

import javax.persistence.*;

import lombok.Data;

@Data
@Entity
@Table(name = "kams_board_attached")
public class KamsBoardAttached implements Serializable {


    private static final long serialVersionUID = -2565451500618009275L;
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
