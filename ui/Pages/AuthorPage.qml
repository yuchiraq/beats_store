import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import Qt5Compat.GraphicalEffects

import "qrc:/ui/Cards"

Page {
    id: authorService
    anchors.fill: parent

    property string author_cover: ""
    property int author_id: 0

    property string author_name: ""

    property int albums_q: 0
    property int tracks_q: 0

    Rectangle {
        anchors.fill: parent
        color: darkest
    }

    Image {
        id: authorCover
        source: authorService.author_cover
        width: parent.width
        height: width
        fillMode: Image.PreserveAspectFit
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
    }

    BusyIndicator {
        running: authorCover.status === Image.Loading
        anchors.centerIn: authorCover
    }

    Flickable {
        contentHeight: authorTop.height + authorContent.height
        anchors.fill: parent
        anchors.topMargin: 0
        anchors.bottomMargin: bottomBar.height

        Rectangle {
            id: authorTop
            color: "transparent"
            height: parent.width
            anchors.top: authorService.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: authorContent
            //anchors.bottomMargin: -blockMargin * 2
        }

        DropShadow {
            anchors.fill: authorAuthor
            transparentBorder: true
            horizontalOffset: -2
            verticalOffset: 2
            radius: 4
            color: "#a0000000"
            source: authorAuthor
        }

        Text {
            id: authorName
            anchors {
                bottom: authorContent.top
                bottomMargin: blockMargin
                horizontalCenter: parent.horizontalCenter
            }

            text: author_name
            color: secondary

            font {
                family: appFont
                pointSize: blockMargin * 2
            }
        }

        DropShadow {
            anchors.fill: authorName
            transparentBorder: true
            horizontalOffset: -2
            verticalOffset: 2
            radius: 4
            color: "#a0000000"
            source: authorName
        }

        Text {
            id: authorData
            anchors {
                bottom: albumAuthor.top

                horizontalCenter: parent.horizontalCenter
            }

            text: authorService.albums_q + " albums • " + authorService.tracks_q + " audio"
            color: accent

            font {
                family: appFont
                pointSize: blockMargin * 2.5
                bold: true
            }
        }

        Rectangle {
            id: authorContent
            width: parent.width
            radius: blockMargin * 2
            height: database.getQuantity(
                        ) * (blockMargin * 7 + 0.5) + blockMargin * 2 + 4 + blockMargin * 30

            anchors.top: authorTop.bottom

            anchors.horizontalCenter: parent.horizontalCenter

            color: darkest

            Rectangle {
                id: topLineAuthor

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

            Rectangle {
                id: authorInfoBlock

                color: dark

                anchors {
                    top: topLineAuthor.bottom
                    topMargin: blockMargin
                    horizontalCenter: parent.horizontalCenter
                }

                width: parent.width - blockMargin * 2

                height: blockMargin * 9

                Rectangle {
                    anchors {
                        top: parent.top
                        topMargin: blockMargin
                        left: parent.left
                        leftMargin: blockMargin
                    }

                    radius: blockMargin
                    border.color: outline
                    border.width: 0.5
                    color: dark

                    Text {
                        text: "Об авторе"
                        font.pointSize: blockMargin * 1.3
                        font.family: appFont
                        color: secondary

                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                    }
                }

                Text {
                    id: authorInfoText
                    text: "hgsadggG JHSDhjad hdbashdbahj da hJDSahbshajbdasjhbdhjfbhdsf"
                    anchors {
                        top: parent.top
                        topMargin: blockMargin * 4
                    }
                }
            }
        }
    }
}
