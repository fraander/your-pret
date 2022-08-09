//
//  Bg.swift
//  your-pret
//
//  Created by Frank Anderson on 8/9/22.
//

import SwiftUI

struct Bg: View {
    @EnvironmentObject var vm: ViewModel
    @Namespace var namespace
    
    var body: some View {
        
        Group {
            VStack {
                if vm.status == .p1 {
                    Color.pretRed
                        .matchedGeometryEffect(id: "backgroundColor", in: namespace)
                } else {
                    Color.white
                        .matchedGeometryEffect(id: "backgroundColor", in: namespace)
                }
            }
            .ignoresSafeArea()
            .animation(.easeInOut, value: vm.status)
        }
    }
}

struct Bg_Previews: PreviewProvider {
    static var previews: some View {
        Bg()
            .environmentObject(ViewModel())
    }
}
