package com.stp.absm.repository;

import com.stp.absm.repository.support.Master;
import com.stp.absm.model.dz.ZaEmpDaikin;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Created by bridge on 15. 12. 24..
 */
@Master
public interface ZaEmpRepository extends JpaRepository<ZaEmpDaikin, Integer> {

//    KPlList findAllByDt(String dt);
//
//    List<KPlList> findAllOrderByDtDesc();


}

