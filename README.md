# Pokédex Somativo SwiftUI

Este é um aplicativo de Pokédex desenvolvido em SwiftUI como um projeto somativo. Ele permite aos usuários navegar por uma lista de Pokémon, visualizar detalhes sobre cada um, criar uma conta, fazer login e salvar seus Pokémon favoritos. O aplicativo utiliza a [PokeAPI](https://pokeapi.co/) para obter os dados dos Pokémon e o SwiftData para persistência de dados do usuário e favoritos.

-----

## 🚀 Funcionalidades

  * **Autenticação e Sessão de Usuário**:

      * Criação de conta com nome de usuário, email e senha.
      * Sistema de Login para acessar a área principal do aplicativo.
      * Gerenciamento de sessão através de um objeto `AppState`, que mantém o usuário logado e direciona para a tela principal.

  * **Lista de Pokémon**:

      * Exibe uma lista de Pokémon em uma grade visualmente agradável.
      * A lista implementa **paginação (scroll infinito)**, carregando mais Pokémon dinamicamente conforme o usuário rola a tela.
      * As imagens dos Pokémon são carregadas de forma assíncrona para não bloquear a UI.

  * **Detalhes do Pokémon**:

      * Exibe uma tela de detalhes com informações como imagem, altura, peso, XP base, habilidades e movimentos.
      * Utiliza uma animação (`matchedGeometryEffect`) na transição da imagem entre a lista e a tela de detalhes para uma experiência mais fluida.

  * **Sistema de Favoritos**:

      * Usuários logados podem adicionar ou remover Pokémon de sua lista de favoritos diretamente na tela de detalhes.
      * Uma tela dedicada exibe todos os Pokémon favoritados pelo usuário.
      * Os favoritos são persistidos localmente usando **SwiftData** e vinculados ao email do usuário, garantindo que cada usuário tenha sua própria lista.

  * **Design System**:

      * O projeto utiliza um sistema de design customizado (`DesignSystem.swift`) para manter a consistência visual.
      * Define cores, fontes, espaçamentos, raios de canto e sombras padronizadas em todo o app.

-----

## 🏛️ Arquitetura

O projeto adota uma arquitetura baseada em **MVVM (Model-View-ViewModel)**, complementada por uma camada de Serviços para uma clara separação de responsabilidades.

  * **Model**: Representa as estruturas de dados, incluindo os modelos da PokeAPI (ex: `Pokemon`, `PokemonListResult`) e os modelos de dados locais gerenciados pelo SwiftData (`Usuario`, `Favorito`).
  * **View**: As telas da interface do usuário construídas com SwiftUI (ex: `PokemonListView`, `LoginView`). São reativas e refletem o estado do ViewModel.
  * **ViewModel**: Contém a lógica de apresentação e o estado da UI (ex: `PokemonListViewModel`, `FavoritosViewModel`). Atua como uma ponte entre o Model e a View, preparando os dados para exibição.
  * **Service**: Uma camada de abstração que lida com a obtenção de dados, seja da rede (`PokemonService`) ou do banco de dados local (`UsuarioService`, `FavoritoService`).
  * **AppState**: Uma classe observável que gerencia o estado global do aplicativo, como a informação do usuário logado, garantindo que a UI reaja a mudanças de estado de autenticação.

-----

## 🛠️ Tecnologias Utilizadas

  * **SwiftUI**: Para a construção da interface de usuário declarativa e reativa.
  * **SwiftData**: Para a persistência de dados locais de forma moderna e segura.
  * **Async/Await**: Para lidar com operações assíncronas de forma limpa e legível, especialmente nas chamadas de rede para a PokeAPI.
  * **PokeAPI**: A fonte de todos os dados relacionados aos Pokémon.

-----

## ⚙️ Como Executar o Projeto

1.  **Clone o repositório:**
    ```bash
    git clone https://github.com/andretini/pokedexsomativoswiftui.git
    ```
2.  **Abra no Xcode:**
      * Navegue até a pasta do projeto e abra o arquivo `PokeDexSomativoSwiftUI.xcodeproj`.
3.  **Execute o Aplicativo:**
      * Selecione um simulador de iOS ou um dispositivo físico.
      * Pressione o botão "Run" (▶) no Xcode para compilar e executar o aplicativo.

-----

[Assista ao vídeo no YouTube](https://youtu.be/EySWHf10E-o)
