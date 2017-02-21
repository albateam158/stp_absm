package com.stp.absm.repository;

import java.util.List;

import com.stp.absm.model.KProdCode;
import com.stp.absm.repository.support.Master;

/**
 * Created by bridge on 15. 12. 24..
 */
@Master
public interface KProdCodeRepository  {

    KProdCode findByProd(String prod);

    List<KProdCode> findAll();


}

