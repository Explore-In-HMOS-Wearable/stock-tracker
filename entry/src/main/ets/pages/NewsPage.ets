import { NewsListTile } from '../components/NewsListTile';
import { NewsItem } from '../model/NewsItem';
import { NewsViewModel } from '../viewmodel/NewsViewModel';

@Entry
struct NewsPage {
  private viewModel: NewsViewModel = new NewsViewModel();

  build() {
    Swiper() {
      ForEach(this.viewModel.newsList, (item: NewsItem) => {
        NewsListTile({
          newsItem: item
        })
      }, (item: NewsItem) => item.title)
    }
    .indicator(
      new DotIndicator()
        .itemWidth(3)
        .itemHeight(3)
        .selectedItemWidth(5)
        .selectedItemHeight(5)
        .selectedColor(Color.Blue)
        .maxDisplayCount(6)
    )
    .loop(false)
    .vertical(true)
    .height('100%')
    .width('100%')
    .linearGradient({
      direction: GradientDirection.Left,
      repeating: false,
      angle: 12,
      colors: [
        [0x0d1b2a, 0.0], // Deep Navy
        [0x1b263b, 0.25], // Charcoal Blue
        [0x415a77, 0.5],// Slate Blue
      ]
    })
  }
}

export { NewsPage }