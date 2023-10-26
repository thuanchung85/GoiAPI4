
import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI
import UniformTypeIdentifiers

public struct RecoveryWalletView: View {
   
  
   
    @State var string12SeedText = ""
   @State var isPassInput12Seed = false
    
    public init() {
        
    }
    
    public var body: some View{
     
            //Choose View
            VStack(alignment: .center) {
                Text("Recovery Your Wallet from 12 seed words").font(.title)
              
                Text("Enter your 12 seeds separated by spaces:")
                
                //text editor cho phep user nhập 12 từ và che dấu khi cần
                HStack{
                    TextEditorInput12SeedsView(isPassInput12Seed: $isPassInput12Seed,text: $string12SeedText, textHide: "", bkt: "", titleKey: "Enter your 12 seeds separated by spaces")
                       
                }
               
                //nut next tơi view tiếp theo genegate lại ví củ theo 12 từ
                //===nút đi tới recovery wallet view của gói API 4===//
                if(isPassInput12Seed == true){
                    NavigationLink(destination:  GenerateWalletView())
                    {
                        Text("Get Wallet")
                            .foregroundColor(.white)
                            .padding(12)
                        
                    }
                    .background(Color.black)
                    .cornerRadius(12)
                }
            }
            .padding(.bottom,10)
            
       
    }
    
    
    
    
}//end struct


