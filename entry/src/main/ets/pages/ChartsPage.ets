import { FinancialListTile } from '../components/FinancialListTile';
import { FinancialAsset } from '../model/FinancialAsset';
import { ListViewModel } from '../viewmodel/ListViewModel';

@Entry
struct ChartsPage {
  private viewModel: ListViewModel = new ListViewModel();
  private DISPLAY_COUNT: number = 1
  private MIN_SCALE: number = 0.75
  private backgroundColors: Color[] = [Color.Green, Color.Blue, Color.Yellow, Color.Pink, Color.Gray, Color.Orange]
  @State opacityList: number[] = []
  @State scaleList: number[] = []
  @State translateList: number[] = []
  @State zIndexList: number[] = []

  aboutToAppear(): void {
    for (let i = 0; i < this.backgroundColors.length; i++) {
      this.opacityList.push(1.0)
      this.scaleList.push(1.0)
      this.translateList.push(0.0)
      this.zIndexList.push(0)
    }
  }

  build() {
    Swiper() {
      ForEach(this.viewModel.listContents, (item: FinancialAsset, index: number) => {
        FinancialListTile({
          financialAsset: item
        })
          .opacity(this.opacityList[index])
          .scale({ x: this.scaleList[index], y: this.scaleList[index] })
          .translate({
            x: 0,
            y: this.translateList[index]
          }).zIndex(this.zIndexList[index])
      }, (item: FinancialAsset, index: number) => item.name)
    }
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
    .indicator(
      new DotIndicator()
        .itemWidth(3)
        .itemHeight(3)
        .selectedItemWidth(5)
        .selectedItemHeight(5)
        .selectedColor(Color.Blue)
        .maxDisplayCount(6)
    )
    .align(Alignment.Center)
    .vertical(true)
    .displayCount(this.DISPLAY_COUNT, true)
    .loop(false)
    .customContentTransition({
      timeout: 1000,
      transition: (proxy: SwiperContentTransitionProxy) => {
        if (proxy.position <= proxy.index % this.DISPLAY_COUNT ||
          proxy.position >= this.DISPLAY_COUNT + proxy.index % this.DISPLAY_COUNT) {
          // When a group of pages is completely scrolled out of the viewport, reset the attribute values.
          this.opacityList[proxy.index] = 1.0
          this.scaleList[proxy.index] = 1.0
          this.translateList[proxy.index] = 0.0
          this.zIndexList[proxy.index] = 0
        } else {
          // When a group of pages is not scrolled out of the viewport, adjust the attribute values
          if (proxy.index % this.DISPLAY_COUNT === 0) {
            this.opacityList[proxy.index] = 1 - proxy.position / this.DISPLAY_COUNT
            this.scaleList[proxy.index] =
              this.MIN_SCALE + (1 - this.MIN_SCALE) * (1 - proxy.position / this.DISPLAY_COUNT)

            // Fix: Adjust translation to maintain center position
            const scaleOffset = (1 - this.scaleList[proxy.index]) * proxy.mainAxisLength / 2.0
            this.translateList[proxy.index] = -proxy.position * proxy.mainAxisLength + scaleOffset
          } else {
            this.opacityList[proxy.index] = 1 - (proxy.position - 1) / this.DISPLAY_COUNT
            this.scaleList[proxy.index] =
              this.MIN_SCALE + (1 - this.MIN_SCALE) * (1 - (proxy.position - 1) / this.DISPLAY_COUNT)

            // Fix: Adjust translation to maintain center position
            const scaleOffset = (1 - this.scaleList[proxy.index]) * proxy.mainAxisLength / 2.0
            this.translateList[proxy.index] = -(proxy.position - 1) * proxy.mainAxisLength - scaleOffset
          }
          this.zIndexList[proxy.index] = -1
        }
      }
    })
    .height('100%')
    .width('100%')
  }
}

export { ChartsPage }