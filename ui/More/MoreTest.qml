import QtQuick 2.15
import QtQuick.Controls.Material

import "qrc:/TextStyles"
import "qrc:/ui/Tracks"

Flickable {
    id: rightScreen

    width: parent

    anchors.fill: parent
    anchors.topMargin: topLogo.height
    anchors.bottomMargin: bottomBar.height

    contentHeight: likedColumn.height

    Column {
        id: likedColumn

//        anchors {
//            top: mainScreen.top
//            //left: mainScreen.left
//            //right: mainScreen.right
//            topMargin: topLogo.height
//            bottomMargin: topLogo.height
//            horizontalCenter: parent.horizontalCenter
//        }
        anchors.centerIn: parent

        spacing: blockMargin

        BasicTextStyle {
            id: likedText
            text: "Liked test view"
            anchors.centerIn: parent
        }

        ProgressBar {
            indeterminate: true
            anchors {
                top: likedText.bottom
                topMargin: 20
            }
        }
    }

}
