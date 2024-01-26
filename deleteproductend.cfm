

<cfquery name="deleteproduct" datasource="StokTakip">
    delete Products where ProductId=#form.PRODUCTID#
</cfquery>
<cflocation url="products.cfm">