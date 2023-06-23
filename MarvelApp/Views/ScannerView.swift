//
//  ScannerView.swift
//  MarvelApp
//
//  Created by Bartosz Wojtkowiak on 22/06/2023.
//

import SwiftUI

struct ScannerView: View {
    @ObservedObject var viewModel = ScannerViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            ZStack(alignment: .center) {
                QrCodeScannerView()
                    .found(r: self.viewModel.onFoundQrCode)
                    .torchLight(isOn: self.viewModel.torchIsOn)
                    .interval(delay: self.viewModel.scanInterval)
//                    .task {
//                        await viewModel.getDetailComics(for: viewModel.lastQrCode)
//                    }
                    .padding()
                
                QRRectangle()
            }
            
            Button {
                self.viewModel.torchIsOn.toggle()
            } label: {
                Image(systemName: self.viewModel.torchIsOn ? "bolt.fill" : "bolt.slash.fill")
                    .foregroundColor(.black)
                    .imageScale(.large)
            }
            
            Button {
                viewModel.lastQrCode = "323"
                Task {
                    await viewModel.getDetailComics(for:viewModel.lastQrCode)
//                    dismiss()
                }
            } label: {
                Text("Do something")
            }

        }
    }
}

struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView()
    }
}
