package com.stp.absm.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.*;

import lombok.Data;

@Data
@Entity
@Table(name = "kams_board_content")
public class KamsBoardContent implements Serializable {


    private static final long serialVersionUID = -2565451500618009275L;
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
