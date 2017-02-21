package com.stp.absm.repository;

import com.stp.absm.repository.support.Master;
import com.stp.absm.model.KPreplList;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Created by bridge on 15. 12. 24..
 */
@Master
public interface KPreplListRepository extends JpaRepository<KPreplList, Integer> {

//    KPreplList findAllByDt(String dt);
//
//    List<KPreplList> findAllOrderByDtDesc();


}

