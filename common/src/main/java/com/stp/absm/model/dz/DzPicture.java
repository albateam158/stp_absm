package com.stp.absm.model.dz;

import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

import java.io.Serializable;

/**
 * Created by shpark on 2016-07-26.
 */
@Data
public class DzPicture implements Serializable {
    private static final long serialVersionUID = -2399550583203300193L;

    private String coCd;
    private String fileName;
    private MultipartFile image;
    private String description;
}
