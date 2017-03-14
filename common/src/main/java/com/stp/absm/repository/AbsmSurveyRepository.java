package com.stp.absm.repository;

import com.stp.absm.model.AbsmSurvey;
import com.stp.absm.repository.support.Master;
import org.springframework.data.jpa.repository.JpaRepository;

@Master
public interface AbsmSurveyRepository extends JpaRepository<AbsmSurvey, Integer> {

}
