//
//  APITest.swift
//  Orderman
//
//  Created by kimjunseong on 2020/12/03.
//

import Foundation

class APITest {
    func test() {
        let model = EPOS2_TM_M30.rawValue
        let japanese = EPOS2_LANG_JA.rawValue
        let printer = Epos2Printer(printerSeries: model, lang: japanese)
        let feedPosition = (printer?.addFeedPosition(EPOS2_FEED_CUTTING.rawValue))
        print(feedPosition ?? "error")
    }
}
