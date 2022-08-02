//
//  ContentView.swift
//  your-pret
//
//  Created by Frank Anderson on 8/2/22.
//

import SwiftUI

extension Color {
    static var pretRed = Color(hue: Double(349/360), saturation: 0.81, brightness: 0.51)
}

enum PretStatus {
    case p1, p2
}

struct ContentView: View {
    @State var status: PretStatus = .p1
    @State private var offset: CGSize = .zero
    
    var bg: some View {
        if status == .p1 {
            return Color.pretRed
        } else {
            return Color.white
        }
    }
    
    // TODO: things ...
    /**
     * 1. hook up to cloudkit model
     * 1.5. time updating and toggle working
     * 2. check ios15 compliance
     * 3. fix gesture animation
     * 4. big refactor
     */
    
    var body: some View {
        VStack {
            
            ZStack {
                bg
                    .ignoresSafeArea()
                
                GeometryReader { geo in
                    ZStack(alignment: status == .p1 ? .top : .bottom) {
                        Capsule()
                            .fill(status == .p1 ? Color.white : Color.pretRed)
                            .padding(20)
                        
                        Button {
                            toggleStatus()
                        } label: {
                            ZStack {
                                Circle()
                                    .fill(status == .p1 ? Color.pretRed : Color.white)
                                    .frame(width: geo.size.width - 60)
                                    .padding(.vertical, 40)
                                
                                VStack(alignment: .center) {
                                    Text("24 minutes ago")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(status == .p1 ? Color.white : Color.pretRed)

                                    Text("10:35am")
                                        .font(.title2)
                                        .italic()
                                        .foregroundColor(status == .p1 ? Color.white : Color.pretRed)
                                }
                            }
                        }
                        .buttonStyle(.plain)
                        .animation(Animation.easeInOut, value: offset)
                        .offset(x: 0, y: self.offset.height)
                        .highPriorityGesture(
                            DragGesture()
                                .onChanged { gesture in
                                    offset = gesture.translation
                                }
                                .onEnded { _ in
                                    if abs(offset.height) > geo.size.height / 4 {
                                        toggleStatus()
                                        offset = .zero
                                    } else {
                                        offset = .zero
                                    }
                                }
                        )
                    }
                }
            }
        }
    }
    
    func toggleStatus() {
        withAnimation {
            if status == .p1 {
                status = .p2
            } else if status == .p2 {
                status = .p1
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
