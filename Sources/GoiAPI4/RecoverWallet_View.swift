
import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI
import UniformTypeIdentifiers

public struct RecoverWallet_View: View {
   
    
    @State var string12SeedText = ""
   @State var isPassInput12Seed = false
    @State var isPassOldWalletView = false
    
    @Binding var isUserPassRecoveryWalletby12Seed:Bool
    @Binding var wallNewName:String
 
    
    public init(isUserPassRecoveryWalletby12Seed:Binding<Bool>, wallNewName:Binding<String>) {
        self._isUserPassRecoveryWalletby12Seed = isUserPassRecoveryWalletby12Seed
        self._wallNewName = wallNewName

    }
    
    public var body: some View{
       
        //mới vô hiện view cho user nhập 12 từ hoặc scan qr
        if(self.isPassOldWalletView == false){
            //view nhập 12 từ vào
            if (self.isPassInput12Seed == false){
                
                
                //text editor cho phep user nhập 12 từ và che dấu khi cần
                Input12SeedsView(isPassInput12Seed: $isPassInput12Seed,
                                 text: $string12SeedText,
                                 textHide: "", bkt: "", titleKey: "Enter your 12-seed phrase, separated by spaces")
                
                
                
                
            }//end if
            
            //nếu user pass nhập đúng 12 từ thì show tiếp OldWalletView
            if (self.isPassInput12Seed == true){
                OldWalletView(string12SeedText: $string12SeedText,
                              isPassOldWalletView: $isPassOldWalletView,
                              wallNewName: $wallNewName, isPassInput12Seed: $isPassInput12Seed)
            }//end if
        }
        
        
        //nếu user pass view tạo lại ví củ thì cho nhập passcode
        if(self.isPassOldWalletView == true){
            PasscodeView_ConfirmPIN(textAskUserDo: "Enter PIN Number for your wallet",
                                    walletName:  $wallNewName,
                                    isUserPassRecoveryWalletby12Seed: $isUserPassRecoveryWalletby12Seed)
        }
       
    }//end body
    
    
    
    
}//end struct


