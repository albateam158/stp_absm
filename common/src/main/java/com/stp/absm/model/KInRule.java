package com.stp.absm.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.*;

import lombok.Data;

@Data
@Entity
@Table(name = "kams_inter_rule_code")
public class KInRule implements Serializable {


    private static final long serialVersionUID = -2565451500618009275L;
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Integer ruleId;
    private String groupId;
    @Transient
    private String groupNm;
    private String docGroup;
    private String docSeq;
    private String docId;
    private String ruleNm;
    private String establishDt;
    private String reformDt;
    private String chargeDept;
    @Transient
    private String chargeDeptNm;
    private String chargeDeptDetail;

    private Integer recentFile;
    @Transient
    private String recentFileUrl;
    @Transient
    private String recentFileName;

    private Integer beforeFile;
    @Transient
    private String beforeFileUrl;
    @Transient
    private String beforeFileName;

    private String state;
    private String regEmp;
    private Date regDate;
    private String updateEmp;
    private Date updateDate;
    private Date deleteDate;
    @Transient
    private String data2;


}
