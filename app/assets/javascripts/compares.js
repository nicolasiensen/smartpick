$(function(){
  google.setOnLoadCallback(drawChart);
  var json = $("#col_chart_custom_tooltip").data('json');
  var cars = json['cars'];

  function drawChart() {
    var dataTable = new google.visualization.DataTable();
    dataTable.addColumn('string', 'Referencia');

    for(var i = 0; i < cars.length; i++){
      dataTable.addColumn('number', cars[i]['name']);
      dataTable.addColumn({type: 'string', role: 'tooltip'});
    }

    for(var i = 0; i < 4; i++){
      dataTable.addRow([
                       i.toString(), 
                       valueFor(i, cars[0]), tooltipFor(i, cars[0]), 
                       valueFor(i, cars[1]), tooltipFor(i, cars[1]), 
                       valueFor(i, cars[2]), tooltipFor(i, cars[2])
      ]);
    }

    var options = { legend: 'none', pointSize: 5 };
    var chart = new google.visualization.AreaChart(document.getElementById('col_chart_custom_tooltip'));
    chart.draw(dataTable, options);
  };

  function valueFor(year, car){
    return car['models'][year]['value'];
  };

  function tooltipFor(year, car){
    return car['models'][year]['name'].concat(": R$").concat(car['models'][year]['value'].toString());
  };
});
