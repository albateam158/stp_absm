package com.stp.absm.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.*;

import lombok.Data;

@Data
@Entity
@Table(name = "absm_case")
public class AbsmCase implements Serializable {

    private static final long serialVersionUID = -2565451500618009275L;
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Integer caId;
    private String dt;
    private String caseNm;
    private String note;
    private Date regDate;
    private Date updateDate;
    private Date deleteDate;

}
