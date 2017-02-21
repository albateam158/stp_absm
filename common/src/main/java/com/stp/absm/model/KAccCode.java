package com.stp.absm.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name = "kams_acc_code")
public class KAccCode implements Serializable {

    private static final long serialVersionUID = -2565451500618009275L;
    @Id
    private String acc;
    private String sign;
    private String accNm;
    private String regEmp;
    private Date regDate;
    private String updateEmp;
    private Date updateDate;
    private Date deleteDate;

}
