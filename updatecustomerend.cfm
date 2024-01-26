

<cfquery name="updateCustomer" datasource="StokTakip">
update Customers SET customerName='#UPDATECUSTOMERNAMEEND#' where customerId=#UPDATECUSTOMERID#
</cfquery>
<cflocation url="customers.cfm"/>