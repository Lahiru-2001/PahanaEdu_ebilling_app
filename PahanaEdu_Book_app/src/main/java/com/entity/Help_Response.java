package com.entity;

import java.util.Date;

public class Help_Response {

	private int help_res_id;
	private int customer_id;
	private int help_id;
	private String response_ms;
	private Date created_at;

	public int getHelp_res_id() {
		return help_res_id;
	}

	public void setHelp_res_id(int help_res_id) {
		this.help_res_id = help_res_id;
	}

	public int getCustomer_id() {
		return customer_id;
	}

	public void setCustomer_id(int customer_id) {
		this.customer_id = customer_id;
	}

	public int getHelp_id() {
		return help_id;
	}

	public void setHelp_id(int help_id) {
		this.help_id = help_id;
	}

	public String getResponse_ms() {
		return response_ms;
	}

	public void setResponse_ms(String response_ms) {
		this.response_ms = response_ms;
	}

	public Date getCreated_at() {
		return created_at;
	}

	public void setCreated_at(Date created_at) {
		this.created_at = created_at;
	}

	@Override
	public String toString() {
		return "Help_Response [help_res_id=" + help_res_id + ", customer_id=" + customer_id + ", help_id=" + help_id
				+ ", response_ms=" + response_ms + ", created_at=" + created_at + "]";
	}

}
