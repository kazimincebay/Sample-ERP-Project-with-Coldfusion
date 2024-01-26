




<cfquery name="addcustomer" datasource="StokTakip">
    insert into Customers (customerName) values ('#form.CUSTOMERNAME#')
</cfquery>
<cflocation url="customers.cfm">