
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
                    CustomSecureField(password: $string12SeedText)
                       
                   
                  
                }
               
            }
            .padding(.bottom,10)
            
        }
        //
    }
    
    
    
    
}//end struct


