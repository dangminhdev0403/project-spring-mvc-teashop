package com.minh.teashop.repository;

import com.minh.teashop.domain.User;
import com.minh.teashop.domain.verifymail.VerificationToken;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public interface VerificationTokenRepository extends JpaRepository<VerificationToken, Long> {
    VerificationToken findByToken(String token);

    @Transactional 
    void deleteByUser(User user);



}
