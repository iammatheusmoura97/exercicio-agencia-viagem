import SwiftUI

struct PacoteViagem: Identifiable {
    
    var id = UUID()
    var titulo: String
    var destino: String
    var qtdDiaria: Int
    var dataPartida: String
    var dataRetorno: String
    var info: String
    var image: String
    var preco: Double
    var isFavorito: Bool
}
