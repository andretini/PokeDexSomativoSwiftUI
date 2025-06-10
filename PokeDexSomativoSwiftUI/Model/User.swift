//
//  User.swift
//  PokeDexSomativoSwiftUI
//
//  Created by user277041 on 6/10/25.
//
import SwiftUI
import SwiftData

@Model
class Usuario {
    @Attribute(.unique) var id: UUID
    var nomeDeUsuario: String
    var email: String
    var senha: String

    init(id: UUID = UUID(), nomeDeUsuario: String, email: String, senha: String) {
        self.id = id
        self.nomeDeUsuario = nomeDeUsuario
        self.email = email
        self.senha = senha
    }
}
