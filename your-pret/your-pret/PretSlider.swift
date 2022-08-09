//
//  PretSlider.swift
//  your-pret
//
//  Created by Frank Anderson on 8/9/22.
//

import SwiftUI

struct PretSlider: View {
    
    @EnvironmentObject var vm: ViewModel
    @State private var offset: CGSize = .zero
    
    var sliderBg: some View {
        Capsule()
            .fill(vm.status == .p1 ? Color.white : Color.pretRed)
            .padding(20)
            .animation(Animation.easeInOut, value: offset)
    }
    
    var sliderSwitch: some View {
        Circle()
            .fill(vm.status == .p1 ? Color.pretRed : Color.white)
            .padding(.horizontal, 40)
            .padding(.vertical, 40)
    }
    
    var timeAgoText: some View {
        Text(vm.lastUpdate, style: .relative)
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(vm.status == .p1 ? Color.white : Color.pretRed)
    }
    
    var timeSpecificText: some View {
        Text(vm.lastUpdate, style: .time)
            .font(.title2)
            .italic()
            .foregroundColor(vm.status == .p1 ? Color.white : Color.pretRed)
    }
    
    var readyText: some View {
        Group {
            if Date().timeIntervalSince(vm.lastUpdate) > 30 * 60 {
                return Text("It's Pret time!")
            } else {
                return Text("Not yet ready.")
            }
        }
        .font(.system(size: 16, weight: .regular, design: .monospaced))
        .foregroundColor(vm.status == .p1 ? Color.secondary : Color.white.opacity(0.8))
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: vm.status == .p1 ? .top : .bottom) {
                sliderBg
                    .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 0)
                    .overlay {
                        readyText
                            .padding(.vertical, 180)
                            .frame(maxHeight: .infinity, alignment: vm.status == .p1 ? .bottom : .top)
                            .animation(.none, value: vm.status)
                    }
                
                Button {
                    withAnimation { vm.toggleStatus() }
                } label: {
                    ZStack(alignment: .center) {
                        sliderSwitch
                            .shadow(color: Color.black, radius: 4, x: 0, y: 0)
                            .animation(Animation.easeInOut, value: offset)
                        
                        VStack {
                            
                            timeAgoText
                            
                            timeSpecificText
                        }
                        .offset(x: 0, y: -self.offset.height)
                    }
                    .offset(x: 0, y: self.offset.height)
                }
            }
            .buttonStyle(.plain)
            .highPriorityGesture(
                DragGesture()
                    .onChanged { gesture in
                        if vm.status == .p1 {
                            if gesture.translation.height > 0
                                && gesture.translation.height < geo.size.height / 2 {
                                offset = gesture.translation
                            }
                        }
                        
                        if vm.status == .p2 {
                            if gesture.translation.height < 0
                                && gesture.translation.height > -geo.size.height / 2 {
                                offset = gesture.translation
                            }
                        }
                        
                        // TODO: prevent drag out of bounds
                    }
                    .onEnded { _ in
                        if abs(offset.height) > geo.size.height / 4 {
                            vm.toggleStatus()
                            offset = .zero
                        } else {
                            offset = .zero
                        }
                    }
            )
        }
    }
}

struct PretSlider_Previews: PreviewProvider {
    static var previews: some View {
        PretSlider()
            .environmentObject(ViewModel())
            .padding()
            .background(Color.gray)
    }
}
