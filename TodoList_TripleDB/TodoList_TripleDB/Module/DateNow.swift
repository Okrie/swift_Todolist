//
//  DateNow.swift
//  TodoList_TripleDB
//
//  Using What Time is it now
//  return ex "2023-09-02"
//
//  Created by Okrie on 2023/09/02.
//

import Foundation

func dateNow() -> String{
    let now = Date()

    let date = DateFormatter()
    date.locale = Locale(identifier: "ko_kr")
    date.timeZone = TimeZone(abbreviation: "KST") // "2023-08-27 18:07:27"
    date.dateFormat = "yyyyMMddHHmm"

    let kr = date.string(from: now)
    print(kr)
    return kr
}
