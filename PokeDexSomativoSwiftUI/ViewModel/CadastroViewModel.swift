//
//  CadastroViewModel.swift
//  PokeDexSomativoSwiftUI
//
//  Created by user277041 on 6/16/25.
//

import Foundation
import SwiftData

@MainActor
class CadastroViewModel: ObservableObject {
    @Published var nome = ""
    @Published var email = ""
    @Published var senha = ""
    @Published var erro = ""

    func cadastrar(context: ModelContext, appState: AppState) {
        guard !nome.isEmpty, !email.isEmpty, !senha.isEmpty else {
            erro = "Todos os campos são obrigatórios"
            return
        }

        let usuarioService = UsuarioService(context: context)
        let novo = usuarioService.registrarUsuario(nome: nome, email: email, senha: senha)
        appState.usuarioLogado = novo
    }
}
