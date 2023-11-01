
import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI
import UniformTypeIdentifiers
import web3swift
import Web3Core
//==========LOADING VIEW========///
struct ActivityIndicator: UIViewRepresentable {

    @Binding var isAnimating: Bool
    
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
struct LoadingView<Content>: View where Content: View {

    @Binding var addressWallet: String
    @Binding var isStillLoadingWallet:Bool
    @State var string12SeedText:String
    @Binding var isShowing: Bool
    var content: () -> Content

    var body: some View {
        GeometryReader { geometry in
            //VStack(alignment: .center) {
                ZStack(alignment: .center) {
                    
                    self.content()
                        .disabled(self.isShowing)
                        .blur(radius: self.isShowing ? 3 : 0)
                        
                    VStack(alignment: .center) {
                        Text("Recover Wallet...")
                        ActivityIndicator(isAnimating: .constant(true), style: .large)
                    }
                    .frame(width: geometry.size.width / 2,
                           height: geometry.size.height / 5)
                    .background(Color.secondary.colorInvert())
                    .foregroundColor(Color.primary)
                    .cornerRadius(20)
                    .opacity(self.isShowing ? 1 : 0)
                    .padding(.horizontal)
                    
                }
                //genegater 12 từ
                .onAppear(){
                    
                    DispatchQueue.global(qos: .userInteractive).async {
                        //let myWallet = Wallet()
                        var recoverString = self.string12SeedText
                        if (recoverString.last == " ")
                        {
                            recoverString.removeLast()
                        }
                        //let HDWallet_1_recover_Data = myWallet.recover_HDWallet_BIP32_with12Words(with12Words: recoverString, newName: "KhoiPhuc_CHUNGWALLET")
                        
                       
                        do{
                            let keystore = try? BIP32Keystore(mnemonics: recoverString, password: "", mnemonicsPassword: "")
                            if let k = keystore  {
                                
                                let pkey = try? k.UNSAFE_getPrivateKeyData(password: "", account: (keystore?.addresses?.first)!).toHexString()
                                let privateKey = "0x"+(pkey ?? "no pkey")
                                UserDefaults.standard.set( self.addressWallet, forKey: "PoolsWallet_addressWallet")
                                self.addressWallet = (keystore?.addresses?.first)!.address
                                print(self.addressWallet)
                                print("pkey :\(privateKey)")
                                let data = Data(privateKey.utf8)
                                //save privakey vao keychain
                                keychain_save(data, service: "PoolsWallet_\(self.addressWallet)_PKey", account: self.addressWallet)
                            }
                           
                            
                        }catch{
                            print("12 seeds ERROR can not make keystore")
                        }
                       
                        
                        self.isStillLoadingWallet = false
                        
                       
                    }
                    
                }
            //}
            //.frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

}
