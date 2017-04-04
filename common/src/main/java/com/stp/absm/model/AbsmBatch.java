package com.stp.absm.model;

import lombok.Data;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * Created by shpark on 2017-04-04.
 */

@Data
@Entity
@Table(name = "absm_batch")
public class AbsmBatch implements Serializable {

    private static final long serialVersionUID = -2565451500618009275L;
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Integer baId;
    private Integer viId;
    private Integer caId;
    private Integer prId;
    private String fileCd;
    private String url;
    private long fileSize;
    private String fileName;
    private String status;

    @Transient
    private String dt;
    @Transient
    private String caseNm;
    @Transient
    private String name;
    @Transient
    private String age;
    @Transient
    private String sex;
    @Transient
    private Integer pNo;

    private Date regDate;
    private Date updateDate;
    private Date deleteDate;

}