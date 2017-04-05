package com.stp.absm.repository;

import com.stp.absm.model.AbsmPrivate;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface AbsmPrivateRepository extends JpaRepository<AbsmPrivate, Integer> {
    List<AbsmPrivate> findByOrderByPrIdAsc();
    List<AbsmPrivate> findByCaIdOrderByPrIdAsc(Integer caId);

    AbsmPrivate findByCaIdAndPNo(Integer caId,Integer pNo);


}
