import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import qs.services

Item {
    id: root
    width: 25
    height: 25

    Row {
        anchors.centerIn: parent
        spacing: 4

        Text {
            id: audioIcon
            anchors.verticalCenter: parent.verticalCenter
            color: Colors.text
            text: Audio.getVolumeIcon() + " " + Audio.getDeviceIcon()

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                acceptedButtons: Qt.LeftButton
                onClicked: {
                    pavucontrolProcess.running = true;
                }
            }
        }

        Text {
            id: batteryText
            anchors.verticalCenter: parent.verticalCenter
            color: Audio.bluetoothBatteryPercentage <= 20 ? Colors.love : Colors.text
            text: Audio.bluetoothBatteryAvailable ? Audio.bluetoothBatteryPercentage + "%" : ""
            font.pixelSize: 10
            visible: Audio.bluetoothBatteryAvailable
        }
    }

    Process {
        id: pavucontrolProcess
        command: ["pavucontrol"]
    }
}
