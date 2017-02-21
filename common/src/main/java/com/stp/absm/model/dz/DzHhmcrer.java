package com.stp.absm.model.dz;

import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

import java.io.Serializable;

/**
 * Created by shpark on 2016-07-26.
 */
@Data
public class DzHhmcrer implements Serializable {
    private static final long serialVersionUID = -2399550583203300193L;

    private String coCd;
    private String empCd;
    private String joinDt;
    private String rtrDt;
    private String dutyDc;
    private String hplcNm;
    private String jbchDc;
    private String hrtNm;
    private String payAm;
    private String rtrsDc;
    private String longYn;
    private String memoCd;
}
