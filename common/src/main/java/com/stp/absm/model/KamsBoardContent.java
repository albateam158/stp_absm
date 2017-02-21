package com.stp.absm.model;

import lombok.Data;

import javax.persistence.*;
import java.io.Serializable;

@Data
@Entity
@Table(name = "kams_board_content")
public class KamsBoardContent implements Serializable {


    private static final long serialVersionUID = -2565451500618009275L;

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public Integer getDisplayId() {
        return displayId;
    }

    public void setDisplayId(Integer displayId) {
        this.displayId = displayId;
    }

    public Integer getBoardId() {
        return boardId;
    }

    public void setBoardId(Integer boardId) {
        this.boardId = boardId;
    }

    public Integer getParentUid() {
        return parentUid;
    }

    public void setParentUid(Integer parentUid) {
        this.parentUid = parentUid;
    }

    public Integer getMemberUid() {
        return memberUid;
    }

    public void setMemberUid(Integer memberUid) {
        this.memberUid = memberUid;
    }

    public String getMemberDisplay() {
        return memberDisplay;
    }

    public void setMemberDisplay(String memberDisplay) {
        this.memberDisplay = memberDisplay;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getUpdate() {
        return update;
    }

    public void setUpdate(String update) {
        this.update = update;
    }

    public Integer getView() {
        return view;
    }

    public void setView(Integer view) {
        this.view = view;
    }

    public Integer getComment() {
        return comment;
    }

    public void setComment(Integer comment) {
        this.comment = comment;
    }

    public Integer getLike() {
        return like;
    }

    public void setLike(Integer like) {
        this.like = like;
    }

    public Integer getUnlike() {
        return unlike;
    }

    public void setUnlike(Integer unlike) {
        this.unlike = unlike;
    }

    public Integer getVote() {
        return vote;
    }

    public void setVote(Integer vote) {
        this.vote = vote;
    }

    public String getThumbnailFile() {
        return thumbnailFile;
    }

    public void setThumbnailFile(String thumbnailFile) {
        this.thumbnailFile = thumbnailFile;
    }

    public String getThumbnailName() {
        return thumbnailName;
    }

    public void setThumbnailName(String thumbnailName) {
        this.thumbnailName = thumbnailName;
    }

    public String getCategory1() {
        return category1;
    }

    public void setCategory1(String category1) {
        this.category1 = category1;
    }

    public String getCategory2() {
        return category2;
    }

    public void setCategory2(String category2) {
        this.category2 = category2;
    }

    public String getSecret() {
        return secret;
    }

    public void setSecret(String secret) {
        this.secret = secret;
    }

    public String getNotice() {
        return notice;
    }

    public void setNotice(String notice) {
        this.notice = notice;
    }

    public String getSearch() {
        return search;
    }

    public void setSearch(String search) {
        this.search = search;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Integer uid;
    @Transient
    private Integer displayId;

    private Integer boardId;
    private Integer parentUid;
    private Integer memberUid;
    private String memberDisplay;
    private String title;
    private String content;
    private String date;
    @Column(name="\"update\"")
    private String update;
    private Integer view;
    private Integer comment;
    @Column(name="\"like\"")
    private Integer like;
    private Integer unlike;
    private Integer vote;
    private String thumbnailFile;
    private String thumbnailName;
    private String category1;
    private String category2;
    private String secret;
    private String notice;
    private String search;
    private String status;
    private String password;

}
