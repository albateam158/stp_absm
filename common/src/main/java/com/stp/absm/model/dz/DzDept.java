package com.stp.absm.model.dz;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.*;

import lombok.Data;
@Data
public class DzDept implements Serializable {


    private static final long serialVersionUID = -2399550583203300193L;
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
