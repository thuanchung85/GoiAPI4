
import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI
import UniformTypeIdentifiers

public struct RecoveryWalletView: View {
   
  
   
    @State var string12SeedText = ""
   
    
    public init() {
        
    }
    
    public var body: some View{
        NavigationView {
            //Choose View
            VStack(alignment: .center) {
                Text("Recovery Your Wallet from 12 seed words").font(.title)
              
                Text("Secret Recovery Words")
                   
                HStack{
                    HybridTextField(text: $string12SeedText, titleKey: "Enter your 12 seeds separated by spaces")
                       
                   
                  
                }
               
            }
            .padding(.bottom,10)
            
        }
        //
    }
    
    
    
    
}//end struct


