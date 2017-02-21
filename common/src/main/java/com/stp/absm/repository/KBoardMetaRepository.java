package com.stp.absm.repository;

import com.stp.absm.model.KamsBoardMeta;
import com.stp.absm.repository.support.Master;
import org.springframework.data.jpa.repository.JpaRepository;

@Master
public interface KBoardMetaRepository extends JpaRepository<KamsBoardMeta, Integer> {

}

