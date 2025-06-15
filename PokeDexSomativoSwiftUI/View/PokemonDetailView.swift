import SwiftUI

struct PokemonDetailView: View {
    let url: String
    
    @EnvironmentObject var favViewModel: FavoritosViewModel
    
    @State private var pokemon: Pokemon?
    @State private var isLoading = true
    @State private var errorMessage: String?
    
    var body: some View {
        VStack(spacing: 20) {
            if isLoading {
                ProgressView("Loading...")
            } else if let pokemon = pokemon {
                Text(pokemon.name.capitalized)
                    .font(.largeTitle)
                    .bold()
                
                if let spriteUrlString = pokemon.sprites.frontDefault,
                   let spriteUrl = URL(string: spriteUrlString) {
                    AsyncImage(url: spriteUrl) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                    } placeholder: {
                        ProgressView()
                    }
                }
                
                Text("Height: \(pokemon.height)")
                Text("Weight: \(pokemon.weight)")
                Text("Base XP: \(pokemon.baseExperience)")
                
                
                let idString = String(pokemon.id)

                if favViewModel.ehFavorito(id: idString) {
                    Button("Remover dos favoritos") {
                        favViewModel.removerFavorito(id: idString)
                    }
                    .foregroundColor(.red)
                } else {
                    Button("Adicionar aos favoritos") {
                        favViewModel.adicionarFavorito(
                            id: idString,
                            nome: pokemon.name,
                            imagemURL: pokemon.sprites.frontDefault ?? "",
                            pokemonURL: url
                        )
                    }
                }
                
            } else if let error = errorMessage {
                Text("Error: \(error)")
                    .foregroundColor(.red)
            }
        }
        .padding()
        .task {
            await fetchPokemon()
        }
    }
    
    func fetchPokemon() async {
        isLoading = true
        errorMessage = nil
        
        guard let url = URL(string: url) else {
            errorMessage = "Invalid URL"
            isLoading = false
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(Pokemon.self, from: data)
            pokemon = decoded
        } catch {
            errorMessage = "Failed to load Pokémon details: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}
