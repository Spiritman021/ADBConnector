import SwiftUI

struct ContentView: View {
    @State private var pairIP = UserDefaults.standard.string(forKey: "pairIP") ?? ""
    @State private var pairCode = UserDefaults.standard.string(forKey: "pairCode") ?? ""
    @State private var connectIP = UserDefaults.standard.string(forKey: "connectIP") ?? ""
    @State private var statusLog = ""
    @State private var isPaired = false
    @State private var showPairCode = false

    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 15) {
                Text("ADB Wireless Manager").font(.title2).bold()

                Group {
                    Text("🔗 Pair Device")
                        .font(.headline)

                    TextField("ADB Pair IP:Port", text: $pairIP)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onChange(of: pairIP) { UserDefaults.standard.set(pairIP, forKey: "pairIP") }

                    ZStack(alignment: .trailing) {
                        if showPairCode {
                            TextField("Pair Code", text: $pairCode)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .onChange(of: pairCode) { UserDefaults.standard.set(pairCode, forKey: "pairCode") }
                        } else {
                            SecureField("Pair Code", text: $pairCode)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .onChange(of: pairCode) { UserDefaults.standard.set(pairCode, forKey: "pairCode") }
                        }

                        Button(action: {
                            showPairCode.toggle()
                        }) {
                            Image(systemName: showPairCode ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(.gray)
                        }
                        .padding(.trailing, 8)
                    }

                    Button("Pair Device") {
                        pairDevice()
                    }
                }

                Divider().padding(.vertical, 10)

                Group {
                    Text("📡 Connect Device")
                        .font(.headline)

                    TextField("ADB Connect IP:Port", text: $connectIP)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onChange(of: connectIP) { UserDefaults.standard.set(connectIP, forKey: "connectIP") }

                    Button("Connect Device") {
                        connectDevice()
                    }
                }

                Spacer()
            }
            .frame(width: 300)
            .padding()

            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("📝 Status Log:")
                        .font(.headline)
                    Spacer()
                    Button("Clear") {
                        statusLog = ""
                    }
                    .foregroundColor(.red)
                }

                ScrollView {
                    Text(statusLog)
                        .font(.system(.body, design: .monospaced))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(5)
                }
                .border(Color.gray)
            }
            .frame(minWidth: 350, maxHeight: .infinity)
            .padding()
        }
        .frame(width: 700, height: 400)
    }

    // MARK: - Pair Logic
    func pairDevice() {
        statusLog += "👉 Pairing with \(pairIP)...\n"
        let output = runCommand(args: ["pair", pairIP, pairCode])

        statusLog += output

        if output.contains("Successfully paired") {
            isPaired = true
            statusLog += "✅ Device Paired Successfully!\n"
        } else {
            isPaired = false
            statusLog += "❌ Pairing Failed. Check IP & Code.\n"
        }
    }

    // MARK: - Connect Logic
    func connectDevice() {
        statusLog += "👉 Connecting to \(connectIP)...\n"
        let output = runCommand(args: ["connect", connectIP])

        statusLog += output

        if output.contains("connected to") {
            statusLog += "✅ Connected Successfully!\n"
        } else {
            statusLog += "❌ Connection Failed. Check IP.\n"
        }
    }

    // MARK: - Run Terminal Command
    func runCommand(args: [String]) -> String {
        let process = Process()
        process.launchPath = "/opt/homebrew/bin/adb"
        process.arguments = args

        let pipe = Pipe()
        process.standardOutput = pipe
        process.standardError = pipe

        do {
            try process.run()
        } catch {
            return "Failed to run adb: \(error.localizedDescription)\n"
        }

        process.waitUntilExit()
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        return String(decoding: data, as: UTF8.self) + "\n"
    }
}
