package com.stp.absm.repository;

import com.stp.absm.model.AbsmCase;
import org.springframework.data.jpa.repository.JpaRepository;


import java.util.List;

public interface AbsmCaseRepository extends JpaRepository<AbsmCase, Integer> {
    List<AbsmCase> findByOrderByCaIdAsc();
}
