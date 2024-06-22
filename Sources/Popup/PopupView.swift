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

public struct PopupView: View {
    
    @ObservedObject var popup: PopupHandler
    
    let locationID: String
    let rounding: Double
    let topOffset: Double
    let isCompact: Bool
    
    let maxWidth: Double = 240
    let minWidth: Double = 180
    
    public init(
        locationID: String = "main",
        rounding: Double = 10,
        topOffset: Double = 22,
        isCompact: Bool = false,
        popup: PopupHandler
    ) {
        self.locationID = locationID
        self.rounding = rounding
        self.topOffset = topOffset
        self.isCompact = isCompact
        self.popup = popup
    }
    
    public var body: some View {
        
        
        if let message = popup.popupMessage, self.locationID == message.locationID {
            
            
            Popup(message)
            
        }
        
    }
}

extension PopupView {
    @ViewBuilder
    func Popup(_ message: PopupMessage) -> some View {
        VStack(spacing: isCompact ? 4 : 6) {
            if message.isLoading {
                PopupLoadingIndicatorView()
            } else {
                let markdownTitle = try! AttributedString(markdown: message.title)
                
                Text(markdownTitle)
                    .foregroundStyle(.primary.opacity( isCompact ? 0.8 : 1.0))
                    .font(.system(size: isCompact ? 11 : 14))
                    .fontWeight(.medium)
                
                if let message = message.message {
                    
                    let markdownMessage = try! AttributedString(markdown: message)
                    
                    Text(markdownMessage)
                        .foregroundStyle(.secondary)
                        .font(.caption)
                    
                } // END popup showing check
                
            } // END loading check
        } // END vstack
        .multilineTextAlignment(.leading)
        .fixedSize(horizontal: false, vertical: true)
        .padding(.horizontal, isCompact ? 12 : 20)
        .padding(.top, isCompact ? 8 : 13)
        .padding(.bottom, isCompact ? 10 : 15)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: rounding)
                    .fill(.ultraThinMaterial)
            }
        )
        //            .padding(10)
        .padding(.top, topOffset)
        .transition(.opacity)
        //            .frame(minWidth: minWidth, maxWidth: maxWidth)
    }
}

#Preview("Popup message") {
    
    RoundedRectangle(cornerRadius: 12)
        .fill(.red.opacity(0.2))
        .overlay(alignment: .topTrailing) {
            PopupView(
                isCompact: true,
                popup: PopupHandler(message: PopupMessage(
                    title: "Hello, it's a message")
                )
            )
        }
        .padding()
#if os(macOS)
        .frame(width: 500, height: 400)
        .background(.black.opacity(0.4))
#endif
    
}
