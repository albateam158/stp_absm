package com.stp.absm.model;

import lombok.Data;
import org.apache.commons.codec.binary.Base64;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Data
@Entity
@Table(name = "kams_file")
public class XFile implements Serializable{


    private static final long serialVersionUID = 2024365375750990217L;
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Integer fileId;

    @Lob @Basic(fetch = FetchType.LAZY)
    private byte[] file;
    private String filename;
    private Date regDate;
    private Date updateDate;
    private Date deleteDate;

    public String getBase64EncodedFile(){

        return Base64.encodeBase64String(file);
    }

}
