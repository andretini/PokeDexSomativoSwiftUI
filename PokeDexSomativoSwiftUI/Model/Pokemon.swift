import Foundation

struct Pokemon: Codable, Identifiable {
    let id: Int
    let name: String
    let baseExperience: Int
    let height: Int
    let weight: Int
    let abilities: [PokemonAbility]
    let moves: [PokemonMove]
    let sprites: PokemonSprites
    let cries: PokemonCries
    let species: NamedAPIResource
    let stats: [PokemonStat]
    let types: [PokemonType]

    enum CodingKeys: String, CodingKey {
        case id, name, height, weight, abilities, moves, species, stats, types, sprites, cries
        case baseExperience = "base_experience"
    }
}

