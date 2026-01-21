// The Swift Programming Language
// https://docs.swift.org/swift-book
import SwiftUI
import Foundation


public enum BadgedLabelContent {
    case text(String)
    case systemImage(name: String)
}

@available(iOS 14.0, *)
public struct BadgedLabel: View {
    
    let content: BadgedLabelContent
    let foregroundColor: Color
    let font: Font
    let backgroundColor: Color
    let padding: EdgeInsets
    
    public init(
        content: BadgedLabelContent,
        foregroundColor: Color = .white,
        font: Font = .caption2,
        backgroundColor: Color = .blue,
        padding: EdgeInsets = EdgeInsets(top: 2, leading: 6, bottom: 2, trailing: 6)
    ) {
        self.content = content
        self.foregroundColor = foregroundColor
        self.font = font
        self.backgroundColor = backgroundColor
        self.padding = padding
    }
    
    public var body: some View {
        label
            .padding(padding)
            .background(backgroundColor)
            .clipShape(Capsule())
    }
    
    @ViewBuilder
    private var label: some View {
        switch content {
        case .text(let value):
            Text(value)
                .font(font)
                .foregroundColor(foregroundColor)
            
        case .systemImage(let name):
            Image(systemName: name)
                .font(font)
                .foregroundColor(foregroundColor)
        }
    }
}


@available(iOS 16.0, *)
public struct HeaderView: View {
    
    let connectionColor: Color
    let title: String
    let background: Color
    let font: Font
    let labelColor: Color
    let iconSize: CGFloat
    let infoText: String?
    
    public init(
        connectionColor: Color,
        title: String,
        background: Color = .blue,
        font: Font = .headline,
        labelColor: Color = .white,
        iconSize: CGFloat = 16,
        infoText: String? = nil
    ) {
        self.connectionColor = connectionColor
        self.title = title
        self.background = background
        self.font = font
        self.labelColor = labelColor
        self.iconSize = iconSize
        self.infoText = infoText
    }
    
    @State private var showInfo = false
    
    public var body: some View {
        ZStack {
            titleView
            contentRow
        }
        .frame(maxWidth: .infinity)
        .background(background)
    }
}

@available(iOS 16.0, *)
private extension HeaderView {
    
    var titleView: some View {
        Text(title.capitalized)
            .font(font)
            .fontWeight(.semibold)
            .foregroundColor(labelColor)
            .padding(.vertical, 4)
    }
    
    var contentRow: some View {
        HStack {
            statusIndicator
            Spacer()
            infoButton
        }
        .padding(.vertical, 4)
        .padding(.horizontal, 15)
    }
    
    var statusIndicator: some View {
        Image(systemName: "circlebadge.fill")
            .foregroundColor(connectionColor)
            .font(.system(size: iconSize))
    }
    
    @ViewBuilder
    var infoButton: some View {
        if let _ = infoText {
            Button {
                showInfo.toggle()
            } label: {
                Image(systemName: "info.circle")
                    .foregroundColor(Widget.stateFieldColor(.neutral))
                    .font(.system(size: iconSize))
            }
            .buttonStyle(.plain)
        }
    }
}


public struct NumberAndStatView: View {
    var period: String
    var periodColor: Color
    var primaryValue: String
    var primaryColor: Color
    var secondaryLabel: String?
    var secondaryValue: String
    var widgetStatus: WidgetStatus
    
    public init(period: String,
                periodColor: Color = .secondary,
                primaryValue: String,
                primaryColor: Color,
                secondaryLabel: String? = nil,
                secondaryValue: String,
                widgetStatus: WidgetStatus) {
        self.period = period
        self.periodColor = periodColor
        self.primaryValue = primaryValue
        self.primaryColor = primaryColor
        self.secondaryLabel = secondaryLabel
        self.secondaryValue = secondaryValue
        self.widgetStatus = widgetStatus
    }
    
    public var body: some View {
        VStack(spacing: 4) {
            Divider()
            Text(period.capitalized)
                .foregroundColor(periodColor)
            Divider()
            Text(primaryValue)
                .foregroundColor(primaryColor)
                .font(.largeTitle)
            HStack {
                if let label = secondaryLabel {
                    Text(label)
                        .foregroundColor(.secondary)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 4)
                }
                BadgedLabel(
                    content: .text(String(secondaryValue)),
                    foregroundColor: Widget.statusFieldColor(widgetStatus),
                    font: .caption2,
                    backgroundColor: Widget.statusFieldBackgroundColor(widgetStatus),
                    padding: EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4)
                )
            }
            Divider()
        }
    }
}


@available(iOS 13.0, *)
public struct NumberAndStateView: View {
    let period: String
    let periodColor: Color
    let primaryValue: String
    let primaryColor: Color
    let primaryAnnotation: String?
    let primaryAnnotationColor: Color?
    let secondaryValue: String
    let secondaryColor: Color
    let widgetState: WidgetState
    
    public init(
        period: String,
        periodColor: Color = .secondary,
        primaryValue: String,
        primaryColor: Color,
        primaryAnnotation: String? = nil,
        primaryAnnotationColor: Color? = .secondary,
        secondaryValue: String,
        secondaryColor: Color,
        widgetState: WidgetState
    ) {
        self.period = period
        self.periodColor = periodColor
        self.primaryValue = primaryValue
        self.primaryColor = primaryColor
        self.primaryAnnotation = primaryAnnotation
        self.primaryAnnotationColor = primaryAnnotationColor
        self.secondaryValue = secondaryValue
        self.secondaryColor = secondaryColor
        self.widgetState = widgetState
    }
    
