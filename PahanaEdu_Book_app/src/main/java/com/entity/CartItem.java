package com.entity;

import java.math.BigDecimal;

public class CartItem {
    private int bill_id;
    private int bill_item_id;
    private String name;
    private String category;
    private BigDecimal price;
    private int quantity;
    private String status;
    private BigDecimal total_amount;
    private BigDecimal subtotal;
	public int getBill_id() {
		return bill_id;
	}
	public void setBill_id(int bill_id) {
		this.bill_id = bill_id;
	}
	public int getBill_item_id() {
		return bill_item_id;
	}
	public void setBill_item_id(int bill_item_id) {
		this.bill_item_id = bill_item_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public BigDecimal getPrice() {
		return price;
	}
	public void setPrice(BigDecimal price) {
		this.price = price;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public BigDecimal getTotal_amount() {
		return total_amount;
	}
	public void setTotal_amount(BigDecimal total_amount) {
		this.total_amount = total_amount;
	}
	public BigDecimal getSubtotal() {
		return subtotal;
	}
	public void setSubtotal(BigDecimal subtotal) {
		this.subtotal = subtotal;
	}
	
	@Override
	public String toString() {
		return "CartItem [bill_id=" + bill_id + ", bill_item_id=" + bill_item_id + ", name=" + name + ", category="
				+ category + ", price=" + price + ", quantity=" + quantity + ", status=" + status + ", total_amount="
				+ total_amount + ", subtotal=" + subtotal + "]";
	}
    
}