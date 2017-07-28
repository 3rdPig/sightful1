// (function () {
//     var app = angular.module("UserLogon", ["ngResource"]);
//
//     app.controller("UserLogin", function ($scope, $http) {
//
//         $scope.user = {};
//         $scope.signIn = function (user) {
//             $http.post('/api/sign_in', user).then(function (response) {
//                 msg = response.data;
//                 if(msg[status]==1) return "good";
//                 else return "not right";
//             })
//         }
//     })
// });