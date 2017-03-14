package com.stp.absm.model;

import lombok.Data;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

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
    private Double meanRri;
    private Double stdRri;
    private Double meanHrv;
    private Double stdHrv;
    private Double rmssdd;
    private Double pnn50;
    private Double lfhf;
    private Double scl;
    private Double surAvg;
    @Transient
    private String dt;
    @Transient
    private String caseNm;
    private Date regDate;
    private Date updateDate;
    private Date deleteDate;

}
