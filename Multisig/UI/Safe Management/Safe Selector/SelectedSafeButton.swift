//
//  SelectedSafeButton.swift
//  Multisig
//
//  Created by Dmitry Bespalov on 06.05.20.
//  Copyright © 2020 Gnosis Ltd. All rights reserved.
//

import SwiftUI

struct SelectedSafeButton: View {

    @Binding var showsSafeInfo: Bool
    
    @FetchRequest(fetchRequest: Safe.fetchRequest().selected())
    var selected: FetchedResults<Safe>

    var body: some View {
        Button(action: { self.showsSafeInfo.toggle() }) {
            if selected.first == nil {
                notSelectedView
            } else {
                SafeCell(safe: selected.first!)
            }
            Spacer()
        }
        .frameForNavigationBar()
        .disabled(selected.first == nil)
    }

    var notSelectedView: some View {
        HStack {
            Image("safe-selector-not-selected-icon")
                .resizable()
                .renderingMode(.original)
                .frame(width: 36, height: 36)

            Text("No Safe loaded")
                .font(Font.gnoBody.weight(.semibold))
                .foregroundColor(Color.gnoMediumGrey)
        }
    }

}
