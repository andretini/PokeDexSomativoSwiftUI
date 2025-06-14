//
//  PokemonStat.swift
//  PokeDexSomativoSwiftUI
//
//  Created by user277041 on 6/14/25.
//

struct PokemonStat: Codable {
    let baseStat: Int
    let effort: Int
    let stat: NamedAPIResource

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
}
