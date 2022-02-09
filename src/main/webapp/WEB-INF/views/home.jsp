<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
body {
  font-family: Arial;
  font-size: 17px;
  padding: 8px;
}

* {
  box-sizing: border-box;
}

.row {
  display: -ms-flexbox; /* IE10 */
  display: flex;
  -ms-flex-wrap: wrap; /* IE10 */
  flex-wrap: wrap;
  margin: 0 -16px;
}

.col-25 {
  -ms-flex: 25%; /* IE10 */
  flex: 25%;
}

.col-50 {
  -ms-flex: 50%; /* IE10 */
  flex: 50%;
}

.col-75 {
  -ms-flex: 75%; /* IE10 */
  flex: 75%;
}

.col-25,
.col-50,
.col-75 {
  padding: 0 16px;
}

.container {
  background-color: #f2f2f2;
  padding: 5px 20px 15px 20px;
  border: 1px solid lightgrey;
  border-radius: 3px;
}

input[type=text] {
  width: 100%;
  margin-bottom: 20px;
  padding: 12px;
  border: 1px solid #ccc;
  border-radius: 3px;
}

label {
  margin-bottom: 10px;
  display: block;
}

.icon-container {
  margin-bottom: 20px;
  padding: 7px 0;
  font-size: 24px;
}

.btn {
  background-color: #4CAF50;
  color: white;
  padding: 12px;
  margin: 10px 0;
  border: none;
  width: 100%;
  border-radius: 3px;
  cursor: pointer;
  font-size: 17px;
}

.btn:hover {
  background-color: #45a049;
}

a {
  color: #2196F3;
}

hr {
  border: 1px solid lightgrey;
}

span.price {
  float: right;
  color: grey;
}

/* Responsive layout - when the screen is less than 800px wide, make the two columns stack on top of each other instead of next to each other (also change the direction - make the "cart" column go on top) */
@media (max-width: 800px) {
  .row {
    flex-direction: column-reverse;
  }
  .col-25 {
    margin-bottom: 20px;
  }
}

</style>
<script>
let orderNo = "${orderNo}"
let price = 0;
	function findByOrderNo() {
		console.log(orderNo);
		let dataArea = document.getElementById("dataArea");
		let xhr = new XMLHttpRequest();
		xhr.open("GET", "<c:url value='/findSCDetailsByOrderNo?orderNo=' />" + orderNo);
		xhr.send();
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				dataArea.innerHTML = processDetailsData(xhr.responseText);
			} console.log(xhr.responseText);
		}
	}
	
	window.onload = function() {
		findByOrderNo();
		window.setTimeout(( () => document.getElementById("price").value = price ), 800);
	}
	
	function processDetailsData(jsonString) {
		let shoppingCarts = JSON.parse(jsonString);
		let segment = "<h4>Cart <span class='price' style='color:black'><i class='fa fa-shopping-cart'></i> <b>" + shoppingCarts.length + "</b></span></h4>";
		let amount = 0;
		for (let n = 0; n < shoppingCarts.length; n++) {
			let shoppingCart = shoppingCarts[n];
			segment += "<p>" + shoppingCart.description + "*" + shoppingCart.qty + "<span class='price'>$" + shoppingCart.unitPrice * shoppingCart.qty + "</span></p>";
			amount += shoppingCart.unitPrice * shoppingCart.qty;
		}
		segment += "<hr>";
		segment += "<p>Total <span class='price' style='color:black'><b>$" + amount + "</b></span></p>";
		price = amount;
		return segment;
	}
</script>
</head>
<body>
<div class="row">
    <div class="col-75">
        <div class="container">
            <form method="post"  action="<c:url value='/pay' />">
                <div class="col-50">
                    <h3>Payment</h3>
                    <label>Accepted Cards</label>
                    <div class="icon-container">
                        <i class="fa fa-cc-visa" style="color:navy;"></i>
                        <i class="fa fa-cc-amex" style="color:blue;"></i>
                        <i class="fa fa-cc-mastercard" style="color:red;"></i>
                        <i class="fa fa-cc-discover" style="color:orange;"></i>
                    </div>
                    <label for="price">Total</label>
                    <input type="text" id="price" name="price" placeholder="請輸入消費金額">
                    <label for="currency">Currency</label>
                    <input type="text" id="currency" name="currency" value="TWD">
                    <label for="method">Payment Method</label>
                    <input type="text" id="method" name="method" value="PAYPAL">
                    <label for="intent">Intent</label>
                    <input type="text" id="intent" name="intent" value="sale">
                    <label for="description">Payment Description</label>
                    <input type="text" id="description" name="description" placeholder="Payment Description">
                </div>

                <input type="submit" value="Continue to checkout" class="btn">
            </form>
        </div>
    </div>
    <div class="col-25">
        
        <div class="container" id="dataArea">
            
        </div>
    </div>
    
</div>
</body>
</html>