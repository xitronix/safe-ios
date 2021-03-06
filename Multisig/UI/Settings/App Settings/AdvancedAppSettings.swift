//
//  AdvancedAppSettings.swift
//  Multisig
//
//  Created by Dmitry Bespalov on 15.05.20.
//  Copyright © 2020 Gnosis Ltd. All rights reserved.
//

import SwiftUI

struct AdvancedAppSettings: View {

    @ObservedObject
    var theme: Theme = App.shared.theme

    var body: some View {
        List {
            Section(header: SectionHeader("ENS RESOLVER ADDRESS")) {
                AddressCell(address: App.shared.ens.registryAddress.hex(eip55: true))
            }

            Section(header: SectionHeader("ENDPOINTS")) {
                KeyValueRow("RPC endpoint",
                            DisplayURL(App.shared.nodeService.url).absoluteString)
                KeyValueRow("Transaction service",
                            DisplayURL(App.shared.safeTransactionService.url).absoluteString)
            }
        }
        .onAppear {
            self.theme.setTemporaryTableViewBackground(nil)
        }
        .onDisappear {
            self.theme.resetTemporaryTableViewBackground()
        }
        .navigationBarTitle("Advanced", displayMode: .inline)
    }
}

struct AdvancedAppSettings_Previews: PreviewProvider {
    static var previews: some View {
        AdvancedAppSettings()
    }
}
