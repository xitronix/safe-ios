//
//  EnterSafeNameViewModel.swift
//  Multisig
//
//  Created by Dmitry Bespalov on 24.04.20.
//  Copyright © 2020 Gnosis Ltd. All rights reserved.
//

import Foundation
import Combine

class EditSafeNameViewModel: ObservableObject {

    @Published
    var enteredText: String = ""

    @Published
    var isValid: Bool?

    @Published
    var error: String = ""

    var address: String

    private var subscribers = Set<AnyCancellable>()

    init(address: String, name: String) {
        self.address = address
        self.enteredText = name
        
        $enteredText
            .dropFirst()
            .map { value -> String in
                value.trimmingCharacters(in: .whitespacesAndNewlines)
            }
            .sink { value in
                self.isValid = !value.isEmpty
                self.error = self.isValid == false ? "Name must not be empty" : ""
            }
            .store(in: &subscribers)
    }

    func onEditing() {
        self.isValid = enteredText.isEmpty ? nil : true
    }

    func submit() {
        guard isValid == true else { return }
        Safe.edit(address: address, name: enteredText)
    }

}
