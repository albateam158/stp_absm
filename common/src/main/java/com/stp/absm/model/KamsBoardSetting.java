package com.stp.absm.model;

import java.io.Serializable;

import javax.persistence.*;

import lombok.Data;

@Data
@Entity
@Table(name = "kams_board_setting")
public class KamsBoardSetting implements Serializable {


    private static final long serialVersionUID = -2565451500618009275L;
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Integer uid;
    private String boardName;
    private String skin;
    private String useComment;
    private String useEditor;
    private String permissionRead;
    private String permissionWrite;
    private String adminUser;
    private String useCategory;
    @Column(name="category1_list")
    private String category1List;
    @Column(name="category2_list")
    private String category2List;
    private Integer pageRpp;
    private String created;

}
