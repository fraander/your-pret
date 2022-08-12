//
//  Color.swift
//  your-pret
//
//  Created by Frank Anderson on 8/9/22.
//

import SwiftUI

extension Color {
    static var pretRed = Color(hue: Double(349/360), saturation: 0.81, brightness: 0.51)
}

struct Color_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            RoundedRectangle(cornerRadius: 20.0)
                .fill(Color.pretRed)
            
            RoundedRectangle(cornerRadius: 20.0)
                .fill(Color.secondary)
            
            
        }
        .padding()
        .shadow(radius: 8)
        .ignoresSafeArea()
        .previewLayout(.sizeThatFits)
    }
}
