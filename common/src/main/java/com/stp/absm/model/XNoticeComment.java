package com.stp.absm.model;

import lombok.Data;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

@Data
@Entity
@Table(name = "kams_notice_comment")
public class XNoticeComment implements Serializable{


    private static final long serialVersionUID = -2565451500618009275L;

    public Integer getCommentId() {
        return commentId;
    }

    public void setCommentId(Integer commentId) {
        this.commentId = commentId;
    }

    public Integer getNoticeId() {
        return noticeId;
    }

    public void setNoticeId(Integer noticeId) {
        this.noticeId = noticeId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public Integer getParentCommentId() {
        return parentCommentId;
    }

    public void setParentCommentId(Integer parentCommentId) {
        this.parentCommentId = parentCommentId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getRegDate() {
        return regDate;
    }

    public void setRegDate(Date regDate) {
        this.regDate = regDate;
    }

    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    public Date getDeleteDate() {
        return deleteDate;
    }

    public void setDeleteDate(Date deleteDate) {
        this.deleteDate = deleteDate;
    }

    public Date getAdminDeleteDate() {
        return adminDeleteDate;
    }

    public void setAdminDeleteDate(Date adminDeleteDate) {
        this.adminDeleteDate = adminDeleteDate;
    }

    public List<XNoticeComment> getReplies() {
        return replies;
    }

    public void setReplies(List<XNoticeComment> replies) {
        this.replies = replies;
    }

    public String getReplyString() {
        return replyString;
    }

    public void setReplyString(String replyString) {
        this.replyString = replyString;
    }

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
