//
//  UserLocalService.swift
//  PokeDexSomativoSwiftUI
//
//  Created by user277041 on 6/16/25.
//

import Foundation
import SwiftData

struct UsuarioService {
    let context: ModelContext

    func registrarUsuario(nome: String, email: String, senha: String) -> Usuario {
        let novo = Usuario(nomeDeUsuario: nome, email: email, senha: senha)
        context.insert(novo)
        do {
            try context.save()
        } catch {
            print("Erro ao registrar usuário: \(error)")
        }
        return novo
    }

    func autenticar(email: String, senha: String) -> Usuario? {
        let descriptor = FetchDescriptor<Usuario>(
            predicate: #Predicate { $0.email == email && $0.senha == senha }
        )

        do {
            return try context.fetch(descriptor).first
        } catch {
            print("Erro ao autenticar: \(error)")
            return nil
        }
    }
}
