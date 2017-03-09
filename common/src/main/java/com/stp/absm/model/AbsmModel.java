package com.stp.absm.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.*;

import lombok.Data;

@Data
@Entity
@Table(name = "absm_model")
public class AbsmModel implements Serializable {

    private static final long serialVersionUID = -2565451500618009275L;
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Integer moId;
    private Integer caId;
    private Integer prId;
    private Integer seCd;
    private Integer meanRri;
    private Integer stdRri;
    private Integer meanHrv;
    private Integer stdHrv;
    private Integer rmssdd;
    private Integer pnn50;
    private Integer lfhf;
    private Integer scl;
    private Integer surAvg;
    private Integer moPre1;
    private Integer moPre2;
    private Integer moPre3;
    private Integer moPre4;
    private Integer stLevel;
    private Date regDate;
    private Date updateDate;
    private Date deleteDate;

}
