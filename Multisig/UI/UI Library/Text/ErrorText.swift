//
//  ErrorText.swift
//  Multisig
//
//  Created by Dmitry Bespalov on 04.05.20.
//  Copyright © 2020 Gnosis Ltd. All rights reserved.
//

import SwiftUI

struct ErrorText: View {

    var label: String

    init(_ label: String) {
        self.label = label
    }

    var body: some View {
        Text(label)
            .font(Font.gnoCallout)
            .foregroundColor(Color.gnoTomato)
            .padding(.trailing)
            .padding(.top, 12)
    }
}

struct ErrorText_Previews: PreviewProvider {
    static var previews: some View {
        ErrorText("Error message")
    }
}
