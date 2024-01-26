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


      
      <cfquery name="getbyproduct" datasource="StokTakip">
      select * from Products where productId=#form.PRODUCTID#
      </cfquery>
      <div class="container">
        <div class="row">
          <div class="col mt-3">
            <cfform method="post" action="updateproductcontrol.cfm">
              <div class="mb-3">
                <label  class="form-label">Ürün Id</label>
                <cfinput type="text" disabled  class="form-control" name="productId" value=#getbyproduct.PRODUCTID# />
                <cfinput type="hidden" value=#getbyproduct.PRODUCTID# name="updateProductId">
              </div>
              <div class="mb-3">
                <label  class="form-label">Ürün Adı</label>
                <cfinput type="text" required="true" value="#getbyproduct.PRODUCTNAME#" class="form-control" name="productName"/>
            </div>
            <div class="mb-3">
              <label  class="form-label">Ürün Fiyatı</label>
              <cfinput type="text" required="true" value="#getbyproduct.PRODUCTPRICE#" class="form-control" name="productPrice"/>
          </div>
              <input type="submit" value="Güncelle" class="btn btn-primary mt-2"/>
            </cfform>
          </div>
        </div>
      </div>
    
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>
</body>
</html>