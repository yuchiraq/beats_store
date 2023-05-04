import QtQml.Models 2.3
import QtQuick 2.15
import QtQuick.Layouts 1.2
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
//import QtQuick.LocalStorage 2.0
//import QtGraphicalEffects 1.15
import Qt5Compat.GraphicalEffects

import "qrc:/primitive"
import "qrc:/cards"

StackView {
    id: centralScreen

    anchors.fill: stackView

    property int lastSortBy: 0

    property string lastRealisesText: "Сначала старые"

    //        Rectangle {
    //            anchors.fill: parent
    //            color: darkest
    //        }
    function clearStack() {
        if (centralScreen.depth > 1) {
            centralScreen.clear(StackView.PopTransition)
            centralScreen.push(bestTracksInitial)
            topBar.backSwitch(1)
        }
    }

    initialItem: Flickable {
        id: bestTracksInitial
        contentHeight: blockNewRealise.height * 2 + blockRandomBeats.height
                       + blockRandomAlbums.height + blockRandomAuthors.height + lastRealises.height

        anchors.fill: parent
        anchors.topMargin: topBar.height
        anchors.bottomMargin: bottomBar.height

        BlockNewRealise {
            id: blockNewRealise

            anchors {
                top: parent.top
                topMargin: blockMargin
                horizontalCenter: parent.horizontalCenter
            }
        }

        //        DropShadow {
        //            anchors.fill: blockRandomBeats
        //            transparentBorder: true
        //            horizontalOffset: -3
        //            verticalOffset: 3
        //            radius: 6.0
        //            color: "#40000000"
        //            source: blockRandomBeats
        //        }
        BlockRandomBeats {
            id: blockRandomBeats

            anchors {
                top: blockNewRealise.bottom
                topMargin: blockMargin
                horizontalCenter: parent.horizontalCenter
            }
        }

        //        DropShadow {
        //            anchors.fill: blockRandomAuthors
        //            transparentBorder: true
        //            horizontalOffset: -3
        //            verticalOffset: 3
        //            radius: 6.0
        //            color: "#40000000"
        //            source: blockRandomAuthors
        //        }
        BlockRandomAuthors {
            id: blockRandomAuthors

            anchors {
                top: blockRandomBeats.bottom
                topMargin: blockMargin
                horizontalCenter: parent.horizontalCenter
            }
        }

        //        DropShadow {
        //            anchors.fill: blockRandomAlbums
        //            transparentBorder: true
        //            horizontalOffset: -3
        //            verticalOffset: 3
        //            radius: 6.0
        //            color: "#40000000"
        //            source: blockRandomAlbums
        //        }
        BlockRandomAlbums {
            id: blockRandomAlbums

            anchors {
                top: blockRandomAuthors.bottom
                topMargin: blockMargin
                horizontalCenter: parent.horizontalCenter
            }
        }

        Text {
            id: lastRealisesTitle
            text: "<b>Последние релизы</b>"
            color: accent
            anchors {
                top: blockRandomAlbums.bottom
                topMargin: blockMargin
                left: parent.left
                leftMargin: blockMargin
            }
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: blockMargin * 1.3
        }

        Button {
            id: lastRealisesSorter

            anchors {
                verticalCenter: lastRealisesTitle.verticalCenter
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

                    id: lastRealisesSorterText
                    text: "Случайные"
                    font.pointSize: blockMargin * 1.3
                    font.family: appFont
                    color: secondary

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
            width: lastRealisesSorterText.width + height + 20

            onClicked: {
                styleChooser.styleFor = 4
                styleChooser.starter()
            }
        }

        Rectangle {
            width: parent.width
            height: 0.5
            color: outline
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: lastRealises.top
        }

        ListView {
            id: lastRealises

            model: lastRealisesModel
            anchors.top: lastRealisesTitle.bottom
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

        Text {
            font.family: appFont
            color: secondary
            text: "<strong>by Chiraq Concept</strong>\n" + mainScreen.height
                  + " * " + mainScreen.width

            anchors {
                topMargin: blockMargin
                top: lastRealises.bottom
                right: parent.right
                rightMargin: blockMargin
                bottomMargin: bottomBar.height + 20
            }
        }
    }

    function update() {
        lastRealises.height = database.getQuantity() * (blockMargin * 7 + 0.5)
        lastRealisesModel.updateModel(lastSortBy)
        randomBeatsModel.updateModel(0)
    }
}
