import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
//import QtGraphicalEffects 1.15
import Qt5Compat.GraphicalEffects

import "qrc:/primitive"

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

    Rectangle {
        id: topBarBackground

        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter

        height: 0
        width: parent.width

        color: darkest

        visible: false
    }

    GaussianBlur {
        source: stackView
        anchors.fill: topBarBackground

        radius: 100
        samples: 128
        transparentBorder: false

        visible: topBarBackground.visible
    }

    Rectangle {
        anchors.fill: topBarBackground
        color: darkestTransparency
        visible: topBarBackground.visible

        Divider {
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
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
        color: searchInputField.focus ? dark : dark
        border.width: 0.5
        border.color: searchInputField.focus ? accent : outline

        Material.theme: Material.Dark

        Rectangle {
            id: searchTopBarCleanerBack
            anchors.centerIn: searchTopBarCleaner
            height: searchTopBarCleaner.height
            width: height
            radius: height / 2
            color: outline
            opacity: 0
        }

        TextField {
            id: searchInputField

            anchors.fill: parent

            //placeholderText: "Поиск..."
            font.family: appFont
            font.pointSize: blockMargin * 2

            placeholderTextColor: outline
            selectedTextColor: secondary
            color: secondary
            leftPadding: searchTopBarCleaner.height
            rightPadding: searchTopBarCleaner.height
            bottomPadding: 0
            topPadding: 0
            background: Rectangle {
                color: "transparent"
            }

            onTextEdited: {
                searchListModel.updateModel(searchInputField.text)
            }

            onAccepted: {
                searchListModel.updateModel(searchInputField.text)
                Qt.inputMethod.hide()
                searchInputField.focus = false
            }
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
            fillMode: Image.PreserveAspectFit
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
            //searchInputFieldMask.visible = true
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
            //searchInputFieldMask.visible = false
            searchInput.visible = false
        }
    }

    property int selectorPos: 1

    Rectangle {
        id: searchSelector

        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter

        width: 0
        height: 0

        radius: blockMargin * 1.5

        color: dark

        visible: false

        border.width: 0.5
        border.color: outline

        Rectangle {
            anchors.left: parent.left
            anchors.leftMargin: parent.width / 3
            anchors.verticalCenter: parent.verticalCenter

            height: blockMargin
            width: 1

            color: outline
        }

        Rectangle {
            anchors.right: parent.right
            anchors.rightMargin: parent.width / 3
            anchors.verticalCenter: parent.verticalCenter

            height: blockMargin
            width: 1

            color: outline
        }

        Rectangle {
            id: selector

            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: blockMargin / 4
            }

            width: parent.width / 3 - blockMargin / 2
            height: parent.height - blockMargin / 2

            color: accentTransparency

            radius: parent.radius - blockMargin / 4
        }

        Text {
            id: textTracks

            text: "Треки"

            font {
                family: appFont
                pointSize: parent.height - blockMargin * 2.5
                bold: true
            }

            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: parent.width / 6 - width / 2
            }

            color: accent
        }

        Text {
            id: textAlbums

            text: "Альбомы"

            font {
                family: appFont
                pointSize: parent.height - blockMargin * 2.5
                bold: false
            }

            anchors {
                centerIn: parent
            }

            color: secondary
        }

        Text {
            id: textAuthors

            text: "Авторы"

            font {
                family: appFont
                pointSize: parent.height - blockMargin * 2.5
                bold: false
            }

            anchors {
                verticalCenter: parent.verticalCenter
                right: parent.right
                rightMargin: parent.width / 6 - width / 2
            }

            color: secondary
        }

        NumberAnimation {
            id: selectorToLeft
            target: selector
            property: "anchors.leftMargin"
            easing.type: Easing.InOutQuad
            from: selector.anchors.leftMargin
            to: blockMargin / 4

            onFinished: {
                textTracks.font.bold = true
                textAlbums.font.bold = false
                textAuthors.font.bold = false

                textTracks.color = accent
                textAlbums.color = secondary
                textAuthors.color = secondary
            }

            running: false
        }

        NumberAnimation {
            id: selectorToCenter
            target: selector
            property: "anchors.leftMargin"
            easing.type: Easing.InOutQuad
            from: selector.anchors.leftMargin
            to: blockMargin / 2 + blockMargin / 4 + selector.width

            onFinished: {
                textTracks.font.bold = false
                textAlbums.font.bold = true
                textAuthors.font.bold = false

                textTracks.color = secondary
                textAlbums.color = accent
                textAuthors.color = secondary
            }
            running: false
        }

        NumberAnimation {
            id: selectorToRight
            target: selector
            property: "anchors.leftMargin"
            easing.type: Easing.InOutQuad
            from: selector.anchors.leftMargin
            to: blockMargin + blockMargin / 4 + selector.width * 2

            onFinished: {
                textTracks.font.bold = false
                textAlbums.font.bold = false
                textAuthors.font.bold = true

                textTracks.color = secondary
                textAlbums.color = secondary
                textAuthors.color = accent
            }
            running: false
        }

        MouseArea {
            width: parent.width / 3
            height: parent.height

            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
            }

            onClicked: {
                selectorToLeft.running = true
                selectorPos = 1
            }
        }

        MouseArea {
            width: parent.width / 3
            height: parent.height

            anchors {
                centerIn: parent
            }

            onClicked: {
                selectorToCenter.running = true
                selectorPos = 2
            }
        }

        MouseArea {
            width: parent.width / 3
            height: parent.height

            anchors {
                verticalCenter: parent.verticalCenter
                right: parent.right
            }

            onClicked: {
                selectorToRight.running = true
                selectorPos = 3
            }
        }
    }

    ParallelAnimation {
        id: searchSelectorOn

        NumberAnimation {
            target: searchSelector
            property: "height"
            from: 0
            to: blockMargin * 3.5
            easing.type: Easing.OutBack
        }

        NumberAnimation {
            target: searchSelector
            property: "width"
            from: 0
            to: parent.width - blockMargin
            easing.type: Easing.OutInBack
        }

        NumberAnimation {
            target: searchSelector
            property: "anchors.topMargin"
            from: 0
            to: blockMargin * 5
            easing.type: Easing.InOutQuad
        }

        NumberAnimation {
            target: topBarBackground
            property: "height"
            easing.type: Easing.OutInBack
            from: 0
            to: blockMargin * 3.5 + blockMargin * 3 + blockMargin * 3
        }

        onStarted: {
            topBarBackground.visible = true
            searchSelector.visible = true
        }

        running: false
    }

    ParallelAnimation {
        id: searchSelectorOff

        NumberAnimation {
            target: searchSelector
            property: "height"
            from: blockMargin * 3.5
            to: 0
            easing.type: Easing.OutBack
        }

        NumberAnimation {
            target: searchSelector
            property: "width"
            from: searchSelector.width
            to: 0
            easing.type: Easing.OutInBack
        }

        NumberAnimation {
            target: searchSelector
            property: "anchors.topMargin"
            from: blockMargin * 5
            to: 0
            easing.type: Easing.InOutQuad
        }

        NumberAnimation {
            target: topBarBackground
            property: "height"
            easing.type: Easing.OutInBack
            from: blockMargin * 3.5 + blockMargin * 3 + blockMargin * 3
            to: 0
        }

        onFinished: {
            topBarBackground.visible = false
            searchSelector.visible = false
        }
        running: false
    }

    function searchOn() {
        backTopBar.visible = false
        topLogo.visible = false
        bottomBar.close()
        searchOnAnimation.running = true
        searchSelectorOn.running = true
        stackView.push("qrc:/topBar/SearchPage.qml")
    }

    function searchOff() {
        Qt.inputMethod.hide()
        searchInputField.cursorVisible = false
        searchOffAnimation.running = true
        searchSelectorOff.running = true
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