    public var body: some View {
        VStack(spacing: 4) {
            Divider()
            Text(period.capitalized)
                .foregroundColor(periodColor)
            Divider()
            HStack(alignment: .firstTextBaseline) {
                Text(primaryValue)
                    .font(.largeTitle)
                    .foregroundColor(primaryColor)
                if let annotation = primaryAnnotation {
                    Text(annotation)
                        .font(.caption)
                        .foregroundColor(primaryAnnotationColor)
                }
            }
            HStack {
                if widgetState != .none {
                    Image(systemName: Widget.stateFieldImage(widgetState))
                        .foregroundColor(Widget.stateFieldColor(widgetState))
                        .padding(.horizontal, 4)
                }
                Text(secondaryValue)
                    .foregroundColor(secondaryColor)
                    .padding(.horizontal, 4)
            }
            Divider()
        }
    }
}


@available(iOS 13.0.0, *)
public struct FooterView<LastUpdateView: View>: View {
    let topic: String
    let topicColor: Color?
    let font: Font
    let lastUpdateView: LastUpdateView?
    
    public init(
        topic: String,
        topicColor: Color? = .primary,
        font: Font = .footnote,
        @ViewBuilder lastUpdateView: () -> LastUpdateView?
    ) {
        self.topic = topic
        self.topicColor = topicColor
        self.font = font
        self.lastUpdateView = lastUpdateView()
    }
    
    public var body: some View {
        VStack(spacing: 4) {
            Text(topic)
                .font(font)
                .fontWeight(.light)
                .foregroundColor(topicColor)
            
            if let lastUpdateView {
                lastUpdateView
            }
        }
    }
}


public struct MetricSummary: View {
    
    public let title: String
    public let todayValue: String
    public let yesterdayValue: String
    public let averageValue: String
    public let averageDelayMinutes: Int
    public let delayThresholdMinutes: Int
    
    public init(
        title: String,
        todayValue: String,
        yesterdayValue: String,
        averageValue: String,
        averageDelayMinutes: Int = 0,
        delayThresholdMinutes: Int = 15
    ) {
        self.title = title
        self.todayValue = todayValue
        self.yesterdayValue = yesterdayValue
        self.averageValue = averageValue
        self.averageDelayMinutes = averageDelayMinutes
        self.delayThresholdMinutes = delayThresholdMinutes
    }
    
    public var body: some View {
        VStack(spacing: 8) {
            
            Text(title)
                .font(.headline)
                .foregroundColor(Color.blue.opacity(0.8))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            dashboardRow(
                value: todayValue,
                label: "NOW",
                showArrow: true,
                isUp: todayValue >= averageValue,
                showClock: false
            )
            
            dashboardRow(
                value: yesterdayValue,
                label: "YTD",
                showArrow: true,
                isUp: yesterdayValue >= averageValue,
                showClock: false
            )
            
            dashboardRow(
                value: averageValue,
                label: "AVG",
                showArrow: false,
                isUp: true,
                showClock: averageDelayMinutes >= delayThresholdMinutes
            )
        }
        .padding(.vertical)
    }
}


extension MetricSummary {
    
    private func dashboardRow(
        value: String,
        label: String,
        showArrow: Bool,
        isUp: Bool,
        showClock: Bool
    ) -> some View {
        HStack(spacing: 0) {
            
            statusBadge(
                showArrow: showArrow,
                isUp: isUp,
                showClock: showClock
            )
            
            Spacer(minLength: 8)
            
            Text(value)
                .font(.system(size: 28, weight: .bold))
                .monospacedDigit()
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 8)
            
            Text(label)
                .font(.caption2)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 8)
        }
        .padding(.horizontal)
        .padding(.vertical, 6)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.gray.opacity(0.28),
                            Color.gray.opacity(0.12)
                        ]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(
                            semanticCellOverlay(
                                isUp: isUp,
                                enabled: showArrow
                            )
                        )
                )
        )
    }
}


extension MetricSummary {
    
    @ViewBuilder
    private func statusBadge(
        showArrow: Bool,
        isUp: Bool,
        showClock: Bool
    ) -> some View {
        if showArrow {
            ZStack {
                Circle()
                    .fill(arrowBadgeBackground(isUp: isUp))
                    .frame(width: 28, height: 28)
                
                Image(systemName: isUp ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
                    .foregroundColor(isUp ? .green : .red)
                    .font(.system(size: 14, weight: .bold))
            }
        } else if showClock {
            ZStack {
                Circle()
                    .fill(clockBadgeBackground())
                    .frame(width: 28, height: 28)
                
                Image(systemName: "clock.fill")
                    .foregroundColor(Color(hex: WidgetStatusColor.warning.rawValue).opacity(0.9))
                    .font(.system(size: 13, weight: .semibold))
            }
        } else {
            Spacer()
                .frame(width: 28)
        }
    }
    
    private func arrowBadgeBackground(isUp: Bool) -> RadialGradient {
        RadialGradient(
            gradient: Gradient(colors: [
                (isUp ? Color.green : Color.red).opacity(0.30),
                Color.gray.opacity(0.15)
            ]),
            center: .center,
            startRadius: 2,
            endRadius: 16
        )
    }
    
    private func clockBadgeBackground() -> RadialGradient {
        RadialGradient(
            gradient: Gradient(colors: [
                Color(hex: WidgetStatusColor.warning.rawValue).opacity(0.25),
                Color.gray.opacity(0.15)
            ]),
            center: .center,
            startRadius: 2,
            endRadius: 16
        )
    }
    
    private func semanticCellOverlay(isUp: Bool, enabled: Bool) -> LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [
                enabled ? (isUp ? Color.green : Color.red).opacity(0.18) : Color.clear,
                Color.clear
            ]),
            startPoint: .topLeading,
            endPoint: .center
        )
    }
}

