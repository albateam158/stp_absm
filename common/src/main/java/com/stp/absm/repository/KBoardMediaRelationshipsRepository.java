package com.stp.absm.repository;

import com.stp.absm.repository.support.Master;
import com.stp.absm.model.KamsBoardMediaRelationships;
import org.springframework.data.jpa.repository.JpaRepository;

@Master
public interface KBoardMediaRelationshipsRepository extends JpaRepository<KamsBoardMediaRelationships, Integer> {

}

