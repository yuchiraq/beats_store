import QtQuick 2.3
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import Qt5Compat.GraphicalEffects

import "qrc:/primitive"

Rectangle {
    id: bottomBar

    anchors {
        left: parent.left
        right: parent.right
        bottom: parent.bottom
    }

    height: blockMargin * 5
    width: mainScreen.width

    color: container

    clip: true

    FastBlur {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        height: mainScreen.height
        width: mainScreen.width
        source: stackView
        radius: 80
        visible: parent.visible
    }

    Rectangle {
        anchors.fill: parent
        color: container //surface
        opacity: .5
    }

    property int buttonMin: height * 0.4
    property int buttonMax: height * 0.43

    property int active: 2

    function bottomBarCorrector() {
        bottomBarCorrectorAnimation.running = true
        if (active == 2)
            centralActivate.running = true
        else if (active == 1)
            leftActivate.running = true
        else if (active == 3)
            rightActivate.running = true
    }

    ParallelAnimation {
        id: bottomBarCorrectorAnimation
        NumberAnimation {
            target: leftBottomBarButtonImg
            property: "height"
            from: leftBottomBarButtonImg.height
            to: buttonMin
            easing.type: Easing.InOutCirc
        }
        NumberAnimation {
            target: centralBottomBarButtonImg
            property: "height"
            from: centralBottomBarButtonImg.height
            to: buttonMin
            easing.type: Easing.InOutCirc
        }
        NumberAnimation {
            target: rightBottomBarButtonImg
            property: "height"
            from: rightBottomBarButtonImg.height
            to: buttonMin
            easing.type: Easing.InOutCirc
        }
        running: false
    }

    function close() {
        bottomBarOff.running = true
    }

    function open() {
        bottomBarOn.running = true
    }

    ParallelAnimation {
        id: bottomBarOff
        NumberAnimation {
            target: bottomBar
            property: "height"
            from: blockMargin * 5
            to: 0
        }

        NumberAnimation {
            target: blurMask
            property: "height"

            from: blurMask.height
            to: blurMask.height == blockMargin * 5 ? 0 : blockMargin * 3
        }
        running: false
    }

    ParallelAnimation {
        id: bottomBarOn

        NumberAnimation {
            target: bottomBar
            property: "height"
            from: 0
            to: blockMargin * 5
        }

        NumberAnimation {
            target: blurMask
            property: "height"

            from: blurMask.height
            to: blurMask.height == 0 ? blockMargin * 5 : blockMargin * 8
        }
        running: false
    }

    ParallelAnimation {
        id: leftActivate

        running: false

        NumberAnimation {
            target: leftBottomBarButtonBack
            property: "width"
            from: 0
            to: leftBottomBarButtonBack.height + (blockMargin * 3)
        }

        NumberAnimation {
            target: leftBottomBarButtonBack
            property: "radius"
            from: 0
            to: leftBottomBarButtonBack.height / 2
        }
    }

    ParallelAnimation {
        id: leftDisactivate

        running: false

        NumberAnimation {
            target: leftBottomBarButtonBack
            property: "width"
            from: leftBottomBarButtonBack.height + (blockMargin * 3)
            to: 0
        }

        NumberAnimation {
            target: leftBottomBarButtonBack
            property: "radius"
            from: leftBottomBarButtonBack.height / 2
            to: 0
        }
    }

    Rectangle {
        id: leftBottomBarButtonBack
        color: outline
        height: leftBottomBarButtonImg.height + blockMargin * 0.5
        width: 0
        anchors.centerIn: leftBottomBarButton
        radius: 0
        opacity: 0.7
    }

    Button {

        id: leftBottomBarButton

        width: parent.width / 3
        height: parent.height

        anchors.left: parent.left

        contentItem: Image {
            id: leftBottomBarButtonImg
            fillMode: Image.PreserveAspectFit
            source: "qrc:/ui_icons/outline/user.svg"

            anchors.centerIn: parent

            height: buttonMin
            sourceSize: buttonMin

            //            ColorOverlay {
            //                id: leftOverlay
            //                anchors.fill: parent
            //                source: parent
            //                color: accent
            //            }
        }

        background: Rectangle {
            color: "#00000000"
        }

        onClicked: {
            if (active == 3)
                rightDisactivate.running = true
            else if (active == 2)
                centralDisactivate.running = true

            if (leftBottomBarButtonImg.height != buttonMin)
                bottomBarCorrector()
            leftActivate.running = true

            leftBottomBarButtonImg.source = "qrc:/ui_icons/solid/user.svg"
            //leftOverlay.color = secondary
            centralBottomBarButtonImg.source = "qrc:/ui_icons/outline/music-alt.svg"
            //centralOverlay.color = accent
            rightBottomBarButtonImg.source = "qrc:/ui_icons/outline/heart.svg"

            //rightOverlay.color = accent
            if (active == 1) {
                leftScreen.clearStack(StackView.ReplaceTransition)
            } else {
                stackView.clear()
                stackView.push(leftScreen, StackView.ReplaceTransition)
            }

            active = 1

            topBar.backSwitch()
        }
    }

    ParallelAnimation {
        id: centralActivate

        running: true

        NumberAnimation {
            target: centralBottomBarButtonBack
            property: "width"
            from: 0
            to: centralBottomBarButtonBack.height + (blockMargin * 3)
        }

        NumberAnimation {
            target: centralBottomBarButtonBack
            property: "radius"
            from: 0
            to: centralBottomBarButtonBack.height / 2
        }
    }

    ParallelAnimation {
        id: centralDisactivate

        running: false

        NumberAnimation {
            target: centralBottomBarButtonBack
            property: "width"
            from: centralBottomBarButtonBack.height + (blockMargin * 3)
            to: 0
        }

        NumberAnimation {
            target: centralBottomBarButtonBack
            property: "radius"
            from: centralBottomBarButtonBack.height / 2
            to: 0
        }
    }

    Rectangle {
        id: centralBottomBarButtonBack
        color: outline
        height: centralBottomBarButtonImg.height + blockMargin * 0.5
        width: 0
        anchors.centerIn: centralBottomBarButton
        radius: 0
        opacity: 0.7
    }

    Button {
        id: centralBottomBarButton

        height: parent.height
        width: parent.width / 3

        anchors.centerIn: parent

        contentItem: Image {
            id: centralBottomBarButtonImg
            source: "qrc:/ui_icons/solid/music-alt.svg"
            fillMode: Image.PreserveAspectFit

            anchors.centerIn: parent
            height: buttonMin
            sourceSize: buttonMin
            //            ColorOverlay {
            //                id: centralOverlay
            //                anchors.fill: parent
            //                source: parent
            //                color: secondary
            //            }
        }
        background: Rectangle {
            color: "#00000000"
        }

        onClicked: {
            if (active == 1)
                leftDisactivate.running = true
            else if (active == 3)
                rightDisactivate.running = true

            if (centralBottomBarButtonImg.height != buttonMin)
                bottomBarCorrector()

            centralActivate.running = true

            leftBottomBarButtonImg.source = "qrc:/ui_icons/outline/user.svg"
            //rightOverlay.color = accent
            centralBottomBarButtonImg.source = "qrc:/ui_icons/solid/music-alt.svg"
            //centralOverlay.color = secondary
            rightBottomBarButtonImg.source = "qrc:/ui_icons/outline/heart.svg"

            //rightOverlay.color = accent
            if (active == 2) {
                centralScreen.clearStack(StackView.ReplaceTransition)
            } else {
                stackView.clear()
                stackView.push(centralScreen, StackView.ReplaceTransition)
            }

            active = 2
            topBar.backSwitch()
        }
    }

    ParallelAnimation {
        id: rightActivate

        running: false

        NumberAnimation {
            target: rightBottomBarButtonBack
            property: "width"
            from: 0
            to: rightBottomBarButtonBack.height + (blockMargin * 3)
        }

        NumberAnimation {
            target: rightBottomBarButtonBack
            property: "radius"
            from: 0
            to: rightBottomBarButtonBack.height / 2
        }
    }

    ParallelAnimation {
        id: rightDisactivate

        running: false

        NumberAnimation {
            target: rightBottomBarButtonBack
            property: "width"
            from: rightBottomBarButtonBack.height + (blockMargin * 3)
            to: 0
        }

        NumberAnimation {
            target: rightBottomBarButtonBack
            property: "radius"
            from: rightBottomBarButtonBack.height / 2
            to: 0
        }
    }

    Rectangle {
        id: rightBottomBarButtonBack
        color: outline
        height: rightBottomBarButtonImg.height + blockMargin * 0.5
        width: 0
        anchors.centerIn: rightBottomBarButton
        radius: 0
        opacity: 0.7
    }

    Button {
        id: rightBottomBarButton

        height: parent.height
        width: parent.width / 3

        anchors.right: parent.right

        contentItem: Image {
            id: rightBottomBarButtonImg
            source: "qrc:/ui_icons/outline/heart.svg"
            fillMode: Image.PreserveAspectFit

            smooth: true

            anchors.centerIn: parent

            height: buttonMin
            sourceSize: buttonMin
            //            ColorOverlay {
            //                id: rightOverlay
            //                anchors.fill: parent
            //                source: parent
            //                color: accent
            //            }
        }

        background: Rectangle {
            color: "#00000000"
        }

        onClicked: {
            if (active == 1)
                leftDisactivate.running = true
            else if (active == 2)
                centralDisactivate.running = true

            if (rightBottomBarButtonImg.height != buttonMin)
                bottomBarCorrector()
            rightActivate.running = true

            //leftOverlay.color = accent
            leftBottomBarButtonImg.source = "qrc:/ui_icons/outline/user.svg"
            //centralOverlay.color = accent
            centralBottomBarButtonImg.source = "qrc:/ui_icons/outline/music-alt.svg"
            //rightOverlay.color = secondary
            rightBottomBarButtonImg.source = "qrc:/ui_icons/solid/heart.svg"

            stackView.clear()
            stackView.push(rightScreen, StackView.ReplaceTransition)
            active = 3
            topBar.backSwitch()
        }
    }

    Divider {
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
