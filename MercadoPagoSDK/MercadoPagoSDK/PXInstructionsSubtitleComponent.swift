//
//  PXInstructionsSubtitleComponent.swift
//  MercadoPagoSDK
//
//  Created by AUGUSTO COLLERONE ALFONSO on 11/15/17.
//  Copyright © 2017 MercadoPago. All rights reserved.
//

import Foundation

public class PXInstructionsSubtitleComponent: NSObject, PXComponetizable {
    var props: PXInstructionsSubtitleProps

    init(props: PXInstructionsSubtitleProps) {
        self.props = props
    }

    public func render() -> UIView {
        return PXInstructionsSubtitleRenderer().render(instructionsSubtitle: self)
    }
}
public class PXInstructionsSubtitleProps: NSObject {
    var subtitle: String
    init(subtitle: String) {
        self.subtitle = subtitle
    }
}
