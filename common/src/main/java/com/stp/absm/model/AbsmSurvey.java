package com.stp.absm.model;

import lombok.Data;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Data
@Entity
@Table(name = "absm_survey")
public class AbsmSurvey implements Serializable {

    private static final long serialVersionUID = -2565451500618009275L;
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Integer suId;
    private Integer caId;
    private Integer prId;
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
    private String sex;
    private String name;
    private String caseNm;
    private Date regDate;
    private Date updateDate;
    private Date deleteDate;

}
