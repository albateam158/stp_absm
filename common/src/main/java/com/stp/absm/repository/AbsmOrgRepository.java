package com.stp.absm.repository;

import com.stp.absm.model.AbsmOrg;
import org.springframework.data.jpa.repository.JpaRepository;

import com.stp.absm.model.AbsmFilter;
import com.stp.absm.repository.support.Master;

@Master
public interface AbsmOrgRepository extends JpaRepository<AbsmOrg, Integer> {

}
