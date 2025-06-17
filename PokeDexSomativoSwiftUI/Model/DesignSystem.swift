//  DesignSystem.swift
//  PokeDexSomativoSwiftUI
//
//  Created by Rafael Galafassi on 15/06/25.
//

import SwiftUI

// - Cores (Tema Pokémon)
enum AppColor {
    case primaryAction, secondaryAction
    case textPrimary, textOnPrimary
    case background, surface, cellBackground
    case error, success

    var color: Color {
        switch self {
        case .primaryAction:
            return Color(red: 0.9, green: 0.17, blue: 0.17) // Vermelho Pokédex
        case .secondaryAction:
            return Color(red: 0.2, green: 0.45, blue: 0.75) // Azul (Great Ball)
        case .textPrimary:
            return Color(red: 0.2, green: 0.2, blue: 0.2)
        case .textOnPrimary:
            return .white
        case .background:
            return Color(.systemGray6)
        case .surface:
            return .white
        case .cellBackground:
            return Color(red: 0.3, green: 0.65, blue: 0.3).opacity(0.2) // Verde claro para a célula
        case .error:
            return Color(red: 0.9, green: 0.17, blue: 0.17)
        case .success:
            return Color(red: 0.3, green: 0.65, blue: 0.3)
        }
    }
}

// - Espaçamentos
enum AppSpacing: CGFloat {
    case small = 4.0
    case medium = 8.0
    case large = 16.0
    case xlarge = 24.0
    case xxlarge = 40.0
}

// - Fontes
enum AppFont {
    case largeTitle, title, body, caption

    func font() -> Font {
        switch self {
        case .largeTitle: return .largeTitle.bold()
        case .title: return .headline
        case .body: return .body
        case .caption: return .caption
        }
    }
}

// - Raios de Canto (Corner Radius)
enum AppCornerRadius: CGFloat {
    case small = 4.0
    case medium = 10.0
    case large = 16.0
}

// - Sombras (Shadows)
struct AppShadow: ViewModifier {
    let radius: CGFloat
    func body(content: Content) -> some View {
        content.shadow(radius: radius)
    }
}
