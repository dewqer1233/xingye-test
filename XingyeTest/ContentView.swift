import SwiftUI
import UIKit

struct ContentView: View {
    @State private var count = 0
    @State private var tapTimes: [Date] = []

    private var deviceInfo: [(String, String)] {
        var list: [(String, String)] = []
        let device = UIDevice.current
        list.append(("设备名称", device.name))
        list.append(("机型", device.model))
        list.append(("系统", "iOS \(device.systemVersion)"))
        let screen = UIScreen.main.bounds
        list.append(("屏幕", String(format: "%.0f × %.0f pt", screen.width, screen.height)))
        list.append(("缩放", String(format: "%.2fx", UIScreen.main.scale)))
        list.append(("侧载状态", "✅ 签名运行成功"))
        return list
    }

    var body: some View {
        VStack(spacing: 24) {
            // 顶部标题
            VStack(spacing: 6) {
                Text("星野测试")
                    .font(.system(size: 34, weight: .bold, design: .rounded))
                Text("iOS 侧载链路验证 App")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.top, 40)

            Spacer()

            // 计数器
            VStack(spacing: 12) {
                Text("\(count)")
                    .font(.system(size: 88, weight: .bold, design: .rounded))
                    .foregroundColor(count > 0 ? .orange : .primary)
                    .animation(.default, value: count)

                Button {
                    count += 1
                    tapTimes.append(Date())
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                } label: {
                    Text("点我 +1")
                        .font(.headline)
                        .frame(width: 160, height: 56)
                        .background(
                            Capsule().fill(
                                LinearGradient(colors: [.blue, .purple],
                                               startPoint: .leading, endPoint: .trailing))
                        )
                        .foregroundColor(.white)
                }
                .buttonStyle(.plain)

                Button("重置") {
                    count = 0
                    tapTimes.removeAll()
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                .disabled(count == 0)
            }

            Spacer()

            // 设备信息
            VStack(alignment: .leading, spacing: 10) {
                Text("设备信息")
                    .font(.footnote.weight(.semibold))
                    .foregroundColor(.secondary)
                ForEach(deviceInfo, id: \.0) { row in
                    HStack {
                        Text(row.0)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text(row.1)
                            .fontWeight(.medium)
                            .lineLimit(1)
                    }
                    .font(.footnote)
                }
            }
            .padding(16)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.secondarySystemBackground))
            )
            .padding(.horizontal, 20)

            Text("此 App 通过 Sideloadly + 免费 Apple ID 侧载")
                .font(.caption2)
                .foregroundColor(Color(.tertiaryLabel))
                .padding(.bottom, 24)
        }
    }
}
