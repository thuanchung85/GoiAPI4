
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
              
                Text("Enter your 12 seeds separated by spaces:")
                
                //text editor cho phep user nhập 12 từ và che dấu khi cần
                HStack{
                    HybridTextField(text: $string12SeedText, textHide: "", bkt: "", titleKey: "Enter your 12 seeds separated by spaces")
                       
                }
               
                //nut next
                Button(action: {
                   
                    
                }) {
                    VStack {
                        Text("NEXT").foregroundColor(Color.red)
                    }
                    .padding()
                    .accentColor(Color(.red))
                    .cornerRadius(4.0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4).stroke(Color(.systemBlue), lineWidth: 2)
                    )
                }
            }
            .padding(.bottom,10)
            
        }
        //
    }
    
    
    
    
}//end struct


