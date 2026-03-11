//
//  InfoCard.swift
//  AppTransitoVial
//
//  Created by Emanuel Perez Altuzar on 10/03/26.
//
import SwiftUI

struct InfoCard: View {
    var icon: String
    var title: String
    var subtitle: String
    var color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(color)
                .font(.title2)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .fontWeight(.bold)
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.white.opacity(0.05))
        .cornerRadius(20)
        .foregroundColor(.white)
    }
}
