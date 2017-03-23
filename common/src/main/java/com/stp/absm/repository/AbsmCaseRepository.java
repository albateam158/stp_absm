package com.stp.absm.repository;

import com.stp.absm.model.AbsmCase;
import org.springframework.data.jpa.repository.JpaRepository;

import com.stp.absm.repository.support.Master;

import java.util.List;

@Master
public interface AbsmCaseRepository extends JpaRepository<AbsmCase, Integer> {
    List<AbsmCase> findByOrderByCaIdAsc();
}
