package com.stp.absm.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.*;

import lombok.Data;

@Data
@Entity
@Table(name = "absm_file")
public class AbsmFile implements Serializable {

    private static final long serialVersionUID = -2565451500618009275L;
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Integer viId;
    private Integer caId;
    private Integer prId;
    private String fileCd;
    private String url;
    private Integer fileSize;
    private String fileName;
    private Date regDate;
    private Date updateDate;
    private Date deleteDate;

}