package com.stp.absm.model;

import lombok.Data;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Data
@Entity
@Table(name = "absm_org")
public class AbsmOrg implements Serializable {

    private static final long serialVersionUID = -2565451500618009275L;
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Integer orId;
    private Integer caId;
    private Integer prId;
    private String fiTm;

    //o**** 는 org데이터 , m**** 는 model데이터
    private Double meanRri;
    @Transient
    private Double oMeanRri;
    @Transient
    private Double mMeanRri;

    private Double stdRri;
    @Transient
    private Double oStdRri;
    @Transient
    private Double mStdRri;

    private Double meanHrv;
    @Transient
    private Double oMeanHrv;
    @Transient
    private Double mMeanHrv;

    private Double stdHrv;
    @Transient
    private Double oStdHrv;
    @Transient
    private Double mStdHrv;

    private Double rmssdd;


    @Transient
    private Double oRmssdd;
    @Transient
    private Double mRmssdd;

    private Double pnn50;
    @Transient
    private Double oPnn50;
    @Transient
    private Double mPnn50;

    private Double lfhf;
    @Transient
    private Double oLfhf;
    @Transient
    private Double mLfhf;

    private Double scl;
    @Transient
    private Double oScl;
    @Transient
    private Double mScl;

    //이벤트시간
    @Transient
    private String evDt1;
    @Transient
    private String evDt2;
    @Transient
    private String evDt3;
    @Transient
    private String evDt4;
    @Transient
    private String evDt5;
    @Transient
    private String evDt6;
    @Transient
    private String evDt7;
    @Transient
    private String evDt8;
    @Transient
    private String evDt9;
    @Transient
    private String evDt10;

    //구간코드
    @Transient
    private String seCd;
    @Transient
    private String codeName;

    @Transient
    private Double surAvg;
    @Transient
    private Double moPre1;
    @Transient
    private Double moPre2;
    @Transient
    private Double moPre3;
    @Transient
    private Double moPre4;
    @Transient
    private Integer stLevel;

    @Transient
    private String dt;
    @Transient
    private String name;
    @Transient
    private String caseNm;
    @Transient
    private int pNo;
    @Transient
    private String chartId;
    @Transient
    private String chartData;

    private Date regDate;
    private Date updateDate;
    private Date deleteDate;

}
