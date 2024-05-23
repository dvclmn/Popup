//
//  PopupHandler.swift
//  Eucalypt
//
//  Created by Dave Coleman on 24/3/2024.
//
//
//  PopupMessageView.swift
//  Eucalypt
//
//  Created by Dave Coleman on 5/2/2024.
//

import SwiftUI
import Styles

public struct PopupView: View {
    
    @ObservedObject var popup: PopupHandler
    
    let rounding: Double
    let topOffset: Double
    
    let maxWidth: Double = 240
    let minWidth: Double = 180
    
    
    public init(
        rounding: Double = Styles.roundingMedium,
        topOffset: Double = 22,
        popup: PopupHandler
    ) {
        self.rounding = rounding
        self.topOffset = topOffset
        self.popup = popup
    }
    
    public var body: some View {
        
        if let popup = popup.popupMessage {
            
            VStack(spacing: 6) {
                if popup.isLoading {
                    PopupLoadingIndicatorView()
                } else {
                    let markdownTitle = try! AttributedString(markdown: popup.title)
                    
                    Text(markdownTitle)
                        .foregroundStyle(.primary)
                        .fontWeight(.medium)
                    
                    if let message = popup.message {
                        
                        let markdownMessage = try! AttributedString(markdown: message)
                        
                        Text(markdownMessage)
                            .foregroundStyle(.secondary)
                            .font(.caption)
                            
                    } // END popup showing check
                    
                } // END loading check
            } // END vstack
            .multilineTextAlignment(.leading)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.horizontal, 20)
            .padding(.top, 13)
            .padding(.bottom, 15)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: rounding)
                        .fill(.ultraThinMaterial)
                }
            )
            .padding(.top, topOffset)
            .transition(.opacity)
            .frame(minWidth: minWidth, maxWidth: maxWidth)
        } // END popup showing check
    }
}

//#Preview("Popup message") {
//
//    PopupMessageView(rounding: 10, loadingView: )
//#if os(macOS)
//        .frame(width: 500, height: 400)
//        .background(Swatch.darkGrey.colour)
//#endif
//
//}
