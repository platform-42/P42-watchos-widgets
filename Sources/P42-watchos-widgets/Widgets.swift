// The Swift Programming Language
// https://docs.swift.org/swift-book
import SwiftUI
import Foundation


@available(iOS 13.0, *)
public struct BadgedLabel: View {
    var labelColor: Color
    var backgroundColor: Color
    var labelValue: String
    var padding: CGFloat

    public init(labelColor: Color = .white,
                backgroundColor: Color = .blue,
                labelValue: String,
                padding: CGFloat = 10) {
        self.labelColor = labelColor
        self.backgroundColor = backgroundColor
        self.labelValue = labelValue
        self.padding = padding
    }

    public var body: some View {
        Text(labelValue)
            .foregroundColor(labelColor)
            .padding(padding)
            .background(backgroundColor)
            .clipShape(Capsule())
            .accessibilityLabel(Text(labelValue))
    }
}


@available(iOS 16.0, *)
public struct HeaderView: View {
    var icon: String
    var title: String
    var background: Color
    var font: Font
    var labelColor: Color
    var iconSize: CGFloat
    var height: CGFloat

    public init(icon: String,
                title: String,
                background: Color = .blue,
                font: Font = .headline,
                labelColor: Color = .white,
                iconSize: CGFloat = 16,
                height: CGFloat = 30
    ) {
        self.icon = icon
        self.title = title
        self.background = background
        self.font = font
        self.labelColor = labelColor
        self.iconSize = iconSize
        self.height = height
    }

    public var body: some View {
        HStack {
            Image(systemName: icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(labelColor)
                .frame(width: iconSize, height: iconSize)
                .padding(4)

            Divider()

            Text(title.capitalized)
                .font(font)
                .fontWeight(.semibold)
                .foregroundColor(labelColor)
                .padding(4)
        }
        .frame(maxWidth: .infinity)
        .frame(height: height)
        .background(background)
    }
}

@available(iOS 13.0, *)
public struct NumberAndStatView: View {
    var period: String
    var periodBG: Color
    var primaryValue: String
    var primaryColor: Color
    var secondaryLabel: String? = nil
    var secondaryValue: String
    var widgetStatus: WidgetStatus

    public init(period: String,
                periodBG: Color,
                primaryValue: String,
                primaryColor: Color,
                secondaryLabel: String? = nil,
                secondaryValue: String,
                widgetStatus: WidgetStatus) {
        self.period = period
        self.periodBG = periodBG
        self.primaryValue = primaryValue
        self.primaryColor = primaryColor
        self.secondaryLabel = secondaryLabel
        self.secondaryValue = secondaryValue
        self.widgetStatus = widgetStatus
    }

    public var body: some View {
        VStack {
            HStack {
                Text(period.capitalized)
                    .accessibilityLabel("Period: \(period.capitalized)")
            }
            .frame(maxWidth: .infinity)
            .background(periodBG)
            
            Divider()
            Text(primaryValue)
                .foregroundColor(primaryColor)
                .font(.largeTitle)
                .accessibilityLabel("Primary value: \(primaryValue)")
            HStack {
                if let label = secondaryLabel {
                    Text(label)
                        .foregroundColor(.secondary)
                        .padding(5)
                        .accessibilityLabel("Secondary label: \(label)")
                }
                BadgedLabel(
                    labelColor: Widget.statusFieldColor(widgetStatus),
                    backgroundColor: Widget.statusFieldBackgroundColor(widgetStatus),
                    labelValue: secondaryValue,
                    padding: 5
                )
                .accessibilityLabel("Secondary value: \(secondaryValue)")
            }
            Divider()
        }
        .padding(.horizontal, 10)
    }
}


@available(iOS 13.0, *)
public struct NumberAndStateView: View {
    var period: String
    var periodBG: Color
    var primaryValue: String
    var primaryColor: Color
    var annotation: String
    var secondaryValue: String
    var secondaryColor: Color
    var widgetState: WidgetState

    public init(period: String,
                periodBG: Color,
                primaryValue: String,
                primaryColor: Color,
                annotation: String,
                secondaryValue: String,
                secondaryColor: Color,
                widgetState: WidgetState) {
        self.period = period
        self.periodBG = periodBG
        self.primaryValue = primaryValue
        self.primaryColor = primaryColor
        self.annotation = annotation
        self.secondaryValue = secondaryValue
        self.secondaryColor = secondaryColor
        self.widgetState = widgetState
    }

    public var body: some View {
        VStack {
            HStack {
                Text(period.capitalized)
                    .accessibilityLabel("Period: \(period.capitalized)")
            }
            .frame(maxWidth: .infinity)
            .background(periodBG)
            
            Divider()
            HStack(alignment: .firstTextBaseline) {
                Text(primaryValue)
                    .font(.largeTitle)
                    .foregroundColor(primaryColor)
                    .accessibilityLabel("Primary value: \(primaryValue)")
                Text(annotation)
                    .font(.caption)
                    .foregroundColor(secondaryColor)
                    .accessibilityLabel("Annotation: \(annotation)")
            }
            HStack {
                if widgetState != .none {
                    Image(systemName: Widget.stateFieldImage(widgetState))
                        .foregroundColor(Widget.stateFieldColor(widgetState))
                        .padding(5)
                        .accessibilityLabel("State logic: \(Widget.stateFieldImage(widgetState))")
                }
                Text(secondaryValue)
                    .foregroundColor(secondaryColor)
                    .padding(5)
                    .accessibilityLabel("Secondary value: \(secondaryValue)")
            }
            Divider()
        }
        .padding(.horizontal, 10)
    }
}



@available(iOS 13.0.0, *)
public struct FooterView: View {
    var topic: String
    var font: Font
    var fontWeight: Font.Weight
    var lastUpdate: String?

    public init(topic: String,
                font: Font = .footnote,
                fontWeight: Font.Weight = .light,
                lastUpdate: String? = nil) {
        self.topic = topic
        self.font = font
        self.fontWeight = fontWeight
        self.lastUpdate = lastUpdate
    }

    public var body: some View {
        VStack {
            Text(topic)
                .font(font)
                .fontWeight(fontWeight)
                .foregroundColor(.primary)
            
            if let lastUpdate = lastUpdate {
                Text(lastUpdate)
                    .font(font)
                    .foregroundColor(.secondary)
            }
        }
    }
}
