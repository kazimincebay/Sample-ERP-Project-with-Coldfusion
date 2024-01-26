


<cfquery name="deleteCustomer" datasource="StokTakip">
    delete from Customers where customerId=#form.UPDATECUSTOMERID#
</cfquery><cflocation url="customers.cfm">