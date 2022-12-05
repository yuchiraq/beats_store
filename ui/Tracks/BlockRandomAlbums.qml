import QtQuick 2.15
//import QtGraphicalEffects 1.15
import Qt5Compat.GraphicalEffects
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3

import "qrc:/ui/Cards"

Rectangle {
    id: blockRandomAlbums

    width: mainScreen.width - (blockMargin * 2)
    height: headerRandomAlbums.height + 20 + blockMargin + blockMargin * 9
    //radius: width / 20
    radius: blockMargin * 1.5
    //color: "#00333333"
    color: dark

    border.color: outline
    border.width: 0

    Text {
        id: headerRandomAlbums

        font.family: appFont
        color: light

        text: "<b>Альбомы</b>"
        anchors {
            top: parent.top
            topMargin: 10
            left: parent.left
            leftMargin: blockMargin * 2
        }
    }

    Flickable {
        id: randomAlbumsFlicable

        contentWidth: AlbumMiniCard.width * 8 + blockMargin * 7
        anchors {
            top: headerRandomAlbums.bottom
            topMargin: 10
            left: parent.left
            right: parent.right
        }

        clip: true

        width: parent.width
        height: parent.height - headerRandomAlbums.height - 20

        Row {
            id: randomAlbums
            anchors.fill: parent
            anchors.leftMargin: blockMargin
            anchors.rightMargin: blockMargin
            spacing: blockMargin

            AlbumMiniCard {
                title: "162 pack 2"
                style: "Trap/EDM"
                author: "Niki-Y On Da Track"
                cover: "qrc:/png/temp/authors/ava.png"
            }

            AlbumMiniCard {
                style: "Boss design"
                author: "Chiraq Concept"
                cover: "qrc:/png/temp/authors/cq.png"
            }

            AlbumMiniCard {
                style: "Shit"
                author: "ogbogtoy"
                cover: "qrc:/png/temp/covers/cover.jpg"
            }

            AlbumMiniCard {
                style: "Shit"
                title: "ogbogdsalkdsald toykjadiojdajdosad"
                cover: "qrc:/png/temp/covers/cover.jpg"
            }
            AlbumMiniCard {}
            AlbumMiniCard {}
            AlbumMiniCard {}
            AlbumMiniCard {}
            AlbumMiniCard {}
        }
    }


}
