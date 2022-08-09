//
//  ViewModel.swift
//  your-pret
//
//  Created by Frank Anderson on 8/2/22.
//

import Foundation
import CloudKit

enum PretStatus {
    case p1, p2
}

class ViewModel: ObservableObject {
    @Published var status: PretStatus
    @Published var lastUpdate: Date
    
    init() {
        self.status = .p1
        self.lastUpdate = Date()
    }
    
    init(status: PretStatus, lastUpdate: Date) {
        self.status = status
        self.lastUpdate = lastUpdate
    }
    
    func toggleStatus() {
        if status == .p1 {
            status = .p2
        } else if status == .p2 {
            status = .p1
        }
    }
}
