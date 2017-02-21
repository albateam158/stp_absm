package com.stp.absm.repository;

import com.stp.absm.model.KamsBoardLatestviewLink;
import com.stp.absm.repository.support.Master;
import org.springframework.data.jpa.repository.JpaRepository;

@Master
public interface KBoardLastestviewLinkRepository extends JpaRepository<KamsBoardLatestviewLink, Integer> {

}

