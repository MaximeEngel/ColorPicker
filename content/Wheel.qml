import QtQuick 2.0
import "ColorFunctions.js" as ColorFunctions

Item {
    id: root
    property real hueColor : Math.atan2(((pickerCursor.y-root.height/2)*(-1)),((pickerCursor.x-root.width/2)))
    property real saturation : Math.sqrt(Math.pow(pickerCursor.x-width/2,2)+Math.pow(pickerCursor.y-height/2,2))
    property color color: "green"

    width: 200 ; height: 200
    clip: true

    Rectangle {
        width: parent.width; height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        color: "transparent"
        ShaderEffect {
            id: shader
            anchors.fill: parent
            vertexShader: "
                uniform highp mat4 qt_Matrix;
                attribute highp vec4 qt_Vertex;
                attribute highp vec2 qt_MultiTexCoord0;
                varying highp vec2 coord;

                void main() {
                    coord = qt_MultiTexCoord0 - vec2(0.5, 0.5);
                    gl_Position = qt_Matrix * qt_Vertex;
            }"
            fragmentShader: "
                varying highp vec2 coord;

                vec3 hsv2rgb(in vec3 c){
                    vec4 k = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
                    vec3 p = abs(fract(c.xxx + k.xyz) * 6.0 - k.www);
                    return c.z * mix(k.xxx, clamp(p - k.xxx, 0.0, 1.0), c.y);
                }

                void main() {
                    const float PI = 3.14159265358979323846264;
                    float s = sqrt(coord.x * coord.x + coord.y * coord.y);

                    if( s > 0.5 ){
                        gl_FragColor = vec4(0, 0, 0, 0);
                        return;
                    }

                    float h = - atan( coord.y / coord.x );
                    s *= 2.0;

                    if( coord.x >= 0.0 ){
                        h += PI;
                    }

                    h = h / (2.0 * PI);
                    vec3 hsl = vec3(h, s, 1.0);
                    vec3 rgb = hsv2rgb(hsl);
                    gl_FragColor.rgb = rgb;
                    gl_FragColor.a = 1.0;
            }"
        }

        Item {
            id: pickerCursor
            x: parent.width/2-r; y:parent.height/2-r
            property int r : 8
            Rectangle {
                width: parent.r*2; height: parent.r*2
                radius: parent.r
                border.color: "black"; border.width: 2
                color: "transparent"
                Rectangle {
                    anchors.fill: parent; anchors.margins: 2;
                    border.color: "white"; border.width: 2
                    radius: width/2
                    color: "transparent"
                }
            }
        }
        MouseArea {
            anchors.fill: parent
            onPositionChanged: ColorFunctions.wheelHandleMouse(mouse)
            onPressed: ColorFunctions.wheelHandleMouse(mouse)
        }
    }


}
