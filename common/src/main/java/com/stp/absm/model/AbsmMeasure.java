package com.stp.absm.model;

import lombok.Data;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Data
@Entity
@Table(name = "absm_measure")
public class AbsmMeasure implements Serializable {

    private static final long serialVersionUID = -2565451500618009275L;
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Integer meId;
    private Integer caId;
    private Integer prId;
    private String egCd;
    private String meTm;
    private Double meVal;
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
    @Transient
    private String num;

    private Date regDate;
    private Date updateDate;
    private Date deleteDate;

}
