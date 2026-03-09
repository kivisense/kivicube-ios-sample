//
//  ContentView.swift
//  Kivicube
//
//  Created by Seth li on 2025/12/5.
//

import SwiftUI

struct ContentView: View {
    @State private var sceneId = "zIUkUZDrNp2HDDf562A2zS2v85uCcWJE"
    @State private var collectionId = "hw5xqx"
    @State private var isShowingWebView = false
    @State private var targetURL: URL?

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Kivicube")
                    .font(.title)
                    .fontWeight(.bold)

                VStack(alignment: .leading, spacing: 10) {
                    Text("Scene ID")
                        .font(.headline)
                        .foregroundColor(.secondary)

                    HStack {
                        TextField("Please enter 32-character scene ID", text: $sceneId)
                            .textFieldStyle(.roundedBorder)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                            .onChange(of: sceneId) { _, newValue in
                                sceneId = String(newValue.prefix(32))
                            }

                        if !sceneId.isEmpty {
                            Button {
                                sceneId = ""
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)

                Button {
                    if validSceneId() {
                        targetURL = buildSceneURL()
                        isShowingWebView = true
                    }
                } label: {
                    Text("Open Kivicube Scene")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .disabled(!validSceneId())
                .padding(.horizontal, 20)

                VStack(alignment: .leading, spacing: 10) {
                    Text("Collection ID")
                        .font(.headline)
                        .foregroundColor(.secondary)

                    HStack {
                        TextField("Please enter 6-character collection ID", text: $collectionId)
                            .textFieldStyle(.roundedBorder)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                            .onChange(of: collectionId) { _, newValue in
                                collectionId = String(newValue.prefix(6))
                            }

                        if !collectionId.isEmpty {
                            Button {
                                collectionId = ""
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)

                Button {
                    if validCollectionId() {
                        targetURL = buildCollectionURL()
                        isShowingWebView = true
                    }
                } label: {
                    Text("Open Kivicube Collection")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                .disabled(!validCollectionId())
                .padding(.horizontal, 20)

                Spacer()
            }
            .padding()
            .navigationDestination(isPresented: $isShowingWebView) {
                if let url = targetURL {
                    WebViewContainer(url: url)
                        .edgesIgnoringSafeArea(.bottom)
                }
            }
        }
    }

    private func validSceneId() -> Bool {
        return sceneId.count == 32 && !sceneId.trimmingCharacters(in: .whitespaces).isEmpty
    }

    private func validCollectionId() -> Bool {
        return collectionId.count == 6 && !collectionId.trimmingCharacters(in: .whitespaces).isEmpty
    }

    private func buildSceneURL() -> URL {
        let urlString = "https://www.kivicube.com/scenes/\(sceneId)"
        return URL(string: urlString)!
    }

    private func buildCollectionURL() -> URL {
        let urlString = "https://www.kivicube.com/collections/\(collectionId)"
        return URL(string: urlString)!
    }
}

#Preview {
    ContentView()
}
