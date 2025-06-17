//
//  PokemonDetailViewModel.swift
//  PokeDexSomativoSwiftUI
//
//  Created by user277041 on 6/16/25.
//

import Foundation

@MainActor
class PokemonDetailViewModel: ObservableObject {
    private let service = PokemonService()
    
    @Published var pokemon: Pokemon?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isImageVisible = false

    func fetchPokemon(from url: String) async {
        isImageVisible = false
        isLoading = true
        errorMessage = nil

        guard let _ = URL(string: url) else {
            errorMessage = "Invalid URL"
            isLoading = false
            return
        }

        do {
            let result = try await service.fetchPokemon(from: url)
            self.pokemon = result
            self.isLoading = false
            self.isImageVisible = true // <-- Apenas altera o estado, animação é feita na View
        } catch {
            errorMessage = "Failed to load Pokémon details: \(error.localizedDescription)"
            isLoading = false
        }
    }

    func fetchPokemonDataByName(name: String) async -> Pokemon? {
        do {
            return try await service.fetchPokemonByName(name)
        } catch {
            print("Error fetching Pokémon data by name: \(error.localizedDescription)")
            return nil
        }
    }

    func fetchPokemonImage(pokemonUrl: String) async -> String? {
        do {
            let pokemon = try await service.fetchPokemon(from: pokemonUrl)
            return pokemon.sprites.frontDefault
        } catch {
            print("Error fetching Pokémon image: \(error.localizedDescription)")
            return nil
        }
    }
}
