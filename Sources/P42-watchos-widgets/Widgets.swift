// The Swift Programming Language
// https://docs.swift.org/swift-book
import SwiftUI
import Foundation


@available(iOS 14.0, *)
public struct BadgedLabel: View {
    let labelColor: Color
    let font: Font
    let backgroundColor: Color
    let labelValue: String
    let padding: EdgeInsets
    
    public init(
        labelColor: Color = .white,
        font: Font = .caption2,
        backgroundColor: Color = .blue,
        labelValue: String,
        padding: EdgeInsets = EdgeInsets(top: 2, leading: 6, bottom: 2, trailing: 6)
    ) {
        self.labelColor = labelColor
        self.font = font
        self.backgroundColor = backgroundColor
        self.labelValue = labelValue
        self.padding = padding
    }
    
    public var body: some View {
        Text(labelValue)
            .font(font)
            .foregroundColor(labelColor)
            .padding(padding)
            .background(backgroundColor)
            .clipShape(Capsule())
    }
}


@available(iOS 16.0, *)
public struct HeaderView<Tooltip: View>: View {

    let connectionColor: Color
    let title: String
    let background: Color
    let font: Font
    let labelColor: Color
    let iconSize: CGFloat

    private let tooltip: Tooltip?
    @State private var showTooltip = false

    public init(
        connectionColor: Color,
        title: String,
        background: Color = .blue,
        font: Font = .headline,
        labelColor: Color = .white,
        iconSize: CGFloat = 16,
        @ViewBuilder tooltip: () -> Tooltip? = { nil }
    ) {
        self.connectionColor = connectionColor
        self.title = title
        self.background = background
        self.font = font
        self.labelColor = labelColor
        self.iconSize = iconSize
        self.tooltip = tooltip()
    }

    public var body: some View {
        ZStack {
            Text(title.capitalized)
                .font(font)
                .fontWeight(.semibold)
                .foregroundColor(labelColor)
                .padding(.vertical, 4)
            HStack {
                Image(systemName: "circlebadge.fill")
                    .foregroundColor(connectionColor)
                    .font(.system(size: iconSize))

                Spacer()
                ZStack(alignment: .topTrailing) {

                    Image(systemName: "info.circle")
                        .foregroundColor(labelColor)
                        .font(.system(size: iconSize))
                        .contentShape(Rectangle())
                        .onTapGesture {
                            if tooltip != nil {
                                withAnimation(.easeInOut(duration: 0.15)) {
                                    showTooltip.toggle()
                                }
                            }
                        }

                    if showTooltip, let tooltip {
                        tooltip
                            .offset(y: -8)
                            .transition(.opacity.combined(with: .scale))
                            .zIndex(1)
                    }
                }
            }
            .padding(.vertical, 4)
            .padding(.horizontal, 15)
        }
        .frame(maxWidth: .infinity)
        .background(background)
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
                    labelColor: Widget.statusFieldColor(widgetStatus),
                    backgroundColor: Widget.statusFieldBackgroundColor(widgetStatus),
                    labelValue: secondaryValue,
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



