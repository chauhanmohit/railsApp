app.controller("TrendsController",
		['$scope',function($scope) {
			$scope.graph = {};
			$scope.graph.series = [ 'Value' ];

			$scope.labels = [ "January", "February", "March", "April", "May",
					"June", "July" ];
			$scope.series = [ 'Series A', 'Series B' ];
			$scope.data = [ [ 65, 59, 80, 81, 56, 55, 40 ],
					[ 28, 48, 40, 19, 86, 27, 90 ] ];
			/**
			 * For Week
			 */
			$scope.graphWeek = {};
			$scope.graphWeek.data = [ [ 16, 15, 20, 12, 16, 12, 8 ] ];
			$scope.graphWeek.labels = [ 'Mon', 'Tue', 'Wed', 'Thu', 'Fri',
					'Sat', 'Sun' ];
			/**
			 * For Month
			 */
			$scope.graphMonth = {};
			$scope.graphMonth.data = [ [ 16, 15, 20, 12, 16, 12, 8, 16, 15, 20,
					12, 16, 12, 8, 16, 15, 20, 12, 16, 12, 8, 16, 15, 20, 12,
					16, 12, 8, 12, 4 ] ];
			$scope.graphMonth.labels = [ '1', '2', '3', '4', '5', '6', '7',
					'8', '9', '10', '11', '12', '13', '14', '15', '16', '17',
					'18', '19', '20', '21', '22', '23', '24', '25', '26', '27',
					'28', '29', '30' ];

			/**
			 * For Day
			 */
			$scope.graphDay = {};
			$scope.graphDay.data = [ [ 16, 15, 20, 12, 16, 12, 8, 16, 15, 20,
					12, 16, 12, 8, 16, 15, 20, 12, 16, 12, 8, 16, 15, 20 ] ];
			$scope.graphDay.labels = [ '1', '2', '3', '4', '5', '6', '7', '8',
					'9', '10', '11', '12', '13', '14', '15', '16', '17', '18',
					'19', '20', '21', '22', '23', '24' ];

		}]);