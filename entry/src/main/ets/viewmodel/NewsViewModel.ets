import { NewsItem } from '../model/NewsItem';

@Observed
export class NewsViewModel {
  newsList: Array<NewsItem> = [
    {
      title: 'Cryptex Nears All-Time High as Market Confidence Grows',
      summary: 'Investors are bullish on Cryptex, pushing its price above $73,000 amid strong momentum in the crypto market.',
      publishedAt: '2025-05-06T08:30:00Z',
      source: 'Finovate Daily'
    },
    {
      title: 'Vizion AI Unveils New Chipset for Smart Devices',
      summary: 'Tech giant Vizion AI announces a next-gen AI processor, sending its stock up nearly 2% during morning trading.',
      publishedAt: '2025-05-06T07:10:00Z',
      source: 'TechNova Weekly'
    }
  ];
}