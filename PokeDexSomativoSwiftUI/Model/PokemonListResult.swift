//
//  PokemonListResult.swift
//  PokeDexSomativoSwiftUI
//
//  Created by user277041 on 6/14/25.
//

struct PokemonListResult: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [NamedAPIResource]
}
