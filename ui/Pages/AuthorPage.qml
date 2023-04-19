import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import Qt5Compat.GraphicalEffects

import "qrc:/ui/Cards"
import "qrc:/ui/Tracks"

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
            id: authorName
            anchors {
                bottom: authorContent.top
                bottomMargin: blockMargin * 3
                horizontalCenter: parent.horizontalCenter
            }

            text: author_name
            color: secondary

            font {
                bold: true
                family: appFont
                pointSize: blockMargin * 2
            }
        }

        Text {
            id: authorData
            anchors {
                bottom: authorContent.top
                bottomMargin: blockMargin

                horizontalCenter: parent.horizontalCenter
            }

            text: authorService.albums_q + " albums • " + authorService.tracks_q + " audio"
            color: accent

            font {
                family: appFont
                pointSize: blockMargin //* 2.5
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

                height: blockMargin * 4 + authorInfoText.height

                radius: blockMargin

                Text {
                    text: "Об авторе"
                    font {
                        bold: true
                        pointSize: blockMargin
                        family: appFont
                    }
                    color: secondary

                    anchors.top: parent.top
                    anchors.topMargin: blockMargin
                    anchors.left: parent.left
                    anchors.leftMargin: blockMargin
                }

                Label {
                    id: authorInfoText
                    text: "hgsadggG JHSDhjad hdbashdbahj da hJDSahbshajbd asjhbdhjfbhdsf"
                          + " hgsadggG JHSDhjad hdbashdbahj da hJDSahbshajb dasjhbdhjfbhdsf"

                    font {
                        bold: true
                        pointSize: blockMargin * 0.9
                        family: appFont
                    }

                    width: parent.width - blockMargin

                    color: light
                    anchors {
                        top: parent.top
                        topMargin: blockMargin * 3
                        left: parent.left
                        leftMargin: blockMargin * 0.5
                        right: parent.left
                        rightMargin: blockMargin * 0.5
                    }
                    wrapMode: Label.Wrap
                }
            }

            BlockRandomAlbums {
                id: blockAuthorAlbums

                anchors {
                    top: authorInfoBlock.bottom
                    topMargin: blockMargin
                    horizontalCenter: parent.horizontalCenter
                }
            }

            ListView {
                id: lastRealises

                model: lastRealisesModel
                anchors.top: blockAuthorAlbum.bottom
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
                        author: Author
                        timeSec: TimeSec
                        id_track: id_db
                        //cover: coverURL
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
