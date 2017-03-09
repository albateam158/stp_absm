package com.stp.absm.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.*;

import lombok.Data;

@Data
@Entity
@Table(name = "absm_code")
public class AbsmCode implements Serializable {


    private static final long serialVersionUID = -2399550583203300193L;
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Integer coId;
    private String code;
    private String data;
    private String codeName;
    private String codeGroup;
    private Date regDate;
    private Date updateDate;
    private Date deleteDate;

}
