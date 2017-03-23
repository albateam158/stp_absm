package com.stp.absm.repository;

import com.stp.absm.model.AbsmPrivate;
import org.springframework.data.jpa.repository.JpaRepository;

import com.stp.absm.repository.support.Master;

import java.util.List;

@Master
public interface AbsmPrivateRepository extends JpaRepository<AbsmPrivate, Integer> {
    List<AbsmPrivate> findByOrderByPrIdAsc();
    List<AbsmPrivate> findByCaIdOrderByPrIdAsc(Integer caId);

}
