package com.rga.controllers;

import java.util.List;
import java.util.NoSuchElementException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.rga.domain.Customer;
import com.rga.services.CustomersService;

@RestController
public class CustomerController {
	@Autowired
	private CustomersService customersService;
	private static Integer sequence = 0;
	
	
    @RequestMapping(value = "/customer/add", method=RequestMethod.POST)
    @ResponseBody
    public String add(@RequestBody String json)  {
		 ObjectMapper mapper = new ObjectMapper();
		 Customer customer;
		try {
			customer = mapper.readValue(json, Customer.class);
			customer.setSno(++sequence);
			customersService.save(customer);
		}catch (Exception e) {
			e.printStackTrace();
			return "save fail";
		}
		return "save success, add a "+ customer.toString() ;
	}
    
	
	@RequestMapping(value = "/customer/queryAll", method=RequestMethod.GET)
    public List<Customer> queryAll() {
    	return customersService.findByAll();
    }
	
	@RequestMapping(value = "/customer/query", method=RequestMethod.GET)
    public String query(@RequestParam(value="sno") Integer sno) {
		try {
			Customer customer = customersService.findBySno(sno);
	    	return customer.toString();
		} catch (NoSuchElementException e) {
			return "no find";
		}
	}
	
	 @RequestMapping(value = "/customer/update", method=RequestMethod.POST)
	    @ResponseBody
	    public String update(@RequestBody String json)  {
			 ObjectMapper mapper = new ObjectMapper();
			 Customer customer;
			try {
				customer = mapper.readValue(json, Customer.class);
				customersService.update(customer);
			}catch (Exception e) {
				e.printStackTrace();
				return "update fial";
			}
			return "update success, update "+ customer.toString() ;
		}
	
	@RequestMapping(value = "/customer/delete", method=RequestMethod.POST)
    public String delete(@RequestParam(value="sno") Integer sno) {
		return customersService.delete(sno)? ("delete success customer sno:"+sno):
											 "no find and no customer deleted";
	}
	
}
