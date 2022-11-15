import QtQuick 2.15
import Qt5Compat.GraphicalEffects
import QtQuick.Controls

import "qrc:/TextStyles"
import "qrc:/ui/Cards"

//Rectangle {
//    id: blockNewRealise

//    width: mainScreen.width - (blockMargin * 2)
//    height: width / 3 * 1

//    radius: width / 20

//    color: dark

//    Image {
//        id: newBeatBackground

//        source: "qrc:/png/temp/162-3.jpg"

//        width: height / 9 * 16
//        height: parent.height
//        anchors.centerIn: parent
//        visible: false
//    }

//    OpacityMask {
//        anchors.fill: blockNewRealise
//        source: newBeatBackground
//        maskSource: blockNewRealise
//    }

//    Image {
//        id: overlay
//        source: "qrc:/png/interface/overlay.png"
//        width: parent.width
//        height: parent.height
//        opacity: 0.2
//        visible: false
//    }

//    /*OpacityMask {
//        anchors.fill: blockNewRealise
//        source: overlay
//        maskSource: blockNewRealise
//    }*/

//    BasicTextStyle {
//        id: newBeatAuthor

//        color: "white"
//        anchors {
//            left: parent.left
//            leftMargin: blockMargin * 2
//            bottom: newBeatName.top
//            bottomMargin: 2
//        }
//        text: "Niki-Y on da track"
//    }

//    HeaderTextStyle {
//        id: newBeatName

//        color: "white"
//        anchors {
//            left: parent.left
//            leftMargin: blockMargin * 2
//            bottom: parent.bottom
//            bottomMargin: blockMargin
//        }

//        text: "«162 pack 3»"

//    }

//    MouseArea {

//        anchors.fill: parent

//        onClicked: {

//            if(newBeatName.text === "«162 pack 3»") {
//                newBeatBackground.source = "qrc:/png/temp/cp3.jpg"
//                newBeatAuthor.text = "Niki-Y on da track"
//                newBeatName.text = "«CLASSIC PACK III»"
//            } else if(newBeatName.text === "«CLASSIC PACK III»") {
//                newBeatBackground.source = "qrc:/png/temp/162-2.jpg"
//                newBeatAuthor.text = "Niki-Y on da track"
//                newBeatName.text = "«162 pack 2»"
//            } else if(newBeatName.text === "«162 pack 2»") {
//                newBeatBackground.source = "qrc:/png/temp/162-3.jpg"
//                newBeatAuthor.text = "Niki-Y on da track"
//                newBeatName.text = "«162 pack 3»"
//            }

//        }

//    }

//}


Item {
    id: blockNewRealise

    width: mainScreen.width - blockMargin * 2
    height: width / 2 * 1

    anchors{
        leftMargin: blockMargin
        rightMargin: blockMargin
    }

    SwipeView {
        id: view
        currentIndex: 2
        anchors.fill: parent
        spacing: blockMargin

        NewBeat {}

        NewBeat{
            author: "Niki-Y On Da Track"
            title: "«CLASSIC PACK III»"
            cover: "qrc:/png/temp/cp3.jpg"
            border.width: 0
        }

        NewBeat{
            author: "Niki-Y On Da Track"
            title: "«162 pack 3»"
            cover: "qrc:/png/temp/162-3.jpg"
            border.width: 0
        }

        NewBeat{
            author: "Niki-Y On Da Track"
            title: "«162 pack 2»"
            cover: "qrc:/png/temp/162-2.jpg"
            border.width: 0
        }

        NewBeat {

        }

//        Repeater {
//            model: 3


//            NewBeat{
//                author: "Niki-Y On Da Track"
//                title: "«162 pack 3»"
//                cover: "qrc:/png/temp/162-3.jpg"
//            }



//        }
    }

    PageIndicator {
        count: view.count
        currentIndex: view.currentIndex
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
