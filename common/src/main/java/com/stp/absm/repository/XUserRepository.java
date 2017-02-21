package com.stp.absm.repository;

import java.util.Date;
import java.util.List;

import com.stp.absm.model.XUser;
import com.stp.absm.repository.support.Master;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Created by bridge on 15. 12. 24..
 */
@Master
public interface XUserRepository extends JpaRepository<XUser, String> {

    XUser findByEmail(String username);

    List<XUser> findByUserStateAndOutDateBefore(String out, Date date);

    int countByEmail(String email);

    XUser findByEmpNo(String username);

}

