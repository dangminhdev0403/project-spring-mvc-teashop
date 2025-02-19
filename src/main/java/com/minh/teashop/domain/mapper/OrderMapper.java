package com.minh.teashop.domain.mapper;

import org.springframework.stereotype.Component;

import com.minh.teashop.domain.Order;
import com.minh.teashop.domain.OrderDetail;
import com.minh.teashop.domain.User;
import com.minh.teashop.domain.dto.CustomerAffiliateDTO;
import com.minh.teashop.domain.dto.OrderAffiliateDTO;

@Component
public class OrderMapper {

    // Phương thức chuyển đổi từ Order sang OrderAffiliateDTO

    public static CustomerAffiliateDTO toCustomerAffiliateDTO(User user) {
        if (user == null) {
            return null; // Trả về null nếu order null
        }
        boolean isEnabled = true;
        if (user.getDeletedAt() != null) {
            isEnabled = false;
        }
        int countOrder = user.getOrders().size();

        double subTotal = 0;
        for (Order order : user.getOrders()) {
            subTotal += order.getTotalPrice();
        }

        return new CustomerAffiliateDTO(user.getCustomerCode(), user.getName(), countOrder, subTotal, isEnabled);
    }


        // Phương thức chuyển đổi từ Order sang OrderAffiliateDTO
    public static OrderAffiliateDTO toOrderDTO(OrderDetail order) {
        if (order == null) {
            return null; // Trả về null nếu order null
        }

        return new OrderAffiliateDTO(
                order.getId(),
                order.getOrder().getOrderDate(),
                order.getOrder().getStatus(),
                order.getPrice(),
                order.getOrder().getUser() != null ? order.getOrder().getUser().getName() : "Khách vãng lai", // Xử lý trường hợp user null
                order.getCommissionRate()
        );
    }
}
