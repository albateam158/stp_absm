package com.stp.absm.repository;

import com.stp.absm.model.AbsmFilter;
import org.springframework.data.jpa.repository.JpaRepository;

import com.stp.absm.model.AbsmCode;
import com.stp.absm.repository.support.Master;

@Master
public interface AbsmFilterRepository extends JpaRepository<AbsmFilter, Integer> {

}
