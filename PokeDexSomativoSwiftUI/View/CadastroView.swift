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

    @StateObject private var viewModel = CadastroViewModel()


    var body: some View {
        VStack(spacing: AppSpacing.xlarge.rawValue) {
            Text("Criar Conta")
                .font(AppFont.largeTitle.font())
                .padding(.top, AppSpacing.xxlarge.rawValue)

            VStack(spacing: AppSpacing.large.rawValue) {
                TextField("Nome de usuário", text: $viewModel.nome)
                TextField("Email", text: $viewModel.email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                SecureField("Senha", text: $viewModel.senha)

                if !viewModel.erro.isEmpty {
                    Text(viewModel.erro)
                        .foregroundColor(AppColor.error.color)
                        .font(AppFont.caption.font())
                }

                Button("Cadastrar") {
                    viewModel.cadastrar(context: context, appState: appState)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(AppColor.success.color)
                .foregroundColor(AppColor.textOnPrimary.color)
                .cornerRadius(AppCornerRadius.medium.rawValue)
                .modifier(AppShadow(radius: 4))
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
