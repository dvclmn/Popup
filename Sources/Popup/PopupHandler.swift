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

struct PopupMessageView: View {
    
    var body: some View {
        
        if let popup = PopupHandler.shared.message {
            
            VStack(spacing: 6) {
                if popup.isLoading {
                    LoadingIndicatorView()
                } else {
                    Group {
                        
                        Text(popup.title)
                                .foregroundStyle(.primary)
                                .fontWeight(.medium)
                        
                        if let message = popup.message {
                            Text(message)
                                .foregroundStyle(.secondary)
                                .font(.caption)
                        } // END popup showing check
                    } // END group
                    .frame(maxWidth: 160)
                } // END loading check
            } // END vstack
            .multilineTextAlignment(.center)
            .padding(.horizontal, 20)
            .padding(.top, 13)
            .padding(.bottom, 14)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: Rounding.large.value)
                        .fill(.ultraThinMaterial)
                }
            )
            .padding(.top)
            .transition(.opacity)
        } // END popup showing check
    }
}

#Preview("Popup message") {
    
    PopupMessageView()
        
        .environment(ImportHandler())
#if os(macOS)
        .frame(width: 500, height: 400)
        .background(.contentBackground)
#endif

}
