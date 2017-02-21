package com.stp.absm.model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.*;

import lombok.Data;

@Data
@Entity
@Table(name = "kams_notice_comment")
public class XNoticeComment implements Serializable{


    private static final long serialVersionUID = -2565451500618009275L;
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Integer commentId;
    private Integer noticeId;
    private String userId;
    private Integer parentCommentId;
    private String content;
//    @Transient
//    private XUser user;
    private Date regDate;
    private Date updateDate;
    private Date deleteDate;
    private Date adminDeleteDate;

    @Transient
    private List<XNoticeComment> replies;

    @Transient
    private String replyString;
}
