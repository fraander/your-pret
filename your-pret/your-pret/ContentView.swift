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
    @State private var offset: CGSize = .zero
    
    var bg: some View {
        if vm.status == .p1 {
            return Color.pretRed
        } else {
            return Color.white
        }
    }
    
    var sliderBg: some View {
        Capsule()
            .fill(vm.status == .p1 ? Color.white : Color.pretRed)
            .padding(20)
    }
    
    var sliderSwitch: some View {
        Circle()
            .fill(vm.status == .p1 ? Color.pretRed : Color.white)
            .padding(.horizontal, 30)
            .padding(.vertical, 40)
    }
    
    var timeAgoText: some View {
        Text("\(vm.timeSince)")
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(vm.status == .p1 ? Color.white : Color.pretRed)
    }
    
    var timeSpecificText: some View {
        Text("10:35am")
            .font(.title2)
            .italic()
            .foregroundColor(vm.status == .p1 ? Color.white : Color.pretRed)
    }
    
    // TODO: things ...
    /**
     * 1. hook up to cloudkit model
     * 1.5. time updating and toggle working
     * 3. fix gesture animation (weird end behavior) -- possibly use subviews and their frames to do this
     * 4. remove geometry reader --  -- possibly use subviews and their frames to do this
     * 5. fix drag out of bounds
     */
    
    var body: some View {
        VStack {
            
            ZStack {
                bg
                    .ignoresSafeArea()
                
                GeometryReader { geo in
                    ZStack(alignment: vm.status == .p1 ? .top : .bottom) {
                        sliderBg
                        
                        Button {
                            toggleStatus()
                        } label: {
                            ZStack(alignment: .center) {
                                sliderSwitch
                                
                                VStack {
                                    
                                    timeAgoText
                                    
                                    timeSpecificText
                                }
                            }
                            .offset(x: 0, y: self.offset.height)
                        }
                    }
                    .buttonStyle(.plain)
                    .animation(Animation.easeInOut, value: offset)
                    
                    .highPriorityGesture(
                        DragGesture()
                            .onChanged { gesture in
                                offset = gesture.translation
                                
                                // TODO: prevent drag out of bounds
                            }
                            .onEnded { _ in
                                if abs(offset.height) > geo.size.height / 4 {
                                    toggleStatus()
                                    offset = .zero
                                        // TODO: replace with containerWidth environment value if this is a thing that exists
                                } else {
                                    offset = .zero
                                }
                            }
                    )
                }
            }
        }
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
