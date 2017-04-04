package com.stp.absm.repository;

import com.stp.absm.model.AbsmBatch;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;


public interface AbsmBatchRepository extends JpaRepository<AbsmBatch, Integer> {
    List<AbsmBatch> findByStatusAndFileCdOrderByPrIdAsc(String status, String fileCd);

}
