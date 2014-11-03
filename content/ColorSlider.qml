import QtQuick 2.0
import "ColorFunctions.js" as ColorFunctions

Item {
    property real value: (1 - pickerCursor.y/height)
    width: 15; height: parent.height
    x: 0; y: 0
    id: root
    Item {
        id: pickerCursor
        width: parent.width
        Rectangle {
            x: -3; y: -height*0.5
            width: parent.width + 4; height: 7
            border.color: "black"; border.width: 1
            color: "transparent"
            Rectangle {
                anchors.fill: parent; anchors.margins: 2
                border.color: "white"; border.width: 1
                color: "transparent"
            }
        }
    }
    MouseArea {
        anchors.fill: parent
        onPositionChanged: ColorFunctions.SliderHandleMouse(mouse, parent.name)
        onPressed: ColorFunctions.SliderHandleMouse(mouse, parent.name)
    }
}
