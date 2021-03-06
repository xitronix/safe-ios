//
//  SafeCell.swift
//  Multisig
//
//  Created by Dmitry Bespalov on 27.04.20.
//  Copyright © 2020 Gnosis Ltd. All rights reserved.
//

import SwiftUI

struct SafeCell: View {

    @ObservedObject
    var safe: Safe

    var iconSize: CGFloat = 36
    var iconToTextSpacing: CGFloat = 12
    var nameToAddressPadding: CGFloat = 0


    var body: some View {
        HStack(spacing: iconToTextSpacing) {
            Identicon(safe.address ?? "")
                .frame(width: iconSize, height: iconSize)

            VStack(alignment: .leading) {
                BoldText(safe.name ?? "")
                    .lineLimit(1)

                AddressText(safe.address ?? "", style: .short)
                    .font(Font.gnoBody.weight(.medium))
            }
        }
    }
}

struct SafeCell_Previews: PreviewProvider {

    static var safe: Safe {
        let s = Safe()
        s.name = "My Safe"
        s.address = "0x34CfAC646f301356fAa8B21e94227e3583Fe3F5F"
        return s
    }

    static var previews: some View {
        SafeCell(safe: safe)
    }
}
