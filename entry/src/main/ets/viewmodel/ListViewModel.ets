import { FinancialAsset, FinancialDataPoint } from '../model/FinancialAsset';

@Observed
export class ListViewModel {
  listContents: Array<FinancialAsset> = [
    {
      name: 'Company_1',
      currentValue: 94534.92,
      dailyPercentage: -0.60,
      historicalData: this.generateSampleData(94534.92, 30, 5000)
    },
    {
      name: 'Company_2',
      currentValue: 4812.34,
      dailyPercentage: 1.25,
      historicalData: this.generateSampleData(4812.34, 30, 200)
    },
    {
      name: 'Company_3',
      currentValue: 189.27,
      dailyPercentage: -0.32,
      historicalData: this.generateSampleData(189.27, 30, 5)
    },
    {
      name: 'Company_4',
      currentValue: 763.91,
      dailyPercentage: 2.10,
      historicalData: this.generateSampleData(763.91, 30, 30)
    },
    {
      name: 'Company_5',
      currentValue: 3421.57,
      dailyPercentage: 0.85,
      historicalData: this.generateSampleData(3421.57, 30, 100)
    },
    {
      name: 'Gold',
      currentValue: 2314.55,
      dailyPercentage: -0.12,
      historicalData: this.generateSampleData(2314.55, 30, 20)
    },
    {
      name: 'S&P 500 ETF (SPY)',
      currentValue: 518.79,
      dailyPercentage: 0.44,
      historicalData: this.generateSampleData(518.79, 30, 10)
    },
    {
      name: 'USD/EUR',
      currentValue: 0.9274,
      dailyPercentage: -0.09,
      historicalData: this.generateSampleData(0.9274, 30, 0.02)
    },
    {
      name: 'Company_6',
      currentValue: 0.144,
      dailyPercentage: 3.87,
      historicalData: this.generateSampleData(0.144, 30, 0.01)
    },
    {
      name: 'Company_7',
      currentValue: 926.48,
      dailyPercentage: 1.92,
      historicalData: this.generateSampleData(926.48, 30, 40)
    }
  ];

  // Generate sample historical data (replace with real data API later)
  private generateSampleData(currentValue: number, days: number, volatility: number): FinancialDataPoint[] {
    const data: FinancialDataPoint[] = [];
    const today = new Date();

    for (let i = days - 1; i >= 0; i--) {
      const date = new Date(today);
      date.setDate(today.getDate() - i);

      // Generate random value with some trend
      const randomChange = (Math.random() - 0.5) * volatility;
      const trendFactor = i === 0 ? 0 : (currentValue - data[data.length - 1]?.value || currentValue) / days;
      const value =
        i === 0 ? currentValue : (data[data.length - 1]?.value || currentValue) + randomChange + trendFactor;

      data.push({
        date: date.toLocaleDateString(),
        value: Math.max(0, value) // Ensure non-negative values
      });
    }

    return data;
  }

  // Method to update chart data for a specific asset
  updateChartData(assetIndex: number, newData: FinancialDataPoint[]): void {
    if (assetIndex >= 0 && assetIndex < this.listContents.length) {
      this.listContents[assetIndex].historicalData = newData;
    }
  }

  // Method to refresh all data (simulating API call)
  refreshData(): void {
    this.listContents.forEach((asset, index) => {
      // Here you would normally fetch real data from an API
      // For now, we'll just regenerate random data
      asset.historicalData = this.generateSampleData(asset.currentValue, 30, asset.currentValue * 0.05);
    });
  }
}