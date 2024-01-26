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
      <cfquery name="getallproduct" datasource="StokTakip">
        select * from Products
      </cfquery>
      

      <div class="container mt-3">
        <div class="row">
          <div class="col">
            <table class="table">
              <thead>
                <tr>
                  <th>Ürün Id</th>
                  <th>Ürün Adı</th>
                  <th>Ürün Fiyatı</th>
                  <th>Ürün Güncelle</th>
                  <th>Ürün Sil</th>
                </tr>
              </thead>
              <tbody>
                <cfloop index="a" from="1" to="#getallproduct.recordCount#">
                  <cfoutput>
                    <tr>
                      <th>#getallproduct.PRODUCTID[a]#</th>
                      <td>#getallproduct.PRODUCTNAME[a]#</td>
                      <td>#getallproduct.PRODUCTPRICE[a]#</td>
                      <td><cfform action="updateproduct.cfm" method="post">
                        <input type="hidden" name="productId" value=#getallproduct.PRODUCTID[a]# />
                        <input type="submit" class="btn btn-warning" value="Güncelle"/>
                      </cfform></td>
                      <td><cfform action="deleteproduct.cfm" method="post">
                        <input type="hidden" name="productId" value=#getallproduct.PRODUCTID[a]# />
                        <input type="submit" class="btn btn-danger" value="Sil"/>
                      </cfform></td>
                    </tr>
                  </cfoutput>
                </cfloop>
              </tbody>
              </table>
          </div>
        </div>
      </div>
   
    
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>
</body>
</html>