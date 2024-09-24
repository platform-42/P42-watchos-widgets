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
    public var body: some View {
            Text(labelValue)
                .foregroundColor(labelColor)
                .padding([.bottom, .top, .trailing, .leading], padding)
                .background(backgroundColor)
                .clipShape(Capsule())
        }
}

@available(iOS 16.0, *)
public struct HeaderView: View {
    var icon: String
    var title: String
    var background: Color
    public var body: some View {
        HStack {
            Image(systemName: icon)
                .padding([.bottom, .top, .trailing, .leading], 2)
            Divider()
            Text(title.capitalized)
                .padding([.bottom, .top, .trailing, .leading], 2)
                .fontWeight(.semibold)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 30)
        .background(background)
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
    public var body: some View {
        Text(shop)
            .fontWeight(.light)
            .foregroundColor(.secondary)
    }
}
