//
//  PlaceHolderExtension.swift
//  receiptOCR
//
//  Created by user on 11/1/23.
//

import Foundation
import SwiftUI

struct PlaceHolderField: View {
    private let titleKey: LocalizedStringKey
    private let font: Font?
    private let color: Color?
    private let align: Alignment
    
    @Binding private var text: String
    
    init(_ titleKey: LocalizedStringKey /*도움말*/, font: Font? = nil /*내용과 폰트를 다르게 하고 싶다면 입력*/, color: Color? = nil /*내용과 색을 다르게 하고 싶다면 입력*/, align: Alignment = .leading /*정렬*/, text: Binding<String> /*내용*/) {
        self.titleKey = titleKey
        self.font = font
        self.color = color
        self._text = text
        self.align = align
    }
    
    var body: some View {
        TextField("", text: $text)
            .background(
                Text(text.isEmpty ? titleKey : "")
                    .modifier(FontModifier(font: font))
                    .modifier(ColorModifier(color: color))
                , alignment: align)
    }
    
    struct FontModifier: ViewModifier {
        let font: Font?
        
        func body(content: Content) -> some View {
            if font == nil {
                content
            }
            else {
                content
                    .font(font)
            }
        }
    }
    
    struct ColorModifier: ViewModifier {
        let color: Color?
        
        func body(content: Content) -> some View {
            if color == nil {
                content
            }
            else {
                content
                    .foregroundColor(color)
            }
        }
    }
}

struct PlaceHolderField2: View {
    private let titleKey: LocalizedStringKey
    private let font: Font?
    private let color: Color?
    private let align: Alignment
    
    @Binding private var text: String
    
    init(_ titleKey: LocalizedStringKey /*도움말*/, font: Font? = nil /*내용과 폰트를 다르게 하고 싶다면 입력*/, color: Color? = nil /*내용과 색을 다르게 하고 싶다면 입력*/, align: Alignment = .leading /*정렬*/, text: Binding<String> /*내용*/) {
        self.titleKey = titleKey
        self.font = font
        self.color = color
        self._text = text
        self.align = align
    }
    
    var body: some View {
        SecureField("", text: $text)
            .background(
                Text(text.isEmpty ? titleKey : "")
                    .modifier(FontModifier(font: font))
                    .modifier(ColorModifier(color: color))
                , alignment: align)
            
    }
    
    struct FontModifier: ViewModifier {
        let font: Font?
        
        func body(content: Content) -> some View {
            if font == nil {
                content
            }
            else {
                content
                    .font(font)
            }
        }
    }
    
    struct ColorModifier: ViewModifier {
        let color: Color?
        
        func body(content: Content) -> some View {
            if color == nil {
                content
            }
            else {
                content
                    .foregroundColor(color)
            }
        }
    }
}

