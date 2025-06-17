// Views/PokemonListView.swift
import SwiftUI

struct PokemonListView: View {
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
                    ForEach(viewModel.pokemons.indices, id: \.self) { index in
                        let pokemon = viewModel.pokemons[index]
                        
                        NavigationLink(
                            destination: PokemonDetailView(url: pokemon.url, animation: animation).environmentObject(favViewModel)
                        ) {
                            PokemonCellView(imageUrl: nil, pokemon: pokemon, animation: animation)
                                .onAppear {
                                    if index == viewModel.pokemons.count - 1 {
                                        Task {
                                            await viewModel.fetchPokemons()
                                        }
                                    }
                                }
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(AppSpacing.large.rawValue)
            }
            
            NavigationLink(destination: FavoritosListView(path: $path)
                .environmentObject(viewModel)
                .environmentObject(favViewModel)
            ) {
                Text("Ver Favoritos")
                    .font(AppFont.title.font())
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(AppColor.secondaryAction.color)
                    .foregroundColor(AppColor.textOnPrimary.color)
                    .cornerRadius(AppCornerRadius.medium.rawValue) 
                    .padding(.horizontal)
            }
            .padding(.bottom)
        }
        .navigationTitle("Pokémon List")
        .onAppear {
            if viewModel.pokemons.isEmpty {
                Task {
                    await viewModel.fetchPokemons()
                }
            }
        }
    }
}
