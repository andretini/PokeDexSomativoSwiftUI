//
//  LoginView.swift
//  PokeDexSomativoSwiftUI
//
//  Created by user277041 on 6/10/25.
//

import SwiftUI
import SwiftData

struct LoginView: View {
    @Environment(AppState.self) var appState
    @Query private var usuarios: [Usuario]

    @State private var email = ""
    @State private var senha = ""
    @State private var erro = ""

    var body: some View {
        VStack(spacing: 24) {
            Text("Entrar")
                .font(.largeTitle.bold())
                .padding(.top, 40)

            VStack(spacing: 16) {
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
                    if let usuario = usuarios.first(where: { $0.email == email && $0.senha == senha }) {
                        appState.usuarioLogado = usuario
                    } else {
                        erro = "Credenciais inválidas"
                    }
                }) {
                    Text("Entrar")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(radius: 4)
                }

                NavigationLink("Criar nova conta", destination: CadastroView())
                    .padding(.top, 10)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(16)
            .shadow(radius: 8)
            .padding(.horizontal)

            Spacer()
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.white]), startPoint: .top, endPoint: .bottom).ignoresSafeArea())
    }
}
