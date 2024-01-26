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


      <cfquery name="getallcustomers" datasource="StokTakip">
        select * from Customers
      </cfquery>
      <cfquery name="getallproducts" datasource="StokTakip">
      select * from products
      </cfquery>

      <div class="container">
        <div class="row">
          <div class="col">
            <cfform class="mt-2" action="addordercontrol.cfm" method="post" id="orderForm">
              <div class="form-group">
                <label for="customerSelect">Kurumsal Üye Adı</label>
                <select class="form-control" id="customerSelect" name="customerId">
                  <option selected>Seçim Yapınız</option>
                  <cfloop index="a" from="1" to="#getallcustomers.recordCount#">
                    <cfoutput><option value="#getallcustomers.CUSTOMERID[a]#">#getallcustomers.CUSTOMERNAME[a]#</option></cfoutput>
                  </cfloop>
                </select>
              </div>
              <div class="form-group">
                <label for="productSelect">Ürün Adı</label>
                <select class="form-control" id="productSelect">
                  <option selected>Seçim Yapınız</option>
                  <cfloop index="a" from="1" to="#getallproducts.recordCount#">
                    <cfoutput><option value="#getallproducts.PRODUCTNAME[a]#">#getallproducts.PRODUCTNAME[a]#</option></cfoutput>
                  </cfloop>
                </select>
              </div>
              <div class="form-group">
                <label for="productPiece">Ürün Adedi</label>
                <input type="number" min="1" class="form-control" id="productPiece">
              </div>
              <a class="btn btn-success mt-3" onclick="addBasketList()">Ürünü Listeye Ekle</a>
              <div class="form-group">
                <label for="basketList">Ürün Listesi</label>
      
                  <select multiple class="form-control" name="basketList" id="basketList">
                    
                  </select>
              </div>
              
              <a class="btn btn-danger mt-3" onclick="removeBasketList()">Ürünü listeden Çıkar</a>
              <input onclick="saveForm()" class="btn btn-primary d-flex justify-content-end mt-5" value="Siparişi Tamamla"/>
            </cfform>
          </div>
        </div>
      </div>

      
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>    
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>
<script>

var basketList=[]
var pieceList=[];
function addBasketList() {
if (document.getElementById("productSelect").value!="Seçim Yapınız" && document.getElementById("productPiece").value!="" && document.getElementById("productPiece").value!="0") {
  if(basketList.includes(document.getElementById("productSelect").value))
  {
    let index= basketList.indexOf(document.getElementById("productSelect").value)
    pieceList[index]=Number(pieceList[index])+Number(document.getElementById("productPiece").value)
    document.getElementById("basketList").options[index].innerHTML= basketList[index]+" - "+pieceList[index];
    document.getElementById("basketList").options[index].value=basketList[index]+" - "+pieceList[index];
    
  }
  else{
  basketList.push(document.getElementById("productSelect").value);
  pieceList.push(document.getElementById("productPiece").value);
  let option=document.createElement("option");
  let index=basketList.indexOf(document.getElementById("productSelect").value)
  option.text = basketList[index]+" - "+pieceList[index];
  option.value=basketList[index]+" - "+pieceList[index];
  document.getElementById("basketList").appendChild(option)
  }
}
else{
  alert("Ürün adı ya da ürün adedini boş bıraktınız");
}
}
function removeBasketList(){
let index= basketList.indexOf(document.getElementById("basketList").value);
if(index!=-1){
  basketList.splice(index,1);
  pieceList.splice(index,1);
  document.getElementById("basketList").options[index].remove()
}

}
function saveForm(){
  if(document.getElementById("customerSelect").value=="Seçim Yapınız"){
    alert("Lütfen kurumsal üye seçimi yapınız")
  }else{
    for (let a = 0; a < basketList.length; a++) {
    

    document.getElementById("basketList").options[a].selected=true;
    document.getElementById("orderForm").submit()
    
  }
  }
  
  
  
}
</script>
</body>
</html>