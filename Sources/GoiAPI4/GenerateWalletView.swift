
import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI
import UniformTypeIdentifiers


public struct GenerateWalletView: View {
   
  
   
    @State var string12SeedText = ""
   
    
    public init() {
        
    }
    
    public var body: some View{
        NavigationView {
            //Choose View
            VStack(alignment: .center) {
                Text("THIS IS YOUR WALLET").font(.title)
                
                
            }
            .onAppear(){
                var myWallet = Wallet()
                let recoverString = "salt multiply enemy burger exit machine apart science agree foot often absent buddy zoo comfort fantasy dune hip night pride reveal tide neither civil"
                let HDWallet_1_recover_Data = myWallet.recover_HDWallet_BIP32_with12Words(with12Words: recoverString, newName: "KhoiPhuc_CHUNGWALLET")
               
            }
            
        }
        //
    }
    
    
    
    
}//end struct


