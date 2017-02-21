package com.stp.absm.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.*;

import lombok.Data;
import org.hibernate.annotations.GenericGenerator;

@Data
@Entity
@Table(name = "kams_prepl_list")
public class KPreplList implements Serializable {


    private static final long serialVersionUID = -2565451500618009275L;
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    @Column(name = "id")
    private Integer id;
    private String dt;
    private String deptCd;
    @Transient
    private String deptNm;
    private String prod;
    private String acc;
    @Transient
    private String prodNm;
    private String fixDeptCd;
    @Transient
    private String fixDeptNm;

    private String amt;


//    @MapsId
//    @OneToOne(cascade=CascadeType.ALL)
//    @JoinColumn(name="id")
//    private KPlList kPlList;


    private String regEmp;
    private Date regDate;
    private String updateEmp;
    private Date updateDate;
    private Date deleteDate;

}
