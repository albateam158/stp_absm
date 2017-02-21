package com.stp.absm.model;

import lombok.Data;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Data
@Entity
@Table(name = "kams_code")
public class XCode implements Serializable {


    private static final long serialVersionUID = -2399550583203300193L;
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Integer codeId;
    private String code;
    private String codeName;
    private String codeGroup;
    private String data1;
    private String data2;
    private Integer orderNo;
    private Date deleteDate;

}
