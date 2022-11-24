import QtQuick 2.15
import QtQuick.Controls.Material
import Qt5Compat.GraphicalEffects

import "qrc:/ui/BottomBar"

Rectangle {
    id: topBar

    anchors {
        left: parent.left
        right: parent.right
        top: parent.top
    }

    height: 60
    width: parent.width

    color: darkestTransparency

    Image {
        id: topLogo

        source: "qrc:/png/fullLOGO.png"

        anchors {
            left: parent.left
            leftMargin: blockMargin * 2
            //leftMargin: (parent.width - width) / 2
            top: parent.top
            topMargin: (parent.height - height) / 2
        }

        width: parent.width * 0.3
        height: width / (2308 / 392)

    }

    MouseArea {
        id: searchTopBar

        width: parent.height * 0.4
        height: width

        anchors {
            right: parent.right
            rightMargin: blockMargin * 2
            verticalCenter: parent.verticalCenter
        }

        Image {
            id: searchTopBarImg

            anchors.centerIn: parent
            source: "qrc:/png/interface/search.svg"
            width: parent.width
            height: width
        }

        onClicked: {
            searchAnimation.running = true
        }

        NumberAnimation {
            id: searchAnimation
            running: false
            target: searchTopBarImg
            property: "rotation"
            duration: timeAnimation * 5
            from: 0
            to: 360
        }

    }

    MouseArea {
        id: backTopBar

        width: 0
        //width: parent.height * 0.3
        height: width

        anchors {
            left: parent.left
            leftMargin: blockMargin
            verticalCenter: parent.verticalCenter
        }

        Image {
            anchors.centerIn: parent
            source: "qrc:/png/interface/angle-right.svg"
            width: parent.width
            height: width
            rotation: 180
        }

        onClicked: {
            if(bottomBar.active == 1){
                leftScreen.pop()
            }

            backOff.running = true

        }

    }

    property int timeAnimation: 150

    ParallelAnimation {
        id: backOn

        running: false

        NumberAnimation {
            target: topLogo
            property: "anchors.leftMargin"
            duration: timeAnimation
            from: blockMargin * 2
            to: (topBar.width - topLogo.width) / 2
        }

        NumberAnimation {
            target: backTopBar
            property: "width"
            duration: timeAnimation
            from: 0
            to: topBar.height * 0.4
        }
    }

    SequentialAnimation {
        id: backOff

        running: false

        NumberAnimation {
            target: backTopBar
            property: "width"
            duration: timeAnimation
            from: topBar.height * 0.4
            to: 0
        }

        NumberAnimation {
            target: topLogo
            property: "anchors.leftMargin"
            duration: timeAnimation
            from: (topBar.width - topLogo.width) / 2
            to: blockMargin * 2
        }
    }

    function backSwitch(){
        if(bottomBar.active == 1){
            if(leftScreen.depth > 1) {
                backOn.running = true
            }
        } else {
            if(backTopBar.width != 0)
                backOff.running = true
        }


    }
}
