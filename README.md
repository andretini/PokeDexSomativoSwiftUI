# Pokédex Somativo SwiftUI

Este é um aplicativo de Pokédex desenvolvido em SwiftUI como um projeto somativo. Ele permite aos usuários navegar por uma lista de Pokémon, visualizar detalhes sobre cada um, criar uma conta, fazer login e salvar seus Pokémon favoritos. O aplicativo utiliza a [PokeAPI](https://pokeapi.co/) para obter os dados dos Pokémon e o SwiftData para persistência de dados do usuário e favoritos.

## 🚀 Funcionalidades

  * **Autenticação de Usuário**:

      * Criação de conta com nome de usuário, email e senha.
      * Sistema de Login para acessar a área principal do aplicativo.
      * A sessão do usuário é mantida, direcionando para a lista de Pokémon após o login bem-sucedido.

  * **Lista de Pokémon**:

      * Exibe uma lista de Pokémon em uma grade.
      * A lista é carregada dinamicamente e implementa paginação (scroll infinito) para carregar mais Pokémon conforme o usuário rola a tela.
      * As imagens dos Pokémon são carregadas de forma assíncrona.

  * **Detalhes do Pokémon**:

      * Ao selecionar um Pokémon, uma tela de detalhes é exibida com informações como nome, imagem, altura, peso e experiência base.
      * Animações são utilizadas na transição da imagem entre a lista e a tela de detalhes.

  * **Sistema de Favoritos**:

      * Usuários logados podem adicionar ou remover Pokémon de sua lista de favoritos.
      * Uma tela dedicada exibe todos os Pokémon favoritados pelo usuário.
      * Os favoritos são persistidos localmente usando SwiftData e vinculados ao email do usuário.

  * **Design System**:

      * O projeto utiliza um sistema de design customizado para manter a consistência visual.
      * Define cores, fontes, espaçamentos, raios de canto e sombras padronizadas.

## 🏛️ Arquitetura

O projeto adota uma arquitetura baseada em **MVVM (Model-View-ViewModel)**.

  * **Model**: As estruturas de dados que representam os Pokémon (buscados da PokeAPI) e os dados do aplicativo, como `Usuario` e `Favorito`.

  * **View**: As telas da interface do usuário construídas com SwiftUI.

  * **ViewModel**: A lógica de negócios e o estado da UI, que atuam como uma ponte entre o Model e a View.

## 🛠️ Tecnologias Utilizadas

  * **SwiftUI**: Para a construção da interface de usuário declarativa.
  * **SwiftData**: Para a persistência de dados locais (`Usuario` e `Favorito`).
  * **Async/Await**: Para lidar com operações assíncronas, como chamadas de rede.
  * **PokeAPI**: A fonte de todos os dados relacionados aos Pokémon.

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
