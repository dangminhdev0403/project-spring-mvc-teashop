package com.minh.teashop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.minh.teashop.domain.OrderDetail;
@Repository
public interface OrderDetailRepository extends JpaRepository<OrderDetail, Long> {
    
}
