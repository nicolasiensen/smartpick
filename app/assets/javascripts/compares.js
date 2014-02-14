$(function(){
  if($("body.compares.show").length){
    google.setOnLoadCallback(drawDepreciationByPriceChart);
    google.setOnLoadCallback(drawDepreciationByPercentageChart);

    var json = $("#compare").data('json');
    var cars = json['cars'];

    function drawDepreciationByPriceChart() {
      var dataTable = new google.visualization.DataTable();
      dataTable.addColumn('string', 'Referencia');

      for(var i = 0; i < cars.length; i++){
        dataTable.addColumn('number', cars[i]['name']);
        dataTable.addColumn({type: 'string', role: 'tooltip'});
      }

      for(var i = 0; i < 5; i++){
        values = ["Ano ".concat((i+1).toString())];

        for(var j = 0; j < cars.length; j++){
          values.push(getModelValue(i, cars[j]), tooltipByValueFor(i, cars[j]))
        }

        dataTable.addRow(values);
      }

      var options = { legend: 'none', pointSize: 5, title: 'Toppings I Like On My Pizza', vAxis: { baseline: 0 }, colors: ['#26C9FF', '#00D96D', '#EF912A'], width: '900', height: '150', backgroundColor: {fill: "white"}, chartArea: {left:80,top:10}, fontName: 'open sans'};
      var chart = new google.visualization.AreaChart(document.getElementById('depreciation_by_price'));
      chart.draw(dataTable, options);
    };

    function drawDepreciationByPercentageChart() {
      var dataTable = new google.visualization.DataTable();
      dataTable.addColumn('string', 'Referencia');

      for(var i = 0; i < cars.length; i++){
        dataTable.addColumn('number', cars[i]['name']);
        dataTable.addColumn({type: 'string', role: 'tooltip'});
      }

      for(var i = 0; i < 5; i++){
        values = ["Ano ".concat((i+1).toString())];

        for(var j = 0; j < cars.length; j++){
          values.push(getModelPercentage(i, cars[j]), tooltipByPercentageFor(i, cars[j]));
        }

        dataTable.addRow(values);
      }

      var options = { legend: 'none', pointSize: 5, title: 'Toppings I Like On My Pizza', vAxis: { baseline: 0, format: "#,###%" }, colors: ['#26C9FF', '#00D96D', '#EF912A'], width: '900', height: '150', backgroundColor: {fill: "white"}, chartArea: {left:80,top:10}, fontName: 'open sans' };
      var chart = new google.visualization.AreaChart(document.getElementById('depreciation_by_percentage'));
      chart.draw(dataTable, options);
    };


    function getModelValue(year, car){
      if(car['models'][year] && car['models'][year]['value'])
        return car['models'][year]['value'];
      else
        return 0;
    }

    function getModelName(year, car){
      if(car['models'][year])
        return car['models'][year]['name'];
      else
        return null;
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
        return getModelName(year, car) + ": R$" + getModelValue(year, car).toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1.") + "\n" + (Math.round(getModelPercentage(year, car) * 100)) + "% de depreciação em relação ao ano anterior";
      }
    }
  }
});
