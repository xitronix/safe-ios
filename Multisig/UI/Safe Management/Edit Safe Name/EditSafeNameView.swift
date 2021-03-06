//
//  EditSafeNameView.swift
//  Multisig
//
//  Created by Moaaz on 5/4/20.
//  Copyright © 2020 Gnosis Ltd. All rights reserved.
//

import SwiftUI
import CoreData

struct EditSafeNameView: View {
    @Environment(\.presentationMode)
    var presentationMode: Binding<PresentationMode>
    
    @FetchRequest(fetchRequest: Safe.fetchRequest().selected())
    var selectedSafe: FetchedResults<Safe>
    
    @State
    var updateID = UUID()
    var didSave = NotificationCenter.default
        .publisher(for: .NSManagedObjectContextDidSave,
                   object: CoreDataStack.shared.viewContext)
        .receive(on: RunLoop.main)

    @State
    var safe: Safe?
    
    @ObservedObject
    var model: EditSafeNameViewModel

    init(address: String, name: String) {
        model = EditSafeNameViewModel(address: address, name: name)
    }

    var body: some View {
        VStack(spacing: 24) {
            VStack(alignment: .leading) {
                RoundedTextField(title: "Enter name",
                            text: $model.enteredText,
                            isValid: $model.isValid,
                            onEditingChanged: { ended in
                                if !ended {
                                    self.model.onEditing()
                                }
                            },
                            onCommit: submit)
                ErrorText(model.error)
            }

            Spacer()
        }
        .padding(.top, 24)
        .padding(.horizontal)
        .navigationBarTitle("Edit Safe Name", displayMode: .inline)
        .navigationBarItems(trailing: saveButton)
    }

    var saveButton: some View {
        Button("Save", action: submit)
            .barButton(disabled: model.isValid != true &&
                model.enteredText != safe?.name)
    }

    func submit() {
        guard model.isValid == true else { return }
        model.submit()
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct EditSafeNameView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EditSafeNameView(address: "0x34CfAC646f301356fAa8B21e94227e3583Fe3F5F", name: "Safe")
        }
    }
}
