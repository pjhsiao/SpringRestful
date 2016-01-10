package com.rga.models;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.rga.domain.Customer;

@Repository
public class CustomersModel {

	private final static List<Customer> customers;
	
	static{
		customers = new ArrayList<>();
	}
	
	public List<Customer> getCurrentCustomers() {
		return customers;
	}
}
