//
//  ScannerView.swift
//  MarvelApp
//
//  Created by Bartosz Wojtkowiak on 22/06/2023.
//

import SwiftUI

struct ScannerView: View {
    @ObservedObject var scannerVM = ScannerViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack(alignment: .center) {
                    QrCodeScannerView()
                        .found(r: self.scannerVM.onFoundQrCode)
                        .torchLight(isOn: self.scannerVM.torchIsOn)
                        .interval(delay: self.scannerVM.scanInterval)
                        .padding()
                    
                    QRRectangle()
                }
                
                Button {
                    self.scannerVM.torchIsOn.toggle()
                } label: {
                    Image(systemName: self.scannerVM.torchIsOn ? "bolt.fill" : "bolt.slash.fill")
                        .foregroundColor(.black)
                        .imageScale(.large)
                }
                
                Button {
                    scannerVM.lastQrCode = "323"
                    Task {
                        await scannerVM.onFoundQrCode("323")
                    }
                } label: {
                    Text("Do something")
                }
            }
            .onReceive(scannerVM.$isDisplayingSheet) { isDisplayingSheet in
                if isDisplayingSheet {
                    dismiss()
                }
            }
        }
    }
}

struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView()
    }
}
