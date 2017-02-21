package com.stp.absm.repository;

import com.stp.absm.repository.support.Master;
import com.stp.absm.model.KamsBoardSetting;
import org.springframework.data.jpa.repository.JpaRepository;

@Master
public interface KBoardSettingRepository extends JpaRepository<KamsBoardSetting, Integer> {

}

