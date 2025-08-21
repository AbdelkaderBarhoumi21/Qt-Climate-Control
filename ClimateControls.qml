import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {

    padding: 10
    header: Label {
        text: qsTr("Climate Control")
        color: "white"
        font.pixelSize: 48
        padding: 10
    }
    background: null

    // background: Rectangle {
    //     color: "red"
    // }
    ColumnLayout {
        anchors.fill: parent
        spacing: 10
        ZoneControls {
            id: zone
            zoneName: "Zone 1"
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
        ZoneControls {
            id: zone2
            zoneName: "Zone 2"
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
}
