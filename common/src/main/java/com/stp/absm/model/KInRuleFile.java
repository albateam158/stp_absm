package com.stp.absm.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.*;

import lombok.Data;

@Data
@Entity
@Table(name = "kams_inter_rule_file")
public class KInRuleFile implements Serializable {


    private static final long serialVersionUID = -2565451500618009275L;
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Integer fileId;
    private String url;

    private Double fileSize;
    private String fileName;
    private Date regDate;
    private Date updateDate;
    private Date deleteDate;


}