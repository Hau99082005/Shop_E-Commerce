package com.shop.developer.util;

import java.math.BigDecimal;
import java.util.List;

import com.shop.developer.modules.OrderItems.models.OrderItems;

public class Helper {
    public static double total(List<OrderItems> orderItemsList) {
        if (orderItemsList == null || orderItemsList.isEmpty()) return 0.0;
        BigDecimal total = BigDecimal.ZERO;
        for (OrderItems item : orderItemsList) {
            if (item == null || item.getPrice() == null) continue;
            BigDecimal line = item.getPrice().multiply(BigDecimal.valueOf(item.getQuantity()));
            total = total.add(line);
        }
        return total.doubleValue();
    }
}
