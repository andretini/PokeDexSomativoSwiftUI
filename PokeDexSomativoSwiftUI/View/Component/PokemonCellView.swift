//
//  PokemonCellView.swift
//  PokeDexSomativoSwiftUI
//
//  Created by user277041 on 6/14/25.
//
import SwiftUI

struct PokemonCellView: View {
    let imageUrl: String?
    let pokemon: NamedAPIResource
    let animation: Namespace.ID

    var body: some View {
        VStack {
            PokemonImageView(pokemonUrl: pokemon.url, image: imageUrl)
                .matchedGeometryEffect(id: pokemon.name, in: animation)
            Text(pokemon.name.capitalized)
                .font(AppFont.title.font())
                .foregroundColor(AppColor.textPrimary.color)
        }
        .frame(maxWidth: .infinity, minHeight: 80)
        .background(AppColor.cellBackground.color)
        .cornerRadius(AppCornerRadius.medium.rawValue)
    }
}
