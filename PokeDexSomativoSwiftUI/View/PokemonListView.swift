import SwiftUI

struct PokemonListView: View {
    @Binding var path: [String]                // navigation stack binding
    @EnvironmentObject var viewModel: PokemonListViewModel
    
    let columns = [
        GridItem(.adaptive(minimum: 150), spacing: 16)
    ]
    
    var body: some View {	
        VStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.pokemons.indices, id: \.self) { index in
                        let pokemon = viewModel.pokemons[index]
                        
                        NavigationLink(
                            destination: PokemonDetailView(url: pokemon.url)
                        ) {
                            PokemonCellView(pokemon: pokemon)
                                .onAppear {
                                    // Trigger load more when the last item appears
                                    if index == viewModel.pokemons.count - 1 {
                                        Task {
                                            await viewModel.fetchPokemons()
                                        }
                                    }
                                }
                            
                        }
                    }
                }
                .padding()
            }
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
