import QtQuick 2.3
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
//import Qt5Compat.GraphicalEffects

Rectangle {
    id: bottomBar

    anchors {
        left: parent.left
        right: parent.right
        bottom: parent.bottom
    }

    height: blockMargin * 5
    width: mainScreen.width

    color: darkest

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
        }
        NumberAnimation {
            target: centralBottomBarButtonImg
            property: "height"
            from: centralBottomBarButtonImg.height
            to: buttonMin
        }
        NumberAnimation {
            target: rightBottomBarButtonImg
            property: "height"
            from: rightBottomBarButtonImg.height
            to: buttonMin
        }
        running: false
    }

    function close() {
        bottomBarOff.running = true
    }

    function open() {
        bottomBarOn.running = true
    }

    NumberAnimation {
        id: bottomBarOff
        target: bottomBar
        property: "height"
        from: blockMargin * 5
        to: 0
        running: false
    }

    NumberAnimation {
        id: bottomBarOn
        target: bottomBar
        property: "height"
        from: 0
        to: blockMargin * 5
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

            //            anchors.verticalCenter: parent.verticalCenter
            //            anchors.left: parent.left
            //            anchors.leftMargin: (parent.width - width) / 2 + blockMargin * 2
            height: buttonMin
            sourceSize: buttonMin

            //            ColorOverlay {
            //                id: leftOverlay
            //                anchors.fill: parent
            //                source: parent
            //                color: accent
            //                visible: false
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

            //leftBottomBarButtonImg.height = buttonMax
            //centralBottomBarButtonImg.height = buttonMin
            //rightBottomBarButtonImg.height = buttonMin
            leftBottomBarButtonImg.source = "qrc:/ui_icons/solid/user.svg"
            centralBottomBarButtonImg.source = "qrc:/ui_icons/outline/music-alt.svg"
            rightBottomBarButtonImg.source = "qrc:/ui_icons/outline/heart.svg"

            if (active == 1) {
                leftScreen.clearStack()
            } else {
                stackView.clear()
                stackView.push(leftScreen)
            }

            active = 1

            topBar.backSwitch()

            //leftOverlay.visible = true
            //centralOverlay.visible = false
            //rightOverlay.visible = false
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
            //                color: accent
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

            //leftBottomBarButtonImg.height = buttonMin
            //centralBottomBarButtonImg.height = buttonMax
            //rightBottomBarButtonImg.height = buttonMin
            leftBottomBarButtonImg.source = "qrc:/ui_icons/outline/user.svg"
            centralBottomBarButtonImg.source = "qrc:/ui_icons/solid/music-alt.svg"
            rightBottomBarButtonImg.source = "qrc:/ui_icons/outline/heart.svg"

            if (active == 2) {
                centralScreen.clearStack()
            } else {
                stackView.clear()
                stackView.push(centralScreen)
            }

            active = 2
            topBar.backSwitch()

            //            leftOverlay.visible = false
            //            centralOverlay.visible = true
            //            rightOverlay.visible = false
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
            //            anchors.verticalCenter: parent.verticalCenter
            //            anchors.right: parent.right
            //            anchors.rightMargin: (parent.width - width) / 2 + blockMargin * 2
            height: buttonMin
            sourceSize: buttonMin
            //            ColorOverlay {
            //                id: rightOverlay
            //                anchors.fill: parent
            //                source: parent
            //                color: accent
            //                visible: false
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

            //leftBottomBarButtonImg.height = buttonMin
            //centralBottomBarButtonImg.height = buttonMin
            //rightBottomBarButtonImg.height = buttonMax
            leftBottomBarButtonImg.source = "qrc:/ui_icons/outline/user.svg"
            centralBottomBarButtonImg.source = "qrc:/ui_icons/outline/music-alt.svg"
            rightBottomBarButtonImg.source = "qrc:/ui_icons/solid/heart.svg"

            //            leftOverlay.visible = false
            //            centralOverlay.visible = false
            //            rightOverlay.visible = true
            stackView.clear()
            stackView.push(rightScreen)
            active = 3
            topBar.backSwitch()
        }
    }

    Rectangle {
        height: 1
        width: parent.width
        color: outline

        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
