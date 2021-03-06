
var $location = $injector.get('$location');
var $routeParams = $injector.get('$routeParams');
var $route = $injector.get('$route');
var $filter = $injector.get('$filter');

$scope.paramId = $routeParams.id;

$scope.assignments = [];
$scope.filtered1 = [];
$scope.displayed1 = [];

$scope.avaliables = [];
$scope.filtered2 = [];
$scope.displayed2 = [];

$scope.all1 = false;
$scope.all2 = false;
$scope.q1 = '';
$scope.q2 = '';

$scope.alerts = [];

$scope.page1 = {
    pageSize: 15,
    total: 0,
    totalPage: 0,
    page: 0,
    begin: 0,
    end: 0,
    next: function () {
        if (page1.page < page1.totalPage - 1) {
            page1.page++;
            page1.begin = page1.page * page1.pageSize;
            page1.end = Math.min(page1.begin + page1.pageSize, page1.total);
            $scope.displayed1 = $scope.filtered1.slice(page1.begin, page1.end);
        }
    },
    prev: function () {
        if (page1.page > 0) {
            page1.page--;
            page1.begin = page1.page * page1.pageSize;
            page1.end = Math.min(page1.begin + page1.pageSize, page1.total);
            $scope.displayed1 = $scope.filtered1.slice(page1.begin, page1.end);
        }
    }
};
$scope.page2 = {
    pageSize: 15,
    total: 0,
    totalPage: 0,
    page: 0,
    begin: 0,
    end: 0,
    next: function () {
        if (page2.page < page2.totalPage - 1) {
            page2.page++;
            page2.begin = page2.page * page2.pageSize;
            page2.end = Math.min(page2.begin + page2.pageSize, page2.total);
            $scope.displayed2 = $scope.filtered2.slice(page2.begin, page2.end);
        }
    },
    prev: function () {
        if (page2.page > 0) {
            page2.page--;
            page2.begin = page2.page * page2.pageSize;
            page2.end = Math.min(page2.begin + page2.pageSize, page2.total);
            $scope.displayed2 = $scope.filtered2.slice(page2.begin, page2.end);
        }
    }
};

page1 = $scope.page1;
page2 = $scope.page2;

query = function () {
    Assignment.get({
        id: $scope.paramId,
        expand: 'assignments,avaliables'
    }, function (row) {
        $scope.model = row;

        $scope.assignments = row.assignments;
        $scope.avaliables = row.avaliables;

        $scope.applyFilter1();
        $scope.applyFilter2();
    }, function (r) {
        if (r.status = 404) {
            $location.path('/error/404');
        }else{
            window.alert(r.statusText);
            window.history.back();
        }
    });
};
query();

$scope.applyFilter1 = function () {
    $scope.filtered1 = $filter('filter')($scope.assignments, $scope.q1);
    page1.total = $scope.filtered1.length;
    page1.totalPage = Math.ceil(page1.total / page1.pageSize);
    page1.page = Math.max(Math.min(page1.page, page1.totalPage - 1), 0);
    page1.begin = page1.page * page1.pageSize;
    page1.end = Math.min(page1.begin + page1.pageSize, page1.total);

    $scope.displayed1 = $scope.filtered1.slice(page1.begin, page1.end);
}

$scope.applyFilter2 = function () {
    $scope.filtered2 = $filter('filter')($scope.avaliables, $scope.q2);
    page2.total = $scope.filtered2.length;
    page2.totalPage = Math.ceil(page2.total / page2.pageSize);
    page2.page = Math.max(Math.min(page2.page, page2.totalPage - 1), 0);
    page2.begin = page2.page * page2.pageSize;
    page2.end = Math.min(page2.begin + page2.pageSize, page2.total);

    $scope.displayed2 = $scope.filtered2.slice(page2.begin, page2.end);
}

$scope.changeAll1 = function () {
    $scope.all1 = !$scope.all1;
    angular.forEach($scope.displayed1, function (item) {
        item.selected = $scope.all1;
    });
}

$scope.changeAll2 = function () {
    $scope.all2 = !$scope.all2;
    angular.forEach($scope.displayed2, function (item) {
        item.selected = $scope.all2;
    });
}

$scope.clickRevoke = function () {
    var items = $filter('filter')($scope.displayed1, {selected: true});
    if (items.length > 0) {
        var post = {
            items: jQuery.map(items, function (item) {
                return item.name;
            }),
        };
        Assignment.revoke({id: $scope.paramId}, post,
            function (r) {
                addAlert('info', r.count + ' item(s) revoked');
                query();
            },
            function (r) {
                addAlert('error', r.statusText);
            });
    }
}

$scope.clickAssign = function () {
    var items = $filter('filter')($scope.displayed2, {selected: true});
    if (items.length > 0) {
        var post = {
            items: jQuery.map(items, function (item) {
                return item.name;
            }),
        };
        Assignment.assign({id: $scope.paramId}, post,
            function (r) {
                addAlert('info', r.count + ' item(s) assigned');
                query();
            },
            function (r) {
                addAlert('error', r.statusText);
            });
    }
}


addAlert = function (type, msg) {
    var alert = {type: type, msg: msg};
    if (type == 'info') {
        alert.time = 3000;
    }
    $scope.alerts.push(alert);
};

$scope.closeAlert = function (index) {
    $scope.alerts.splice(index, 1);
};