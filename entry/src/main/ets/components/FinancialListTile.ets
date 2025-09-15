import { FinancialAsset } from '../model/FinancialAsset';
import { VChart } from '@visactor/harmony-vchart';
import {
  AxisConfig,
  ChartAnimation,
  ChartData,
  ChartDataItem,
  CrosshairConfig,
  CrosshairLineStyle,
  LineStyle,
  PointStyle,
  SeriesConfig,
  ThemeConfig,
  TooltipConfig,
  TooltipContent,
  VChartSpec
} from '../model/ChartModels';

@Component
export struct FinancialListTile {
  @Prop financialAsset: FinancialAsset;
  @State spec: VChartSpec = this.getInitialSpec();

  aboutToAppear() {
    this.setupChartSpec();
  }

  private getInitialSpec(): VChartSpec {
    return {
      type: 'line',
      height: 120,
      padding: 0,
      data: [],
      series: [],
      axes: [],
      background: 'transparent'
    };
  }

  setupChartSpec() {
    const isPositive = this.financialAsset.dailyPercentage >= 0;
    const color = isPositive ? '#00ff00' : '#ff0000';

    // Prepare data for the chart
    const chartDataValues: ChartDataItem[] = this.financialAsset.historicalData?.map((point, index) => {
      const dataItem: ChartDataItem = {
        x: index,
        y: point.value,
        date: point.date
      };
      return dataItem;
    }) || [];

    const chartData: ChartData = {
      id: 'lineData',
      values: chartDataValues
    };

    const lineStyle: LineStyle = {
      stroke: color,
      lineWidth: 2,
      lineCap: 'round',
      lineJoin: 'round'
    };

    const pointStyle: PointStyle = {
      fill: '#ffffff',
      stroke: '#ffe9cc13',
      lineWidth: 2,
      size: 0
    };

    const animation: ChartAnimation = {
      duration: 1000,
      easing: 'cubicOut',
      type: 'clipIn'
    };

    const seriesConfig: SeriesConfig = {
      type: 'line',
      dataId: 'lineData',
      xField: 'x',
      yField: 'y',
      line: {
        style: lineStyle
      },
      point: {
        visible: false,
        size: 0,
        style: pointStyle
      },
      animation: true,
      animationAppear: animation
    };

    const xAxis: AxisConfig = {
      orient: 'bottom',
      visible: false,
      type: 'linear'
    };

    const yAxis: AxisConfig = {
      orient: 'left',
      visible: false,
      type: 'linear'
    };

    const tooltipContent: TooltipContent = {
      key: this.financialAsset.name,
      value: (datum: ChartDataItem) => `$${datum?.y?.toFixed(2) || '0.00'}`
    };

    const tooltip: TooltipConfig = {
      mark: {
        visible: false,
        title: {
          value: (datum: ChartDataItem) => datum?.date || ''
        },
        content: [tooltipContent]
      }
    };

    const crosshairLineStyle: CrosshairLineStyle = {
      stroke: '#666',
      lineWidth: 1,
      opacity: 0.6,
      lineDash: [4, 4]
    };

    const crosshair: CrosshairConfig = {
      xField: {
        visible: false,
        line: {
          style: crosshairLineStyle
        }
      },
      yField: {
        visible: false
      }
    };

    const theme: ThemeConfig = {
      colorScheme: {
        default: {
          palette: [color]
        }
      }
    };

    this.spec = {
      type: 'line',
      height: 120,
      padding: 0,
      data: [chartData],
      series: [seriesConfig],
      axes: [xAxis, yAxis],
      theme: theme,
      background: 'transparent',
    };
  }

  build() {
    Column({ space: 12 }) {
      Row() {
        Column({ space: 4 }) {
          Text(this.financialAsset.name)
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('sys.color.white'))
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })

          Row({ space: 8 }) {
            Text(`$${this.financialAsset.currentValue.toLocaleString('en-US', {
              minimumFractionDigits: 2,
              maximumFractionDigits: 2
            })}`)
              .fontSize(16)
              .fontColor($r('sys.color.white'))

            Text(`${this.financialAsset.dailyPercentage >= 0 ? '+' :
              ''}${this.financialAsset.dailyPercentage.toFixed(2)}%`)
              .fontSize(14)
              .fontColor(this.financialAsset.dailyPercentage >= 0 ? '#00ff00' : '#ff0000')
          }
        }
        .layoutWeight(3)
        .alignItems(HorizontalAlign.Start)
      }
      .padding({
        left: 16,
        right: 16,
        top: 32,
      })

      // VChart Component
      if (this.financialAsset.historicalData && this.financialAsset.historicalData.length > 0) {
        Column() {
          VChart({ spec: this.spec })
            .height(10)
        }
        .width('100%')
        .height(120)
        .padding({ left: 8, right: 8 })
      } else {
        Text('No chart data available')
          .fontSize(14)
          .fontColor('#666666')
          .width('100%')
          .height(120)
          .padding({ left: 16, right: 16 })
          .textAlign(TextAlign.Center)
      }
    }
    .width('75%')
    .borderRadius(12)
    .margin({
      left: 16,
      right: 16,
      top: 8,
      bottom: 8
    })
    .shadow({
      radius: 8,
      color: '#00000033',
      offsetX: 0,
      offsetY: 2
    })
  }

  onPageShow() {
    this.setupChartSpec();
  }
}