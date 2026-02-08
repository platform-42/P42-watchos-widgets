# P42-watchos-widgets

private func statusBadge(
showArrow: Bool,
state: WidgetState,
latency: String?
) -> some View {
if showArrow {
ZStack {
Circle()
.fill(arrowBadgeBackground(state: state))
.frame(width: MetricsDimension.iconSize, height: MetricsDimension.iconSize)

Image(systemName: Widget.stateFieldImage(state))
.foregroundColor(Widget.stateFieldColor(state))
.font(.system(size: MetricsDimension.iconFontSize, weight: .bold))
}
} else if let latency {
VStack(spacing: 1) {
ZStack {
Circle()
.fill(clockBadgeBackground())
.frame(width: MetricsDimension.iconSize, height: MetricsDimension.iconSize)

Image(systemName: "clock.fill")
.foregroundColor(Widget.stateFieldColor(state))
.font(.system(size: MetricsDimension.iconFontSize, weight: .semibold))
}
Text(latency)
.foregroundColor(Widget.stateFieldColor(state))
.font(.system(size: 8, weight: .bold))
.monospacedDigit()
}
} else {
Spacer()
.frame(width: MetricsDimension.iconSize)
}
}

