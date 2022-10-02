//
//  Array+Ext.swift
//  BarberVip
//
//  Created by Leonardo Portes on 30/09/22.
//

import UIKit

extension Array {
    func chunkedElements(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
