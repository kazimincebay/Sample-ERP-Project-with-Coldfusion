<!DOCTYPE html>
<head>
    <meta charset="tuf-8">
    <cfprocessingdirective pageencoding="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
    <title>Stok Takip </title>
</head>
<body>
    <nav class="navbar navbar-expand-lg bg-body-tertiary">
        <div class="container-fluid">
          <a class="navbar-brand" href="index.cfm">Stok Takip</a>
          <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>
          <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
            <div class="navbar-nav">
              <a class="nav-link active" aria-current="page" href="index.cfm">Anasayfa</a>
              <a class="nav-link" href="customers.cfm">Kurumsal Üyeler</a>
              <a class="nav-link" href="products.cfm">Ürünler</a>
              <a class="nav-link" href="orders.cfm">Siparişler</a>
            </div>
          </div>
        </div>
      </nav>
   
      <cfquery name="getallorders" datasource="StokTakip">
        select * from Orders
      </cfquery> 
      
      



      <div class="container mt-5">
        <div class="row">
          <div class="col justify-content-start d-flex"> <cfform action="orders.cfm" method="post" class="d-flex" role="search">
            <cfinput class="form-control me-2" name="info" type="search" placeholder="Üye Adı ya da Sipariş Numarası Giriniz" aria-label="Search">
            <button class="btn btn-outline-success" type="submit">Ara</button>
          </cfform></div>
          <div class="col justify-content-center d-flex">
            <cfform>
              <div class="form-check">
                <input class="form-check-input" type="radio" name="orderRadioButton" value="newToOld" id="orderRadioButton1">
                <label class="form-check-label" for="orderRadioButton1" >
                  Yeniden Eskiye
                </label>
              </div>
              <div class="form-check">
                <input class="form-check-input" type="radio" name="orderRadioButton" value="oldToNew" id="orderRadioButton2" >
                <label class="form-check-label" for="orderRadioButton2">
                  Eskiden Yeniye
                </label>
                <input type="submit" class="btn btn-primary"  value="Sırala"/>
              </div>
          </cfform>
          </div>
          <div class="col justify-content-end d-flex"><a class="btn btn-success justify-content-end d-flex" href="addorder.cfm">Sipariş Ekle</a></div>
        </div>
        <div class="row">
          <div class="col">
            <cfif not isDefined("form.info") >
              <cfif not isDefined("form.info") && not isDefined("form.ORDERRADIOBUTTON")>
              
                <cfif not isDefined("form.ORDERRADIOBUTTON") >
                  <table class="table">
                    <thead>
                      <tr>
                        <th>Sipariş Id</th>
                        <th>Üye Adı</th>
                        <th>Sipariş Tarihi</th>
                        <th>Sipariş Tutarı</th>
                        <th>Detay</th>
                        
                      </tr>
                    </thead>
                    <tbody>
                      <cfloop index="a" from="1" to="#getallorders.recordCount#">
                        <cfquery name="getCustomerName" datasource="StokTakip">select CustomerName from Customers Where CustomerId=#getallorders.CUSTOMERID[a]# </cfquery>
                        <cfoutput>
                          <tr>
                            <th>#getallorders.ORDERID[a]#</th>
                            <td class="excel">#getCustomerName.CUSTOMERNAME#</td>
                            <td class="excel">#DateFormat(getallorders.ORDERCREATEDDATE[a],'short')#</td>
                            <td class="excel">#getallorders.ORDERTOTAL[a]# ₺</td>
                            <th>
                              <cfform action="orderdetails.cfm" method="post">
                                <input type="hidden" name="OrderId" value="#getallorders.ORDERID[a]#">
                                <input type="submit" class="btn btn-success" value="Görüntüle"/>
                              </cfform></th>
                          </tr>
                        </cfoutput>
                      </cfloop>
                    </tbody>
                    </table>
                    <table class="table2" style="visibility:hidden;height:0px;display:block;">
                      <thead>
                        <tr>
                          <th>Üye Adı</th>
                          <th>Sipariş Tarihi</th>
                          <th>Sipariş Tutarı</th>
                        </tr>
                      </thead>
                      <tbody>
                        <cfloop index="a" from="1" to="#getallorders.recordCount#">
                          <cfquery name="getCustomerName" datasource="StokTakip">select CustomerName from Customers Where CustomerId=#getallorders.CUSTOMERID[a]# </cfquery>
                          <cfoutput>
                            <tr>
                              <td class="excel">#getCustomerName.CUSTOMERNAME#</td>
                              <td class="excel">#DateFormat(getallorders.ORDERCREATEDDATE[a],'short')#</td>
                              <td class="excel">#getallorders.ORDERTOTAL[a]# ₺</td>

                            </tr>
                          </cfoutput>
                        </cfloop>
                      </tbody>
                      </table>
                <cfelse>
                </cfif>
              
            <cfelse>
              <cfif #form.ORDERRADIOBUTTON#=="newToOld">
                <cfquery name="newToOldQuery" datasource="StokTakip">
                  select * from Orders order by OrderCreatedDate desc
                </cfquery>
                <table class="table">
                  <thead>
                    <tr>
                      <th>Sipariş Id</th>
                      <th>Üye Adı</th>
                      <th>Sipariş Tarihi</th>
                      <th>Sipariş Tutarı</th>
                      <th>Detay</th>
                      
                    </tr>
                  </thead>
                  <tbody>
                    <cfloop index="a" from="1" to="#newToOldQuery.recordCount#">
                      <cfquery name="getCustomerName" datasource="StokTakip">select CustomerName from Customers Where CustomerId=#newToOldQuery.CUSTOMERID[a]# </cfquery>
                      <cfoutput>
                        <tr>
                          <th>#newToOldQuery.ORDERID[a]#</th>
                          <td class="excel">#getCustomerName.CUSTOMERNAME#</td>
                          <td class="excel">#DateFormat(newToOldQuery.ORDERCREATEDDATE[a],'short')#</td>
                          <td class="excel">#newToOldQuery.ORDERTOTAL[a]# ₺</td>
                          <th>
                            <cfform action="orderdetails.cfm" method="post">
                              <input type="hidden" name="OrderId" value="#newToOldQuery.ORDERID[a]#">
                              <input type="submit" class="btn btn-success" value="Görüntüle"/>
                            </cfform></th>
                        </tr>
                      </cfoutput>
                    </cfloop>
                  </tbody>
                  </table>
                  <table class="table2" style="visibility:hidden;height:0px;display:block;">
                    <thead>
                      <tr>
                        <th>Üye Adı</th>
                        <th>Sipariş Tarihi</th>
                        <th>Sipariş Tutarı</th>
                      </tr>
                    </thead>
                    <tbody>
                      <cfloop index="a" from="1" to="#newToOldQuery.recordCount#">
                        <cfquery name="getCustomerName" datasource="StokTakip">select CustomerName from Customers Where CustomerId=#newToOldQuery.CUSTOMERID[a]# </cfquery>
                        <cfoutput>
                          <tr>
                            <td class="excel">#getCustomerName.CUSTOMERNAME#</td>
                            <td class="excel">#DateFormat(newToOldQuery.ORDERCREATEDDATE[a],'short')#</td>
                            <td class="excel">#newToOldQuery.ORDERTOTAL[a]# ₺</td>
                            
                          </tr>
                        </cfoutput>
                      </cfloop>
                    </tbody>
                    </table>
              <cfelse>
              </cfif>
              <cfif #form.ORDERRADIOBUTTON#=="oldToNew">
                <cfquery name="oldToNewQuery" datasource="StokTakip">
                  select * from Orders order by OrderCreatedDate
                </cfquery>
                <table class="table">
                  <thead>
                    <tr>
                      <th>Sipariş Id</th>
                      <th>Üye Adı</th>
                      <th>Sipariş Tarihi</th>
                      <th>Sipariş Tutarı</th>
                      <th>Detay</th>
                      
                    </tr>
                  </thead>
                  <tbody>
                    <cfloop index="a" from="1" to="#oldToNewQuery.recordCount#">
                      <cfquery name="getCustomerName" datasource="StokTakip">select CustomerName from Customers Where CustomerId=#oldToNewQuery.CUSTOMERID[a]# </cfquery>
                      <cfoutput>
                        <tr>
                          <th>#oldToNewQuery.ORDERID[a]#</th>
                          <td class="excel">#getCustomerName.CUSTOMERNAME#</td>
                          <td class="excel">#DateFormat(oldToNewQuery.ORDERCREATEDDATE[a],'short')#</td>
                          <td class="excel">#oldToNewQuery.ORDERTOTAL[a]# ₺</td>
                          <th>
                            <cfform action="orderdetails.cfm" method="post">
                              <input type="hidden" name="OrderId" value="#oldToNewQuery.ORDERID[a]#">
                              <input type="submit" class="btn btn-success" value="Görüntüle"/>
                            </cfform></th>
                        </tr>
                      </cfoutput>
                    </cfloop>
                  </tbody>
                  </table>
                  <table class="table2" style="visibility:hidden;height:0px;display:block;">
                    <thead>
                      <tr>
                        <th>Üye Adı</th>
                        <th>Sipariş Tarihi</th>
                        <th>Sipariş Tutarı</th>
                      </tr>
                    </thead>
                    <tbody>
                      <cfloop index="a" from="1" to="#oldToNewQuery.recordCount#">
                        <cfquery name="getCustomerName" datasource="StokTakip">select CustomerName from Customers Where CustomerId=#oldToNewQuery.CUSTOMERID[a]# </cfquery>
                        <cfoutput>
                          <tr>
                            <td>#getCustomerName.CUSTOMERNAME#</td>
                            <td>#DateFormat(oldToNewQuery.ORDERCREATEDDATE[a],'short')#</td>
                            <td>#oldToNewQuery.ORDERTOTAL[a]# ₺</td>
                          </tr>
                        </cfoutput>
                      </cfloop>
                    </tbody>
                    </table>
              <cfelse>
              </cfif>
            </cfif>
            <cfelse>
              <cfif form.info=="">
                <cfoutput>Herhangi bir arama kriteri girilmedi.</cfoutput>
                <cfelse>
                  <cfquery name="getCustomerId" datasource="StokTakip">
                    select CustomerId from Customers where CustomerName='#form.info#'
                  </cfquery>
                  <cfif #getCustomerId.CUSTOMERID#!="">
                    <cfquery name="getbyCustomerName" datasource="StokTakip">
                      select * from Orders where CustomerId=#getCustomerId.CUSTOMERID#
                    </cfquery>
                    <table class="table">
                      <thead>
                        <tr>
                          <th>Sipariş Id</th>
                          <th>Üye Adı</th>
                          <th>Sipariş Tarihi</th>
                          <th>Sipariş Tutarı</th>
                          <th>Detay</th>
                        </tr>
                      </thead>
                      <tbody>
                        <cfloop index="a" from="1" to="#getbyCustomerName.recordCount#">
                          <cfquery name="getCustomerName" datasource="StokTakip">select CustomerName from Customers Where CustomerId=#getCustomerId.CUSTOMERID# </cfquery>
                          <cfoutput>
                            <tr>
                              <th>#getbyCustomerName.ORDERID[a]#</th>
                              <td class="excel">#getCustomerName.CUSTOMERNAME#</td>
                              <td class="excel">#DateFormat(getbyCustomerName.ORDERCREATEDDATE[a],'short')#</td>
                              <td class="excel">#getbyCustomerName.ORDERTOTAL[a]# ₺</td>
                              <th>
                                <cfform action="orderdetails.cfm" method="post">
                                  <input type="hidden" name="OrderId" value="#getallorders.ORDERID[a]#">
                                  <input type="submit" class="btn btn-success" value="Görüntüle"/>
                                </cfform></th>
                            </tr>
                          </cfoutput>
                        </cfloop>
                      </tbody>
                      </table>
                      <table class="table2" style="visibility:hidden;height:0px;display:block;">
                        <thead>
                          <tr>
                            <th>Üye Adı</th>
                            <th>Sipariş Tarihi</th>
                            <th>Sipariş Tutarı</th>
                          </tr>
                        </thead>
                        <tbody>
                          <cfloop index="a" from="1" to="#getbyCustomerName.recordCount#">
                            <cfquery name="getCustomerName" datasource="StokTakip">select CustomerName from Customers Where CustomerId=#getCustomerId.CUSTOMERID# </cfquery>
                            <cfoutput>
                              <tr>
                                <td class="excel">#getCustomerName.CUSTOMERNAME#</td>
                                <td class="excel">#DateFormat(getbyCustomerName.ORDERCREATEDDATE[a],'short')#</td>
                                <td class="excel">#getbyCustomerName.ORDERTOTAL[a]# ₺</td>
                              </tr>
                            </cfoutput>
                          </cfloop>
                        </tbody>
                        </table>
                  <cfelse>
                  </cfif>
                  
                  <cfif #getCustomerId.CUSTOMERID#=="">
                    <cfif isNumeric(form.info)=="YES">
                      <cfquery name="getbyOrderId" datasource="StokTakip">
                        select * from Orders where OrderId=#form.info#
                      </cfquery>
                      <cfif #getbyOrderId.ORDERID#=="">
                        <cfoutput>Herhangi bir sonuca rastlanmadı</cfoutput>
                      <cfelse>
                      </cfif>
                      <cfif #getbyOrderId.ORDERID#!="">
                        <table class="table">
                          <thead>
                            <tr>
                              <th>Sipariş Id</th>
                              <th>Üye Adı</th>
                              <th>Sipariş Tarihi</th>
                              <th>Sipariş Tutarı</th>
                              <th>Detay</th>
                            </tr>
                          </thead>
                          <tbody>
                            <cfloop index="a" from="1" to="#getbyOrderId.recordCount#">
                              <cfquery name="getCustomerName" datasource="StokTakip">select CustomerName from Customers Where CustomerId=#getbyOrderId.CUSTOMERID[a]# </cfquery>
                              <cfoutput>
                                <tr>
                                  <th>#getbyOrderId.ORDERID[a]#</th>
                                  <td class="excel">#getCustomerName.CUSTOMERNAME#</td>
                                  <td class="excel">#DateFormat(getbyOrderId.ORDERCREATEDDATE[a],'short')#</td>
                                  <td class="excel">#getbyOrderId.ORDERTOTAL[a]# ₺</td>
                                  <th>
                                    <cfform action="orderdetails.cfm" method="post">
                                      <input type="hidden" name="OrderId" value="#getallorders.ORDERID[a]#">
                                      <input type="submit" class="btn btn-success" value="Görüntüle"/>
                                    </cfform></th>
                                </tr>
                              </cfoutput>
                            </cfloop>
                          </tbody>
                          </table>
                          <table class="table2" style="visibility:hidden;height:0px;display:block;">
                            <thead>
                              <tr>
                                <th>Üye Adı</th>
                                <th>Sipariş Tarihi</th>
                                <th>Sipariş Tutarı</th>
                              </tr>
                            </thead>
                            <tbody>
                              <cfloop index="a" from="1" to="#getbyOrderId.recordCount#">
                                <cfquery name="getCustomerName" datasource="StokTakip">select CustomerName from Customers Where CustomerId=#getbyOrderId.CUSTOMERID[a]# </cfquery>
                                <cfoutput>
                                  <tr>
                                    <td class="excel">#getCustomerName.CUSTOMERNAME#</td>
                                    <td class="excel">#DateFormat(getbyOrderId.ORDERCREATEDDATE[a],'short')#</td>
                                    <td class="excel">#getbyOrderId.ORDERTOTAL[a]# ₺</td>
                                  </tr>
                                </cfoutput>
                              </cfloop>
                            </tbody>
                            </table>
                    <cfelse>
                      
                  </cfif>
                    
                    
                    <cfelse>
                      <cfoutput>Herhangi bir sonuca rastlanmadı</cfoutput>
                      
                    </cfif>
                  <cfelse>
                  </cfif> 
                  <!--- <cfquery name="findByName" datasource="StokTakip"> 
                  select * from Orders where C 
                  </cfquery>--->
              </cfif>
            </cfif>

            
          
          
          
          
            </div>
            <div class="row">
            <div class="col d-flex justify-content-start"><a class="btn btn-primary" onclick="tableToExcel()"><i class="bi bi-file-earmark-excel mr-2">Excel Export</i></a></div>
          </div>
        </div>
      </div>




      
<script src="js/table2excel.js"></script> 
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>
<script>function tableToExcel(){
var table2excel=new Table2Excel();
table2excel.export(document.querySelectorAll("table.table2"));


}</script>
</body>
</html>