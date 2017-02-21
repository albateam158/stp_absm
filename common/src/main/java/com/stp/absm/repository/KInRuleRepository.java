package com.stp.absm.repository;

import com.stp.absm.repository.support.Master;
import com.stp.absm.model.KInRule;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Created by bridge on 15. 12. 24..
 */
@Master
public interface KInRuleRepository extends JpaRepository<KInRule, Integer> {

//    KPlList findAllByDt(String dt);
//
//    List<KPlList> findAllOrderByDtDesc();


}

