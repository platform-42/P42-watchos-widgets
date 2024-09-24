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

    public init(icon: String,
                title: String,
                background: Color = .blue,
                font: Font = .headline,
                labelColor: Color = .white,
                iconSize: CGFloat = 16) {
        self.icon = icon
        self.title = title
        self.background = background
        self.font = font
        self.labelColor = labelColor
        self.iconSize = iconSize
    }

    public var body: some View {
        HStack {
            Image(systemName: icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
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
        .frame(height: 40)  // Increased height for better proportions
        .background(background)
        .cornerRadius(8)
    }
}

@available(iOS 13.0, *)
public struct NumberAndStatView: View {
    var period: String
    var primaryValue: String
    var primaryColor: Color
    var secondaryLabel: String? = nil
    var secondaryValue: String
    var secondaryStatus: StatusLogic
    public var body: some View {
        VStack(spacing: 5) {
            Text(period.capitalized)
            Divider()
            /*
             * Primary value
             */
            Text(primaryValue)
                .foregroundColor(primaryColor)
                .font(.largeTitle)
            HStack {
                /*
                 *  Secondary label
                 */
                if let label = secondaryLabel {
                    Text(label)
                        .foregroundColor(.secondary)
                        .padding([.bottom, .top, .trailing, .leading], 5)
                }
                /*
                 *  Secondary value with clipshape badge
                 */
                BadgedLabel(
                    labelColor: WidgetStatus.statusFieldColor(secondaryStatus),
                    backgroundColor: WidgetStatus.statusFieldBackgroundColor(secondaryStatus),
                    labelValue: secondaryValue,
                    padding: 5
                )
            }
            Divider()
        }
    }
}


@available(iOS 13.0, *)
public struct NumberAndStateView: View {
    var period: String
    var primaryValue: String
    var primaryColor: Color
    var secundaryValue: String
    var secundaryColor: Color
    var stateLogic: StateLogic
    public var body: some View {
        VStack(spacing: 5) {
            Text(period.capitalized)
            Divider()
            /*
             *  Primary value
             */
            Text(primaryValue)
                .font(.largeTitle)
                .foregroundColor(primaryColor)
            HStack {
                /*
                 *  Indicator
                 */
                if (stateLogic != .none) {
                    Image(systemName: WidgetStatus.stateFieldImage(stateLogic))
                        .foregroundColor(WidgetStatus.stateFieldColor(stateLogic))
                        .padding([.bottom, .top, .trailing, .leading], 5)
                }
                /*
                 *  Secundary value
                 */
                Text(secundaryValue)
                    .foregroundColor(secundaryColor)
                    .padding([.bottom, .top, .trailing, .leading], 5)
            }
            Divider()
        }
    }
}


@available(iOS 13.0.0, *)
public struct FooterView: View {
    var shop: String
    var font: Font
    var fontWeight: Font.Weight
    var labelColor: Color

    public init(shop: String,
                font: Font = .body,
                fontWeight: Font.Weight = .light,
                labelColor: Color = .secondary) {
        self.shop = shop
        self.font = font
        self.fontWeight = fontWeight
        self.labelColor = labelColor
    }

    public var body: some View {
        Text(shop)
            .font(font)
            .fontWeight(fontWeight)
            .foregroundColor(labelColor)
            .padding(.vertical, 4)
    }
}
