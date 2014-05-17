$(function(){
  if($("body.compares.show").length){
    google.setOnLoadCallback(drawDepreciationByPriceChart);
    google.setOnLoadCallback(drawDepreciationByPercentageChart);
    google.setOnLoadCallback(drawLossByPriceChart);
    google.setOnLoadCallback(drawLossByPercentageChart);
    google.setOnLoadCallback(drawIPVAChart);
    google.setOnLoadCallback(drawTotalChart);

    var json = $("#compare").data('json');
    var cars = json['cars'];
    var defaultChartOptions = {
      legend: 'none',
      pointSize: 5,
      vAxis: { baseline: 0 },
      colors: ['#26C9FF', '#00D96D', '#EF912A'],
      width: '900',
      height: '150',
      backgroundColor: {fill: "white"},
      chartArea: {left:80,top:10},
      fontName: 'Helvetica Neue'
    };

    function drawDepreciationByPriceChart() {
      var dataTable = initDataTable();

      for(var i = 0; i < 5; i++){
        values = ["Ano ".concat((i+1).toString())];

        for(var j = 0; j < cars.length; j++){
          values.push(getModelValue(i, cars[j]), tooltipByValueFor(i, cars[j]))
        }

        dataTable.addRow(values);
      }

      chartOptions = defaultChartOptions;
      chartOptions.vAxis.format = "R$###,###";

      var chart = new google.visualization.AreaChart(document.getElementById('depreciation_by_price'));
      chart.draw(dataTable, chartOptions);
    };

    function drawDepreciationByPercentageChart() {
      var dataTable = initDataTable();

      for(var i = 0; i < 5; i++){
        values = ["Ano ".concat((i+1).toString())];

        for(var j = 0; j < cars.length; j++){
          values.push(getModelPercentage(i, cars[j]), tooltipByPercentageFor(i, cars[j]));
        }

        dataTable.addRow(values);
      }

      chartOptions = defaultChartOptions;
      chartOptions.vAxis.format = "#,###%";

      var chart = new google.visualization.AreaChart(document.getElementById('depreciation_by_percentage'));
      chart.draw(dataTable, chartOptions);
    };

    function drawLossByPriceChart() {
      var dataTable = initDataTable();

      for(var i = 0; i < 5; i++){
        values = ["Ano ".concat((i+1).toString())];
        for(var j = 0; j < cars.length; j++){
          values.push(getModelLossInPrice(i, cars[j]), tooltipByLossInPriceFor(i, cars[j]));
        }
        dataTable.addRow(values);
      }

      chartOptions = defaultChartOptions;
      chartOptions.vAxis.format = "R$###,###";

      var chart = new google.visualization.AreaChart(document.getElementById('loss_by_price'));
      chart.draw(dataTable, chartOptions);
    }

    function drawLossByPercentageChart() {
      var dataTable = initDataTable();

      for(var i = 0; i < 5; i++){
        values = ["Ano ".concat((i+1).toString())];
        for(var j = 0; j < cars.length; j++){
          values.push(getModelLossInPercentage(i, cars[j]), tooltipByLossInPercentageFor(i, cars[j]));
        }
        dataTable.addRow(values);
      }

      chartOptions = defaultChartOptions;
      chartOptions.vAxis.format = "#,###%";

      var chart = new google.visualization.AreaChart(document.getElementById('loss_by_percentage'));
      chart.draw(dataTable, chartOptions);
    }

    function drawIPVAChart(){
      var dataTable = initDataTable();

      for(var i = 0; i < 5; i++){
        values = ["Ano ".concat((i+1).toString())];
        for(var j = 0; j < cars.length; j++){
          values.push(getModelIPVA(i, cars[j]), tooltipIPVAFor(i, cars[j]));
        }
        dataTable.addRow(values);
      }

      chartOptions = defaultChartOptions;
      chartOptions.vAxis.format = "R$###,###";

      var chart = new google.visualization.AreaChart(document.getElementById('ipva'));
      chart.draw(dataTable, chartOptions);
    }

    function drawTotalChart(){
      var dataTable = initDataTable();

      for(var i = 0; i < 5; i++){
        values = ["Ano ".concat((i+1).toString())];
        for(var j = 0; j < cars.length; j++){
          values.push(getModelTotal(i, cars[j]), tooltipTotalFor(i, cars[j]));
        }
        dataTable.addRow(values);
      }

      chartOptions = defaultChartOptions;
      chartOptions.vAxis.format = "R$###,###";

      var chart = new google.visualization.AreaChart(document.getElementById('total'));
      chart.draw(dataTable, chartOptions);
    }

    function initDataTable(){
      var dataTable = new google.visualization.DataTable();
      dataTable.addColumn('string', 'Referencia');

      for(var i = 0; i < cars.length; i++){
        dataTable.addColumn('number', cars[i]['name']);
        dataTable.addColumn({type: 'string', role: 'tooltip'});
      }

      return dataTable;
    }

    // Tooltip text generators

    function tooltipByValueFor(year, car){
      if(getModelName(year, car) == null){
        return "Valor não existente"
      }
      else{
        return getModelName(year, car).concat(": R$").concat(getModelValue(year, car).toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1."));
      }
    };

    function tooltipByPercentageFor(year, car){
      if(getModelName(year, car) == null){
        return "Valor não existente"
      }
      else if(year == 0){
        return getModelName(year, car).concat(": R$").concat(getModelValue(year, car).toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1."));
      }
      else{
        return getModelName(year, car) + ": R$" + getModelValue(year, car).toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1.") + "\n" + (getModelPercentage(year, car) * 100).toFixed(2) + "% de depreciação em relação ao ano anterior";
      }
    }

    function tooltipByLossInPriceFor(year, car){
      if(getModelName(year, car) == null){
        return "Valor não existente"
      }
      else{
        return getModelName(year, car) + ": R$" + getModelValue(year, car).toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1.") + "\n" + "R$".concat(getModelLossInPrice(year, car).toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1.")) + " de prejuízo em relação valor original";
      }
    }

    function tooltipIPVAFor(year, car){
      if(getModelName(year, car) == null){
        return "Valor não existente"
      }
      else{
        return getModelName(year, car) + ": R$" + Math.floor(getModelIPVA(year, car)).toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1.");
      }
    }

    function tooltipByLossInPercentageFor(year, car){
      if(getModelName(year, car) == null)
        return "Valor não existente"
      else if(year == 0)
        return getModelName(year, car).concat(": R$").concat(getModelValue(year, car).toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1."));
      else
        return getModelName(year, car) + ": R$" + getModelValue(year, car).toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1.") + "\n" + (getModelLossInPercentage(year, car) * 100).toFixed(2) + "% de prejuízo em relação valor original";
    }

    function tooltipTotalFor(year, car){
      if(getModelName(year, car) == null)
        return "Valor não existente"
      else{
        return getModelName(year, car) + ": R$" + getModelTotal(year,car).toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1.") + "\n" +
        "Prejuízo: R$" + getModelLossInPrice(year, car).toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1.") + "\n" +
        "IPVA: R$" + getModelIPVA(year,car).toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1.") + "\n" +
        "DPVAT: R$" + getDPVAT(year) + "\n" +
        "Licenciamento: R$" + getLicense(year)
      }
    }

    // Values calculators

    function getModelValue(year, car){
      if(car['models'][year] && car['models'][year]['value'])
        return car['models'][year]['value'];
      else
        return 0;
    }

    function getModelPercentage(year, car){
      if(year == 0)
        return 0
      else if(car['models'][year]){
        lastValue = getModelValue(year - 1, car);
        currentValue = getModelValue(year, car);
        difference = lastValue - currentValue;
        return difference/lastValue;
      }
      else
        return 0
    }

    function getModelLossInPrice(year, car){
      if(getModelValue(year, car) > 0)
        return getModelValue(0, car) - getModelValue(year, car);
      else
        return 0;
    }

    function getModelIPVA(year, car){
      if(getModelValue(year, car) > 0)
        return parseInt(getModelValue(year, car) * 0.04);
      else
        return 0;
    }

    function getModelLossInPercentage(year, car){
      if(getModelValue(year, car) > 0)
        return 1 - (getModelValue(year, car)/getModelValue(0, car));
      else
        return 0;
    }

    function getModelTotal(year, car){
      return getModelLossInPrice(year, car) +
      getModelIPVA(year, car) +
      getDPVAT(year) +
      getLicense(year)
    }

    function getDPVAT(year){
      if(year <= 1)
        return 105
      else
        return 101
    }

    function getLicense(year){
      if(year <= 1)
        return 65
      else if(year == 2)
        return 62
      else
        return 59
    }

    // Gets

    function getModelName(year, car){
      if(car['models'][year])
        return car['models'][year]['name'];
      else
        return null;
    }

    // Helpers

    function toMoney(value){
      return "R$" + value.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1.")
    }
  }
});
