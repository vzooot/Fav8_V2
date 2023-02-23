//
//  ErrorModal.swift
//  Fav8
//
//  Created by Administrator on 1/16/23.
//

import SwiftUI

struct ErrorModal: View {
    let shadowColor: Color = .init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5))
    let textColor: Color = .init(#colorLiteral(red: 0.1080646291, green: 0.116887562, blue: 0.1296843588, alpha: 1))
    let errorColor: Color = .init(#colorLiteral(red: 0.6461197734, green: 0.1092272475, blue: 0.2935471833, alpha: 1))

    var errorMsg: String = ""

    var body: some View {
        ZStack {
            VStack {
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 36))
                    .foregroundColor(errorColor)
                    .padding(.vertical, 10)

                Text(errorMsg)
                    .padding([.bottom, .horizontal], 20)
            }

            .frame(minWidth: UIScreen.main.bounds.width/2, minHeight: UIScreen.main.bounds.width/4)
            .background(.white)
            .foregroundColor(textColor)
            .cornerRadius(10)
            .shadow(color: shadowColor, radius: 5, x: 5, y: 5)
        }
    }
}

// struct ErrorModal_Previews: PreviewProvider {
//    static var previews: some View {
//        ErrorModal()
//    }
// }
