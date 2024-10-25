package com.minh.teashop.domain;

import org.springframework.web.bind.annotation.ControllerAdvice;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Setter
@Getter
@NoArgsConstructor
@ControllerAdvice
public class CartDetail {
        @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id ;
    private double price ;
    private long quantity ;
    @ManyToOne
    @JoinColumn(name = "cart_id")
    private Cart cart ;
    
    @ManyToOne
    @JoinColumn(name = "product_id")
    private Product product ;
    
}