//
// MUICardView.swift
// MaterialUIKit: https://github.com/aumChauhan/MaterialUIKit
//
// Author: Aum Chauhan
// Created On: 30/12/23
//

import SwiftUI

// MARK: - MUICardType

/// Enum to specify the type of card layout.
@available(iOS 17.0, *)
public enum MUICardType {
    /// Automatically determine the card layout based on content.
    case automatic
    
    /// Horizontal card layout.
    case horizontal
    
    /// Stack card layout.
    case stack
}

// MARK: - MUICardStyle

/// Enum to specify the style of the card.
@available(iOS 17.0, *)
public enum MUICardStyle {
    /// Elevared card style.
    case elevated
    
    /// Tonal card style.
    case tonal
}

// MARK: - MUICardView

/// A SwiftUI view representing a MaterialUI style card.
@available(iOS 17.0, *)
public struct MUICardView<Content>: View where Content: View {
    
    // MARK: - Properties
    
    public let heading: String
    public let subheading: String
    public let image: String
    public let cardType: MUICardType
    public let cardStyle: MUICardStyle
    public let content: Content
    
    @State private var descriptive: Bool = false
    @Environment(\.colorScheme) private var colorScheme
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

@available(iOS 17.0, *)
extension MUICardView {
    
    /// Returns a card with heading & subheading.
    private func titleContent() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            // Card heading
            Text(heading)
                .foregroundStyle(MaterialUI.tint.primaryTitle(colorScheme))
                .font(.headline)
                .fontWeight(.semibold)
                .lineLimit(1)
            
            // Card subheading
            Text(subheading)
                .foregroundStyle(MaterialUI.tint.secondaryTitle(colorScheme))
                .font(.subheadline)
                .fontWeight(.medium)
                .lineLimit(1)
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
        .cardStyleModifier(cardStyle: cardStyle, colorScheme: colorScheme)
        .onTapGesture { // Toggle card style to stack
            withAnimation(.bouncy) {
                descriptive.toggle()
            }
        }
    }
    
    /// Returns a Stack card.
    private func stackCard() -> some View {
        VStack(alignment: .leading, spacing: 15) {
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
                            .foregroundColor(MaterialUI.tint.accent(colorScheme).opacity(0.7))
                            .padding(5)
                            .matchedGeometryEffect(id: "toggleKey", in: namespace)
                    }
                    .buttonStyle(MUIButtonTapStyle())
                }
            }
            
            // Card image
            Image(image)
                .resizable()
                .cornerRadius(15)
                .matchedGeometryEffect(id: "cardImage", in: namespace)
                .frame(maxWidth: .infinity)
                .scaledToFit()
            
            content
                .font(.callout)
                .multilineTextAlignment(.leading)
                .foregroundColor(MaterialUI.tint.secondaryTitle(colorScheme))
                .matchedGeometryEffect(id: "cardDescription", in: namespace)
                .frame(maxWidth: .infinity)
        }
        .cardStyleModifier(cardStyle: cardStyle, colorScheme: colorScheme)
    }
}

// MARK: - View Extension

@available(iOS 17.0, *)
extension View {
    
    /// Applies a dynamic card style to the view.
    ///
    /// - Note: This modifier is designed for internal use and not intended for general use.
    ///
    /// - Parameter cardStyle: The card style to apply.
    /// - Returns: A view modified with the specified card style.
    public func cardStyleModifier(cardStyle: MUICardStyle, colorScheme: ColorScheme) -> some View {
        VStack {
            switch cardStyle {
            case .elevated:
                self.elevatedInfinityButtonStyle(colorScheme)
            case .tonal:
                self.tonalInfinityButtonStyle(colorScheme)
            }
        }
    }
}

