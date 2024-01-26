<!DOCTYPE html>
<head>
    <meta charset="tuf-8">
    <cfprocessingdirective pageencoding="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
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

<cfquery name="getallcustomer" datasource="StokTakip">
  select * from Customers
</cfquery>



<div class="container mt-2">
  <div class="row">
    <div class="col justify-content-start d-flex"> <cfform action="customers.cfm" method="post" class="d-flex" role="search">
      <cfinput class="form-control me-2" name="customerName" type="search" placeholder="Kurumsal Üye Ara" aria-label="Search">
      <button class="btn btn-outline-success" type="submit">Ara</button>
    </cfform></div>
    <div class="col justify-content-end d-flex"><a class="btn btn-success justify-content-end d-flex" href="addcustomer.cfm">Kurumsal Üye Ekle</a></div>
  </div>
  <div class="row">
<div class="col">
  
  

  <cfif not isDefined("form.customerName")>
    <table class="table mt-3">
      <thead>
        <tr>
          <th>Kurumsal Üye Numarası</th>
          <th>Kurumsal Üye Adı</th>
          <th>Kullanıcı Düzenle</th>
          <th>Kullanıcı Sil</th>
        </tr>
      </thead>
      <tbody>
        <cfloop index="a" from="1" to="#getallcustomer.recordCount#">
          <cfoutput>
            <tr>
              <th>#getallcustomer.CUSTOMERID[a]#</th>
              <td>#getallcustomer.CUSTOMERNAME[a]#</td>
              <td><cfform action="updatecustomer.cfm" method="post">
                <input type="hidden" name="customerId" value=#getallcustomer.CUSTOMERID[a]# />
                <input type="submit" class="btn btn-warning" value="Düzenle"/>
              </cfform></td>
              <td><cfform action="deletecustomer.cfm" method="post">
                <input type="hidden" name="customerId" value=#getallcustomer.CUSTOMERID[a]# />
                <input type="submit" class="btn btn-danger" value="Sil"/>
              </cfform></td>
            </tr>
          </cfoutput>
        </cfloop>
      </tbody>
      </table>
    <cfelse>
      <cfif form.customerName=="">
        <cfoutput>boş arama yaptınız</cfoutput>
        <cfelse>
          <cfquery name="getcustomerbyname" datasource="StokTakip">
            select * from Customers where customerName='#form.customerName#'
          </cfquery>
          <table class="table mt-3">
            <thead>
              <tr>
                <th>Kurumsal Üye Numarası</th>
                <th>Kurumsal Üye Adı</th>
                <th>Kullanıcı Düzenle</th>
                <th>Kullanıcı Sil</th>
              </tr>
            </thead>
            <tbody>
              <cfloop index="a" from="1" to="#getcustomerbyname.recordCount#">
                <cfoutput>
                  <tr>
                    <th>#getcustomerbyname.CUSTOMERID[a]#</th>
                    <td>#getcustomerbyname.CUSTOMERNAME[a]#</td>
                    <td><cfform action="updatecustomer.cfm" method="post">
                      <input type="hidden" name="customerId" value=#getcustomerbyname.CUSTOMERID[a]# />
                      <input type="submit" class="btn btn-warning" value="Düzenle"/>
                    </cfform></td>
                    <td><cfform action="deletecustomer.cfm" method="post">
                      <input type="hidden" name="customerId" value=#getcustomerbyname.CUSTOMERID[a]# />
                      <input type="submit" class="btn btn-danger" value="Sil" />
                    </cfform></td>
                  </tr>
                </cfoutput>
              </cfloop>
            </tbody>
            </table>
            <cfoutput>#form.customerName# Adlı Kurumsal üye için arama yapıyorsunuz.</cfoutput>
      </cfif>
      
  </cfif>
    
  


  
 
</div>
  </div>
</div>









      
   
    
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>
</body>
</html>