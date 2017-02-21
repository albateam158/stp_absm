package com.stp.absm.model;

import java.io.Serializable;

import javax.persistence.*;

import lombok.Data;

@Data
@Entity
@Table(name = "kams_board_meta")
public class KamsBoardMeta implements Serializable {


    private static final long serialVersionUID = -2565451500618009275L;
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Integer boardId;
    private String key;
    private String value;

}
