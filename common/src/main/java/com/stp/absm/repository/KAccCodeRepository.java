package com.stp.absm.repository;

import java.util.List;

import com.stp.absm.model.KAccCode;
import com.stp.absm.repository.support.Master;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Created by bridge on 15. 12. 24..
 */
@Master
public interface KAccCodeRepository extends JpaRepository<KAccCode, Integer> {


    List<KAccCode> findAll();


}

