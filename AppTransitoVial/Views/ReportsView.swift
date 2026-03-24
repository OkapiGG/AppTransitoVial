//
//  ReportsView.swift
//  AppTransitoVial
//
//  Created by Alan Cervantes on 12/03/26.
//

import SwiftUI
import PhotosUI

struct ReportsView: View {
    
    @State private var selection: String = "Selecciona un tipo de señal"
    @State private var description: String = ""
    @State private var selectedItem: [PhotosPickerItem] = []
    @State private var selectedImages: [UIImage] = []

    var body: some View {
        ZStack{
            Color(Color.background)
                .ignoresSafeArea()
            VStack{
                
                
                //Titulo, Comentado por que queda descuadrado #ool
//                HStack{
//                    Image(systemName: "arrow")
//                        .font(.system(size: 14, weight: .bold))
//                        .foregroundColor(Color.white)
//                    
//                    Text("Reportar Señal")
//                        .foregroundStyle(.white)
//                        .font(.title)
//                    
//                    Spacer()
//                    
//                    Button(action: {
//                        
//                    }){
//                        Label("Ayuda", systemImage: "questionmark")
//                            .font(.subheadline)
//                            .fontWeight(.bold)
//                    }
//
//                }
                
                VStack{
                    Text("Tipo de señal")
                        .foregroundStyle(.white)
                    Menu {
                        Button("Rojo"){ selection = "Rojo" }
                        Button("Amarillo"){ selection = "Amarillo" }
                        Button("Verde"){ selection = "Verde" }
                    } label: {
                        HStack(spacing: 12) {
                            Text(selection)
                                .foregroundStyle(.white)
                                .font(.body)
                                .lineLimit(1)
                            
                            Spacer(minLength: 8)
                            
                            Image(systemName: "chevron.down")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(15)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.white.opacity(0.2), lineWidth: 1)
                        )
                    }
                    .accentColor(.white)
                }.padding()
            
                VStack{
                    Text("Descripción del Problema")
                        .foregroundStyle(.white)
                    
                    ZStack(alignment: .leading) {
                        if description.isEmpty {
                            Text("Describe el daño (ej. grafiti, doblada, etc)...")
                                .foregroundStyle(Color.white.opacity(0.6))
                                .padding(.horizontal, 15)
                        }
                        TextField("", text: $description)
                            .foregroundStyle(.white)
                            .tint(.white)
                            .padding()
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(15)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
                            )
                    }
                }.padding()
                
                VStack{
                    Text("Evidencia Visual")
                        .foregroundStyle(.white)
                    
                    HStack(spacing: 40){
                        PhotosPicker(selection: $selectedItem, matching: .images){
                            Rectangle()
                                .fill(Color.white.opacity(0.1))
                                .frame(width: 150, height: 150)
                                .overlay(
                                    VStack {
                                        Image(systemName: "camera")
                                            .font(.system(size: 30))
                                            .foregroundColor(.white)
                                            .padding(.bottom, 8)
                                        
                                        Text("Agregar Foto")
                                            .font(.subheadline)
                                            .foregroundStyle(Color.white)
                                    }
                                )
                        }.cornerRadius(15)
                        
                        ZStack {
                            Rectangle()
                                .fill(Color.white.opacity(0.1))
                            
                            if let firstImage = selectedImages.first {
                                Image(uiImage: firstImage)
                                    .resizable()
                                    .scaledToFill()
                            } else {
                                VStack(spacing: 8) {
                                    Image(systemName: "photo")
                                        .font(.system(size: 30))
                                        .foregroundColor(.white.opacity(0.7))
                                    
                                    Text("Vista previa")
                                        .font(.subheadline)
                                        .foregroundStyle(Color.white.opacity(0.7))
                                }
                            }
                        }
                        .frame(width: 150, height: 150)
                        .clipped()
                        .cornerRadius(15)

                    }
                }.padding()
                
                VStack{
                    
                    MapCard().padding(.bottom, 10)
                    
                    Button {
                        
                    } label: {
                        HStack{
                            Text("Enviar Reporte")
                                .foregroundStyle(Color.white)
                            Image(systemName: "paperplane")
                                .foregroundStyle(Color.white)
                        }
                    }
                    .padding(10)
                    .frame(height: 50)
                    .background(Color.blue)
                    .cornerRadius(12)
                }.padding(.horizontal)
            }
        }
        .ignoresSafeArea()
        .task(id: selectedItem) {
            await loadSelectedImages()
        }
    }
    
    private func loadSelectedImages() async {
        var loadedImages: [UIImage] = []
        
        for item in selectedItem {
            if let data = try? await item.loadTransferable(type: Data.self),
               let image = UIImage(data: data) {
                loadedImages.append(image)
            }
        }
        
        selectedImages = loadedImages
    }
}

#Preview {
    ReportsView()
}
