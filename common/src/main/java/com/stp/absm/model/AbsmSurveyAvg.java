package com.stp.absm.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.*;

import lombok.Data;

@Data
@Entity
@Table(name = "absm_survey_avg")
public class AbsmSurveyAvg implements Serializable {

    private static final long serialVersionUID = -2565451500618009275L;
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Integer suId;
    private Integer caId;
    private String suVal1;
    private String suVal2;
    private String suVal3;
    private String suVal4;
    private String suVal5;
    private String suVal6;
    private String suVal7;
    private String suVal8;
    @Transient
    private String dt;
    @Transient
    private String age;
    @Transient
    private String sex;
    @Transient
    private String name;
    @Transient
    private String caseNm;
    @Transient
    private String pNo;

    private Date regDate;
    private Date updateDate;
    private Date deleteDate;

}
