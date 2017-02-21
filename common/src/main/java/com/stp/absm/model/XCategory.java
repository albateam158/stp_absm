package com.stp.absm.model;

import lombok.Data;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Data
@Entity
@Table(name = "kams_category")
public class XCategory implements Serializable{


    private static final long serialVersionUID = -1177287852873606028L;
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Integer categoryId;
    private String type;
    private String name;
    private Integer orderNo;
    private Integer parentCategoryId;
    private Integer featuredProjectId;
    private String imageUrl;
    private String isCollect;
    private Date regDate;
    private Date updateDate;
    private Date deleteDate;

    @Transient
    private Integer projectCount;

}
