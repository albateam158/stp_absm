package com.stp.absm.model.dz;

import java.io.Serializable;

import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Data
@Entity
@Table(name = "kams_dept")
public class ZaDeptDaikin implements Serializable {

    private static final long serialVersionUID = -2399550583203300193L;
    @Id
    private String deptCd;
    private String coCd;
    private String sectCd;
    private String sectNm;
    private String deptNm;
    private String deptNmk;
    private String divCd;
    private String regDt;
    private String toDt;
    private String insertDt;
    private String modifyDt;

}
