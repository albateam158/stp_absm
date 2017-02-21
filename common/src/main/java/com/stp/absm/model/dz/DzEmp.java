package com.stp.absm.model.dz;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.*;

import lombok.Data;

@Data
public class DzEmp implements Serializable {


    private static final long serialVersionUID = -2399550583203300193L;

    private String coCd;
    private String empCd;
    private String korNm;
    private String korNmk;
    private String enlsNm;
    private String brthDt;
    private String lsclFg;
    private String joinDt;
    private String rtrDt;
    private String deptCd;
    private String deptNm;
    private String sectNm;
    private String tel;
    private String genderFg;
    private String hclsCd;
    private String hclsNm;
    private String hrspCd;
    private String hrspNm;
    private String hplcNm;
    private String enrlFg;
    private String enrlNm;
    private String emalAdd;
    private String hp;
    private String insertDt;
    private String modifyDt;
//    @OneToOne
//    @JoinColumn(name = "dept_cd")
//    private DzDept dept;
}
