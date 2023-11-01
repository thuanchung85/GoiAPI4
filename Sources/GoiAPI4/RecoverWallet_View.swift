
import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI
import UniformTypeIdentifiers

public struct RecoverWallet_View: View {
    @Binding var isBack:Bool
    @Binding var isBack2:Bool
    
    @State var string12SeedText = ""
   @State var isPassInput12Seed = false
    @State var isPassOldWalletView = false
    
    @Binding var isUserPassRecoveryWalletby12Seed:Bool
    @Binding var wallNewName:String
    @Binding var wallAddress:String
    
    //==INIT===//
    public init(isUserPassRecoveryWalletby12Seed:Binding<Bool>, wallNewName:Binding<String>, wallAddress:Binding<String> ,isBack:Binding<Bool>, isBack2:Binding<Bool>) {
        self._isUserPassRecoveryWalletby12Seed = isUserPassRecoveryWalletby12Seed
        self._wallNewName = wallNewName
        self._wallAddress = wallAddress
        self._isBack = isBack
        self._isBack2 = isBack2
    }
    
    //===BODY==///
    public var body: some View{
       
        //mới vô hiện view cho user nhập 12 từ hoặc scan qr
        if(self.isPassOldWalletView == false){
            //view nhập 12 từ vào
            if (self.isPassInput12Seed == false){
                
                
                //text editor cho phep user nhập 12 từ và che dấu khi cần
                Input12SeedsView(isPassInput12Seed: $isPassInput12Seed,
                                 text: $string12SeedText,
                                 textHide: "", bkt: "", titleKey: "Enter your 12-seed phrase, separated by spaces",
                                 isBack:$isBack, isBack2: $isBack2)
                
                
                
                
            }//end if
            
            //nếu user pass nhập đúng 12 từ thì show tiếp OldWalletView
            if (self.isPassInput12Seed == true){
                OldWalletView(string12SeedText: $string12SeedText,
                              isPassOldWalletView: $isPassOldWalletView,
                              wallNewName: $wallNewName, wallAddress:$wallAddress,
                              isPassInput12Seed: $isPassInput12Seed)
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


