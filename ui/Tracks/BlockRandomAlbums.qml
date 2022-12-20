import QtQuick 2.15
//import QtGraphicalEffects 1.15
import Qt5Compat.GraphicalEffects
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3

import "qrc:/ui/Cards"

Rectangle {
    id: blockRandomAlbums

    width: mainScreen.width - (blockMargin * 2)
    height: headerRandomAlbums.height + blockMargin * 2 + blockMargin + blockMargin * 15
    //radius: width / 20
    radius: blockMargin * 1.5
    //color: "#00333333"
    color: dark

    border.color: outline
    border.width: 0.5

    Text {
        id: headerRandomAlbums

        font.family: appFont
        color: light

        text: "<b>Альбомы</b>"
        anchors {
            top: parent.top
            topMargin: blockMargin
            left: parent.left
            leftMargin: blockMargin
        }
        font.pointSize: blockMargin * 1.3
    }

    Button {
        id: blockRandomAlbumsStyleButton

        anchors {
            verticalCenter: headerRandomAlbums.verticalCenter
            right: parent.right
            rightMargin: blockMargin
        }

        background: Rectangle {
            anchors.fill: parent
            radius: blockMargin
            border.color: outline
            border.width: 0.5
            color: dark

            Text {

                id: randomAlbumsSelectorText
                text: "Случайные"
                font.pointSize: blockMargin * 1.3
                font.family: appFont
                color: light

                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 10
            }

            Image {
                source: "qrc:/png/interface/next.png"
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 10

                rotation: 90
                height: parent.height / 2
                width: height
            }
        }

        height: blockMargin * 1.6
        width: randomAlbumsSelectorText.width + height + 20

        onClicked: {
            styleChooser.styleFor = 3
            console.log("Clicked!!!!!")
            styleChooser.starter()
        }
    }

    Flickable {
        id: randomAlbumsFlicable

        contentWidth: AlbumMiniCard.width * 8 + blockMargin * 7
        anchors {
            top: headerRandomAlbums.bottom
            topMargin: blockMargin
            left: parent.left
            right: parent.right
            leftMargin: 1
            rightMargin: 1
        }

        clip: true

        width: parent.width - 2
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
                cover: "qrc:/png/temp/covers/2.png"
            }

            AlbumMiniCard {
                style: "Boss design"
                author: "Chiraq Concept"
                cover: "qrc:/png/temp/covers/balenciaga.jpg"
            }

            AlbumMiniCard {
                style: "Shit"
                author: "ogbogtoy"
                cover: "qrc:/png/temp/covers/cover.jpg"
            }

            AlbumMiniCard {
                style: "Shit"
                title: "ogbogdsalkdsald toykjadiojdajdosad"
                cover: "qrc:/png/temp/covers/PLINOFFICIAL - Cocaina80%.jpg"
            }
            AlbumMiniCard {
                cover: "qrc:/png/temp/covers/trap-no-hook.jpg"
            }
            AlbumMiniCard {}
            AlbumMiniCard {}
            AlbumMiniCard {}
            AlbumMiniCard {}
        }
    }
}
