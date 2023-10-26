
import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI
import UniformTypeIdentifiers

public struct RecoveryWalletView: View {
   
  
    @State var isShowOrHideTextOf12Seed  = true
    @State var string12SeedText = ""
    public init() {
        
    }
    
    public var body: some View{
        NavigationView {
            //Choose View
            VStack(alignment: .center) {
                Text("Recovery Your Wallet from 12 seed words").font(.title)
                HStack{
                    Text("Secret Recovery Words")
                    Spacer()
                    //nut show và hide các từ seeds mà user nhập vào
                    Button(action: {
                        
                        
                    }) {
                        VStack {
                            Text(isShowOrHideTextOf12Seed ? "Show" : "Hide")
                        }
                        .padding()
                        .accentColor(Color(.systemBlue))
                    }
                }
                HStack{
                    TextField("Enter your 12 seeds separated by spaces", text: $string12SeedText)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 100)
                }
               
            }
            .padding(.bottom,10)
            
        }
        //
    }
    
    
    
    
}//end struct

