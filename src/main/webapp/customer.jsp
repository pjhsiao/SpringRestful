<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<meta http-equiv="Content-Type" content="text/html;">
<script type="text/javascript">
var updateSno; // use temp sno when update event
var buttonObserver;
$(document).ready( function () {  
    $( "#add" ).click( function () {  
    	addCustmoer();  
    });  

    $( "#update" ).click( function () {  
    	updateCustmoer();  
    }); 
    
    $( "#queryAll" ).click( function () {  
    	queryAllCustmoer();  
    });
    buttonObserver = [$( "#add" ), $( "#update" )]; 
    isUpateState(false);
});

function  addCustmoer() {  
	var custmoer_json = {}
	custmoer_json["name"] = $("#name").val();
	custmoer_json["age"] = $("#age").val();
	custmoer_json["addr"] = $("#addr").val();
	
	if(custmoer_json["name"].length<1){ alert('name is empty'); return; }
	if(custmoer_json["age"].length<1){ alert('age is empty'); return; }
	if(custmoer_json["addr"].length<1){ alert('addr is empty'); return; }
	
    $.ajax(
		 	  {
				url : 'http://127.0.0.1:8080/SpringRestful/services/customer/add/',
		        type: 'POST',
		        data: JSON.stringify(custmoer_json),
		   	    contentType: 'application/json;',
		        async: false,
		        success: reload
   		    }
   		);
}

function  updateCustmoer() {  
	var custmoer_json = {}
	custmoer_json["sno"]  = updateSno;
	custmoer_json["name"] = $("#name").val();
	custmoer_json["age"]  = $("#age").val();
	custmoer_json["addr"] = $("#addr").val();
	
    $.ajax(
		 	  {
				url : 'http://127.0.0.1:8080/SpringRestful/services/customer/update/',
		        type: 'POST',
		        data: JSON.stringify(custmoer_json),
		   	    contentType: 'application/json;',
		        async: false,
		        success: reload
   		    }
   		);
}

function  queryAllCustmoer() {  
    $.ajax(
		 	  {
				url : 'http://127.0.0.1:8080/SpringRestful/services/customer/queryAll/' ,
		        type: 'GET',
		        async: false,
		        success: showTable
   		    }
   		);
}

function editCustomer(event){
	$("#name").val($(event).closest('tr').children('.name').html());
	$("#age").val($(event).closest('tr').children('.age').html());
	$("#addr").val($(event).closest('tr').children('.addr').html());
	updateSno = $(event).closest('tr').children('.sno').html();
	isUpateState(true);
}

function  deleteCustomer(event) {
	var sno = $(event).closest('tr').children('.sno').html();  
    $.ajax(
		 	  {
				url : 'http://127.0.0.1:8080/SpringRestful/services/customer/delete/' ,
		        type: 'POST',
 				data: "sno="+sno,
		        async: false,
		        success: function(msg) {
			          	  alert(msg);
			          	  queryAllCustmoer(); 
			    		}
		 	  }
   		);
}

function showTable(msg){
	$("#name").attr("value",'');
 	$("#age").attr("value" , '');
    $("#addr").attr("value", '');
	$("#showTable").remove();
	var dynamicTable = "<table id='showTable' style='border: 1px solid black;'><th>sno</th><th>name</th><th>age</th><th>addr</th><th>delButton</th><th>editButton</th>"
	for (var i = 0; i < msg.length; i++) {
		dynamicTable += "<tr>"
		var json_text = JSON.stringify(msg[i], null, null);
		var customer = jQuery.parseJSON(json_text);
		dynamicTable += "<td class='sno'>"+customer.sno+"</td>";
		dynamicTable += "<td class='name'>"+customer.name+"</td>";
		dynamicTable += "<td class='age'>"+customer.age+"</td>";
		dynamicTable += "<td class='addr'>"+customer.addr+"</td>";
		dynamicTable += "<td ><input type='button' onClick=deleteCustomer(this) id='delete' value='delete' style='width:80px' /></td>";
		dynamicTable += "<td ><input type='button' onClick=editCustomer(this)  id='edit' value='edit' style='width:80px' /></td>";
		dynamicTable += "</tr>"
	};
	dynamicTable = dynamicTable+"</table>";
	$("#showDiv").append(dynamicTable);
	isUpateState(false);
}

function reload(msg){
	  alert(msg);
      queryAllCustmoer(); 
}

function isUpateState(bol){
	$.each( buttonObserver, function( key, value ) {
			key==0?value.prop( "disabled", bol ):value.prop( "disabled", !bol );
		});
	
}
</script>
<title>Customer page</title>
</head>
<body>
	<H1>Customer CURD based on JQuery & Spring Restful</H1>
	<table>
		<tr>
			<td>name</td>
			<td colspan="2"><input type="text" id="name" /></td>
		</tr>
		<tr>
			<td>age</td>
			<td colspan="2"><input type="text" id="age" /></td>
		</tr>
		<tr>
			<td>address</td>
			<td colspan="2"><input type="text"  id="addr" /></td>
		</tr>
		<tr>
			<td><input type="button" id="add" value="add"/></td>
			<td><input type="button" id="update" value="update"/></td>
			<td><input type="button" id="queryAll" value="queryAll"/></td>
		</tr>
<!-- 		<tr> -->
<!-- 			<td><input type="button" id="query" value="query"/></td> -->
<!-- 		</tr> -->
	</table>
	<Div id="showDiv"></Div>
</body>
</html>