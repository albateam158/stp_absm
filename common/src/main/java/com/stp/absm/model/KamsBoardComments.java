package com.stp.absm.model;

import java.io.Serializable;

import javax.persistence.*;

import lombok.Data;

@Data
@Entity
@Table(name = "kams_board_setting")
public class KamsBoardComments implements Serializable {


    private static final long serialVersionUID = -2565451500618009275L;
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Integer uid;
    private Integer contentUid;
    private Integer parentUid;
    private Integer userUid;
    private String userDisplay;
    private String content;
    private Integer like;
    private Integer unlike;
    private Integer vote;
    private String created;
    private String status;
    private String password;

}
