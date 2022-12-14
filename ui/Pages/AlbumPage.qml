import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import Qt5Compat.GraphicalEffects

import "qrc:/ui/Cards"

Page {
    id: albumService
    anchors.fill: parent

    property string album_cover: ""
    property int album_id: 0

    property string album_title: ""
    property string album_author: ""

    Rectangle {
        anchors.fill: parent
        color: darkest
    }

    Image {
        id: albumCover
        source: albumService.album_cover
        width: parent.width
        height: width
        fillMode: Image.PreserveAspectFit
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
    }

    DropShadow {
        anchors.fill: albumAuthor
        transparentBorder: true
        horizontalOffset: -2
        verticalOffset: 2
        radius: 4
        color: "#a0000000"
        source: albumAuthor
    }

    Text {
        id: albumAuthor
        anchors {
            bottom: albumCover.bottom
            bottomMargin: blockMargin * 2 + blockMargin
            horizontalCenter: parent.horizontalCenter
        }

        text: album_author
        color: secondary

        font {
            family: appFont
            pointSize: blockMargin * 2.5
        }
    }

    DropShadow {
        anchors.fill: albumTitle
        transparentBorder: true
        horizontalOffset: -2
        verticalOffset: 2
        radius: 4
        color: "#a0000000"
        source: albumTitle
    }

    Text {
        id: albumTitle
        anchors {
            bottom: albumAuthor.top

            horizontalCenter: parent.horizontalCenter
        }

        text: album_title
        color: accent

        font {
            family: appFont
            pointSize: blockMargin * 2.5
            bold: true
        }
    }

    Flickable {
        contentHeight: albumTop.height + albumContent.height
        anchors.fill: parent
        anchors.topMargin: 0
        anchors.bottomMargin: bottomBar.height

        Rectangle {
            id: albumTop
            color: "transparent"
            height: albumCover.height - blockMargin * 2
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Rectangle {
            id: albumContent
            width: parent.width
            radius: blockMargin * 2
            height: database.getQuantity(
                        ) * (blockMargin * 7 + 0.5) + blockMargin * 2 + 4 + blockMargin * 30

            anchors.top: albumTop.bottom
            //anchors.topMargin: albumCover.height - blockMargin * 2
            anchors.horizontalCenter: parent.horizontalCenter

            color: darkest

            Rectangle {
                id: topLineAlbum

                width: 80
                height: 4

                color: accent

                radius: 2

                anchors {
                    top: parent.top
                    topMargin: blockMargin
                    horizontalCenter: parent.horizontalCenter
                }
            }

            ListView {
                id: lastRealises

                model: lastRealisesModel
                anchors.top: topLineAlbum.bottom
                anchors.topMargin: blockMargin
                anchors.right: parent.right
                anchors.left: parent.left
                height: database.getQuantity() * (blockMargin * 7 + 0.5)

                delegate: Item {
                    id: lastRealise
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width - blockMargin
                    height: lastRealiseBeat.height + 0.5

                    BeatLine {
                        id: lastRealiseBeat
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: parent.width
                        title: Title
                        author: albumPage.album_author
                        timeSec: TimeSec
                        id_track: id_db
                        cover: albumPage.album_cover
                    }

                    Rectangle {
                        width: parent.width
                        height: 0.5
                        color: outline
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: lastRealiseBeat.bottom
                    }
                }
            }
        }
    }
}
