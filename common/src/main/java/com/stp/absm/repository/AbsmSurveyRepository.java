package com.stp.absm.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.stp.absm.model.AbsmCode;
import com.stp.absm.repository.support.Master;

@Master
public interface AbsmSurveyRepository extends JpaRepository<AbsmCode, Integer> {

}
