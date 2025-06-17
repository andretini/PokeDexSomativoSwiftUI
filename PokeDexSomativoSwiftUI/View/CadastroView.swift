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
        VStack(spacing: AppSpacing.xlarge.rawValue) {
            Text("Criar Conta")
                .font(AppFont.largeTitle.font())
                .padding(.top, AppSpacing.xxlarge.rawValue)

            VStack(spacing: AppSpacing.large.rawValue) {
                TextField("Nome de usuário", text: $nome)
                    .padding()
                    .background(AppColor.background.color)
                    .cornerRadius(AppCornerRadius.medium.rawValue)

                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(AppColor.background.color)
                    .cornerRadius(AppCornerRadius.medium.rawValue)

                SecureField("Senha", text: $senha)
                    .padding()
                    .background(AppColor.background.color)
                    .cornerRadius(AppCornerRadius.medium.rawValue)

                if !erro.isEmpty {
                    Text(erro)
                        .foregroundColor(AppColor.error.color)
                        .font(AppFont.caption.font())
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
                        .background(AppColor.success.color)
                        .foregroundColor(AppColor.textOnPrimary.color)
                        .cornerRadius(AppCornerRadius.medium.rawValue)
                        .modifier(AppShadow(radius: 4))
                }
            }
            .padding()
            .background(AppColor.surface.color)
            .cornerRadius(AppCornerRadius.large.rawValue)
            .modifier(AppShadow(radius: 8))
            .padding(.horizontal)

            Spacer()
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [AppColor.success.color.opacity(0.1), AppColor.surface.color]), 
                startPoint: .top,
                endPoint: .bottom
            ).ignoresSafeArea()
        )
    }
}
