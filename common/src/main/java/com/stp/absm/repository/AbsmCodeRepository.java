package com.stp.absm.repository;

import com.stp.absm.model.AbsmCode;
import org.springframework.data.jpa.repository.JpaRepository;

import com.stp.absm.repository.support.Master;

import java.util.List;

@Master
public interface AbsmCodeRepository extends JpaRepository<AbsmCode, Integer> {
    List<AbsmCode> findAllByCodeGroupAndDeleteDateIsNull(String codeGroup);
    List<AbsmCode> findAllByCodeGroupAndDeleteDateIsNullOrderByCoIdDesc(String codeGroup);

    AbsmCode findAllByCodeAndCodeGroupAndDeleteDateIsNull(String code, String codeGroup);
}
