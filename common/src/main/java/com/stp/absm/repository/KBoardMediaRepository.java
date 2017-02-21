package com.stp.absm.repository;

import com.stp.absm.model.KamsBoardMedia;
import com.stp.absm.repository.support.Master;
import org.springframework.data.jpa.repository.JpaRepository;

@Master
public interface KBoardMediaRepository extends JpaRepository<KamsBoardMedia, Integer> {

}

