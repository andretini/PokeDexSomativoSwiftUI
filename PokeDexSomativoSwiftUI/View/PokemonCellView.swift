//
//  PokemonCellView.swift
//  PokeDexSomativoSwiftUI
//
//  Created by user277041 on 6/14/25.
//
import SwiftUI;

struct PokemonCellView: View {
    let imageUrl: String?
    let pokemon: NamedAPIResource

    var body: some View {
        VStack {
            PokemonImageView(pokemonUrl: pokemon.url, image: imageUrl)
            Text(pokemon.name.capitalized)
                .font(.headline)
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity, minHeight: 80)
        .background(Color.green.opacity(0.2))
        .cornerRadius(8)
    }
}
