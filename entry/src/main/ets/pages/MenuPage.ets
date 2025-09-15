import { ChartsPage } from './ChartsPage';
import { NewsPage } from './NewsPage';

@Entry
@Component
struct Index {
  @Provide('NavPathStack') pageStack: NavPathStack = new NavPathStack();

  @Builder
  routeMap(name: string, params: object) {
    NavDestination() {
      if (name === 'ChartsPage') {
        ChartsPage();
      } else if (name === 'NewsPage') {
        NewsPage();
      }
    }
    .hideTitleBar(true);
  }

  build() {
    Navigation(this.pageStack) {

      Row({ space: 12 }) {
        Image($r('app.media.news'))
          .height(72)
          .width(72)
          .padding(8)
          .borderRadius(12)
          .backgroundColor($r('app.color.icon_background'))
          .onClick(() => {
            this.pageStack.pushPath({ name: 'NewsPage' })
          })

        Image($r('app.media.line_chart_icon'))
          .padding(8)
          .height(72)
          .width(72)
          .borderRadius(12)
          .backgroundColor($r('app.color.icon_background'))
          .onClick(() => {
            this.pageStack.pushPath({ name: 'ChartsPage' })
          })
      }
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Center)
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
      .width('100%')
      .height('100%')
    }
    .navDestination(this.routeMap)
    .ignoreLayoutSafeArea()
    .hideTitleBar(true)
    .width('100%')
    .height('100%');
  }
}