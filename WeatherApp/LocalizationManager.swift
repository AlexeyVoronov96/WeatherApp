//
//  LocalizationManager.swift
//  WeatherApp
//
//  Created by Алексей Воронов on 12/11/2018.
//  Copyright © 2018 Алексей Воронов. All rights reserved.
//

import Foundation

extension String {
    func localize() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
