//
//  CadastroView.swift
//  PokeDexSomativoSwiftUI
//
//  Created by user277041 on 6/10/25.
//

import SwiftUI
import SwiftData

struct CadastroView: View {
    @Environment(\.modelContext) private var context
    @Environment(AppState.self) var appState

    @State private var nome = ""
    @State private var email = ""
    @State private var senha = ""
    @State private var erro = ""

    var body: some View {
        VStack(spacing: 24) {
            Text("Criar Conta")
                .font(.largeTitle.bold())
                .padding(.top, 40)

            VStack(spacing: 16) {
                TextField("Nome de usuário", text: $nome)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)

                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)

                SecureField("Senha", text: $senha)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)

                if !erro.isEmpty {
                    Text(erro)
                        .foregroundColor(.red)
                        .font(.caption)
                }

                Button(action: {
                    if nome.isEmpty || email.isEmpty || senha.isEmpty {
                        erro = "Todos os campos são obrigatórios"
                        return
                    }

                    let novo = Usuario(nomeDeUsuario: nome, email: email, senha: senha)
                    context.insert(novo)
                    appState.usuarioLogado = novo
                }) {
                    Text("Cadastrar")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(radius: 4)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(16)
            .shadow(radius: 8)
            .padding(.horizontal)

            Spacer()
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color.green.opacity(0.1), Color.white]), startPoint: .top, endPoint: .bottom).ignoresSafeArea())
    }
}
