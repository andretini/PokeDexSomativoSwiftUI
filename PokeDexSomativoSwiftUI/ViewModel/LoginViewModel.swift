//
//  LoginViewModel.swift
//  PokeDexSomativoSwiftUI
//
//  Created by user277041 on 6/16/25.
//

import Foundation
import SwiftData

@MainActor
class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var senha = ""
    @Published var erro: String = ""

    func autenticar(context: ModelContext, appState: AppState) {
        let usuarioService = UsuarioService(context: context)
        
        guard let usuario = usuarioService.autenticar(email: email, senha: senha) else {
            erro = "Credenciais inválidas"
            return
        }

        appState.usuarioLogado = usuario
    }
}

