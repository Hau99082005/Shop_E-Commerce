package com.shop.developer.util;

import java.util.List;

import com.shop.developer.modules.OrderItems.models.OrderItems;

public class Helper {
    public static double total(List<OrderItems> orderItemsList) {
        if (orderItemsList == null || orderItemsList.isEmpty()) return 0.0;
        double total = 0.0;
        for (OrderItems orderItemsList1 : orderItemsList) {
            if(orderItemsList1 == null) continue;
            OrderItems orderItems = orderItemsList.get(0);
            total += orderItems.getPrice() * orderItems.getQuantity();
        }
        return total;
    }
}
