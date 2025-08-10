package com.entity;

public class Help {

	private int help_id;
	private int customer_id;
	private String title;
	private String content;

	public int getHelp_id() {
		return help_id;
	}

	public void setHelp_id(int help_id) {
		this.help_id = help_id;
	}

	public int getCustomer_id() {
		return customer_id;
	}

	public void setCustomer_id(int customer_id) {
		this.customer_id = customer_id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@Override
	public String toString() {
		return "Help [help_id=" + help_id + ", customer_id=" + customer_id + ", title=" + title + ", content=" + content
				+ "]";
	}

}
