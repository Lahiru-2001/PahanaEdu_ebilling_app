package com.entity;

public class Customer {

	private int customer_Id;
	private int user_Id;
	private String account_Number;
	private String first_Name;
	private String last_Name;
	private String address;
	private String phone_Number;
	private String status;
	
	
	public Customer() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	public int getCustomer_Id() {
		return customer_Id;
	}
	public void setCustomer_Id(int customer_Id) {
		this.customer_Id = customer_Id;
	}
	public int getUser_Id() {
		return user_Id;
	}
	public void setUser_Id(int user_Id) {
		this.user_Id = user_Id;
	}
	public String getAccount_Number() {
		return account_Number;
	}
	public void setAccount_Number(String account_Number) {
		this.account_Number = account_Number;
	}
	public String getFirst_Name() {
		return first_Name;
	}
	public void setFirst_Name(String first_Name) {
		this.first_Name = first_Name;
	}
	public String getLast_Name() {
		return last_Name;
	}
	public void setLast_Name(String last_Name) {
		this.last_Name = last_Name;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhone_Number() {
		return phone_Number;
	}
	public void setPhone_Number(String phone_Number) {
		this.phone_Number = phone_Number;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	
	@Override
	public String toString() {
		return "user [customer_Id=" + customer_Id + ", user_Id=" + user_Id + ", account_Number=" + account_Number
				+ ", first_Name=" + first_Name + ", last_Name=" + last_Name + ", address=" + address + ", phone_Number="
				+ phone_Number + ", status=" + status + "]";
	}

	
	

	
}
