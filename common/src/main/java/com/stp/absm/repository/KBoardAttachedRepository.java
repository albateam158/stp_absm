package com.stp.absm.repository;

import com.stp.absm.model.KamsBoardAttached;
import org.springframework.data.jpa.repository.JpaRepository;

import com.stp.absm.repository.support.Master;

import java.util.List;

@Master
public interface KBoardAttachedRepository extends JpaRepository<KamsBoardAttached, Integer> {
    List<KamsBoardAttached> findByContentUidOrderByUidDesc(Integer keyword);


}

