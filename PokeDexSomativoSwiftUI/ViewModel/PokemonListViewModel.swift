import Foundation

@MainActor
class PokemonListViewModel: ObservableObject {
    @Published var pokemons: [NamedAPIResource] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private var limit = 20
    private var offset = 0
    private var canLoadMore = true

    private let service = PokemonService()

    func fetchPokemons() async {
        guard canLoadMore else { return }
        isLoading = true
        errorMessage = nil

        do {
            let result = try await service.fetchPokemonList(limit: limit, offset: offset)
            pokemons.append(contentsOf: result.results)
            offset += limit

            if result.next == nil {
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
}
