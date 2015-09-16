app.factory('ApiParams', function() {
	var data = {};
	return {
		getData : function() {
			console.log("the set data is ", data);
			return data ? data : "emtpy resoult";
		},
		setData : function(value){
			data = value ;
			console.log("value set successfully",data);
		}
	}
	
});