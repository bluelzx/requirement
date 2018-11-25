<!DOCTYPE html>
<%@ include file="include.jsp"%>
<%@ page pageEncoding="UTF-8"%>
<html>
<title>Bootstrap learning</title>
<meta name="viewport" content="width=device-width,initial-scale=1.0">
 <script src="<%=basePath %>echarts/esl.js"></script>
<link href="<%=basePath %>bootstrap/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>bootstrap/bootstrap-responsive.css" rel="stylesheet">
</head>
<body>

<div class="row-fluid">
    	<div class="span12">
    		<div id="rCountDiv"  style='width:100%;height:300px;float:left;margin-right:0;padding-right:0;border-right-width:0'></div>
    	</div>
    </div>
<script type="text/javascript">
// 路径配置
require.config({
            paths:{ 
                'echarts' : '<%=basePath %>echarts/echarts',
                'echarts/chart/line': '<%=basePath %>echarts/echarts',
	            'echarts/chart/bar': '<%=basePath %>echarts/echarts',
	            'echarts/chart/scatter': '<%=basePath %>echarts/echarts',
	            'echarts/chart/k': '<%=basePath %>echarts/echarts',
	            'echarts/chart/pie': '<%=basePath %>echarts/echarts',
	            'echarts/chart/radar': '<%=basePath %>echarts/echarts',
	            'echarts/chart/map': '<%=basePath %>echarts/echarts',
	            'echarts/chart/chord': '<%=basePath %>echarts/echarts',
	            'echarts/chart/force': '<%=basePath %>echarts/echarts'
            }
        });
  
  // 使用
        require(
            [
                'echarts',
                'echarts/chart/line',
		        'echarts/chart/bar',
		        'echarts/chart/scatter',
		        'echarts/chart/k',
		        'echarts/chart/pie',
		        'echarts/chart/radar',
		        'echarts/chart/force',
		        'echarts/chart/chord'
            ],
            function(ec) {
            
             var myChart = ec.init(document.getElementById('rCountDiv')); 
            
            var	option = {
    legend: {
        data:['高度(km)与气温(°C)变化关系']
    },
    toolbox: {
        show : true,
        feature : {
            mark : {show: true},
            dataView : {show: true, readOnly: false},
            magicType : {show: true, type: ['line', 'bar']},
            restore : {show: true},
            saveAsImage : {show: true}
        }
    },
    calculable : true,
    tooltip : {
        trigger: 'axis',
        formatter: "Temperature : <br/>{b}km : {c}°C"
    },
    xAxis : [
        {
            type : 'value',
            axisLabel : {
                formatter: '{value} °C'
            },
            splitArea : {show : true}
        }
    ],
    yAxis : [
        {
            type : 'category',
            axisLabel : {
                formatter: '{value} km'
            },
            boundaryGap : false,
            data : ['0', '10', '20', '30', '40', '50', '60', '70', '80']
        }
    ],
    series : [
        {
            name:'高度(km)与气温(°C)变化关系',
            type:'line',
            smooth:true,
            itemStyle: {
                normal: {
                    lineStyle: {
                        shadowColor : 'rgba(0,0,0,0.4)'
                    }
                }
            },
            data:[15, -50, -56.5, -46.5, -22.1, -2.5, -27.7, -55.7, -76.5]
        }
    ]
};
              myChart.setOption(option);
              window.onresize = myChart.resize;  
            });
        
</script>

<script src="<%=basePath %>bootstrap/jquery.js"></script>
<script src="<%=basePath %>bootstrap/bootstrap.js"></script>
</body>

</html>