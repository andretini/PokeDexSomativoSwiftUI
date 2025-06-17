//
//  PokemonApiService.swift
//  PokeDexSomativoSwiftUI
//
//  Created by user277041 on 6/16/25.
//

import Foundation

struct PokemonService {
    private let baseURL = "https://pokeapi.co/api/v2"

    func fetchPokemonList(limit: Int, offset: Int) async throws -> PokemonListResult {
        let urlString = "\(baseURL)/pokemon?limit=\(limit)&offset=\(offset)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(PokemonListResult.self, from: data)
    }

    func fetchPokemon(from urlString: String) async throws -> Pokemon {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(Pokemon.self, from: data)
    }

    func fetchPokemonByName(_ name: String) async throws -> Pokemon {
        let urlString = "\(baseURL)/pokemon/\(name)"
        return try await fetchPokemon(from: urlString)
    }
}
