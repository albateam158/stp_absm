package com.stp.absm.repository;

import com.stp.absm.model.AbsmFile;
import org.springframework.data.jpa.repository.JpaRepository;

import com.stp.absm.model.AbsmCode;
import com.stp.absm.repository.support.Master;

@Master
public interface AbsmFileRepository extends JpaRepository<AbsmFile, Integer> {

}
