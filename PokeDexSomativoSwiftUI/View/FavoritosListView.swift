//
//  FavoritosView.swift
//  PokeDexSomativoSwiftUI
//
//  Created by user277041 on 6/15/25.
//

import SwiftUI

struct FavoritosListView: View {
    @Binding var path: [String]
    @EnvironmentObject var viewModel: PokemonListViewModel
    @EnvironmentObject var favViewModel: FavoritosViewModel
    
    @Namespace private var animation
    
    let columns = [
        GridItem(.adaptive(minimum: 150), spacing: AppSpacing.large.rawValue)
    ]
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: AppSpacing.large.rawValue) {
                    ForEach(favViewModel.favoritos) { favorito in
                        let pokemon = NamedAPIResource(name: favorito.nome, url: favorito.pokemonURL)
                        
                        NavigationLink(destination: PokemonDetailView(url: pokemon.url, animation: animation).environmentObject(favViewModel)) {
                            PokemonCellView(imageUrl: favorito.imagemURL, pokemon: pokemon, animation: animation)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(AppSpacing.large.rawValue)
            }
        }
        .navigationTitle("Meus Favoritos")
        .onAppear {
            favViewModel.loadFavoritos() 
        }
    }
}
