//
//  PokemonSprites.swift
//  PokeDexSomativoSwiftUI
//
//  Created by user277041 on 6/14/25.
//

struct PokemonSprites: Codable {
    let frontDefault: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
