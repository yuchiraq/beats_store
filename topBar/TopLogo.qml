import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
//import QtGraphicalEffects 1.15
import Qt5Compat.GraphicalEffects

Rectangle {
    id: topBar

    Keys.onBackPressed: {
        topBar.standartBack()
    }

    anchors {
        left: parent.left
        right: parent.right
        top: parent.top
    }

    height: blockMargin * 5
    width: parent.width

    //color: darkest
    gradient: Gradient {
        GradientStop {
            position: 0.00
            color: darkest
        }
        GradientStop {
            position: 1.00
            color: "transparent"
        }
    }

    function standartBack() {
        if (searchInput.visible) {
            searchOff()
        } else {
            if (bottomBar.active == 1 && leftScreen.depth > 1) {
                leftScreen.pop()
                if (leftScreen.depth === 1)
                    backOff.running = true
            } else if (bottomBar.active == 2 && centralScreen.depth > 1) {
                centralScreen.pop()
                if (centralScreen.depth === 1)
                    backOff.running = true
            }
        }
    }

    Image {
        id: topLogo

        //source: "qrc:/topLogoCQ.png"
        source: "../topLogoCQ.png"
        anchors {
            left: parent.left
            leftMargin: blockMargin * 1.5
            top: parent.top
            topMargin: (parent.height - height) / 2
        }
        fillMode: Image.PreserveAspectFit
        height: parent.height * 0.55
    }

    MouseArea {
        anchors.fill: topLogo
        onClicked: {
            console.log("TopLogo click!")
            //centralScreen.flick(0, 0)
            startSplashScreen.startSplash()
            musicPlayer.track_id = 0
        }
    }

    Rectangle {
        id: searchInput
        anchors {
            verticalCenter: topBar.verticalCenter
            left: topBar.left
            leftMargin: blockMargin / 2
            right: topBar.right
            rightMargin: blockMargin / 2
        }

        height: blockMargin * 3.5
        //radius: blockMargin * 1.5
        radius: height / 2
        color: dark

        Rectangle {
            id: searchTopBarCleanerBack
            anchors.centerIn: searchTopBarCleaner
            height: searchTopBarCleaner.height
            width: height
            radius: height / 2
            color: outline
            opacity: 0
        }

        SequentialAnimation {
            id: searchTopBarCleanerBackAnim
            NumberAnimation {
                target: searchTopBarCleanerBack
                property: "opacity"
                from: 0
                to: 1
            }
            NumberAnimation {
                target: searchTopBarCleanerBack
                property: "opacity"
                from: 1
                to: 0
            }
            running: false
        }

        MouseArea {
            id: searchTopBarCleaner

            width: searchInput.height
            height: width

            anchors {
                right: searchInput.right
                //rightMargin: blockMargin / 4
                verticalCenter: parent.verticalCenter
            }

            Image {
                anchors.centerIn: parent
                source: "qrc:/ui_icons/outline/cross.svg"
                width: parent.height * 0.4 //(searchInput.height - blockMargin / 2) * 0.5
                height: width
                smooth: true
            }

            onPressed: searchTopBarCleanerBackAnim.running = true

            onClicked: {
                searchInputField.clear()
                searchListModel.updateModel("")
            }

            //visible: searchInputField.text !== ""
        }
        visible: false
    }

    Rectangle {
        id: searchInputFieldMask
        visible: false

        anchors {
            verticalCenter: topBar.verticalCenter
            left: searchTopBar.right
            right: topBar.right
            rightMargin: searchTopBar.width
        }

        height: blockMargin * 3.5
        radius: blockMargin * 1.5

        color: "transparent"

        TextField {
            id: searchInputField
            placeholderText: "Поиск...                   "
            font.family: appFont
            font.pointSize: blockMargin * 2
            placeholderTextColor: outline
            selectedTextColor: secondary
            color: secondary

            background: Rectangle {
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    leftMargin: blockMargin
                    right: parent.right
                    rightMargin: searchTopBar.width
                }
                height: blockMargin * 3.5
                color: "transparent"
            }

            //            onTextEdited: {
            //                searchListModel.updateModel(searchInputField.text)
            //            }
            onAccepted: {
                searchListModel.updateModel(searchInputField.text)
                Qt.inputMethod.hide()
                console.log(searchListModel.updateModel(searchInputField.text))
                searchInputField.cursorVisible = false
            }
        }
    }

    Rectangle {
        id: searchTopBarBack
        anchors.centerIn: searchTopBar
        height: searchInput.height
        width: height
        radius: height / 2
        color: outline
        opacity: 0
    }

    SequentialAnimation {
        id: searchTopBarBackAnim
        NumberAnimation {
            target: searchTopBarBack
            property: "opacity"
            from: 0
            to: 1
        }
        NumberAnimation {
            target: searchTopBarBack
            property: "opacity"
            from: 1
            to: 0
        }
        running: false
    }

    MouseArea {
        id: searchTopBar

        width: parent.height
        height: width

        anchors {
            right: parent.right
            //rightMargin: blockMargin * 2
            verticalCenter: parent.verticalCenter
        }

        Image {
            id: searchTopBarImg

            anchors.centerIn: parent
            source: "qrc:/ui_icons/outline/search.svg"
            width: parent.height * 0.4
            height: width
            ColorOverlay {
                anchors.fill: parent
                source: parent
                color: accent
            }
        }

        onClicked: {
            if (topLogo.visible) {
                searchOn()
                searchListModel.updateModel(searchInputField.text)
            } else {
                searchOff()
                //searchAnimation.running = true
            }
        }

        onPressed: searchTopBarBackAnim.running = true

        NumberAnimation {
            id: searchAnimation
            running: false
            target: searchTopBarImg
            property: "rotation"
            from: 0
            to: 90
        }
    }

    NumberAnimation {
        id: searchOnAnimation

        target: searchTopBar
        property: "anchors.rightMargin"
        from: 0
        to: topBar.width - searchTopBar.width + blockMargin / 4

        running: false

        onFinished: {
            searchInput.visible = true
            searchInputFieldMask.visible = true
        }
    }

    NumberAnimation {
        id: searchOffAnimation

        target: searchTopBar
        property: "anchors.rightMargin"
        from: topBar.width - searchTopBar.width + blockMargin / 4
        to: 0

        running: false

        onStarted: {
            searchInputFieldMask.visible = false
            searchInput.visible = false
        }
    }

    function searchOn() {
        backTopBar.visible = false
        topLogo.visible = false
        bottomBar.close()
        searchOnAnimation.running = true
        stackView.push("qrc:/topBar/SearchPage.qml")
    }

    function searchOff() {
        Qt.inputMethod.hide()
        searchInputField.cursorVisible = false
        searchOffAnimation.running = true
        topLogo.visible = true
        bottomBar.open()
        stackView.pop()
        backSwitch()
    }

    Rectangle {
        id: backTopBarBack
        anchors.centerIn: backTopBar
        height: searchInput.height
        width: height
        radius: height / 2
        color: outline
        opacity: 0
    }

    SequentialAnimation {
        id: backTopBarBackAnim
        NumberAnimation {
            target: backTopBarBack
            property: "opacity"
            from: 0
            to: 1
        }
        NumberAnimation {
            target: backTopBarBack
            property: "opacity"
            from: 1
            to: 0
        }
        running: false
    }

    MouseArea {
        id: backTopBar

        width: 0

        height: width

        anchors {
            left: parent.left
            //leftMargin: blockMargin
            verticalCenter: parent.verticalCenter
        }

        Image {
            anchors.centerIn: parent
            source: "qrc:/ui_icons/basic/angle-small-right.svg"
            width: parent.height * 0.7
            height: parent.height * 0.7
            rotation: 180
            ColorOverlay {
                source: parent
                color: secondary
                anchors.fill: parent
            }
        }

        onPressed: backTopBarBackAnim.running = true

        onClicked: {
            if (bottomBar.active == 1 && leftScreen.depth > 1) {
                leftScreen.pop()
                if (leftScreen.depth == 1)
                    backOff.running = true
            } else if (bottomBar.active == 2 && centralScreen.depth > 1) {
                centralScreen.pop()
                if (centralScreen.depth == 1)
                    backOff.running = true
            }

            //backSwitch()
            //backOff.running = true
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
            from: blockMargin * 1
            to: (topBar.width - topLogo.width) / 2
        }

        NumberAnimation {
            target: backTopBar
            property: "width"
            duration: timeAnimation
            from: 0
            to: topBar.height
        }

        onStarted: backTopBar.visible = true
    }

    ParallelAnimation {
        id: backOff

        running: false

        NumberAnimation {
            target: backTopBar
            property: "width"
            duration: timeAnimation
            from: topBar.height
            to: 0
        }

        NumberAnimation {
            target: topLogo
            property: "anchors.leftMargin"
            duration: timeAnimation
            from: (topBar.width - topLogo.width) / 2
            to: blockMargin * 1.5
        }

        onFinished: backSwitch()
    }

    function backSwitch(back) {
        if (back) {
            backOff.running = true
            return
        }

        if (bottomBar.active == 1) {
            if (leftScreen.depth > 1 && backTopBar.width == 0) {
                backOn.running = true
            } else if (backTopBar.width != 0) {
                backOff.running = true
            }
        } else if (bottomBar.active == 2) {
            if (centralScreen.depth > 1 && backTopBar.width == 0) {
                backOn.running = true
            } else if (backTopBar.width != 0) {
                backOff.running = true
            }
        } else {
            if (backTopBar.width != 0)
                backOff.running = true
        }
    }
}
