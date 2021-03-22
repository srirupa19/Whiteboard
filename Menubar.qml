import QtQuick 2.0
import QtQuick.Controls 2.5

MenuBar{
        background: Rectangle{
            height: parent.height
            color: "light grey"
            anchors.verticalCenterOffset: 5
        }


        Menu{
            title: qsTr("&File")
            MenuItem {
                text: qsTr("New")
                icon.name: "document-new"
                onTriggered: { canvas.clear()

                }
            }
            MenuItem {
                text: qsTr("Open")
                icon.name: "document-open"
                onTriggered: fileOpenDialog.open()
            }
            MenuItem {
                text: qsTr("Save")
                icon.name: "document-save"
                onTriggered: canvas.save("C:\Srirupa\Qt\Whiteboard")
            }
        }
}
