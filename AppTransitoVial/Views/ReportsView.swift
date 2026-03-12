//
//  ReportsView.swift
//  AppTransitoVial
//
//  Created by Alan Cervantes on 12/03/26.
//

import SwiftUI

struct ReportsView: View {
    
    @State private var selection: String = "Selecciona un tipo de señal"
    @State private var description: String = ""
    
    var body: some View {
        ZStack{
            Color(Color.background)
                .ignoresSafeArea()
            VStack{
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
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: 150, height: 150)
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: 150, height: 150)
                    }
                }.padding()
                
                VStack{
                    HStack {
                        Text("Ubicacion del Incidente")
                            .foregroundStyle(Color.white)
                        Spacer()
                        HStack{
                            Image(systemName: "mappin.and.ellipse")
                                .font(.system(size: 20))
                                .foregroundStyle(Color.blue)
                            
                            Text("Mi ubicación")
                                .foregroundStyle(Color.blue)
                        }
                    }
                    
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: .infinity, height: 150)
                        .padding(.bottom, 20)
                    
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
                    .frame(width: .infinity, height: 50)
                    .background(Color.blue)
                    .cornerRadius(12)
                }.padding()
            }
        }.ignoresSafeArea()
    }
}



#Preview {
    ReportsView()
}
