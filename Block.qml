import QtQuick 2.0

import QtQuick 2.5

Rectangle {
    id: root
    width: 28; height: 28
    radius: height/2
    color: "black"
    signal clicked
    property bool active: false
    border.color: active? "dark grey" : "light grey"
    border.width: 1

    MouseArea {
        id: area
        anchors.fill :parent
        onClicked: {
            root.clicked()
        }
    }

}
