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
        VStack(spacing: AppSpacing.xlarge.rawValue) {
            Text("Entrar")
                .font(AppFont.largeTitle.font())
                .padding(.top, AppSpacing.xxlarge.rawValue)

            VStack(spacing: AppSpacing.large.rawValue) {
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
                    if let usuario = usuarios.first(where: { $0.email == email && $0.senha == senha }) {
                        appState.usuarioLogado = usuario
                    } else {
                        erro = "Credenciais inválidas"
                    }
                }) {
                    Text("Entrar")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(AppColor.primaryAction.color)
                        .foregroundColor(AppColor.textOnPrimary.color)
                        .cornerRadius(AppCornerRadius.medium.rawValue)
                        .modifier(AppShadow(radius: 4))
                }

                NavigationLink("Criar nova conta", destination: CadastroView())
                    .padding(.top, AppSpacing.medium.rawValue)
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
                gradient: Gradient(colors: [AppColor.primaryAction.color.opacity(0.1), AppColor.surface.color]),
                startPoint: .top,
                endPoint: .bottom
            ).ignoresSafeArea()
        )
    }
}
