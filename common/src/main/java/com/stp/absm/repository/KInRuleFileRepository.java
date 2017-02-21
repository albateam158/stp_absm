package com.stp.absm.repository;

import com.stp.absm.repository.support.Master;
import com.stp.absm.model.KInRuleFile;
import org.springframework.data.jpa.repository.JpaRepository;

@Master
public interface KInRuleFileRepository extends JpaRepository<KInRuleFile, Integer> {
}
