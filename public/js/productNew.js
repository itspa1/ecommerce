var priceHandle = document.getElementById('product_price');
var priceErrorHandle = document.getElementById('priceError');
var productAvailabilityHandle = document.getElementById('product_availability');
var productStockHandle = document.getElementById('product_stock');
var stockErrorHandle = document.getElementById('stockError');
var categoryHandle = document.getElementById('product_category_id');
var spanHandle = document.getElementById('count');

priceHandle.onkeyup = function(){
  if(priceHandle.value < 1){
    priceErrorHandle.innerHTML = "Price should be greater than 0."
  }else if(isNaN(priceHandle.value)){
    priceErrorHandle.innerHTML = "Entered value is an alphabet."
  }else {
    priceErrorHandle.innerHTML = "";
  }
}

productStockHandle.onkeyup = function(){
	if(productAvailabilityHandle.checked && productStockHandle.value < 1){
		stockErrorHandle.innerHTML = "Availability is checked but stock is 0."
	}
	else if(productStockHandle.value > 0 && !productAvailabilityHandle.checked){
		productAvailabilityHandle.setAttribute('checked',true);
	}else{
		stockErrorHandle.innerHTML = "";
	}
}

categoryHandle.onchange = function(){
	//console.log(categoryHandle.options[categoryHandle.selectedIndex].getAttribute("value"));
	var request = new XMLHttpRequest();
	var url = '/categories/count_products.json?category_id=' + categoryHandle.value;
	console.log(url);
	request.open('GET',url);
	request.onreadystatechange = function(){
		if(request.readyState === 4 && request.status === 200){
			var response = JSON.parse(request.responseText);
			spanHandle.innerHTML = response.products_count;
		}
	}
}