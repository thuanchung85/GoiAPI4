//
//  File.swift
//  GoiAPI2
//
//  Created by SWEET HOME (^0^)!!! on 20/10/2023.
//
import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI
import UniformTypeIdentifiers

public struct QRCodeMakerView: View {
   
    @Binding  var walletAddress:String
  
    
   
    
     var width:CGFloat?
     var height:CGFloat?
    
    public init( walletAddress: Binding<String>, width:CGFloat,  height:CGFloat) {
       
        self._walletAddress = walletAddress
       
        self.width = width
        self.height = height
    }
    
    public var body: some View{
        NavigationView{
         
            VStack() {
                Image(uiImage: generateQRCode(from: self.walletAddress))
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                
                Text("Wallet address: " + self.walletAddress)
                    .font(.body)
                
                Button {
                    print("Copy Button was tapped save to clipbroad")
                  
                    UIPasteboard.general.setValue(self.walletAddress,
                                                      forPasteboardType: UTType.plainText.identifier)
                   
                } label: {
                    Text("Copy!")
                        .font(.body)
                       
                }
            }
           
        }
    }
    
    
    func generateQRCode(from string:String)-> UIImage{
         let context = CIContext()
         let filter = CIFilter.qrCodeGenerator()
        filter.message = Data(string.utf8)
        
        if let outputImage = filter.outputImage{
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent){
                return UIImage(cgImage: cgImage)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
}//end struct

