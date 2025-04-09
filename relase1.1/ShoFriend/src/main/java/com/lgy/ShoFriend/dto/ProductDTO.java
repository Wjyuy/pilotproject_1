package com.lgy.ShoFriend.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
@AllArgsConstructor
public class ProductDTO {
	private int id;
	private int store_id;
	private int category_id;
	private String title;
	private String description;
	private int price;
	private int stock;
	private String status;
	private String picture;
	private Timestamp discount_start;
	private Timestamp discount_end;
	private int discount_percentage;
}
