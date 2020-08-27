//
//  LoadingView.swift
//  Mukja
//
//  Created by Daniel Kim on 8/24/20.
//  Copyright © 2020 Daniel Kim. All rights reserved.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            LottieView(filename: "30180-calendar-icon")
                .frame(width: 200, height: 200)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
