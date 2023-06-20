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

    color: "transparent"

    property bool searching: false

    Rectangle {
        id: topBarBackground

        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter

        height: topBar.height
        width: parent.width

        color: surface
        opacity: 1

        visible: true

        clip: true

        FastBlur {
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            height: mainScreen.height
            width: mainScreen.width
            source: stackView
            radius: 80
            visible: parent.visible
        }

        Rectangle {
            anchors.fill: parent
            color: surface
            opacity: .5
            visible: parent.visible
        }
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
        anchors.fill: parent

        onClicked: {
            if (topBar.searching) {
                mouse.accepted = false
                return
            }

            if (bottomBar.active == 1) {
                moveLeftScreen.running = true
            } else if (bottomBar.active == 2) {
                moveCentralScreen.running = true
            }
        }
    }

    NumberAnimation {
        id: moveLeftScreen
        target: leftScreen.get(leftScreen.depth - 1)
        property: "contentY"
        //duration: 200
        easing.type: Easing.InOutCirc
        from: leftScreen.get(leftScreen.depth - 1).contentY
        to: 0
    }

    NumberAnimation {
        id: moveCentralScreen
        target: centralScreen.get(centralScreen.depth - 1)
        property: "contentY"
        //duration: 200
        easing.type: Easing.InOutCirc
        from: centralScreen.get(centralScreen.depth - 1).contentY
        to: 0
    }

    MouseArea {
        anchors.fill: topLogo
        onClicked: {
            console.log("TopLogo click!")

            startSplashScreen.startSplash()
            musicPlayer.track_id = 0
        }
    }

    function searchFun() {
        if (selectorType.height != 0) {
            selectorTypeOff.restart()
        }

        search.updateModel(searchInputField.text, searchInputField.searchType,
                           searchInputField.searchWhat)
        stackView.pop(StackView.ReplaceTransition)
        stackView.push("qrc:/topBar/SearchPage.qml",
                       StackView.ReplaceTransition)
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
        radius: blockMargin * 1.5
        //radius: height / 2
        color: surface
        border.width: 0.5
        border.color: searchInputField.focus ? accent : outline

        //Material.theme: Material.Dark
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
            //font.family: appFont
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

            property string searchType: {
                if (selectorPos == 1) {
                    if (selectorTracks == 1)
                        return "title"
                    else if (selectorTracks == 2)
                        return "tags"
                } else if (selectorPos == 2) {
                    if (selectorAlbums == 1)
                        return "title"
                    else if (selectorAlbums == 2)
                        return "tags"
                } else if (selectorPos == 3) {
                    if (selectorTracks == 1)
                        return "title"
                    else if (selectorTracks == 2)
                        return "tags"
                }
            }

            property string searchWhat: {
                if (selectorPos == 1)
                    return "tracks"
                else if (selectorPos == 2)
                    return "albums"
                else if (selectorPos == 3)
                    return "authors"
            }


            /*onTextEdited: {

                search.updateModel(searchInputField.text, searchType,
                                   searchWhat)
                stackView.pop()
                stackView.push("qrc:/topBar/SearchPage.qml")
            }*/
            onAccepted: {
                topBar.searchFun()
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
                easing.type: Easing.InOutCirc
            }
            NumberAnimation {
                target: searchTopBarCleanerBack
                property: "opacity"
                from: 1
                to: 0
                easing.type: Easing.InOutCirc
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
                topBar.searchFun()
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
            easing.type: Easing.InOutCirc
        }
        NumberAnimation {
            target: searchTopBarBack
            property: "opacity"
            from: 1
            to: 0
            easing.type: Easing.InOutCirc
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
                //topBar.searchFun()
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
        easing.type: Easing.InOutCirc

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
        easing.type: Easing.InOutCirc

        running: false

        onStarted: {
            //searchInputFieldMask.visible = false
            searchInput.visible = false
        }
    }

    property int selectorPos: 1
    property int selectorTracks: 1
    property int selectorAlbums: 1
    property int selectorAuthors: 1
    property int selectorTypeRows: 0
    property int selectorSelectedRow: 1

    Rectangle {
        id: selectorType

        width: searchSelector.width / 3
        height: 0

        clip: true

        anchors {
            top: searchSelector.top
            left: searchSelector.left
        }

        color: container

        border {
            width: 0.5
            color: outline
        }

        radius: blockMargin * 1.5

        Divider {
            anchors {
                top: parent.top
                horizontalCenter: parent.horizontalCenter
                topMargin: searchSelector.height
            }

            width: parent.width - blockMargin
        }

        Rectangle {
            id: selectorTypeOne
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                topMargin: searchSelector.height
            }

            width: parent.width
            height: searchSelector.height

            color: "transparent"

            property string text: "По названию"

            Text {
                text: parent.text

                font {
                    //family: appFont
                    pointSize: searchSelector.height - blockMargin * 2
                    bold: selectorSelectedRow == 1
                }

                anchors.centerIn: parent

                color: selectorSelectedRow == 1 ? accent : secondary
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (selectorPos == 1)
                        selectorTracks = 1
                    else if (selectorPos == 2)
                        selectorAlbums = 1
                    else if (selectorTracks == 3)
                        selectorAuthors = 1
                    selectorSelectedRow = 1
                    selectorToTwo.restart()
                }
            }
        }

        Divider {
            anchors {
                top: parent.top
                horizontalCenter: parent.horizontalCenter
                topMargin: searchSelector.height * 2
            }

            width: parent.width - blockMargin
        }

        Rectangle {
            id: selectorTypeTwo
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                topMargin: searchSelector.height * 2
            }

            width: parent.width
            height: searchSelector.height

            color: "transparent"

            property string text: "По тэгам"

            Text {
                text: parent.text

                font {
                    //family: appFont
                    pointSize: searchSelector.height - blockMargin * 2
                    bold: selectorSelectedRow == 2
                }

                color: selectorSelectedRow == 2 ? accent : secondary

                anchors.centerIn: parent
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (selectorPos == 1)
                        selectorTracks = 2
                    else if (selectorPos == 2)
                        selectorAlbums = 2
                    else if (selectorTracks == 3)
                        selectorAuthors = 2
                    selectorSelectedRow = 2
                    selectorToTwo.restart()
                }
            }
        }

        NumberAnimation {
            id: selectorTypeOn
            target: selectorType
            property: "height"
            duration: 200
            easing.type: Easing.InOutCirc
            from: 0
            to: (selectorTypeRows + 1) * searchSelector.height
            onStarted: {
                if (selectorPos == 1) {
                    selectorSelectedRow = selectorTracks
                    selectorType.anchors.leftMargin = 0
                } else if (selectorPos == 2) {
                    selectorSelectedRow = selectorAlbums
                    selectorType.anchors.leftMargin = searchSelector.width / 3
                } else if (selectorPos == 3) {
                    selectorSelectedRow = selectorAuthors
                    selectorType.anchors.leftMargin = searchSelector.width / 3 * 2
                }
            }
        }

        NumberAnimation {
            id: selectorTypeOff
            target: selectorType
            property: "height"
            duration: 200
            easing.type: Easing.InOutCirc
            from: selectorType.height
            to: 0
            onStarted: selectorToOne.restart()
        }
    }

    Rectangle {
        id: searchSelector

        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter

        width: 0
        height: 0

        radius: blockMargin * 1.5

        color: container

        visible: false

        border.width: 0.5
        border.color: outline

        Rectangle {
            id: selector

            anchors {
                top: parent.top
                topMargin: blockMargin / 4
                left: searchSelector.left
                leftMargin: blockMargin / 4
            }

            width: searchSelector.width / 3 - blockMargin / 2
            height: searchSelector.height - blockMargin / 2

            color: outline //**//

            radius: searchSelector.radius - blockMargin / 4

            Text {
                anchors.centerIn: parent

                font {
                    //family: appFont
                    pointSize: searchSelector.height - blockMargin * 2
                    bold: true
                }

                color: accent

                text: if (selectorSelectedRow == 1) {
                          return selectorTypeOne.text
                      } else if (selectorSelectedRow == 2)
                          return selectorTypeTwo.text

                visible: selectorType.height > searchSelector.height
            }
        }

        Rectangle {
            anchors.left: parent.left
            anchors.leftMargin: parent.width / 3
            anchors.verticalCenter: parent.verticalCenter

            height: blockMargin
            width: px(1)

            color: outline
        }

        Rectangle {
            anchors.right: parent.right
            anchors.rightMargin: parent.width / 3
            anchors.verticalCenter: parent.verticalCenter

            height: blockMargin
            width: px(1)

            color: outline
        }

        Text {
            id: textTracks

            text: "Треки"

            font {
                //family: appFont
                pointSize: parent.height - blockMargin * 2
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
                //family: appFont
                pointSize: parent.height - blockMargin * 2
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
                //family: appFont
                pointSize: parent.height - blockMargin * 2
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
            easing.type: Easing.InOutCirc
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
            easing.type: Easing.InOutCirc
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
            easing.type: Easing.InOutCirc
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

        NumberAnimation {
            id: selectorToOne
            target: selector
            property: "anchors.topMargin"
            duration: 200
            easing.type: Easing.InOutQuad
            from: selector.anchors.topMargin
            to: blockMargin / 4
            running: false
        }

        NumberAnimation {
            id: selectorToTwo
            target: selector
            property: "anchors.topMargin"
            duration: 200
            easing.type: Easing.InOutQuad
            from: selector.anchors.topMargin
            to: blockMargin / 4 + searchSelector.height * selectorSelectedRow
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
                if (selectorPos == 1) {
                    if (selectorType.height == 0) {
                        selectorTypeRows = 2
                        selectorTypeOne.text = "По названию"
                        selectorTypeTwo.text = "По тэгам"
                        selectorTypeOn.restart()
                        selectorToTwo.restart()
                    } else {
                        topBar.searchFun()
                        //selectorTypeOff.restart()
                    }

                    return
                }
                if (selectorType.height != 0) {
                    //selectorToOne.restart()
                    selectorTypeOff.restart()
                }

                selectorToLeft.running = true
                selectorPos = 1
                topBar.searchFun()
            }
        }

        MouseArea {
            width: parent.width / 3
            height: parent.height

            anchors {
                centerIn: parent
            }

            onClicked: {
                if (selectorPos == 2) {
                    if (selectorType.height == 0) {
                        selectorTypeRows = 2
                        selectorTypeOne.text = "По названию"
                        selectorTypeTwo.text = "По тэгам"
                        selectorTypeOn.restart()
                        selectorToTwo.restart()
                    } else {
                        topBar.searchFun()
                        //selectorTypeOff.restart()
                    }

                    return
                }
                if (selectorType.height != 0) {
                    //selectorToOne.restart()
                    selectorTypeOff.restart()
                }

                selectorToCenter.running = true
                selectorPos = 2
                topBar.searchFun()
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
                if (selectorPos == 3) {
                    if (selectorType.height == 0) {
                        selectorTypeRows = 2
                        selectorTypeOne.text = "По имени"
                        selectorTypeTwo.text = "По тэгам"
                        selectorTypeOn.restart()
                        selectorToTwo.restart()
                    } else {
                        topBar.searchFun()
                        //selectorTypeOff.restart()
                    }
                    return
                }
                if (selectorType.height != 0) {
                    //selectorToOne.restart()
                    selectorTypeOff.restart()
                }

                selectorToRight.running = true
                selectorPos = 3
                topBar.searchFun()
            }
        }
    }

    ParallelAnimation {
        id: searchSelectorOn

        NumberAnimation {
            target: searchSelector
            property: "height"
            from: 0
            to: blockMargin * 3
            easing.type: Easing.InOutCirc
        }

        NumberAnimation {
            target: searchSelector
            property: "width"
            from: 0
            to: parent.width - blockMargin
            easing.type: Easing.InOutCirc
        }

        NumberAnimation {
            target: searchSelector
            property: "anchors.topMargin"
            from: 0
            to: blockMargin * 5
            easing.type: Easing.InOutCirc
        }

        NumberAnimation {
            target: topBarBackground
            property: "height"
            easing.type: Easing.InOutCirc
            from: topBar.height
            to: blockMargin * 3 + blockMargin * 3 + blockMargin * 3
        }

        onStarted: {
            searchSelector.visible = true
        }

        running: false
    }

    ParallelAnimation {
        id: searchSelectorOff

        NumberAnimation {
            target: searchSelector
            property: "height"
            from: blockMargin * 3
            to: 0
            easing.type: Easing.InOutCirc
        }

        NumberAnimation {
            target: searchSelector
            property: "width"
            from: searchSelector.width
            to: 0
            easing.type: Easing.InOutCirc
        }

        NumberAnimation {
            target: searchSelector
            property: "anchors.topMargin"
            from: blockMargin * 5
            to: 0
            easing.type: Easing.InOutCirc
        }

        NumberAnimation {
            target: topBarBackground
            property: "height"
            easing.type: Easing.InOutCirc
            from: blockMargin * 3 + blockMargin * 3 + blockMargin * 3
            to: topBar.height
        }

        onFinished: {
            searchSelector.visible = false
        }
        running: false
    }

    function searchOn() {
        topBar.searching = true
        backTopBar.visible = false
        topLogo.visible = false
        bottomBar.close()
        searchOnAnimation.running = true
        searchSelectorOn.running = true
        stackView.push("qrc:/primitive/Splash.qml", StackView.ReplaceTransition)
        stackView.push("qrc:/topBar/SearchPage.qml",
                       StackView.ReplaceTransition)
    }

    function searchOff() {
        topBar.searching = false
        Qt.inputMethod.hide()
        searchInputField.cursorVisible = false
        searchOffAnimation.running = true
        searchSelectorOff.running = true
        topLogo.visible = true
        bottomBar.open()
        stackView.pop(StackView.ReplaceTransition)
        stackView.pop(StackView.ReplaceTransition)
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
                leftScreen.pop(StackView.Immediate)
                if (leftScreen.depth == 1)
                    backOff.running = true
            } else if (bottomBar.active == 2 && centralScreen.depth > 1) {
                centralScreen.pop(StackView.Immediate)
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
            easing.type: Easing.InOutCirc
        }

        NumberAnimation {
            target: backTopBar
            property: "width"
            duration: timeAnimation
            from: 0
            to: topBar.height
            easing.type: Easing.InOutCirc
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
            easing.type: Easing.InOutCirc
        }

        NumberAnimation {
            target: topLogo
            property: "anchors.leftMargin"
            duration: timeAnimation
            from: (topBar.width - topLogo.width) / 2
            to: blockMargin * 1.5
            easing.type: Easing.InOutCirc
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
