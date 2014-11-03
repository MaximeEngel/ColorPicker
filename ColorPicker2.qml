import QtQuick 2.3
import QtQuick.Window 2.2
import "content"
import "content/ColorFunctions.js" as ColorFunctions

Window {
    width:600 ;height: 400
    color: "#3C3C3C"

    Row {
        anchors.fill: parent
        spacing: 5

        // saturation/hue picker wheel
        Wheel {
            id: wheel
            width: 400; height: parent.height
        }

        // brightness picker slider
        Item {
            id: brightnessPicker
            property real brightness: brightnessSlider.value
            width: 20; height: parent.height
            Rectangle {
                anchors.fill: parent
                // background gradient
                gradient: Gradient {
                    GradientStop { id: brightnessBeginColor; position: 0.0; color: wheel.color }
                    GradientStop { position: 1.0;  color: "#000000" }
                }
            }
            ColorSlider { id: brightnessSlider; property string name: "brightnessSlider"; anchors.fill: parent }
        }

        // alpha (transparency) picking slider
        Item {
            id: alphaPicker
            property real alpha : alphaSlider.y / height;
            width: 20; height: parent.height
            CheckerBoard { cellSide: 4 }
            //  alpha intensity gradient background
            Rectangle {
                anchors.fill: parent
                gradient: Gradient {
                    GradientStop { id: alphaBeginColor; position: 0.0; color: "#FF000000" }
                    GradientStop { position: 1.0; color: "#00000000" }
                }
            }
            ColorSlider { id: alphaSlider; property string name: "alphaSlider"; anchors.fill: parent }
        }

        // text inputs

        Item {
            width: 135; height: parent.height
            Column {
                width: parent.width; height: parent.height-10
                anchors.verticalCenter: parent.verticalCenter
                spacing: 10

                // current color display
                Rectangle {
                    width: parent.width; height: 50
                    CheckerBoard { cellSide: 5 }
                    Rectangle {
                        id: colorDisplay
                        width: parent.width; height: parent.height
                        border.width: 1; border.color: "black"
                        color: "#AAFFFF00"
                    }
                }

                // current color value
                PanelBorder {
                    width: parent.width; height: 25
                    TextInput {
                        id: currentColor
                        color: "#AAAAAA"
                        selectionColor: "#FF7777AA"
                        font.pixelSize: 20
                        maximumLength: 9
                        focus: true
                        text: "#AAFFFF00"
                        font.family: "TlwgTypewriter"
                        anchors.verticalCenterOffset: 0
                        anchors.verticalCenter: parent.verticalCenter
                        selectByMouse: true
                        validator: RegExpValidator { regExp: /^#([A-Fa-f0-9]{8})$/ }
                        onTextChanged: ColorFunctions.currentColorChanged(text)
                    }
                }

                // H, S, B color value boxes
                Column {
                    width: parent.width
                    NumberBox { id: hue; caption: "H"; value:"0.1"}
                    NumberBox { id: sat; caption: "S"; value:"0.1"}
                    NumberBox { id: brightness; caption: "B"; value:"0.1"}
                    NumberBox { id: hsbAlpha; caption: "A"; value:"0.1"}
                }

                // R, G, B color values boxes
                Column {
                    width: parent.width
                    NumberBox {
                        id: red
                        caption: "R"; value: "255"
                        min: 0; max: 255; decimals: 0
                    }
                    NumberBox {
                        id: green
                        caption: "G"; value: "255"
                        min: 0; max: 255; decimals: 0
                    }
                    NumberBox {
                        id: blue
                        caption: "B"; value: "0"
                        min: 0; max: 255; decimals: 0
                    }
                    NumberBox {
                        id: rgbAlpha
                        caption: "A"; value: "100"
                        min: 0; max: 255; decimals: 0
                    }
                }
            }
        }
    }
}


