import QtQuick 2.15
import QtQuick.Controls.Material

import "qrc:/TextStyles"
import "qrc:/ui/Tracks"
import "qrc:/ui"

Flickable {
    id: centralScreen

    contentHeight: bestTracksColumn.height
    anchors.fill: parent
    anchors.topMargin: topLogo.height
    anchors.bottomMargin: bottomBar.height

    property int blockMargin: mainScreen.width / 40

//    Pane {
//        id: centralScreen

//        //    anchors {
//        //        top: parent.top
//        //        left: parent.left
//        //        right: parent.right
//        //    }
//        anchors.fill: parent
//        anchors.topMargin: topLogo.height
//        anchors.bottomMargin: topLogo.height


        //    ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        //    ScrollBar.vertical.policy: ScrollBar.AlwaysOff

        //    ScrollBar.horizontal.interactive: false
        //    ScrollBar.vertical.interactive: true

        //    contentWidth: width
        //    contentHeight: blockRandomBeats.height * 5

        Column {
            id: bestTracksColumn

            anchors {
                top: mainScreen.top
                //left: mainScreen.left
                //right: mainScreen.right
                topMargin: topLogo.height
                bottomMargin: topLogo.height
                horizontalCenter: parent.horizontalCenter
            }

            spacing: blockMargin

            BlockNewRealise {
                id: blockNewRealise

                anchors.horizontalCenter: parent.horizontalCenter
            }


            BlockRandomBeats {
                id: blockRandomBeats

                anchors.horizontalCenter: parent.horizontalCenter
            }

            BlockRandomAuthors {
                id: blockRandomAuthors

                anchors.horizontalCenter: parent.horizontalCenter
            }

            BasicTextStyle {
                text: "by Chiraq Concept"

                anchors {
                    right: parent.right
                    rightMargin: blockMargin
                }
            }

        }
    }

//}
