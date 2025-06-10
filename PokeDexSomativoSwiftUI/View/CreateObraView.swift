import SwiftUI
import PhotosUI

// Estrutura que guarda os dados do formulário para criar uma nova obra
struct ObraFormData {
    var titulo = ""
    var artista = ""
    var ano = ""
    var estilo = ""
    var descricao = ""
    var imagePath = ""
}

struct CreateObraView: View {
    @EnvironmentObject var viewModel: ObrasViewModel    // Acesso ao ViewModel global das obras
    @Binding var path: [String]                         // Binding para o controle da navegação
    
    @State private var formData = ObraFormData()       // Estado local que guarda os dados do formulário
    @State private var selectedItem: PhotosPickerItem? // Item selecionado no seletor de fotos
    @State private var processedImage: UIImage?        // Imagem processada para mostrar na tela
    
    // Função que salva uma UIImage como arquivo PNG no diretório de documentos e retorna a URL do arquivo salvo
    func saveImage(image: UIImage, name: String) -> URL? {
        if let data = image.pngData() {
            let url = FileManager.default
                .urls(for: .documentDirectory, in: .userDomainMask)[0]
                .appendingPathComponent(name)
            do {
                try data.write(to: url)  // Tenta gravar os dados no arquivo
                return url               // Retorna a URL se sucesso
            } catch {
                print("Erro ao salvar imagem: \(error)")  // Erro ao salvar
            }
        }
        return nil
    }
    
    var body: some View {
        Form {
            Section {
                // Picker para selecionar imagem da biblioteca do dispositivo
                PhotosPicker(selection: $selectedItem, matching: .images) {
                    if let processedImage {
                        // Mostra a imagem selecionada redimensionada
                        Image(uiImage: processedImage)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 250)
                            .clipped()
                            .cornerRadius(0)
                    } else {
                        // Se nenhuma imagem selecionada, mostra placeholder
                        ContentUnavailableView("Nenhuma imagem", systemImage: "photo.badge.plus")
                            .frame(height: 150)
                    }
                }
                .listRowInsets(EdgeInsets())  // Remove as margens padrão da linha do formulário
            }
            .onChange(of: selectedItem) {
                Task {
                    // Ao mudar o item selecionado, carrega os dados da imagem assincronamente
                    if let data = try? await selectedItem?.loadTransferable(type: Data.self),
                       let image = UIImage(data: data) {
                        processedImage = image   // Atualiza a imagem processada para mostrar na tela
                        let imageName = UUID().uuidString + ".png"  // Gera nome único para o arquivo
                        if let _ = saveImage(image: image, name: imageName) {
                            formData.imagePath = imageName  // Salva o caminho da imagem no formulário
                        }
                    }
                }
            }
            
            // Campos de texto do formulário para preencher dados da obra
            TextField("Título", text: $formData.titulo)
            TextField("Artista", text: $formData.artista)
            TextField("Ano", text: $formData.ano)
                .keyboardType(.numberPad)  // Teclado numérico para ano
            TextField("Estilo", text: $formData.estilo)
            TextField("Descrição", text: $formData.descricao)
        }
        
        // Botão para criar a nova obra
        Button("Criar") {
            // Valida se campos obrigatórios estão preenchidos e se ano é número
            guard !formData.titulo.isEmpty,
                  !formData.artista.isEmpty,
                  !formData.ano.isEmpty,
                  let anoInt = Int(formData.ano) else {
                print("Dados inválidos")  // Caso inválido, apenas imprime no console
                return
            }
            
            // Cria uma nova instância de obra com os dados do formulário
            let novaObra = ObraDeArte(
                id: UUID(),
                titulo: formData.titulo,
                artista: formData.artista,
                ano: anoInt,
                estilo: formData.estilo,
                imagemNome: formData.imagePath,
                descricao: formData.descricao
            )
            
            viewModel.addObra(novaObra)  // Adiciona nova obra no ViewModel
            
            // Reseta o formulário e imagem para estado inicial
            formData = ObraFormData()
            processedImage = nil
            selectedItem = nil
            
            path.removeLast()  // Remove a view atual da pilha de navegação (volta para lista)
        }
        .buttonStyle(.borderedProminent)  // Estilo visual do botão
    }
}
