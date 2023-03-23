//
//  ContentView.swift
//  CurrentValueSubjectFromBackground
//
//  Created by Igor Malyarov on 23.03.2023.
//

import Combine
import SwiftUI

final class ContentViewModel: ObservableObject {
    
    @Published private(set) var mainString: String = ""
    @Published private(set) var backgroundString: String = ""
    
    private let model: Model
    
    init(model: Model) {
        
        self.model = model
        bind()
    }
    
    private func bind() {
        
        model.action
            .receive(on: DispatchQueue.main)
            .assign(to: &$mainString)
        
#warning("need `.receive(on: DispatchQueue.main)`")
        model.action
        //.receive(on: DispatchQueue.main)
            .assign(to: &$backgroundString)
    }
}

struct ContentView: View {
    
    @ObservedObject private var viewModel: ContentViewModel
    
    init(viewModel: ContentViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            
            Text(viewModel.mainString)
            Text(viewModel.backgroundString)
        }
        .padding()
    }
}

extension ContentView {
    
    static let preview: Self = .init(viewModel: .preview)
}

private extension ContentViewModel {
    
    static let preview: ContentViewModel = .init(model: .init())
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: .preview)
    }
}
