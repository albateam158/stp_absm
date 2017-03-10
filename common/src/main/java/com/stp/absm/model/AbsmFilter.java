package com.stp.absm.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.*;

import lombok.Data;

@Data
@Entity
@Table(name = "absm_filter")
public class AbsmFilter implements Serializable {

    private static final long serialVersionUID = -2565451500618009275L;
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Integer fiId;
    private Integer caId;
    private Integer prId;
    private String fiTm;
    private Integer meanRri;
    private Integer stdRri;
    private Integer meanHrv;
    private Integer stdHrv;
    private Integer rmssdd;
    private Integer pnn50;
    private Integer lfhf;
    private Integer scl;
    private Integer surAvg;
    @Transient
    private String dt;
    @Transient
    private String caseNm;
    private Date regDate;
    private Date updateDate;
    private Date deleteDate;

}
