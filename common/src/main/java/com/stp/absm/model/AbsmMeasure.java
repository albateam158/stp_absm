package com.stp.absm.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.*;

import lombok.Data;

@Data
@Entity
@Table(name = "absm_measure")
public class AbsmMeasure implements Serializable {

    private static final long serialVersionUID = -2565451500618009275L;
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Integer meId;
    private Integer caId;
    private Integer prId;
    private String egCd;
    private String meTm;
    private Integer meVal;
    private Date regDate;
    private Date updateDate;
    private Date deleteDate;

}
