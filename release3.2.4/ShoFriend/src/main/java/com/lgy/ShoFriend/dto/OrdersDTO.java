package com.lgy.ShoFriend.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrdersDTO {
	private int id;
	private int product_id;
	private int customer_id;
	private int friend_id;
	private int total_price;
	private Timestamp created_at;
	private String status;
	private int posted;
}
