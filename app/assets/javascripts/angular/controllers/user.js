var app = angular.module("User", ["ngResource", "ng-rails-csrf", "rcMailgun"]);

// config rcMailgunProvider in vendor/assets
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
app.controller("UserCtrl", function ($scope, $http, $log) {

    $scope.signIn = function () {
        // $http.post('/api/sign_in', {'email': $scope.email, 'password': $scope.password}).then(function (response) {
        //     msg = response.data;
        //     if(msg["status"]==1) $log.error("good");
        //     else $log.error("not right");
        // });
        $http.post('/sessions', {'email': $scope.email, 'password': $scope.password}).then(
            function (response) {
                $log.info(response);
                return response;
            },
            function (reason) {
                $log.info(reason);
            }
        );
    }
});
