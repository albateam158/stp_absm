package com.stp.absm.repository;

import com.stp.absm.model.KamsBoardComments;
import com.stp.absm.repository.support.Master;
import org.springframework.data.jpa.repository.JpaRepository;

@Master
public interface KBoardCommentsRepository extends JpaRepository<KamsBoardComments, Integer> {

}

