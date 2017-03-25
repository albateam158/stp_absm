package com.stp.absm.model;

import lombok.Data;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Data
@Entity
@Table(name = "absm_event")
public class AbsmEvent implements Serializable {

    private static final long serialVersionUID = -2565451500618009275L;
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Integer evId;
    private Integer caId;
    private Integer pNo;
    private String evDt1;
    private String evDt2;
    private String evDt3;
    private String evDt4;
    private String evDt5;
    private String evDt6;
    private String evDt7;
    private String evDt8;
    private String evDt9;
    private String evDt10;
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
    private Date regDate;
    private Date updateDate;
    private Date deleteDate;

}
