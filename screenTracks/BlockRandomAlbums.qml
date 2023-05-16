import QtQuick 2.15
//import QtGraphicalEffects 1.15
import Qt5Compat.GraphicalEffects
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3

import "qrc:/cards"

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

    clip: true

    GaussianBlur {
        source: randomAlbumsFlicable
        anchors.fill: randomAlbumsFlicable
        radius: 16
        samples: 16
        transparentBorder: true
        opacity: 0.5

        visible: false
    }

    Text {
        id: headerRandomAlbums

        font.family: appFont
        color: secondary

        text: "<b>Альбомы</b>"
        anchors {
            top: parent.top
            topMargin: blockMargin
            left: parent.left
            leftMargin: blockMargin
        }
        font.pointSize: blockMargin * 1.3
    }

    ComboBox {
        id: blockRandomAlbumsStyleButton

        anchors {
            verticalCenter: headerRandomAlbums.verticalCenter
            right: parent.right
            rightMargin: blockMargin
        }

        background: Rectangle {
            height: blockMargin * 1.6
            width: 60
            radius: blockMargin
            border.color: outline
            border.width: 0.5
            color: dark
        }

        delegate: Text {

            id: randomAlbumsSelectorText
            text: modelData
            font.pointSize: blockMargin * 1.3
            font.family: appFont
            color: secondary

            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 10
        }

        indicator: Image {
            source: "qrc:/ui_icons/basic/angle-small-right.svg"
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 10

            rotation: 90
            height: parent.height
            width: height

            ColorOverlay {
                source: parent
                color: secondary
                anchors.fill: parent
            }
        }

        width: 60
        height: blockMargin * 1.6

        //width: randomAlbumsSelectorText.width + height + 20
        model: ["Trap", "R\&B", "Rock", "Rap", "Drill", "Pop"]

        //        onClicked: {
        //            styleChooser.styleFor = 3
        //            console.log("Clicked!!!!!")
        //            styleChooser.starter()
        //        }
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
                cover: "http://" + ip + "/coversMini/1.jpg"
            }

            AlbumMiniCard {
                style: "Boss design"
                author: "Chiraq Concept"
                cover: "http://" + ip + "/coversMini/2.jpg"
            }

            AlbumMiniCard {
                style: "Shit"
                author: "ogbogtoy"
                cover: "http://" + ip + "/coversMini/3.jpg"
            }

            AlbumMiniCard {
                style: "Shit"
                title: "ogbogdsalkdsald toykjadiojdajdosad"
                cover: "http://" + ip + "/coversMini/4.jpg"
            }
            AlbumMiniCard {
                cover: "http://" + ip + "/coversMini/5.jpg"
            }
            AlbumMiniCard {
                style: "Music"
                title: "162 pack 2"
                author: "Niki-Y On Da Track"
                cover: "http://" + ip + "/coversMini/6.jpg"
            }
            AlbumMiniCard {
                style: "Music"
                title: "CLASSIC PACK III"
                author: "Niki-Y On Da Track"
                cover: "http://" + ip + "/coversMini/7.jpg"
            }
            AlbumMiniCard {
                cover: "http://" + ip + "/coversMini/13.jpg"
            }
            AlbumMiniCard {}
        }
    }
}
