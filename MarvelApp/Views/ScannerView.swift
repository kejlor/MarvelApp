//
//  ScannerView.swift
//  MarvelApp
//
//  Created by Bartosz Wojtkowiak on 22/06/2023.
//

import SwiftUI
import CodeScanner

struct ScannerView: View {
    @EnvironmentObject var scannerVM: ScannerViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack(alignment: .center) {
                    CodeScannerView(codeTypes: [.qr]) { response in
                        switch response {
                        case .success(let success):
                            Task {
                                scannerVM.lastQrCode = success.string
                                dismiss()
                            }
                        case .failure(let failure):
                            print(failure)
                        }
                    }
                    QRRectangle()
                }
            }
            .onAppear {
                scannerVM.lastQrCode = ""
            }
        }
    }
}

struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView()
            .environmentObject(ScannerViewModel())
    }
}
