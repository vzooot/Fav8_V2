//
//  StationButtonView.swift
//  Fav8
//
//  Created by Administrator on 12/6/22.
//

import AVFoundation
import SwiftUI

struct StationButtonView: View {
    @State var isPlaying: Bool = false
    let buttonColor: Color = .init(
        #colorLiteral(red: 0.1326819658, green: 0.1122616902, blue: 0.1552955806, alpha: 1))
    let playPauseColor: Color = .init(
        #colorLiteral(red: 0.6461197734, green: 0.1092272475, blue: 0.2935471833, alpha: 1))
    @State var station: RadioStation
    @State var player = AVPlayer()
    @State var playerItem: AVPlayerItem!

    var body: some View {
        HStack(spacing: 10) {
            HStack {
                Text(station.name)
                    .foregroundColor(.white)
                Spacer()

                Button {
                    if isPlaying {
                        stop(url: station.url)
                        isPlaying = false

                    } else {
                        play(url: station.url)
                        isPlaying = true
                    }
                } label: {
                    Image(systemName: isPlaying ? "stop.fill" : "play.fill")
                        .foregroundColor(.white)
                }
            }
            .padding(10)
        }
        .frame(maxWidth: .infinity, maxHeight: 40)
        .background(buttonColor)
        .cornerRadius(20)
        .padding([.horizontal, .top], 20)
    }

    func play(url: String) {
        isPlaying.toggle()
        guard let url = URL(string: url) else { return }
        let playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        player.play()
    }

    func stop(url: String) {
        isPlaying.toggle()
        player.pause()
    }
}

struct StationButtonView_Previews: PreviewProvider {
    static var previews: some View {
        StationButtonView(isPlaying: false, station: RadioStation(name: "name", url: "url"))
    }
}
