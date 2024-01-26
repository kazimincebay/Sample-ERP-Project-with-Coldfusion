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


      <cfquery name="getOrderInformation" datasource="StokTakip">
        select * from Orders where OrderId=#form.ORDERID#
      </cfquery>
      <cfquery name="getOrderDetails" datasource="StokTakip">
        select * from OrderDetails where OrderId=#form.ORDERID#
      </cfquery>
      <cfquery name="getCustomerName" datasource="StokTakip">
        select CustomerName from Customers where CustomerId=#getOrderInformation.CUSTOMERID#
      </cfquery>
      <cfloop index="a" from=1 to=#getOrderDetails.recordCount#>
        <cfquery name="getProductName" datasource="StokTakip">
          select ProductName from Products where ProductId=#getOrderDetails.PRODUCTID[a]#
        </cfquery>
      </cfloop>
      
      
      <div class="container">
        <div class="row">
          <div class="col">
            <cfform class="mt-2" id="orderForm">
              <div class="form-group">
                <label for="customerSelect">Sipariş Id</label>
                <cfinput type="text" name="orderId" class="form-control" disabled value=#form.ORDERID# />
              </div>
              <div class="form-group">
                <label for="productSelect">Kurumsal Üye Adı</label>
                <cfinput type="text" name="customerName" class="form-control" value=#getCustomerName.CUSTOMERNAME# disabled>
              </div>
              <div class="form-group">
                <label for="productPiece">Toplam Tutar</label>
                <cfinput type="number" name="totalPrice" min="1" class="form-control" value='#getOrderInformation.ORDERTOTAL#' id="productPiece" disabled>
              </div>
              <div class="form-group">
                <label for="basketList">Ürün Listesi</label>
                  <select multiple disabled class="form-control" name="basketList" id="basketList">
                    <cfloop index="p" from=1 to=#getOrderDetails.recordCount#>
                      
                      <cfquery name="getProductName" datasource="StokTakip">
                        select ProductName from Products where ProductId=#getOrderDetails.PRODUCTID[p]#
                      </cfquery>
                      <cfoutput><option> #getProductName.PRODUCTNAME# - #getOrderDetails.PRODUCTPIECE[p]#</option></cfoutput>
                    </cfloop>
                  </select>
              </div>
              <a href="orders.cfm" class="btn btn-primary d-flex justify-content-center mt-5">Siparişler Sayfasına Dön</a>
            </cfform>
          </div>
        </div>
      </div>

      
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>    
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>
</body>
</html>