
import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI
import UniformTypeIdentifiers

public struct RecoveryWalletView: View {
   
  
    @State var isShowOrHideTextOf12Seed  = false
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
                        isShowOrHideTextOf12Seed.toggle()
                        
                    }) {
                        VStack {
                            Text(isShowOrHideTextOf12Seed ? "Hide" : "Show")
                        }
                        .padding()
                        .accentColor(Color(.systemBlue))
                    }
                }
                HStack{
                    if isShowOrHideTextOf12Seed == true {
                        TextField("Enter your 12 seeds separated by spaces", text: $string12SeedText)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 100)
                            .foregroundColor(Color.white)
                            .background(Color.gray)
                            .cornerRadius(5)
                    } else {
                        SecureField("Enter your 12 seeds separated by spaces", text: $string12SeedText)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 100)
                            .foregroundColor(Color.white)
                            .background(Color.gray)
                            .cornerRadius(5)
                    }
                  
                }
               
            }
            .padding(.bottom,10)
            
        }
        //
    }
    
    
    
    
}//end struct

