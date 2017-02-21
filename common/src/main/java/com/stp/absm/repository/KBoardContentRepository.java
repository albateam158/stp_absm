package com.stp.absm.repository;

import com.stp.absm.repository.support.Master;
import com.stp.absm.model.KamsBoardContent;
import org.springframework.data.jpa.repository.JpaRepository;

@Master
public interface KBoardContentRepository extends JpaRepository<KamsBoardContent, Integer> {

}

