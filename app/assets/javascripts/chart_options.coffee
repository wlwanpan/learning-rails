
window.ChartOptions =
  line:
    title:
      display: false
      text: "Linear chart of active users"
      padding: 20
      margin: 20
      fontSize: 30
    legend:
      position: 'bottom'
    animationEasing: 'easeOutElastic'
    responsive: true
    scales:
      xAxes: [{
        stacked: true
        scaleLabel:
          display: true
          labelString: 'Date Of Registered Entries / UTC'
          fontSize: 20
        gridLines:
          display: false
          lineWidth: 2
          color: "#D3D3D3"
      }]
      yAxes: [{
        stacked: false
        scaleLabel:
          display: false
          labelString: '# of Active Users'
          fontSize: 20
        gridLines:
          display: false
          lineWidth: 2
          color: "#D3D3D3"
      }]
  dataset:
    fill: false
    borderWidth: 1
    pointBorderColor: "#FFFFFF"
    pointRadius: 5
