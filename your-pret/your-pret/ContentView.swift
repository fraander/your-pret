//
//  ContentView.swift
//  your-pret
//
//  Created by Frank Anderson on 8/2/22.
//

import SwiftUI
import CloudKit

struct ContentView: View {
    @StateObject var vm = ViewModel()
    
    // TODO: things ...
    /**
     * 1. hook up to cloudkit model
     */
    
    var body: some View {
        VStack {
            
            ZStack {
                Bg()
                
                PretSlider()
            }
        }
        .environmentObject(vm)
    }
    
    func toggleStatus() {
        withAnimation {
            vm.toggleStatus()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
