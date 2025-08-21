import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

//pane like page but without header and footer
Pane {
    id: root
    property string zoneName: ""
    property int celsius: temperatureDial.value
    property int fahrenheit: (celsius * 1.8) + 32
    readonly property color temperatureColor: {
        if (celsius < 10)
            return Qt.color("lightblue")
        else if (celsius >= 10 && celsius < 20)
            return Qt.color("cyan")
        else if (celsius >= 20 && celsius < 30)
            return Qt.color("orange")
        else
            return Qt.color("red")
    }
    //palette property is used to customize the color scheme of the component
    //windowText: This property defines the color of the text displayed in the window
    palette {
        windowText: root.temperatureColor
        //Dial use dark palette role
        dark: root.temperatureColor
    }

    background: Rectangle {
        color: "black"
        opacity: 0.5
    }
    //column layout and row layout automatiqie fill each other
    RowLayout {
        anchors.fill: parent
        spacing: 10
        ColumnLayout {
            id: leftColumn
            spacing: 10
            RowLayout {
                spacing: 10
                CheckBox {
                    id: zoneEnabledCheckBox
                    checked: true
                    text: qsTr("Enable %1").arg(zoneName)
                }
                Switch {
                    //binary 0 - 1 state
                    //dont use switch as id because it reseverd by JS
                    id: unitsSwitch
                    text: qsTr("°C / °F") //u00B0 // UTF-16 for degree ° symbol
                }
            }

            RowLayout {
                // enabled => This property holds whether the item receives mouse and keyboard events. By default this is true
                enabled: zoneEnabledCheckBox.checked
                spacing: 10
                Image {
                    source: Qt.resolvedUrl("assets/cool.svg")
                    Layout.alignment: Qt.AlignBottom
                }

                Dial {
                    //for °C
                    //SnapAlways=>which snaps while the handle is dragged, and Dial.SnapOnReleas=> which snaps only after the handle is released
                    id: temperatureDial
                    value: 21 //default value °C
                    from: 0
                    to: 40
                    stepSize: 1 //whole degreee
                    snapMode: Dial.SnapAlways
                    onValueChanged: console.log("Dial value : ", value)
                }
                Image {
                    source: Qt.resolvedUrl("assets/heat.svg")
                    Layout.alignment: Qt.AlignBottom
                }
            }
        }
        ColumnLayout {
            id: rightColumn
            enabled: zoneEnabledCheckBox.checked
            spacing: 10
            Label {
                text: unitsSwitch.checked ? root.fahrenheit + "°F" : root.celsius + "°C"

                font {
                    weight: Font.ExtraLight
                    pixelSize: 200
                }
                Layout.fillWidth: true
                horizontalAlignment: Qt.AlignRight
                // for Qt6.7 =>renderTypeQuality: Text.HighRenderTypeQuality //imporve the apperance of large fontsize tha use more memory
                renderType: Text.CurveRendering // have better result for large font size reduce grpahic consumption(For Qt 6.7 and later)
            }
            RowLayout {
                spacing: 10
                Image {
                    source: fantSpeedSlider.value
                            > 0 ? Qt.resolvedUrl(
                                      "assets/fan_outline.svg") : Qt.resolvedUrl(
                                      "assets/fan_off.svg")
                }

                Slider {
                    id: fantSpeedSlider
                    //for the fan speed of each zone
                    from: 0
                    to: 100
                    Layout.fillWidth: true
                }
            }
        }
    }
}
