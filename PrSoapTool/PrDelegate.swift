//
//  PrDelegate.swift
//  PrSoapTool
//
//  Created by iOS Papiroom on 27/01/15.
//  Authors : Gökhan Çokkeçeci,Eren Çelik
//  Copyright (c) 2015 Papiroom. All rights reserved.
//

import Foundation

protocol PrDelegate
{
    func onPreExecute()
    func onPostExecute(response: String)
}
