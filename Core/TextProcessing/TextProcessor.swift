//
//  TextProcessor.swift
//  echo
//
//  Created by Shivam Bhasin on 11/07/26.
//


protocol TextProcessor {

    func process(_ text: String) async throws -> String

}
