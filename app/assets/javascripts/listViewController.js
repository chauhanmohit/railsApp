app.controller('ListViewContoller',['$scope','$http','$q',function($scope,$http,$q){
    $scope.mydata = "adskdhsakjdhsajdhsajdhsadkjhsadlkhsadlkhl";
    $scope.detailInfo = false ;
    var canceller ;
    $scope.search = {
	'lat' : 41.8838113,
	'lang' : -87.6317489,
	'radius' : 1000,
	'from' : '2010-2-10',
	'to' : '2011-2-10',
	'type': ["THEFT","ASSAULT","BATTERY","ROBBERY"],
	'arrest': 'true', 
    } ;
    
    console.log("comes in listview action");
    $scope.$on('searchData1', function (event, args) {
        $scope.search = args ;
        console.log('onchage Event',args);
    });
    $scope.listViewAction = function(){
        $scope.showLoder = true ;
    	if (canceller) canceller.resolve("User Intrupt");
	//creating the defered object
	canceller = $q.defer();
	$http.get('/api/web/getlistViewContent.json?lat='+$scope.search.lat+'&lang='+$scope.search.lang+'&radius='+$scope.search.radius+'&from='+$scope.search.from+'&to='+$scope.search.to+'&type='+$scope.search.type+'&arrest='+$scope.search.arrest ,
	{ timeout: canceller.promise })
	.success(function(res,status,config,header){
	    $scope.listViewData = res ;
            $scope.showLoder = false ;
	}).error(function(err,status,config,header){
            $scope.showLoder = false ;
	    console.log("Something happend wrong at serverEnd");
	}); 
    }
    
    $scope.showDetailInfo = function(id){
        $("#showInfo" + id ).slideToggle();
    }
    
}]);



