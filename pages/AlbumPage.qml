import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import Qt5Compat.GraphicalEffects

//import QtGraphicalEffects 1.15
import "../cards"
import "qrc:/primitive"

Page {
    id: albumService
    anchors.fill: parent

    property string album_cover: ""
    property int album_id: 0

    property string album_title: ""
    property string album_author: ""

    Rectangle {
        anchors.fill: parent
        color: surface
    }

    Image {
        id: albumCover
        source: albumService.album_cover
        width: parent.width
        height: width
        fillMode: Image.PreserveAspectFit
        anchors.top: parent.top
        anchors.topMargin: topBar.height
        anchors.horizontalCenter: parent.horizontalCenter
    }

    BusyIndicator {
        running: albumCover.status === Image.Loading
        anchors.centerIn: albumCover
    }

    Flickable {
        contentHeight: albumTop.height + albumContent.height
        anchors.fill: parent
        anchors.topMargin: 0
        anchors.bottomMargin: bottomBar.height

        Rectangle {
            id: albumTop
            color: "transparent"
            height: parent.width + topBar.height
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: albumContent
            //anchors.bottomMargin: -blockMargin * 2
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
                bottom: albumContent.top
                bottomMargin: blockMargin
                horizontalCenter: parent.horizontalCenter
            }

            text: album_author
            color: secondary

            font {
                //family: appFont
                pointSize: blockMargin * 2
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
                //family: appFont
                pointSize: blockMargin * 2.5
                bold: true
            }
        }

        Rectangle {
            id: albumContent
            width: parent.width
            radius: blockMargin * 2

            anchors.top: albumTop.bottom

            anchors.horizontalCenter: parent.horizontalCenter

            color: surface

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
        }
    }
}
