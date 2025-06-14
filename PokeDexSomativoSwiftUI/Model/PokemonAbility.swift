 //
//  PokemonAbility.swift
//  PokeDexSomativoSwiftUI
//
//  Created by user277041 on 6/14/25.
//

struct PokemonAbility: Codable {
    let isHidden: Bool
    let slot: Int
    let ability: NamedAPIResource

    enum CodingKeys: String, CodingKey {
        case isHidden = "is_hidden"
        case slot, ability
    }
}
