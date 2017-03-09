package com.stp.absm.repository;

import com.stp.absm.repository.support.Master;
import com.stp.absm.model.KamsBoardLatestview;
import org.springframework.data.jpa.repository.JpaRepository;

@Master
public interface KBoardLastestviewRepository extends JpaRepository<KamsBoardLatestview, Integer> {

}
