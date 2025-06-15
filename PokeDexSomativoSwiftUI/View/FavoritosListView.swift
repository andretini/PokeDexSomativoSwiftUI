//
//  FavoritosView.swift
//  PokeDexSomativoSwiftUI
//
//  Created by user277041 on 6/15/25.
//

import SwiftUI

struct FavoritosListView: View {
    @Binding var path: [String]                // navigation stack binding
    @EnvironmentObject var viewModel: PokemonListViewModel
    @EnvironmentObject var favViewModel: FavoritosViewModel
    
    let columns = [
        GridItem(.adaptive(minimum: 150), spacing: 16)
    ]
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(favViewModel.favoritos) { favorito in
                        let pokemon = NamedAPIResource(name: favorito.nome, url: favorito.pokemonURL)
                        
                        NavigationLink(destination: PokemonDetailView(url: pokemon.url).environmentObject(favViewModel)) {
                            PokemonCellView(imageUrl: favorito.imagemURL, pokemon: pokemon).onAppear {
                                print(pokemon.url)  // print aqui dentro é válido
                            }
                        }

                    }
                }
                .padding()
            }
        }
        .navigationTitle("Pokémon List")
        .onAppear {
            if favViewModel.favoritos.isEmpty {
                Task {
                    favViewModel.loadFavoritos()
                }
            }
        }

    }
}
