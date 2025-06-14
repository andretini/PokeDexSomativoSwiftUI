//
//  PokemonMoves.swift
//  PokeDexSomativoSwiftUI
//
//  Created by user277041 on 6/14/25.
//

struct PokemonMove: Codable {
    let move: NamedAPIResource
    let versionGroupDetails: [PokemonMoveVersion]
	
    enum CodingKeys: String, CodingKey {
        case move
        case versionGroupDetails = "version_group_details"
    }
}

struct PokemonMoveVersion: Codable {
    let moveLearnMethod: NamedAPIResource
    let versionGroup: NamedAPIResource
    let levelLearnedAt: Int

    enum CodingKeys: String, CodingKey {
        case moveLearnMethod = "move_learn_method"
        case versionGroup = "version_group"
        case levelLearnedAt = "level_learned_at"
    }
}
