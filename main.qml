import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.3
import QtQuick.Dialogs 1.2
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.12


ApplicationWindow {
    id : window
    width: 640
    height: 480
    visible: true
    title: qsTr("White Board")

    palette.highlight: "grey"



    FileDialog {
            id: fileOpenDialog
            title: "Open an image file"
            // folder: shortcuts.documents
            nameFilters: [
                "Image files (*.png *.jpeg *.jpg)",
            ]
            onAccepted: {

                // canvas.loadImage(fileOpenDialog.fileUrl)
                // canvas.requestPaint()
                var contex = canvas.getContext('2d')
                    contex.drawImage(fileOpenDialog.fileUrl, 0, 0)
                    canvas.requestPaint()
            }
        }

    FileDialog {
            id: fileSaveDialog
            title: "Save an image file"
            selectExisting: false
            DialogButtonBox {
                Button {
                    text: qsTr("Save")
                    DialogButtonBox.buttonRole: DialogButtonBox.AcceptRole
                }
                Button {
                    text: qsTr("Close")
                    DialogButtonBox.buttonRole: DialogButtonBox.DestructiveRole
                }
            }

            // folder: shortcuts.documents
            // standardButtons: StandardButton.Save | StandardButton.Cancel
            defaultSuffix: ".png"
//            nameFilters: [
//                "Image files (*.png *.jpeg *.jpg)",
//            ]

            onAccepted: {
                canvas.getContext('2d')
                var img = canvas.toDataURL(" ");

                canvas.save(img)
                // canvas.Image
                console.log(img , "hello")

            }
        }



menuBar: MenuBar{
    id: menu
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
            onTriggered: {
                fileSaveDialog.open()
            }
        }
    }
}



Rectangle{
    id: area
    anchors.fill: parent

    color: "light grey"


//    ScrollView{
//        width: parent.width
//        height: parent.height
//        clip: true
//        ScrollBar.vertical.policy: ScrollBar.AlwaysOn
        //ScrollBar.horizontal.policy: ScrollBar.AlwaysOn

    Rectangle{
        id: bg
        anchors.left: parent.left
        anchors.top: parent.top
        width: 640
        height: 400
        color: "white"
     Canvas{
        id: canvas
        height: 1000
        /*anchors{
            top: parent.top
            bottom: tools.top
            left: parent.left
            right: parent.right

        }*/
        anchors.fill: parent

        property real lastX
        property real lastY
        property color selectedColor: tools.currentColor
        property real selectedBrushSize: brushSize.value

        onPaint: {
            var ctx = getContext('2d')
            ctx.lineWidth = canvas.selectedBrushSize
            ctx.strokeStyle = canvas.selectedColor
            ctx.lineJoin = 'round'
            ctx.textBaseline = 'top'
            ctx.beginPath()
            ctx.moveTo(lastX, lastY)
            lastX = drawingMouseArea.mouseX
            lastY = drawingMouseArea.mouseY
            ctx.lineTo(lastX, lastY)
            ctx.stroke()
            ctx.save()
        }

        function onSelected(x , y){

        }

        function clear()
        {
            var ctx = getContext('2d')
            ctx.reset()
            canvas.requestPaint()
        }




        MouseArea{
            id: drawingMouseArea
            anchors.fill: parent

            onPressed: {
                canvas.lastX = mouseX
                canvas.lastY = mouseY
            }

            onPositionChanged: {

                selector.active? canvas.onSelected(canvas.lastX , canvas.lastY): canvas.requestPaint()

                            }
            onReleased: {
                if (selector.active)
                {
                    selector.active = !selector.active
                }
            }

        }


    //}

    }
    }




        Row {
            id : tools
            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
                bottomMargin: 8

            }
            spacing: 6

            property color currentColor: "black"

            Repeater {
                        model: ["blue", "red", "yellow", "green", "black" , "white"]
                        Block {
                            id: colordata
                            color: modelData
                            active: parent.currentColor === color
                            onClicked: {
                                parent.currentColor = color
                            }
                        }
                    }

            Slider{
                height: 28
                id: brushSize
                from: 0.1
                value: 1.5
                to: 20
            }

            RoundButton{
                width: 28
                height: 28
                radius: height/2
                text: "+"
                id: selector
                onClicked: {
                    colorDialog.open()

                }

                property bool active: false
            }
        }
}

ColorDialog {
    id: colorDialog
    title: "Please choose a color"
    showAlphaChannel: true
    onAccepted: {
        console.log("You chose: " + colorDialog.color)
        //Qt.quit()
    }
    onRejected: {
        console.log("Canceled")
        //Qt.quit()
    }
}


}



