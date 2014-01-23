$(function(){
  if($("body.compares.show").length){
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
                         getModelValue(i, cars[0]), tooltipFor(i, cars[0]), 
                         getModelValue(i, cars[1]), tooltipFor(i, cars[1]), 
                         getModelValue(i, cars[2]), tooltipFor(i, cars[2])
        ]);
      }

      var options = { legend: 'none', pointSize: 5 };
      var chart = new google.visualization.AreaChart(document.getElementById('col_chart_custom_tooltip'));
      chart.draw(dataTable, options);
    };

    function getModelValue(year, car){
      if(car['models'][year])
        return car['models'][year]['value'];
      else
        return 0;
    }

    function getModelName(year, car){
      if(car['models'][year])
        return car['models'][year]['name'];
      else
        return "Sem nome";
    }

    function tooltipFor(year, car){
      return getModelName(year, car).concat(": R$").concat(getModelValue(year, car).toString());
    };
  }
});
