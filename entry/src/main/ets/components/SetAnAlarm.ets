@Component
export struct SetAnAlarmButton {
  build() {
    Button('Set Alarm')
      .fontColor(Color.White)
      .fontWeight(FontWeight.Bold)
      .backgroundColor(Color.Blue)
  }
}