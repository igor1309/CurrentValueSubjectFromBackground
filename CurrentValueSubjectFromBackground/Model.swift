//
//  Model.swift
//  CurrentValueSubjectFromBackground
//
//  Created by Igor Malyarov on 23.03.2023.
//

import Combine
import Foundation

final class Model {
    
    let action: CurrentValueSubject<String, Never> = .init("")
    
    private var cancellables = Set<AnyCancellable>()
    
    init () {
        
        Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .map(\.timeIntervalSinceReferenceDate)
            .receive(on: DispatchQueue.global())
            .sink { [weak self] in
                
                self?.action.send("\($0)")
            }
            .store(in: &cancellables)
    }
}
