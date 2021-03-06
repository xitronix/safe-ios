//
//  Identicon.swift
//  Multisig
//
//  Created by Dmitry Bespalov on 16.04.20.
//  Copyright © 2020 Gnosis Ltd. All rights reserved.
//

import SwiftUI
import UIKit
import BlockiesSwift

struct Identicon: View {

    private let blockSize: CGFloat = 8

    private var text: String?

    init(_ text: String?) {
        self.text = text
    }

    var body: some View {
        ZStack {
            if text == nil || text!.isEmpty {
                placeholder
            } else {
                blockyImage
            }
        }

    }

    var placeholder: some View {
        Circle().foregroundColor(Color.gnoLightGrey)
    }

    var blockyImage: some View {
        GeometryReader { geometry in
            Image(uiImage: self.blocky(geometry.size))
            .renderingMode(.original)
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .clipShape(Circle())
        }
    }


    func blocky(_ size: CGSize) -> UIImage {
        Blockies(
            seed: text,
            size: Int(blockSize),
            scale: Int(min(size.width, size.height) / blockSize)
        ).createImage()!
    }
}

struct Identicon_Previews: PreviewProvider {
    static var previews: some View {
        Identicon("Hello").frame(width: 32)
    }
}
