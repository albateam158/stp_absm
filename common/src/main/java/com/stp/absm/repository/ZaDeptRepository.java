package com.stp.absm.repository;

import com.stp.absm.model.dz.ZaDeptDaikin;
import com.stp.absm.repository.support.Master;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Created by bridge on 15. 12. 24..
 */
@Master
public interface ZaDeptRepository extends JpaRepository<ZaDeptDaikin, Integer> {

//    KPlList findAllByDt(String dt);
//
//    List<KPlList> findAllOrderByDtDesc();


}

