import Foundation

@MainActor
class PokemonListViewModel: ObservableObject {
    @Published var pokemons: [NamedAPIResource] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var limit = 20
    private var offset = 0
    private var canLoadMore = true
    
    private let API: String = "https://pokeapi.co/api/v2";
    
    func fetchPokemons() async {
        guard canLoadMore else { return }
        isLoading = true
        errorMessage = nil
        
        let urlString = API + "/pokemon?limit=\(limit)&offset=\(offset)"
        guard let url = URL(string: urlString) else {
            errorMessage = "Invalid URL"
            isLoading = false
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(PokemonListResult.self, from: data)
            
            pokemons.append(contentsOf: decoded.results)
            offset += limit
            
            // Stop if no more results
            if decoded.next == nil {
                canLoadMore = false
            }
        } catch {
            errorMessage = "Failed to fetch Pokémon list: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    func reset() {
        pokemons.removeAll()
        offset = 0
        canLoadMore = true
    }
    
    func fetchPokemonImage(pokemonUrl: String) async -> String? {
        guard let url = URL(string: pokemonUrl) else { return nil }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
            return pokemon.sprites.frontDefault
        } catch {
            print("Error fetching Pokémon image: \(error.localizedDescription)")
            return nil
        }
    }
    
    // 3. Fetch full Pokémon model from its URL
    func fetchPokemonData(pokemonUrl: String) async -> Pokemon? {
        guard let url = URL(string: pokemonUrl) else { return nil }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
            return pokemon
        } catch {
            print("Error fetching Pokémon data: \(error.localizedDescription)")
            return nil
        }
    }
    
    func fetchPokemonDataByName(name: String) async -> Pokemon? {
        guard let url = URL(string: API + "pokemon/" + name) else { return nil }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
            return pokemon
        } catch {
            print("Error fetching Pokémon data: \(error.localizedDescription)")
            return nil
        }
    }
}
