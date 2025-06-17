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
    @Environment(\.modelContext) private var context

    @StateObject private var viewModel = LoginViewModel()

    var body: some View {
        VStack(spacing: AppSpacing.xlarge.rawValue) {
            AsyncImage(url: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/9/98/International_Pok%C3%A9mon_logo.svg/1200px-International_Pok%C3%A9mon_logo.svg.png")) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.8)
                    .padding(.top, 30)
            } placeholder: {
                ProgressView()
            }
            Text("Entrar")
                .font(AppFont.largeTitle.font())
                .padding(.top, AppSpacing.xxlarge.rawValue)

            VStack(spacing: AppSpacing.large.rawValue) {
                TextField("Email", text: $viewModel.email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(AppColor.background.color)
                    .cornerRadius(AppCornerRadius.medium.rawValue)

                SecureField("Senha", text: $viewModel.senha)
                    .padding()
                    .background(AppColor.background.color)
                    .cornerRadius(AppCornerRadius.medium.rawValue)

                if !viewModel.erro.isEmpty {
                    Text(viewModel.erro)
                        .foregroundColor(AppColor.error.color)
                        .font(AppFont.caption.font())
                }

                Button(action: {
                    viewModel.autenticar(context: context, appState: appState)
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
