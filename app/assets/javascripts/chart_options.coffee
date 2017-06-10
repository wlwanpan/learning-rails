
window.ChartOptions =
  line:
    title:
      display: true
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
        scaleLabel:
          display: true
          labelString: 'Time Registered'
          fontSize: 20
        gridLines:
          display: false
          lineWidth: 2
          color: "#191919"
      }]
      yAxes: [{
        scaleLabel:
          display: true
          labelString: '# of Active Users'
          fontSize: 20
        gridLines:
          display: false
          lineWidth: 2
          color: "#191919"
      }]
  dataset:
    fill: false
    borderWidth: 1
    pointBorderColor: "#FFFFFF"
    pointRadius: 5
