//
//   UserRespounse.swift
//  VK News
//
//  Created by Валентина Лучинович on 01.04.2022.
//

import Foundation

struct UserResponseWrapped: Decodable {
    let response: [UserRespounse]
}

struct UserRespounse: Decodable {
    let photo100: String?
}
