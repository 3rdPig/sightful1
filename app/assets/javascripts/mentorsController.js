var app = angular.module('sightfull', ['toaster', "ngResource", "ng-rails-csrf", "rcMailgun"]);
app.controller('mentorsCtrl', function($scope,$http,toaster) {
//toaster.pop('error', "title", "text");
		console.log('I am in');
		//get_mentors
		var Indata = {field:'val1'};

	$scope.myfunc = function(){
		//$('#txtfn1').val()
		toaster.pop('info',"Sent","Invitation has been sent.");
		toaster.pop('success',$scope.from +' '+ $scope.to)

		var params = "?from="+$scope.from+"&to="+$scope.to+"&time="+$('#txtfn1').val()+"&date="+$('#txtfn').val()

		$http.post('/api/add_invitation'+params,{
		  format: 'json',
		  params:Indata,

				}).then(function successCallback(response) {
		  
				toaster.pop('success', "Success", response);		
		  }, function errorCallback(response) {
		    // called asynchronously if an error occurs
		    // or server returns response with an error status.
		    	console.log(response);
				toaster.pop('error', "title", response);
		  });

		params = "?from="+$scope.from+"&to="+$scope.to+"&time="+$('#txttm22').val()+"&date="+$('#txttm2').val()

		$http.post('/api/add_invitation'+params,{
		  format: 'json',
		  params:Indata,
		  
				}).then(function successCallback(response) {
		  
				toaster.pop('success', "Success", response);		
		  }, function errorCallback(response) {
		    // called asynchronously if an error occurs
		    // or server returns response with an error status.
		    	console.log(response);
				toaster.pop('error', "title", response);
		  });

		params = "?from="+$scope.from+"&to="+$scope.to+"&time="+$('#txtem2').val()+"&date="+$('#txtem').val()

		$http.post('/api/add_invitation'+params,{
		  format: 'json',
		  params:Indata,
		  
				}).then(function successCallback(response) {
		  
				toaster.pop('success', "title", response);
				toaster.pop('info', "Success", "Invite Sent");
		  }, function errorCallback(response) {
		    // called asynchronously if an error occurs
		    // or server returns response with an error status.
		    	console.log(response);
				toaster.pop('error', "title", response);

		  });
	}
	/*$http.post('/api/get_mentors',{
		  format: 'json',
		  params:Indata,

				}).then(function successCallback(response) {
		  
				toaster.pop('success', "title", response);		
		  }, function errorCallback(response) {
		    // called asynchronously if an error occurs
		    // or server returns response with an error status.
		    	console.log(response);
				toaster.pop('error', "title", response);
		  });*/
});

app.config(['rcMailgunProvider', function(rcMailgunProvider){

    var mailgunOptions = {
        api_key: 'pubkey-40d01d3c08e9586ea3e3ad9f01c9af1b',
        in_progress: null,
        success: null,
        error: null,
    };

    rcMailgunProvider.configure(mailgunOptions);
}])




//useless code, leave it for later usage.
// app.controller("UserCtrl", function ($scope, $http, $log) {
//
//     $scope.signIn = function () {
//         // $http.post('/api/sign_in', {'email': $scope.email, 'password': $scope.password}).then(function (response) {
//         //     msg = response.data;
//         //     if(msg["status"]==1) $log.error("good");
//         //     else $log.error("not right");
//         // });
//         $http.post('/sessions', {'email': $scope.email, 'password': $scope.password}).then(
//             function (response) {
//                 $log.info(response);
//                 return response;
//             },
//             function (reason) {
//                 $log.info(reason);
//             }
//         );
//     }
// });