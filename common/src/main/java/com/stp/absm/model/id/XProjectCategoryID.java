package com.stp.absm.model.id;

import lombok.Data;

import javax.persistence.Embeddable;
import java.io.Serializable;

@Embeddable
@Data
public class XProjectCategoryID implements Serializable{

    private Integer projectId;
    private Integer categoryId;
}
