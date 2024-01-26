

<cfquery name="updateproducts" datasource="StokTakip">
    update Products set productName='#form.UPDATEPRODUCTNAMEEND#',productPrice=#form.UPDATEPRODUCTPRICEEND# where productId=#form.UPDATEPRODUCTID# 
</cfquery>
<cflocation url="products.cfm">