package com.rga.domain;

public class Customer{
	 	
		private Integer sno;
		private String  name;
		private Integer age;
		private String  addr;
	    
		public Integer getSno() {
			return sno;
		}
		public void setSno(Integer sno) {
			this.sno = sno;
		}
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public Integer getAge() {
			return age;
		}
		public void setAge(Integer age) {
			this.age = age;
		}
		public String getAddr() {
			return addr;
		}
		public void setAddr(String addr) {
			this.addr = addr;
		}
		
		@Override
		public String toString() {
			return "Customer [sno=" + sno + ", name=" + name + ", age=" + age + ", addr=" + addr + "]";
		}
}
