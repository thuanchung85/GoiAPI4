
import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI
import UniformTypeIdentifiers

public struct RecoverWallet_View: View {
   
    @State var isShow_OldWalletView:Bool = false
   
    @State var string12SeedText = ""
   @State var isPassInput12Seed = false
    @Binding var userPassRecoveryWalletby12Seed:Bool
    @Binding var wallNewName:String
    
    public init(userPassRecoveryWalletby12Seed:Binding<Bool>, wallNewName:Binding<String>) {
        self._userPassRecoveryWalletby12Seed = userPassRecoveryWalletby12Seed
        self._wallNewName = wallNewName
    }
    
    public var body: some View{
        ScrollView {
            //view nhập 12 từ vào
            if (self.isShow_OldWalletView == false){
                VStack(alignment: .center) {
                    Text("Recovery Your Wallet").font(.title)
                    
                    Text("Enter your 12 seeds separated by spaces:")
                    
                    //text editor cho phep user nhập 12 từ và che dấu khi cần
                    HStack{
                        Input12SeedsView(isPassInput12Seed: $isPassInput12Seed,
                                         text: $string12SeedText,
                                         textHide: "", bkt: "", titleKey: "Enter your 12 seeds separated by spaces")
                        
                    }
                 
                    
                    
                    
                }
                .padding(.bottom,10)
                
            }
            
            //nếu user pass nhập đúng 12 từ thì show tiếp OldWalletView
            if (self.isShow_OldWalletView == true){
                VStack(alignment: .center) {
                    OldWalletView(string12SeedText: $string12SeedText,
                                  userPassRecoveryWalletby12Seed: $userPassRecoveryWalletby12Seed,
                                  wallNewName: $wallNewName)
                }
            }
            
           
        }//end if
    }
    
    
    
    
}//end struct


