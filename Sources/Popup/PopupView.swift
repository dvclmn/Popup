//
//  PopupHandler.swift
//  Eucalypt
//
//  Created by Dave Coleman on 24/3/2024.
//

import Foundation
import SwiftUI

struct PopupMessage {
    var isLoading: Bool = false
    var title: String
    var message: String?
}

@Observable
public class PopupHandler {
    
    public static let shared = PopupHandler()
    
    public init() {} // Private initializer to prevent external instantiation
    
    var message: PopupMessage? = nil
    
    private var popupTask: Task<Void, Never>? = nil
    
    func showPopup(title: String, message: String? = nil) {
        let popupMessage = PopupMessage(isLoading: false, title: title, message: message)
        Task {
            await showAndHidePopup(popupMessage: popupMessage)
        }
    }
    
    private func showAndHidePopup(popupMessage: PopupMessage) async {
        popupTask?.cancel()
        print("Popup triggered: \(popupMessage.title)")
        
        popupTask = Task { [weak self] in
            await self?.displayPopup(popupMessage: popupMessage)
            
            do {
                try await Task.sleep(for: .seconds(2.5))
            } catch {
                return
            }
            
            await self?.hidePopup()
        }
    } // END show hide popup
    
    private func displayPopup(popupMessage: PopupMessage) async {
        await MainActor.run {
            withAnimation(.easeOut(duration: 0.1)) {
                self.message = popupMessage
            }
        }
    }
    
    private func hidePopup() async {
        await MainActor.run {
            withAnimation(.easeInOut(duration: 0.6)) {
                self.message = nil
            }
        }
    }
}
