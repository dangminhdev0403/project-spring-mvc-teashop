package com.minh.teashop.controller.client;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.minh.teashop.domain.Address;
import com.minh.teashop.domain.Order;
import com.minh.teashop.domain.User;
import com.minh.teashop.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller

public class ProfileController {
    private final UserService userService;

    public ProfileController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/order-history")
    public String getOrderHistoryPage(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        long id = (long) session.getAttribute("id");
        User currentUser = new User();
        currentUser.setUser_id(id);
        List<Order> listOrder = this.userService.getOrder(currentUser);

        model.addAttribute("listOrders", listOrder);
        return "client/order/oder-history";

    }

    @PostMapping("/cancel-oder")
    public String postMethodName( HttpServletRequest request) {
        String referer = request.getHeader("Referer");
        
        return "redirect:" + referer;

    }

    @PostMapping("/add-address")
    public String handleCreateAddress(@ModelAttribute("newAddress") Address address,
            RedirectAttributes redirectAttributes, HttpServletRequest request) {
        String referer = request.getHeader("Referer");
        HttpSession session = request.getSession(false);
        long id = (long) session.getAttribute("id");
        User currentUser = new User();
        currentUser.setUser_id(id);
            address.setUser(currentUser);    
        this.userService.handleSaveAddress(address);
        redirectAttributes.addFlashAttribute("success", "Thêm địa chỉ thành công");

        return "redirect:" + referer;
    }

    @PostMapping("/delete-address")
    public String deleteAddress(HttpServletRequest request, RedirectAttributes redirectAttributes,
            @RequestParam("adrID") long id) {
        String referer = request.getHeader("Referer");
        this.userService.handleDeleteAddressById(id);
        redirectAttributes.addFlashAttribute("success", "Xoá địa chỉ thành công");

        return "redirect:" + referer;
    }

    @PostMapping("/update-address")
    public String updateAddress(HttpServletRequest request, RedirectAttributes redirectAttributes,
            @RequestParam("idAddress") long id,
            @RequestParam("receiverName") String receiverName,
            @RequestParam("receiverPhone") String receiverPhone,
            @RequestParam("city") String city,
            @RequestParam("district") String district,
            @RequestParam("ward") String ward,
            @RequestParam("address") String newAddress

    ) {
        String referer = request.getHeader("Referer");
        HttpSession session = request.getSession(false);
        long userId = (long) session.getAttribute("id");
        User currentUser = new User();
        currentUser.setUser_id(userId);
        Address address = new Address(id, receiverPhone, receiverName, city, district, ward, newAddress, currentUser) ;

        this.userService.handleSaveAddress(address);

        redirectAttributes.addFlashAttribute("success", "Cập nhật địa chỉ thành công");

        return "redirect:" + referer;
    }

}
