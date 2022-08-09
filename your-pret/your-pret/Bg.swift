//
//  Bg.swift
//  your-pret
//
//  Created by Frank Anderson on 8/9/22.
//

import SwiftUI

struct Bg: View {
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        Group {
            VStack {
                if vm.status == .p1 {
                    Color.pretRed
                } else {
                    Color.white
                }
            }
            .ignoresSafeArea()
        }
    }
}

struct Bg_Previews: PreviewProvider {
    static var previews: some View {
        Bg()
    }
}
