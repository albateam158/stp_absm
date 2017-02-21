package com.stp.absm.model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.*;

import lombok.Data;

@Data
@Entity
@Table(name = "kams_notice")
public class XNotice implements Serializable{


    private static final long serialVersionUID = -2565451500618009275L;
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Integer noticeId;
    private Integer userId;
    private String category;
    @Transient
    private String categoryName;
    private String title;
    private String content;
    private Integer viewCount;
    private Date regDate;
    private Date updateDate;
    private Date deleteDate;

//    @Transient
//    private XUser user;

    @Transient
    private Integer commentCount;

    @Transient
    private List<XNoticeComment> comments;
}
