<!--- Formdaki Ürünleri Tek Tek yazdırmak --->

<cfset basketList = ListToArray(#Trim(form.basketList)#,',')/>
<cfdump var="#basketList#">
<cfset productList= arrayToList(#basketList#," - ")/>>
<cfdump var="#productList#">
<cfset list = ListToArray(#productList#,'-')/>
<cfdump var="#list#">



<!--- Price Hesaplama --->

<cfset totalPrice= 0 />

<cfloop index="p" from=1 to=#Arraylen(list)#>   
<cfquery name="getProductPrice" datasource="StokTakip">
select productPrice from Products where ProductName='#Trim(list[p])#'
</cfquery>
<cfif #getProductPrice.PRODUCTPRICE#!="">
    <cfset totalPrice+=#Trim(getProductPrice.PRODUCTPRICE)#*#Trim(list[p+1])# />
<cfelse>  
</cfif>


</cfloop>


<!--- Veri Tabanından Kullanıcı Adı Getirme  --->
<cfset customerId="#form.customerId#"/>

<!--- Tarih Alma --->
<cfset date=now()>
<cfset shortDate=#dateFormat(date, 'short')#>


<!--- Orders Tablosuna Veri Eklemek --->

<cfquery name="addOrdersTable" datasource="StokTakip">
    insert into Orders (OrderCreatedDate,CustomerId,OrderTotal) values ('#shortdate#','#customerId#','#totalPrice#')
    select SCOPE_IDENTITY();
</cfquery>
<cfset lastInsertId="#addOrdersTable.COMPUTED_COLUMN_1#">
 
<!--- Order Details Tablosuna Veri Eklemek --->
<cfloop index="d" from=1 to="#ArrayLen(list)#">
    <cfset prdPiece=0/>
    <cfif #IsNumeric(list[d])#=='NO'>
        <cfquery name="getprdInfo" datasource="StokTakip">
            select ProductId,ProductPrice from Products where productName='#Trim(list[d])#'
        </cfquery>
        <cfset prdId=#getprdInfo.PRODUCTID#>

        <cfset prdPrc=#getprdInfo.PRODUCTPRICE#>

    <cfelse>
        <cfset prdPiece=#list[d]#>
    </cfif>
    <cfif prdPiece==0>
    <cfelse>
        <cfquery name="addOrderDetails" datasource="StokTakip">
            insert into OrderDetails (OrderId,ProductId,ProductPrice,ProductPiece) values ('#lastInsertId#','#prdId#','#prdPrc#','#prdPiece#')
            </cfquery>
    </cfif>
    
    
</cfloop>
<cflocation url="orders.cfm"/>