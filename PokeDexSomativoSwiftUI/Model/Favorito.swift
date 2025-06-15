//
//  Favoritos.swift
//  PokeDexSomativoSwiftUI
//
//  Created by user277041 on 6/15/25.
//

import Foundation
import SwiftData

@Model
class Favorito {
    @Attribute(.unique) var id: String        // Ex: nome ou ID do Pokémon
    var nome: String
    var imagemURL: String
    var pokemonURL: String
    var usuarioEmail: String                  // Para saber de quem é o favorito

    init(id: String, nome: String, imagemURL: String, pokemonURL: String, usuarioEmail: String) {
        self.id = id
        self.nome = nome
        self.imagemURL = imagemURL
        self.pokemonURL = pokemonURL
        self.usuarioEmail = usuarioEmail
    }
}
