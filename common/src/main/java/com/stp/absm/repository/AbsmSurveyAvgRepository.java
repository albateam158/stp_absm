package com.stp.absm.repository;

import com.stp.absm.model.AbsmSurveyAvg;
import org.springframework.data.jpa.repository.JpaRepository;

import com.stp.absm.model.AbsmSurvey;
import com.stp.absm.repository.support.Master;

@Master
public interface AbsmSurveyAvgRepository extends JpaRepository<AbsmSurveyAvg, Integer> {

}
