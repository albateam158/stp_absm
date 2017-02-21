package com.stp.absm.model;

import java.io.Serializable;

import javax.persistence.*;

import lombok.Data;

@Data
@Entity
@Table(name = "kams_board_latestview")
public class KamsBoardLatestview implements Serializable {


    private static final long serialVersionUID = -2565451500618009275L;
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Integer uid;
    private String name;
    private String skin;
    private Integer rpp;
    private String sort;
    private String created;

}
