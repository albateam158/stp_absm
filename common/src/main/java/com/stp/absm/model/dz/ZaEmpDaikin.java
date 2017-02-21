package com.stp.absm.model.dz;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name = "kams_emp")
public class ZaEmpDaikin implements Serializable {

    private static final long serialVersionUID = -2399550583203300193L;

    private String coCd;
    @Id
    private String empCd;
    private String korNm;
    private String korNmk;
    private String enlsNm;
    private String brthDt;
    private String lsclFg;
    private String joinDt;
    private String rtrDt;
    private String deptCd;
    private String tel;
    private String genderFg;
    private String hclsCd;
    private String hclsNm;
    private String hrspCd;
    private String hrspNm;
    private String enrlFg;
    private String enrlNm;
    private String emalAdd;
    private String hp;
    private String insertDt;
    private String modifyDt;

}
