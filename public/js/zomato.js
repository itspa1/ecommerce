	var spanHandle = document.getElementById('count');
 	var listHandle = document.getElementById('cities');
 	var selectHandle = document.getElementById('select');
	
	loadCities = function(){
		var request = new XMLHttpRequest();
		request.open('GET','cities.json');
 		request.onreadystatechange = function(){
 			if(request.readyState === 4 && request.status === 200){
 				//default response type is string, we use JSON.parse to convert the string to object
 				var response = JSON.parse(request.responseText);
 				listCities(response);
 				//console.log("Total cities is " + "(" +response.length + ")");
 			}
 		}
 		request.send();
 	}();// iffy - immediately invoked function Expression is used to invoke the function immediately after defining it using the () after the definition.
 	
 	function listCities(response){
 		var cityOutput = "";
 		response.forEach(function(city){
 			var option = document.createElement('option');
 			var text = document.createTextNode(city.name);
 			option.appendChild(text);
 			option.setAttribute('value',city.id);
 			selectHandle.appendChild(option)
 			cityOutput += '<li>' + city.name + '</li>';
 		})
 		listHandle.innerHTML = cityOutput;
 		spanHandle.innerHTML = "(" + response.length + ")";
 	}

 	var restaurantHandle = document.getElementById('restaurants');
 	var rSpanHandle = document.getElementById('rcount');
 	var restaurantResponse;

	loadRestaurants = function(){ 	
		var restaurantRequest = new XMLHttpRequest();
	 	restaurantRequest.open('GET','restaurants.json');
	 	restaurantRequest.onreadystatechange = function(){
	 		if(restaurantRequest.readyState === 4 && restaurantRequest.status === 200){
	 		 restaurantResponse = JSON.parse(restaurantRequest.responseText);
	 			listRestaurants(restaurantResponse);
	 		}
	 	}
	 	restaurantRequest.send();
	 }();

 	selectHandle.onchange = function(){
 		if (selectHandle.value != ""){
 		var output = restaurantResponse.filter(function(restaurant){
 			return restaurant.city_id == selectHandle.value;
 		});
 		listRestaurants(output);
 		}else{
 			listRestaurants(restaurantResponse);
 		}
 	}



 	function listRestaurants(restaurants){
 		var restaurantOutput = "";
 		restaurants.forEach(function(restaurant){
 			restaurantOutput += '<li>' + restaurant.name + " " + restaurant.rating + '</li>';
 		})
 		restaurantHandle.innerHTML = restaurantOutput;
 		rSpanHandle.innerHTML = "(" + restaurants.length + ")";
 	}