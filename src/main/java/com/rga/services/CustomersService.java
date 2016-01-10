package com.rga.services;

import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rga.domain.Customer;
import com.rga.models.CustomersModel;

@Service
public class CustomersService {
	@Autowired
	private CustomersModel customersModel;
	
	public Customer findBySno(final Integer sno) throws NoSuchElementException{
		Optional<Customer> optional = customersModel.getCurrentCustomers()
									.stream()
									.filter(customer->customer.getSno().intValue()==sno.intValue())
									.findFirst();
		return optional.get();
	}
	
	public List<Customer> findByAll(){
		return customersModel.getCurrentCustomers();
	}
	
	public boolean save(Customer customer){
			return customersModel.getCurrentCustomers().add(customer);
	}
	
	public void update(Customer customer){
		for (int i = 0; i < customersModel.getCurrentCustomers().size(); i++) {
			if(customersModel.getCurrentCustomers().get(i).getSno().intValue()
					== customer.getSno().intValue()){
				customersModel.getCurrentCustomers().set(i, customer);
			}
		}
	}
	
	public boolean delete(final int sno) throws NoSuchElementException{
		try {
			Optional<Customer> optional = customersModel.getCurrentCustomers()
					.stream()
					.filter(customer->customer.getSno().intValue()==sno)
					.findFirst();
			return customersModel.getCurrentCustomers().remove(optional.get());
		} catch (NoSuchElementException e) {
			return false;
		}
	}
}
