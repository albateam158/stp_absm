package com.stp.absm.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.*;

import lombok.Data;

@Data
@Entity
@Table(name = "kams_pl_list")
public class KPlList implements Serializable {

    private static final long serialVersionUID = -2565451500618009275L;
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Integer id;
    private String dt;
    private String deptCd;
    @Transient
    private String deptNm;
    private String prod;
    @Transient
    private String prodNm;
    private String acc;
    @Transient
    private String accNm;
    @Transient
    private String sign;

    private String contents;
    private Integer amt;
    private Integer preId;

    private String regEmp;
    private Date regDate;
    private String updateEmp;
    private Date updateDate;
    private Date deleteDate;

    @Transient
    private String fixDeptCd;
    @Transient
    private String fixDeptNm;
    @Transient
    private Integer fixAmt;

    @Transient
    private Integer profit;
    @Transient
    private Integer totAmt;
    @Transient
    private Integer amt1;
    @Transient
    private Integer amt2;
    @Transient
    private Integer amt3;
    @Transient
    private String level;
    @Transient
    private String sectCd;
    @Transient
    private String sectNm;
}
