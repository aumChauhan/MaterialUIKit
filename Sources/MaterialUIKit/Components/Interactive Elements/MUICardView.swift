//
// MUICardView.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit.git
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

// MARK: - MUICardType

/// Enum to specify the type of card layout.
@available(iOS 15.0, *)
@frozen public enum MUICardType {
    /// Automatically determine the card layout based on content.
    case automatic
    
    /// Horizontal card layout.
    case horizontal
    
    /// Stack card layout.
    case stack
}

// MARK: - MUICardStyle

/// Enum to specify the style of the card.
@available(iOS 15.0, *)
@frozen public enum MUICardStyle {
    /// Elevared card style.
    case elevated
    
    /// Tonal card style.
    case tonal
}

// MARK: - MUICardView

/// A SwiftUI view representing a MaterialUI style card.
@available(iOS 15.0, *)
public struct MUICardView<Content>: View where Content: View {
    
    // MARK: - Properties
    
    private let heading: String
    private let subheading: String
    private let image: String
    private let cardType: MUICardType
    private let cardStyle: MUICardStyle
    private let content: Content
    
    @State private var descriptive: Bool = false
    @Namespace private var namespace
    
    // MARK: - Initializers
    
    /// Creates a MaterialUIstyle card with `.automatic` card type and `.tonal` card style.
    /// - Parameters:
    ///   - heading: The heading text of the card.
    ///   - subheading: The subheading text of the card.
    ///   - image: The image name for the card.
    ///   - content: The content view of the card.
    public init(heading: String, subheading: String, image: String, @ViewBuilder content: () -> Content) {
        self.heading = heading
        self.subheading = subheading
        self.image = image
        self.content = content()
        self.cardType = .automatic
        self.cardStyle = .tonal
    }
    
    /// Creates a MaterialUI style card with specified card type and style.
    /// - Parameters:
    ///   - heading: The heading text of the card.
    ///   - subheading: The subheading text of the card.
    ///   - image: The image name for the card.
    ///   - cardType: The type of card layout.
    ///   - cardStyle: The style of the card.
    ///   - content: The content view of the card.
    public init(heading: String, subheading: String, image: String, cardType: MUICardType, cardStyle: MUICardStyle, @ViewBuilder content: () -> Content) {
        self.heading = heading
        self.subheading = subheading
        self.image = image
        self.content = content()
        self.cardType = cardType
        self.cardStyle = cardStyle
    }
    
    // MARK: - View Body
    
    public var body: some View {
        switch cardType {
        case .automatic:
            if !descriptive {
                horizontalCard()
            } else {
                stackCard()
            }
        case .horizontal:
            horizontalCard()
            
        case .stack:
            stackCard()
        }
    }
}

// MARK: - Extension MUICard

@available(iOS 15.0, *)
extension MUICardView {
    
    /// Returns a card with heading & subheading.
    private func titleContent() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            // Card heading
            Text(heading)
                .foregroundStyle(.muiPrimaryTitle)
                .font(.headline)
                .fontWeightWithFallback(.semibold)
                .lineLimit(1)
            
            // Card subheading
            Text(subheading)
                .foregroundStyle(.muiSecondaryTitle)
                .font(.body)
                .fontWeightWithFallback(.medium)
        }
    }
    
    /// Returns a horizontal card.
    private func horizontalCard() -> some View {
        HStack {
            titleContent()
                .matchedGeometryEffect(id: "cardTitle", in: namespace)
            
            EmptyView()
                .matchedGeometryEffect(id: "cardDescription", in: namespace)
            
            EmptyView()
                .matchedGeometryEffect(id: "toggleKey", in: namespace)
            
            Spacer()
            
            // Card image
            Image(image)
                .resizable()
                .matchedGeometryEffect(id: "cardImage", in: namespace)
                .cornerRadius(15)
                .frame(width: 70, height: 70)
                .scaledToFit()
        }
        .cardStyleModifier(cardStyle: cardStyle)
        // Toggles card style to stack
        .onTapGesture {
            withAnimation(.bouncy) {
                descriptive.toggle()
            }
        }
    }
    
    /// Returns a Stack card.
    private func stackCard() -> some View {
        VStack(alignment: .leading, spacing: MUIConstants.verticalContentPadding) {
            HStack {
                titleContent()
                    .matchedGeometryEffect(id: "cardTitle", in: namespace)
                
                Spacer()
                
                // Toggle backs to horizontal card
                if cardType != .stack {
                    Button {
                        withAnimation(.bouncy) {
                            descriptive.toggle()
                        }
                    } label: {
                        Image(systemName: "chevron.down.circle.fill")
                            .font(.title3)
                            .foregroundStyle(.muiAccent.opacity(0.7))
                            .padding(5)
                            .matchedGeometryEffect(id: "toggleKey", in: namespace)
                    }
                    .buttonStyle(MUIButtonTapStyle())
                }
            }
            
            // Card image
            Image(image)
                .resizable()
                .cornerRadius(20)
                .matchedGeometryEffect(id: "cardImage", in: namespace)
                .frame(maxWidth: .infinity)
                .scaledToFit()
            
            // Card Content
            content
                .font(.callout)
                .multilineTextAlignment(.leading)
                .foregroundStyle(.muiSecondaryTitle)
                .matchedGeometryEffect(id: "cardDescription", in: namespace)
                .frame(maxWidth: .infinity)
                .padding(8)

        }
        .cardStyleModifier(cardStyle: cardStyle)
    }
}

// MARK: - View Extension

@available(iOS 15.0, *)
extension View {
    
    /// Applies a dynamic card style to the view.
    ///
    /// - Note: This modifier is designed for internal use and not intended for general use.
    ///
    /// - Parameter cardStyle: The card style to apply.
    /// - Returns: A view modified with the specified card style.
    public func cardStyleModifier(cardStyle: MUICardStyle) -> some View {
        VStack {
            switch cardStyle {
            case .elevated:
                self.elevatedInfinityButtonStyle(cornerRadius: MUIConstants.cornerRadius)
            case .tonal:
                self.tonalInfinityButtonStyle(cornerRadius: MUIConstants.cornerRadius)
            }
        }
    }
}

