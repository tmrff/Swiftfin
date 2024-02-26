//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2024 Jellyfin & Jellyfin Contributors
//

import Introspect
import SwiftUI

private enum EyeIcon: String {
    case visible = "eye.fill"
    case invisible = "eye.slash.fill"
}

struct RevealableSecureField: View {

    let title: String

    @Binding
    var text: String

    @State
    private var isTextSecure: Bool = true

    private var currentEyeIcon: EyeIcon {
        isTextSecure ? .invisible : .visible
    }

    var body: some View {
        HStack {
            passwordInputField
            if !text.isEmpty {
                secureTextToggleButton
            }
        }
    }

    private var passwordInputField: some View {
        SecureField(title, text: $text)
            .introspectTextField { textField in
                textField.isSecureTextEntry = isTextSecure
            }
    }

    private var secureTextToggleButton: some View {
        Button(action: { isTextSecure.toggle() }) {
            Image(systemName: currentEyeIcon.rawValue)
                .foregroundColor(.accentColor)
        }
        .buttonStyle(.plain)
    }
}
